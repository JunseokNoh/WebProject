"""
::: CONTENTS :::
Project		: news_crawling
Version		: 4.0
Filename	: news_crawling_only_text_ver.20200506.py
Date		: 2020/05/06
Purpose		: crawl only text from 약사공론
Programmer	: Yoobi (hackery00bi@gmail.com)
Reviewer	:
PatchNote   :
- ver.20200421 -
Add filtering keyword
Add get_news2() / troubleshooting
Add error_log part
Add auto load page number
Add make loop code 1990~2020
- ver.20200423 -
Add progress bar
Add function comment
- ver.20200506 -
modify 약사공론 ver
"""

import requests
from bs4 import BeautifulSoup
from datetime import datetime

RESULT_PATH = './crawling_result/'
MAIN_URL = 'http://www.yakup.com'
DATE = 0
ARTICLE_URL = ''


def main():
    crawler()


# crawling web site
def crawler():
    page = 170016
    global ARTICLE_URL

    while page > 165744:
        try:
            print("page : {}".format(page))
            url = "https://www.yakup.com/news/index.html?num_start=" + str(page) + "&keyword=&cat=all&cat2=&cat3=&mode=&pmode="
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')
            soup = soup.select("div#wrap > div#content > div.listBoxType_2.tm_10.clear")  # > ul.tp_5 > div.listBoxType_3")

            for href in soup[0].find("ul", class_="tp_5"):
                if(str(type(href)) == "<class 'bs4.element.Tag'>"):
                    href.select("h3.h6Type")
                    ARTICLE_URL = href.find("a")["href"]
                    get_news(MAIN_URL + ARTICLE_URL)
            page -= 16
        except Exception as e:
            error_logging(str(e))
            print("Error Detected & logged try get_news()")


# get news div ID = articleBodyContents
def get_news(n_url):
    global date
    breq = requests.get(n_url)
    bsoup = BeautifulSoup(breq.content, 'lxml')
    date = bsoup.select("div#wrap > div#content > div.clear.tp_5 > p.conTop2 > span")
    date = date[0]
    date = str(date)[68:75]
    #print(date)

    text = bsoup.select("div#wrap > div#content > div.bodyarea")
    text = text[0]
    #print(text)
    f = open(RESULT_PATH + date + ".txt", 'a', encoding='utf-8')

    f.write("{}\n".format(text))

    f.close()

# error logging
def error_logging(text):
    fe = open(RESULT_PATH + "error_log/error_log.txt", 'a', encoding='utf-8')
    fe.write("{} {} {}\n".format(datetime.now(), ARTICLE_URL, text))
    fe.close()


main()
