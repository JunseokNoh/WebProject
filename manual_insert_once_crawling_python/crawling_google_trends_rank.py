import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *
from urllib import parse

import crawling


class GoogleTrendsCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.find("p").get_text()
            soup = soup.split("\"date\":\"")[1]
            soup = soup.split("\"shareUrl\":\"")[1:]
            # print(soup)

            for i in range(len(soup)):
                soup[i] = soup[i].split("\"}")[0]
                RANK_URL = soup[i]

                soup[i] = soup[i].split("?geo")[1].split("#")[0]
                RANK_NAME = parse.unquote(soup[i])[22:]
                self.connect_db(i, RANK_NAME, RANK_URL, "", "", "", "", "")
                # print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)
            f = open("./../../manual_active_log.txt", "a")
            f.write("table : google_trends_rank UPDATED" + "\n")
            print("table : google_trends_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, title, info_url, tmp4, tmp5, tmp6, tmp7, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        # sql = """insert into google_trends_rank (rank, title, url) values (%s, %s, %s)"""
        # curs.execute(sql, (rank_number, title, info_url))
        if rank_number == 1:
            sql = """delete from google_trends_rank"""
            curs.execute(sql)

        sql = """insert into google_trends_rank (rank, title, url) values (%s, %s, %s)"""
        curs.execute(sql, (rank_number, title, info_url))

        '''
        row = curs.fetchone()
        if row[0] == title:
            #print("same google trend")
            pass
        else:
            #print(rank_number + " : " + title + " : " + info_url)
            sql = """update google_trends_rank set title=%s, url=%s where rank=%s"""
            curs.execute(sql, (title, info_url, rank_number))
        '''
        conn.commit()
        conn.close()
