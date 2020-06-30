import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class DaumMovieCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div.main_detail > div.movie_join > ul.list_boxthumb > li")
            # print(soup)

            for i in range(len(soup)):
                RANK_NAME = soup[i].find("a", {"class": "link_g"}).get_text().lstrip()

                RANK_TICKETING = soup[i].select("dl.list_state > dd")[1].get_text()
                RANK_TICKETING = RANK_TICKETING[3:RANK_TICKETING.find("%") + 1]

                RANK_URL = soup[i].find("a", {"class": "link_g"})["href"]
                IMAGE_URL = soup[i].find("img")["src"]

                self.connect_db(i, RANK_NAME, RANK_TICKETING, RANK_URL, IMAGE_URL, "", "", "")
                #print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL + " : " + RANK_TICKETING)
            f = open("./../../manual_active_log.txt", "a")
            f.write("table : daum_movie_rank UPDATED" + "\n")
            print("table : daum_movie_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, movie_title, movie_ticketing, movie_info_url, image_url, tmp6, tmp7, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """delete from daum_movie_rank"""
        curs.execute(sql)

        sql = """insert into daum_movie_rank (rank, title, ticketing, url, image_url) values (%s, %s, %s, %s, %s)"""
        curs.execute(sql, (rank_number, movie_title, movie_ticketing, movie_info_url, image_url))
        '''
        sql = """select title from daum_movie_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == movie_title:
            #print("same daum")
            pass
        else:
            #print(rank_number + " : " + movie_title + " : " + movie_info_url + " : " + movie_ticketing)
            sql = """update daum_movie_rank set title=%s, ticketing=%s, url=%s, image_url=%s where rank=%s"""
            curs.execute(sql, (movie_title, movie_ticketing, movie_info_url, image_url, rank_number))
        '''
        conn.commit()
        conn.close()
