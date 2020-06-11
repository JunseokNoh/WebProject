import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class NateTrendsCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div.isKeyword > ol.isKeywordList > li")
            # print(soup)

            for i in range(len(soup)):
                RANK_NAME = soup[i].find("a", {"class": "ik"}).find("span", {"class": "txt_rank"}).get_text()
                self.connect_db(i, RANK_NAME, "", "", "", "", "", "")
                #print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)
            f = open("./../../manual_active_log.txt", "a")
            f.write("table : nate_trends_rank UPDATED" + "\n")
            print("table : nate_trends_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, title, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """insert into nate_trends_rank (rank, title) values (%s, %s)"""
        curs.execute(sql, (rank_number, title))
        '''
        sql = """select title from nate_trends_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()

        if row[0] == title:
            #print("same nate trend")
            pass
        else:
            #print(str(rank_number) + " : " + title)
            sql = """update nate_trends_rank set title=%s where rank=%s"""
            curs.execute(sql, (title, rank_number))
        '''

        conn.commit()
        conn.close()
