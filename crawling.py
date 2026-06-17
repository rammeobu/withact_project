import asyncio
import os

import pymysql
from datetime import datetime
from bs4 import BeautifulSoup
from playwright.async_api import async_playwright


# ===== DB 설정 =====
DB_CONFIG = {
    'host': os.getenv('DB_HOST'),
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'database': os.getenv('DB_NAME'),
    'charset': 'utf8mb4'
}


# ===== 유틸 함수 =====
def parse_date(raw_text):
    """날짜 문자열을 안전하게 YYYY-MM-DD로 변환"""
    if not raw_text:
        return None
    try:
        cleaned = raw_text.strip().replace(' ', '')
        parsed = datetime.strptime(cleaned, '%Y.%m.%d')
        return parsed.strftime('%Y-%m-%d')
    except ValueError:
        print(f"  ⚠️ 날짜 파싱 실패: '{raw_text}'")
        return None


# ===== DB 함수 =====
def init_database():
    """데이터베이스 테이블 초기화"""
    conn = pymysql.connect(**DB_CONFIG)
    cursor = conn.cursor()

    cursor.execute('''
    CREATE TABLE IF NOT EXISTS activities (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(500),
        organization VARCHAR(200),
        category VARCHAR(100),
        sourceUrl VARCHAR(500) UNIQUE,
        imageUrl VARCHAR(500),
        description MEDIUMTEXT,
        startDate DATE NULL,
        endDate DATE NULL,
        location VARCHAR(200),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_endDate (endDate),
        INDEX idx_category (category)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
    ''')

    conn.commit()
    cursor.close()
    conn.close()
    print("✅ 데이터베이스 테이블 준비 완료")


def save_to_database(activities):
    """중복 없이 DB에 저장"""
    if not activities:
        return 0

    # sourceUrl이 비어있는 데이터 필터링
    valid_activities = [item for item in activities if item.get('sourceUrl')]
    if not valid_activities:
        return 0

    conn = pymysql.connect(**DB_CONFIG)
    cursor = conn.cursor()

    insert_query = '''
        INSERT IGNORE INTO activities 
        (title, organization, category, sourceUrl, imageUrl, description, startDate, endDate, location)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    '''

    data_tuples = [
        (
            item.get('title', '')[:500],
            item.get('organization', '')[:200],
            item.get('category', '')[:100],
            item['sourceUrl'][:500],
            item.get('imageUrl', '')[:500],
            item.get('description', ''),
            item.get('startDate'),
            item.get('endDate'),
            item.get('location', '')[:200]
        )
        for item in valid_activities
    ]

    cursor.executemany(insert_query, data_tuples)
    affected_rows = cursor.rowcount
    conn.commit()

    cursor.close()
    conn.close()

    return affected_rows


# ===== 크롤링 함수 =====
async def scrape_detail_page(context, url, semaphore):
    """상세 페이지 크롤링"""
    if not url:
        return {"description": "", "startDate": None, "endDate": None, "detailImageUrl": ""}

    async with semaphore:
        page = await context.new_page()
        try:
            await page.goto(url)
            await page.wait_for_timeout(1500)

            detail_html = await page.content()
            detail_soup = BeautifulSoup(detail_html, 'html.parser')

            # 마감일
            end_date = None
            end_date_tag = detail_soup.select_one('span.end-at + span')
            if end_date_tag:
                end_date = parse_date(end_date_tag.text)

            # 시작일
            start_date = None
            start_date_tag = detail_soup.select_one('span.start-at + span')
            if start_date_tag:
                start_date = parse_date(start_date_tag.text)

            # 상세 내용
            detail_text = ""
            h2_tag = detail_soup.find('h2', string=lambda text: text and '상세내용' in text)
            if h2_tag:
                detail_content_area = h2_tag.find_next('div', class_='responsive-element')
                if detail_content_area:
                    detail_text = detail_content_area.get_text(separator="\n", strip=True)

            # 상세 이미지
            detail_image_url = ""
            img_tag = detail_soup.select_one('img.card-image')
            if img_tag and img_tag.has_attr('src'):
                detail_image_url = img_tag['src']

            return {
                "description": detail_text,
                "startDate": start_date,
                "endDate": end_date,
                "detailImageUrl": detail_image_url
            }

        except Exception as e:
            print(f"  상세 페이지 에러 ({url}): {e}")
            return {"description": "", "startDate": None, "endDate": None, "detailImageUrl": ""}
        finally:
            await page.close()


