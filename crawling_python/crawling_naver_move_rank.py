import pymysql
import requests
from bs4 import BeautifulSoup
from datetime import datetime
from abc import *

import crawling


class NaverMovieCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, article_url, db_host, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().__MAIN_URL
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div#wrap > " +
                               "div#container > " +
                               "div#content > " +
                               "div.article > " +
                               "div.old_layout.old_super_db > " +
                               "div#cbody > " +
                               "div#old_content > " +
                               "table.list_ranking > " +
                               "tbody > " +
                               "tr > " +
                               "td.title > " +
                               "div.tit3")
            # print(soup)

            for i in range(len(soup)):
                RANK_URL = soup[i].find("a")["href"]
                RANK_NAME = soup[i].find("a")["title"]
                # connect_db(i, RANK_NAME, RANK_URL)
                print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)

        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, movie_title, movie_info_url):
        rank_number = i + 1
        conn = pymysql.connect(host=super().__DB_HOST,
                               user=super().__DB_USER,
                               password=super().__DB_PW,
                               db=super().__DB_NAME,
                               charset=super().__DB_CHARSET)
        curs = conn.cursor()

        sql = """insert into naver_movie_rank(rank, title, url) values (%s, %s, %s)"""
        curs.execute(sql, (rank_number, movie_title, movie_info_url))
        conn.commit()
        conn.close()
