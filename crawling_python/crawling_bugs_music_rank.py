import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class BugsMusicCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, article_url, db_host, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("table.list.trackList.byChart >" +
                               "tbody >" +
                               "tr")
            # print(soup)

            for i in range(len(soup)):
                SONG_RANK = soup[i].find("div", {"class": "ranking"}).find("strong").get_text()
                RANK_ALBUM_TITLE = soup[i].find("a", {"class": "album"}).get_text()
                RANK_ALBUM_URL = soup[i].find("a", {"class": "thumbnail"})["href"]
                RANK_SONG_TITLE = soup[i].find("p", {"class": "title"}).find("a").get_text()
                RANK_SONG_ARTIST = soup[i].find("td", {"class": "left"}).find("p", {"class": "artist"}).find("a").get_text()
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

        sql = """select song_title from bugs_music_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == song_title:
            print("same bugs")
        else:
            sql = """update bugs_music_rank set album_title=%s, album_url=%s, song_title=%s, song_artist=%s where rank=%s"""
            curs.execute(sql, (album_title, album_info_url, song_title, song_artist, rank_number))

        conn.commit()
        conn.close()