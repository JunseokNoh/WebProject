import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class BillboardMusicCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, article_url, db_host, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div.chart-list.container >" +
                               "ol.chart-list__elements >" +
                               "li.chart-list__element.display--flex")
            # print(soup)

            for i in range(len(soup)):
                RANK_SONG_TITLE = soup[i].find("span", {"class": "chart-element__information__song"}).get_text()
                RANK_SONG_ARTIST = soup[i].find("span", {"class": "chart-element__information__artist"}).get_text()
                self.connect_db(i, RANK_SONG_TITLE, RANK_SONG_ARTIST)
                # print(str(i + 1) + " : " + RANK_SONG_TITLE + " : " + RANK_SONG_ARTIST)

        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, song_title, song_artist):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """select song_title from billboard_music_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == song_title:
            print("same billboard")
        else:
            sql = """update billboard_music_rank set song_title=%s, song_artist=%s where rank=%s"""
            curs.execute(sql, (song_title, song_artist, rank_number))

        conn.commit()
        conn.close()