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

                temp = self.get_names(RANK_URL)
                DIRECTOR_NAME = temp[0]
                ACTOR_NAMES = temp[1]

                self.connect_db(i, RANK_NAME, RANK_TICKETING, RANK_URL, IMAGE_URL, DIRECTOR_NAME, ACTOR_NAMES, "")
                # print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL + " : " + RANK_TICKETING + " : " + DIRECTOR_NAME + " : " + ACTOR_NAMES)
            f = open("./../../active_log.txt", "a")
            f.write("table : daum_movie_rank UPDATED" + "\n")
            print("table : daum_movie_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print(str(e))
            #print("Error Detected")

    def get_names(self, URL):
        header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
        req = requests.get(URL, headers=header)  ## 주간 차트를 크롤링 할 것임
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')
        #print(soup)
        soup = soup.select("div.movie_summary > dl")
        temp = soup[2].select("dd")[1].get_text()[2:].lstrip().split(",")
        temp_str = temp[0]
        for i in range(1, len(temp)):
            temp[i] = temp[i].lstrip()
            temp_str = temp_str + ", " + temp[i]
        result = [soup[2].select("dd")[0].find("a").get_text(), temp_str]
        return result

    def connect_db(self, i, movie_title, movie_ticketing, movie_info_url, image_url, director_name, actor_names, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        if rank_number == 1:
            sql = """delete from daum_movie_rank"""
            curs.execute(sql)

        sql = """insert into daum_movie_rank (rank, title, ticketing, url, image_url, director_name, actor_names) values (%s, %s, %s, %s, %s, %s, %s)"""
        curs.execute(sql, (rank_number, movie_title, movie_ticketing, movie_info_url, image_url, director_name, actor_names))

        #sql = """insert into daum_movie_rank (rank, title, ticketing, url) values (%s, %s, %s, %s)"""
        #curs.execute(sql, (rank_number, movie_title, movie_ticketing, movie_info_url))

        # sql = """select title from daum_movie_rank where rank = %s"""
        # curs.execute(sql, rank_number)
        # row = curs.fetchone()
        # if row[0] == movie_title:
        #     #print("same daum")
        #     if row[1] != movie_ticketing:
        #         sql = """update daum_movie_rank set ticketing=%s where rank=%s"""
        #         curs.execute(sql, (movie_ticketing, rank_number))
        #     pass
        # else:
        #     #print(rank_number + " : " + movie_title + " : " + movie_info_url + " : " + movie_ticketing)
        #     sql = """update daum_movie_rank set title=%s, ticketing=%s, url=%s, image_url=%s, director_name=%s, actor_names=%s where rank=%s"""
        #     curs.execute(sql, (movie_title, movie_ticketing, movie_info_url, image_url, director_name, actor_names, rank_number))

        conn.commit()
        conn.close()