from bs4 import BeautifulSoup
from playwright.sync_api import sync_playwright

# linkareer.html 읽기
def crawl_detail_page(url):
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False)
        page = browser.new_page()
        page.goto(url)
        page.wait_for_timeout(2000)

        html = page.content()
        browser.close()

        soup = BeautifulSoup(html, 'html.parser')

        # 시작일 (end-at 다음 span)
        start_tag = soup.select_one('span[class*="start-at"] + span')
        start_date = start_tag.text.strip() if start_tag else None

        # 종료일 (end-at 다음 span)
        end_tag = soup.select_one('span[class*="end-at"] + span')
        end_date = end_tag.text.strip() if end_tag else None

        print(f"시작일: {start_date}")
        print(f"종료일: {end_date}")

        return {
            'startDate': start_date,
            'endDate': end_date
        }


with open("linkareer.html", "r", encoding="utf-8") as f:
    html = f.read()

soup = BeautifulSoup(html, 'html.parser')
cards = soup.select('div.ActivityListCardItem__StyledWrapper-sc-39989f6d-0')

print(f"총 {len(cards)}개 카드 발견\n")

for i, card in enumerate(cards[:3], 1):  # 처음 3개만
    link = card.select_one('a.image-link')
    href = link.get('href') if link else ""
    url = f"https://linkareer.com{href}" if href else ""

    title = card.select_one('h5.activity-title').text.strip()
    print(f"{i}.{title}")
    print(crawl_detail_page(url))

