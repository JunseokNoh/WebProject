import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class NaverMovieCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
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
                self.connect_db(i, RANK_NAME, RANK_URL, "", "", "", "")
            # print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)
            f = open("./active_log.txt", "a")
            f.write("table : naver_movie_rank UPDATED" + "\n")
            print("table : naver_movie_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, title, info_url, tmp4, tmp5, tmp6, tmp7):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """select title from naver_movie_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == title:
            # print("same naver moive")
            pass
        else:
            # print("change value " + str(rank_number) + " : " + title)
            sql = """update naver_movie_rank set title=%s, url=%s where rank=%s"""
            curs.execute(sql, (title, info_url, rank_number))

        conn.commit()
        conn.close()
