import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class BoxofficeMovieCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup2 = soup.select("div.movie_rank_wrap > div.movie_audience_ranking._main_panel.v2 > div._content > ul > li > div.thumb")
            soup = soup.select("div.movie_rank_wrap > div.movie_audience_ranking._main_panel.v2 > div._content > ul > li > div.movie_info")
            # print(soup)

            for i in range(20):
                RANK_NAME = soup[i].find("strong").get_text()
                RANK_ATTENDANCE = soup[i].select("dl.movie_item > dd")[1].get_text()
                RANK_URL = "https://search.naver.com/search.naver" + soup[i].find("a", {"class": "movie_tit"})["href"]
                IMAGE_URL = soup2[i].find("img")["src"]
                #print(IMAGE_URL)
                self.connect_db(i, RANK_NAME, RANK_ATTENDANCE, RANK_URL, IMAGE_URL, "", "", "")
                #print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL + " : " + RANK_ATTENDANCE)
            f = open("./../../manual_active_log.txt", "a")
            f.write("table : boxoffice_movie_rank UPDATED" + "\n")
            print("table : boxoffice_movie_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, movie_title, movie_attendance, movie_info_url, image_url, tmp6, tmp7, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """delete from boxoffice_movie_rank"""
        curs.execute(sql)

        sql = """insert into boxoffice_movie_rank (rank, title, attendance, url, image_url) values (%s, %s, %s, %s, %s)"""
        curs.execute(sql, (rank_number, movie_title, movie_attendance, movie_info_url, image_url))
        '''
        sql = """select title from boxoffice_movie_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == movie_title:
            #print("same boxoffice")
            pass
        else:
            #print(rank_number + " : " + movie_title + " : " + movie_info_url + " : " + movie_attendance)
            sql = """update boxoffice_movie_rank set title=%s, attendance=%s, url=%s, image_url=%s where rank=%s"""
            curs.execute(sql, (movie_title, movie_attendance, movie_info_url, image_url, rank_number))
        '''

        conn.commit()
        conn.close()
