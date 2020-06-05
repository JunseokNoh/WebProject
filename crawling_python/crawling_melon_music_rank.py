import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class MelonMusicCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, article_url, db_host, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
            req = requests.get(super().MAIN_URL(), headers=header)  ## 주간 차트를 크롤링 할 것임
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div.service_list_song.type02.d_song_list >" +
                               "table >" +
                               "tbody >" +
                               "tr.lst50")
            # print(soup)

            for i in range(len(soup)):
                SONG_RANK = soup[i].find("div", {"class": "t_center"}).find("span", {"class": "rank"}).get_text()
                RANK_ALBUM_TITLE = soup[i].find("a", {"class": "image_typeAll"})["title"]

                RANK_ALBUM_URL = soup[i].find("a", {"class": "image_typeAll"})["href"]
                RANK_ALBUM_URL = "https://www.melon.com/album/detail.htm?albumId=" + RANK_ALBUM_URL[37:45]

                RANK_SONG_TITLE = soup[i].find("div", {"class": "wrap_song_info"}).find("div", {"class": "rank01"}).find("span").find("a").get_text()
                RANK_SONG_ARTIST = soup[i].find("div", {"class": "wrap_song_info"}).find("div", {"class": "rank02"}).find("span").find("a").get_text()

                self.connect_db(SONG_RANK, RANK_ALBUM_TITLE, RANK_ALBUM_URL, RANK_SONG_TITLE, RANK_SONG_ARTIST)
                #print(SONG_RANK + " : " + RANK_ALBUM_TITLE + " : " + RANK_ALBUM_URL + " : " + RANK_SONG_TITLE + " : " + RANK_SONG_ARTIST)

        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, rank_number, album_title, album_info_url, song_title, song_artist):

        conn = pymysql.connect(host=super().DB_HOST(),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """select title from melon_music_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[3] == song_title:
            print("same melon")
        else:
            sql = """update melon_music_rank set album_title=%s, album_url=%s, song_title=%s, song_artist=%s where rank=%s"""
            curs.execute(sql, (album_title, album_info_url, song_title, song_artist, rank_number))

        conn.commit()
        conn.close()