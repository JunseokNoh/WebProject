import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class BoxofficeMovieUSCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div#boxoffice > table > tbody > tr")
            #print(soup)

            for i in range(len(soup)):
                RANK_NAME = soup[i].select("td.titleColumn > a")[0].get_text()
                RANK_URL = "https://www.imdb.com" + soup[i].select("td.posterColumn > a")[0]["href"]
                RANK_ATTENDANCE = soup[i].select("span.secondaryInfo")[0].get_text()
                IMAGE_URL = self.get_image(RANK_URL)
                #print(IMAGE_URL)
                temp = soup[i].select("td.titleColumn > a")[0]["title"].split(" (dir.), ")
                DIRECTOR_NAME = temp[0]
                ACTOR_NAMES = temp[1]
                self.connect_db(i, RANK_NAME, RANK_ATTENDANCE, RANK_URL, IMAGE_URL, DIRECTOR_NAME, ACTOR_NAMES, "")
                # print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL + " : " + RANK_ATTENDANCE + " : " + DIRECTOR_NAME + " : " + ACTOR_NAMES)
            f = open("./../../active_log.txt", "a")
            f.write("table : boxoffice_movie_us_rank UPDATED" + "\n")
            print("table : boxoffice_movie_us_rank UPDATED")
            # f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def get_image(self, URL):
        header = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
        req = requests.get(URL, headers=header)  ## 주간 차트를 크롤링 할 것임
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')

        return soup.select("div.poster > a > img")[0]["src"]

    def connect_db(self, i, movie_title, movie_attendance, movie_info_url, image_url, director_name, actor_names, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        #sql = """insert into boxoffice_movie_us_rank (rank, title, attendance, url) values (%s, %s, %s, %s)"""
        #curs.execute(sql, (rank_number, movie_title, movie_attendance, movie_info_url))

        sql = """select title, attendance from boxoffice_movie_us_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == movie_title:
            # print("same boxoffice US")
            if row[1] != movie_attendance:
                sql="""update boxoffice_movie_us_rank set attendance=%s where rank=%s"""
                curs.execute(sql, (movie_attendance, rank_number))
            pass
        else:
            #print(rank_number + " : " + movie_title + " : " + movie_info_url + " : " + movie_attendance)
            sql = """update boxoffice_movie_us_rank set title=%s, attendance=%s, url=%s, image_url=%s, director_name=%s, actor_names=%s where rank=%s"""
            curs.execute(sql, (movie_title, movie_attendance, movie_info_url, image_url, director_name, actor_names, rank_number))


        conn.commit()
        conn.close()