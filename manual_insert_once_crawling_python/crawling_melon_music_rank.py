import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class MelonMusicCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
            req = requests.get(super().MAIN_URL(), headers=header)  ## 주간 차트를 크롤링 할 것임
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div.service_list_song.type02.d_song_list > " +
                               "table > " +
                               "tbody > " +
                               "tr.lst50")
            # print(soup)

            for i in range(len(soup)):
                SONG_RANK = soup[i].find("div", {"class": "t_center"}).find("span", {"class": "rank"}).get_text()

                SONG_TITLE = soup[i].find("div", {"class": "wrap_song_info"}).find("div", {"class": "rank01"}).find("span").find("a").get_text()
                SONG_URL = soup[i].find("a", {"class": "song_info"})["href"]
                SONG_URL = "https://www.melon.com/song/detail.htm?songId=" + SONG_URL[36:44]

                SONG_ARTIST = soup[i].find("div", {"class": "wrap_song_info"}).find("div", {"class": "rank02"}).find(
                    "span").find("a").get_text()
                ARTIST_URL = soup[i].find("div", {"class": "wrap_song_info"}).find("div", {"class": "rank02"}).find("span").find(
                    "a")["href"]
                ARTIST_URL = "https://www.melon.com/artist/timeline.htm?artistId=" + ARTIST_URL[38:44]

                ALBUM_TITLE = soup[i].find("a", {"class": "image_typeAll"})["title"]
                ALBUM_URL = soup[i].find("a", {"class": "image_typeAll"})["href"]
                ALBUM_URL = "https://www.melon.com/album/detail.htm?albumId=" + ALBUM_URL[37:45]
                IMAGE_URL = self.get_image(SONG_URL)
                self.connect_db(SONG_RANK, SONG_TITLE, SONG_URL, SONG_ARTIST, ARTIST_URL, ALBUM_TITLE, ALBUM_URL, IMAGE_URL)
                #print(SONG_RANK + " : " + SONG_TITLE + " : " + SONG_ARTIST + " : " + ALBUM_TITLE +
                #      "\n" + SONG_URL + "\n" + ARTIST_URL + "\n" + ALBUM_URL)
            f = open("./../../manual_active_log.txt", "a")
            f.write("table : melon_music_rank UPDATED" + "\n")
            print("table : melon_music_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def get_image(self, URL):
        header = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
        req = requests.get(URL, headers=header)  ## 주간 차트를 크롤링 할 것임
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')

        soup = soup.select("div.wrap_info > div.thumb > a.image_typeAll")
        return soup[0].find("img")["src"]

    def connect_db(self, rank_number, song_title, song_url, song_artist, artist_url, album_title, album_url, image_url):

        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """delete from melon_music_rank"""
        curs.execute(sql)

        sql = """insert into melon_music_rank (rank, song_title, song_url, song_artist, artist_url, album_title, album_url, image_url) values (%s, %s, %s, %s, %s, %s, %s, %s)"""
        curs.execute(sql, (rank_number, song_title, song_url, song_artist, artist_url, album_title, album_url, image_url))
        '''
        sql = """select song_title from melon_music_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == song_title:
            #print("same melon")
            pass
        else:
            #print(str(rank_number) + " : " + song_title + " : " + song_artist + " : " + album_title)
            sql = """update melon_music_rank set song_title=%s, song_url=%s, song_artist=%s, artist_url=%s, album_title=%s, album_url=%s, image_url=%s where rank=%s"""
            curs.execute(sql, (song_title, song_url, song_artist, artist_url, album_title, album_url, image_url, rank_number))
        '''
        conn.commit()
        conn.close()
