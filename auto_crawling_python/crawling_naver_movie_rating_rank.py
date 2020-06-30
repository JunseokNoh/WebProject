import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class NaverMovieRatingCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup_title = soup.select("table.list_ranking > tbody > tr > td.title > div.tit5 > a")
            soup_rating = soup.select("table.list_ranking > tbody > tr > td.point")
            # print(soup)

            for i in range(len(soup_title)):
                RANK_NAME = soup_title[i]["title"]
                RANK_RATING = soup_rating[i].get_text()
                RANK_URL = "https://movie.naver.com" + soup_title[i]["href"]
                temp = self.get_image_and_names(RANK_URL)
                IMAGE_URL = temp[0]
                DIRECTOR_NAME = temp[1]
                ACTOR_NAMES = temp[2]
                # self.connect_db(i, RANK_NAME, RANK_RATING, RANK_URL, IMAGE_URL, DIRECTOR_NAME, ACTOR_NAMES, "")
                print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL + " : " + RANK_RATING + " : " + DIRECTOR_NAME + " : " + ACTOR_NAMES)
            # f = open("./../../active_log.txt", "a")
            # f.write("table : naver_movie_rating_rank UPDATED" + "\n")
            # print("table : naver_movie_rating_rank UPDATED")
            # f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def get_image_and_names(self, URL):
        header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
        req = requests.get(URL, headers=header)  ## 주간 차트를 크롤링 할 것임
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')
        #print(soup)
        soup1 = soup.select("div.poster")
        soup2 = soup.select("dl.info_spec > dd")
        temp = [soup1[0].find("img")["src"], soup2[1].find("p").find("a").get_text(), soup2[2].find("p").get_text()]
        return temp

    def connect_db(self, i, movie_title, movie_rating, movie_info_url, image_url, director_name, actor_names, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        # sql = """insert into naver_movie_rating_rank (rank, title, rating, url) values (%s, %s, %s, %s)"""
        # curs.execute(sql, (rank_number, movie_title, movie_rating, movie_info_url))

        sql = """select title from naver_movie_rating_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == movie_title:
            # print("same naver_rating")
            if row[1] != movie_rating:
                sql = """update naver_movie_rating_rank set rating=%s where rank=%s"""
                curs.execute(sql, (movie_rating, rank_number))
            pass
        else:
            # print(rank_number + " : " + movie_title + " : " + movie_info_url + " : " + movie_rating)
            sql = """update naver_movie_rating_rank set title=%s, rating=%s, url=%s, image_url=%s, director_name=%s, actor_names=%s where rank=%s"""
            curs.execute(sql, (movie_title, movie_rating, movie_info_url, image_url, director_name, actor_names, rank_number))

        conn.commit()
        conn.close()
