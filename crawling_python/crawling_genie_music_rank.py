import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class GenieMusicCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, article_url, db_host, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
            req = requests.get(super().MAIN_URL(), headers=header)  ## 주간 차트를 크롤링 할 것임
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div#body-content >" +
                               "div.newest-list >" +
                               "div.music-list-wrap >" +
                               "table.list-wrap >" +
                               "tbody >" +
                               "tr.list")
            # print(soup)

            for i in range(len(soup)):
                SONG_RANK = soup[i].find("td", {"class": "number"}).get_text()
                SONG_RANK = SONG_RANK[0:SONG_RANK.find('\n')]

                SONG_TITLE = soup[i].find("a", {"class": "title"}).get_text()
                SONG_TITLE = SONG_TITLE.lstrip()
                SONG_URL = "https://www.genie.co.kr/detail/songInfo?xgnm=" + \
                           soup[i].find("td", {"class": "link"}).find("a")["onclick"][16:24]

                SONG_ARTIST = soup[i].find("a", {"class": "artist"}).get_text()
                ARTIST_URL = "https://www.genie.co.kr/detail/artistInfo?xxnm=" + soup[i].find("a", {"class": "artist"})[
                                                                                     "onclick"][14:22]

                ALBUM_TITLE = soup[i].find("a", {"class": "albumtitle"}).get_text()
                ALBUM_URL = "https://www.genie.co.kr/detail/albumInfo?axnm=" + soup[i].find("a", {"class": "cover"})[
                                                                                   "onclick"][18:26]

                self.connect_db(SONG_RANK, SONG_TITLE, SONG_URL, SONG_ARTIST, ARTIST_URL, ALBUM_TITLE, ALBUM_URL)
                # print(SONG_RANK + " : " + SONG_TITLE + " : " + SONG_ARTIST + " : " + ALBUM_TITLE
                #  + "\n" + SONG_URL + "\n" + ARTIST_URL + "\n" + ALBUM_URL)

        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, rank_number, song_title, song_url, song_artist, artist_url, album_title, album_url):

        conn = pymysql.connect(host=super().DB_HOST(),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """select song_title from genie_music_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == song_title:
            print("same genie")
        else:
            sql = """update genie_music_rank set song_title=%s, song_url=%s, song_artist=%s, artist_url=%s, album_title=%s, album_url=%s where rank=%s"""
            curs.execute(sql, (song_title, song_url, song_artist, artist_url, album_title, album_url, rank_number))

        conn.commit()
        conn.close()