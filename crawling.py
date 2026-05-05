import asyncio
import json
from bs4 import BeautifulSoup
from playwright.async_api import async_playwright


async def scrape_detail_page(context, url, semaphore):
    if not url:
        return {"description": "", "startDate": None, "endDate": None, "detailImageUrl": ""}

    async with semaphore:
        page = await context.new_page()
        try:
            await page.goto(url)
            await page.wait_for_timeout(1500)

            detail_html = await page.content()
            detail_soup = BeautifulSoup(detail_html, 'html.parser')

            end_date = None
            end_date_tag = detail_soup.select_one('span.end-at + span')
            if end_date_tag:
                end_date = end_date_tag.text.strip().replace('.', '-')

            start_date = None
            start_date_tag = detail_soup.select_one('span.start-at + span')
            if start_date_tag:
                start_date = start_date_tag.text.strip().replace('.', '-')

            detail_text = ""
            h2_tag = detail_soup.find('h2', string=lambda text: text and '상세내용' in text)
            if h2_tag:
                detail_content_area = h2_tag.find_next('div', class_='responsive-element')
                if detail_content_area:
                    detail_text = detail_content_area.get_text(separator="\n", strip=True)

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
            print(f"상세 페이지 에러 발생 ({url}): {e}")
            return {"description": "", "startDate": None, "endDate": None, "detailImageUrl": ""}
        finally:
            await page.close()



async def crawl_linkareer_async():
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=False)
        context = await browser.new_context()

        page_num = 1
        all_activities = []
        file_name = "linkareer_safe_data.json"

        while True:
            print(f"\n=== [ {page_num} 페이지 ] 수집 시작 ===")

            list_page = await context.new_page()

            target_url = f"https://linkareer.com/list/contest?filterBy_categoryIDs=35&filterBy_categoryIDs=33&filterType=CATEGORY&orderBy_direction=DESC&orderBy_field=CREATED_AT&page={page_num}"
            await list_page.goto(target_url)
            await list_page.wait_for_timeout(2000)

            html = await list_page.content()
            soup = BeautifulSoup(html, 'html.parser')

            cards = soup.select('div.ActivityListCardItem__StyledWrapper-sc-39989f6d-0')

            if len(cards) == 0:
                print(f"\n 더 이상 데이터가 없습니다. 최종 {page_num - 1}페이지에서 탐색을 종료합니다.")
                await list_page.close()  # 종료 전 탭 닫기
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

                activities_basic.append({
                    'title': title,
                    'organization': org,
                    'category': '공모전',
                    'sourceUrl': detail_link,
                    'imageUrl': img_url
                })
                detail_urls.append(detail_link)


            await list_page.close()

            semaphore = asyncio.Semaphore(5)
            tasks = [scrape_detail_page(context, url, semaphore) for url in detail_urls]
            detail_results = await asyncio.gather(*tasks)

            for i, activity in enumerate(activities_basic):
                activity['description'] = detail_results[i]["description"]
                activity['startDate'] = detail_results[i]["startDate"]
                activity['endDate'] = detail_results[i]["endDate"]

                # KeyError 방어 로직 (.get 사용)
                if detail_results[i].get("detailImageUrl"):
                    activity['imageUrl'] = detail_results[i]["detailImageUrl"]

                activity['location'] = '온라인'

            all_activities.extend(activities_basic)

            with open(file_name, "w", encoding="utf-8") as f:
                json.dump(all_activities, f, ensure_ascii=False, indent=2)

            print(f"  └── [JSON 저장 완료] 누적 {len(all_activities)}개의 데이터가 안전하게 덮어쓰기")

            page_num += 1

        await browser.close()
        print(f"\n전체 크롤링 완료 총 {len(all_activities)}개의 데이터가 '{file_name}'저장")
        return all_activities


if __name__ == "__main__":
    asyncio.run(crawl_linkareer_async())