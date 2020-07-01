import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class NaverMovieCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div#wrap > " +
                               "div#container > " +
                               "div#content > " +
                               "div.article > " +
                               "div.old_layout.old_super_db > " +
                               "div#cbody > " +
                               "div#old_content > " +
                               "table.list_ranking > " +
                               "tbody > " +
                               "tr > " +
                               "td.title > " +
                               "div.tit3")
            # print(soup)

            for i in range(len(soup)):
                RANK_URL = soup[i].find("a")["href"]
                RANK_NAME = soup[i].find("a")["title"]
                data = self.get_image(RANK_URL)
                self.connect_db(i, RANK_NAME, RANK_URL, data[0], data[1], data[2], "", "")
                #print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)
            # print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)
            f = open("./../../manual_active_log.txt", "a")
            f.write("table : naver_movie_rank UPDATED" + "\n")
            print("table : naver_movie_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def get_image(self, URL):
        URL = "https://movie.naver.com" + URL
        header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
        req = requests.get(URL, headers=header)  ## 주간 차트를 크롤링 할 것임
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')
        #print(soup)
        soup1 = soup.select("div.poster")
        soup2 = soup.select("dl.info_spec > dd")

        data = [soup1[0].find("img")["src"], soup2[1].select("p > a")[0].get_text(), soup2[2].select("p")[0].get_text()]

        return data

    def connect_db(self, i, title, info_url, image_url, director_name, actor_names, tmp7, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        if int(rank_number) == 1:
            sql = """delete from naver_movie_rank"""
            curs.execute(sql)

        sql = """insert into naver_movie_rank (rank, title, url, image_url, director_name, actor_names) values (%s, %s, %s, %s, %s, %s)"""
        curs.execute(sql, (rank_number, title, info_url, image_url, director_name, actor_names))
        '''
        sql = """select title from naver_movie_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == title:
            # print("same naver moive")
            pass
        else:
            # print("change value " + str(rank_number) + " : " + title)
            sql = """update naver_movie_rank set title=%s, url=%s, image_url=%s where rank=%s"""
            curs.execute(sql, (title, info_url, image_url, rank_number))
        '''
        conn.commit()
        conn.close()
