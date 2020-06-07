import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class NaverMovieRatingCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, article_url, db_host, db_user, db_pw, db_name, db_charset)

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

            for i in range(len(soup)):
                RANK_NAME = soup_title[i]["title"]
                RANK_RATING = soup_rating[i].get_text()
                RANK_URL = "https://movie.naver.com" + soup_title[i]["href"]

                self.connect_db(i, RANK_NAME, RANK_RATING, RANK_URL)
                #print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL + " : " + RANK_RATING)

        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, movie_title, movie_rating, movie_info_url):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """select title from naver_movie_rating_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == movie_title:
            print("same naver_rating")
        else:
            sql = """update naver_movie_rating_rank set title=%s, rating=%s, url=%s where rank=%s"""
            curs.execute(sql, (movie_title, movie_rating, movie_info_url, rank_number))

        conn.commit()
        conn.close()