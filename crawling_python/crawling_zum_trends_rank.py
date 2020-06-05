import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class ZumTrendsCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, article_url, db_host, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div.inner > ul.ranking_list > li.inner_cont")
            # print(soup)

            for i in range(len(soup)):
                RANK_URL = soup[i].find("a", {"class": "btn_search"})["href"]
                RANK_NAME = soup[i].find("a", {"class": "daily-keyword"}).find("span", {"class": "word"}).get_text()
                self.connect_db(i, RANK_NAME, RANK_URL)
#                print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)

        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, trends_title, trends_info_url):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """select title from zum_trends_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == trends_title:
            print("same zum")
        else:
            sql = """update zum_trends_rank set title=%s, url=%s where rank=%s"""
            curs.execute(sql, (trends_title, trends_info_url, rank_number))

        conn.commit()
        conn.close()