async def crawl_linkareer_async():

    init_database()

    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        context = await browser.new_context()

        page_num = 1
        total_crawled = 0
        total_saved = 0

        while True:
            print(f"\n=== [ {page_num} 페이지 ] 수집 시작 ===")

            list_page = await context.new_page()

            target_url = (
                f"https://linkareer.com/list/contest"
                f"?filterBy_categoryIDs=35&filterBy_categoryIDs=33"
                f"&filterType=CATEGORY"
                f"&orderBy_direction=DESC&orderBy_field=CREATED_AT"
                f"&page={page_num}"
            )
            await list_page.goto(target_url)
            await list_page.wait_for_timeout(2000)

            html = await list_page.content()
            soup = BeautifulSoup(html, 'html.parser')

            cards = soup.select('div.ActivityListCardItem__StyledWrapper-sc-39989f6d-0')

            if len(cards) == 0:
                print(f"\n✅ 더 이상 데이터가 없습니다. 최종 {page_num - 1}페이지에서 탐색을 종료합니다.")
                await list_page.close()
                break

            activities_basic = []
            detail_urls = []

            for card in cards:
                title = card.select_one('h5.activity-title').text.strip() if card.select_one(
                    'h5.activity-title') else ""
                org = card.select_one('.organization-name').text.strip() if card.select_one(
                    '.organization-name') else ""
                img_tag = card.select_one('img.activity-image')
                img_url = img_tag.get('src') if img_tag else ""

                link_tag = card.select_one('a')
                detail_link = "https://linkareer.com" + link_tag.get('href') if link_tag else ""

                # 빈 URL 필터링
                if not detail_link:
                    continue

                activities_basic.append({
                    'title': title,
                    'organization': org,
                    'category': '공모전',
                    'sourceUrl': detail_link,
                    'imageUrl': img_url
                })
                detail_urls.append(detail_link)

            await list_page.close()

            # 상세 페이지 병렬 크롤링
            semaphore = asyncio.Semaphore(5)
            tasks = [scrape_detail_page(context, url, semaphore) for url in detail_urls]
            detail_results = await asyncio.gather(*tasks)

            # 상세 정보 병합
            for i, activity in enumerate(activities_basic):
                activity['description'] = detail_results[i]["description"]
                activity['startDate'] = detail_results[i]["startDate"]
                activity['endDate'] = detail_results[i]["endDate"]

                if detail_results[i].get("detailImageUrl"):
                    activity['imageUrl'] = detail_results[i]["detailImageUrl"]

                activity['location'] = '온라인'

            # DB에 저장 (중복 자동 제외)
            saved_count = save_to_database(activities_basic)
            total_crawled += len(activities_basic)
            total_saved += saved_count

            skipped = len(activities_basic) - saved_count
            print(f"   이번 페이지: 크롤링 {len(activities_basic)}개 / 신규 저장 {saved_count}개 / 중복 {skipped}개")
            print(f"   누적: 총 크롤링 {total_crawled}개 / DB 저장 {total_saved}개")

            page_num += 1
            await asyncio.sleep(1)

        await browser.close()
        print(f"\n 전체 크롤링 완료!")
        print(f"   총 크롤링: {total_crawled}개")
        print(f"   DB 신규 저장: {total_saved}개")
        print(f"   중복 제외: {total_crawled - total_saved}개")


if __name__ == "__main__":
    asyncio.run(crawl_linkareer_async())