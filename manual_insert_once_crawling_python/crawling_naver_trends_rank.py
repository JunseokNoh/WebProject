import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class NaverTrendsCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
            req = requests.get(super().MAIN_URL(), headers=header)  ## 주간 차트를 크롤링 할 것임
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            #print(soup)
            soup = soup.select("div.ranking_box > " +
                               "div.list_group > " +
                               "ul.ranking_list > " +
                               "li.ranking_item")
            #print(soup)

            for i in range(len(soup)):
                RANK_NAME = soup[i].find("span", {"class": "item_title"}).get_text()
                RANK_URL = "https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=" + RANK_NAME
                self.connect_db(i, RANK_NAME, RANK_URL, "", "", "", "", "")
                #print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)
            f = open("./../../manual_active_log.txt", "a")
            f.write("table : naver_trends_rank UPDATED" + "\n")
            print("table : naver_trends_rank UPDATED")
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

        if rank_number == 1:
            sql = """delete from naver_trends_rank"""
            curs.execute(sql)

        sql = """insert into naver_trends_rank (rank, title, url) values (%s, %s, %s)"""
        curs.execute(sql, (rank_number, title, info_url))
        '''
        sql = """select title from naver_trends_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        
        if row[0] == title:
            #print("same naver trend")
            pass
        else:
            #print(str(rank_number) + " : " + title)
            sql = """update naver_trends_rank set title=%s, url=%s where rank=%s"""
            curs.execute(sql, (title, info_url, rank_number))
        '''
        conn.commit()
        conn.close()
