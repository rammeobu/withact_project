import os
import requests
from bs4 import BeautifulSoup
import pandas as pd
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser=p.chromium.launch(headless=False)
    page=browser.new_page()
    page.goto("https://linkareer.com/list/contest?filterBy_categoryIDs=35&filterBy_categoryIDs=33&filterType=CATEGORY&orderBy_direction=DESC&orderBy_field=CREATED_AT&page=1")
    # page.wait_for_timeout(3000)
    html = page.content()
    with open("linkareer.html", "w", encoding="utf-8") as f:
        f.write(html)
    browser.close()
    soup =BeautifulSoup(html,'html.parser')
    cards = soup.select('div.ActivityListCardItem__StyledWrapper-sc-39989f6d-0')
    date=[]
    for card in cards:
        title = card.select_one('h5.activity-title').text.strip()
        org = card.select_one('.organization-name').text.strip()
        img_tag = card.select_one('img.activity-image')
        img_url = img_tag.get('src') if img_tag else ""
        date.append({
            'title': title,
            'organization': org,
            'image_url': img_url
        })
        print(f"{len(date)}개")