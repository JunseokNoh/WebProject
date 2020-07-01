import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling

count = 1

class OnestoreGameCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
            req = requests.get(super().MAIN_URL(), headers=header)  ## 주간 차트를 크롤링 할 것임
            cont = req.content
            soup = BeautifulSoup(cont, 'html.parser')

            # print(soup)
            soup = soup.find_all("div", {"class": "item-info"})
            # print(soup)
            print(len(soup))

            for i in range(len(soup)):
                RANK_URL = self.get_url("https://www.mobileindex.com/" + soup[i].find("a")["href"])
                RANK_NAME = soup[i].select("div.appTitle > a > span.appname")[0].get_text()
                RANK_PUBLISHER = soup[i].select("div.appTitle > a > span.publisher")[0].get_text()
                IMAGE_URL = soup[i].select("a > img")[0]["src"]
                RANK_TYPE = str(i%3)
                self.connect_db(i//3, RANK_NAME, RANK_URL, IMAGE_URL, RANK_PUBLISHER, RANK_TYPE, "", "")
                #print(str(i // 3 + 1) + " : " + RANK_NAME + " : " + RANK_URL + " : " + RANK_PUBLISHER + " : " + RANK_TYPE + " : " + IMAGE_URL)
            f = open("./../../active_log.txt", "a")
            f.write("table : onestore_game_rank UPDATED" + "\n")
            print("table : onestore_game_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def get_url(self, URL):
        header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
        req = requests.get(URL, headers=header)  ## 주간 차트를 크롤링 할 것임
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')
        soup = soup.select("div.app-info > table > tbody > tr > td")
        if soup[0].get_text() == "One Store":
            return soup[4].find("a")["href"]
        elif len(soup) > 5 and soup[5].get_text() == "One Store":
            return soup[9].find("a")["href"]
        elif len(soup) > 10 and soup[10].get_text() == "One Store":
            return soup[14].find("a")["href"]

    def connect_db(self, i, name, info_url, image_url, publisher, rank_type, tmp7, tmp8):
        global count
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        if count == 1:
            sql = """delete from onestore_game_rank"""
            curs.execute(sql)
            count += 1

        sql = """insert into onestore_game_rank (rank, name, rank_type, url, publisher, image_url) values (%s, %s, %s, %s, %s, %s)"""
        curs.execute(sql, (rank_number, name, rank_type, info_url, publisher, image_url))

        # sql = """select name from onestore_game_rank where rank = %s and rank_type = %s"""
        # curs.execute(sql, rank_number, rank_type)
        # row = curs.fetchone()
        # if row[0] == name:
        #     # print("same onestore game")
        #     pass
        # else:
        #     # print("change value " + str(rank_number) + " : " + title)
        #     sql = """update onestore_game_rank set name=%s, url=%s, image_url=%s, publisher=%s where rank=%s and rank_type = %s"""
        #     curs.execute(sql, (name, info_url, image_url, publisher, rank_number, rank_type))

        conn.commit()
        conn.close()
