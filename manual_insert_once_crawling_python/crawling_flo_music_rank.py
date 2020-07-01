import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *
import json

import crawling


class FloMusicCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content

            # print(cont)
            dict = json.loads(cont)
            #print(dict)
            dict = dict['data']['trackList']

            for i in range(len(dict)):
                SONG_RANK = str(i + 1)
                SONG_TITLE = dict[i]['name']
                SONG_URL = "https://www.music-flo.com/search/all?keyword=" + SONG_TITLE
                SONG_ARTIST = dict[i]['representationArtist']['name']
                ARTIST_URL = "https://www.music-flo.com/search/all?keyword=" + SONG_ARTIST
                ALBUM_TITLE = dict[i]['album']['title']
                ALBUM_URL = "https://www.music-flo.com/search/all?keyword=" + ALBUM_TITLE
                IMAGE_URL = dict[i]['album']['imgList'][0]['url']

                #print(IMAGE_URL)
                # print(SONG_RANK + " : " + SONG_TITLE + " : " + SONG_ARTIST + " : " + ALBUM_TITLE +
                #       "\n" + SONG_URL + "\n" + ARTIST_URL + "\n" + ALBUM_URL)
                self.connect_db(SONG_RANK, SONG_TITLE, SONG_URL, SONG_ARTIST, ARTIST_URL, ALBUM_TITLE, ALBUM_URL, IMAGE_URL)
                #self.connect_db(SONG_RANK, '', '', '', '', '', '', '')

            f = open("./../../active_log.txt", "a")
            f.write("table : flo_music_rank UPDATED" + "\n")
            print("table : flo_music_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, rank_number, song_title, song_url, song_artist, artist_url, album_title, album_url, image_url):

        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        if int(rank_number) == 1:
            sql = """delete from flo_music_rank"""
            curs.execute(sql)

        sql = """insert into flo_music_rank (rank, song_title, song_url, song_artist, artist_url, album_title, album_url, image_url) values (%s, %s, %s, %s, %s, %s, %s, %s)"""
        print(sql)
        curs.execute(sql, (rank_number, song_title, song_url, song_artist, artist_url, album_title, album_url, image_url))

        #sql = """insert into flo_music_rank (rank, song_title, song_url, song_artist, artist_url, album_title, album_url) values (%s, %s, %s, %s, %s, %s, %s)"""
        #curs.execute(sql, (rank_number, song_title, song_url, song_artist, artist_url, album_title, album_url))

        # sql = """select song_title from flo_music_rank where rank = %s"""
        # curs.execute(sql, rank_number)
        # row = curs.fetchone()
        # if row[0] == song_title:
        #     #print("same flo music")
        #     pass
        # else:
        #     #print(str(rank_number) + " : " + song_title + " : " + song_artist + " : " + album_title)
        #     sql = """update flo_music_rank set song_title=%s, song_url=%s, song_artist=%s, artist_url=%s, album_title=%s, album_url=%s, image_url=%s where rank=%s"""
        #     curs.execute(sql, (song_title, song_url, song_artist, artist_url, album_title, album_url, image_url, rank_number))

        conn.commit()
        conn.close()
