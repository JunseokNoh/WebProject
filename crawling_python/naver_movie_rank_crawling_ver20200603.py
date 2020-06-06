"""
::: CONTENTS :::
Project		: naver_movie_rank_crawling
Version		: ver.20200603
Filename	: naver_movie_rank_crawling_ver.1.py
Date		: 2020/06/03
Purpose		: get naver moive rank
Programmer	: Yoobi (hackery00bi@gmail.com)
Reviewer	:
PatchNote   :
- ver.20200603 -
(1) crawling naver movie rank data
(2) connect DB & insert data to MYSQL

"""

import pymysql
import requests
from bs4 import BeautifulSoup
from datetime import datetime

RESULT_PATH = './crawling_result/'
MAIN_URL = 'https://movie.naver.com/movie/sdb/rank/rmovie.nhn'
DATE = 0
ARTICLE_URL = ''


def main():
    crawler()


# crawling web site
def crawler():
    global ARTICLE_URL

    try:
        url = MAIN_URL
        req = requests.get(url)
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')

        # print(soup)
        soup = soup.select(
            "div#wrap > div#container > div#content > div.article > div.old_layout.old_super_db > div#cbody > div#old_content > table.list_ranking > tbody > tr > td.title > div.tit3")  # > ul.tp_5 > div.listBoxType_3")

        # print(soup)

        for i in range(len(soup)):
            RANK_URL = soup[i].find("a")["href"]
            RANK_NAME = soup[i].find("a")["title"]
            # connect_db(i, RANK_NAME, RANK_URL)
            print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)

    except Exception as e:
        error_logging(str(e))
        print("Error Detected")


# get news div ID = articleBodyContents
def get_news(n_url):
    global date
    breq = requests.get(n_url)
    bsoup = BeautifulSoup(breq.content, 'lxml')
    date = bsoup.select("div#wrap > div#content > div.clear.tp_5 > p.conTop2 > span")
    date = date[0]
    date = str(date)[68:75]
    # print(date)

    text = bsoup.select("div#wrap > div#content > div.bodyarea")
    text = text[0]
    # print(text)
    f = open(RESULT_PATH + date + ".txt", 'a', encoding='utf-8')

    f.write("{}\n".format(text))

    f.close()


# error logging
def error_logging(text):
    fe = open(RESULT_PATH + "error_log/error_log.txt", 'a', encoding='utf-8')
    fe.write("{} {} {}\n".format(datetime.now(), ARTICLE_URL, text))
    fe.close()


def connect_db(i, movie_title, movie_info_url):
    rank_number = i + 1
    conn = pymysql.connect(host='localhost', user='yoobi', password='toor', db='jsp_db', charset='utf8')

    curs = conn.cursor()

    sql = """insert into naver_movie_rank(rank, title, url) values (%s, %s, %s)"""
    curs.execute(sql, (rank_number, movie_title, movie_info_url))
    conn.commit()
    conn.close()


main()
