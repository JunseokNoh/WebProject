import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class BugsMusicCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("table.list.trackList.byChart > " +
                               "tbody > " +
                               "tr")
            # print(soup)

            for i in range(len(soup)):
                SONG_RANK = soup[i].find("div", {"class": "ranking"}).find("strong").get_text()
                SONG_TITLE = soup[i].find("p", {"class": "title"}).find("a").get_text()
                SONG_URL = soup[i].find("a", {"class": "trackInfo"})["href"]
                SONG_ARTIST = soup[i].find("p", {"class": "artist"}).find("a").get_text()
                ARTIST_URL = soup[i].find("p", {"class": "artist"}).find("a")["href"]
                ALBUM_TITLE = soup[i].find("a", {"class": "album"}).get_text()
                ALBUM_URL = soup[i].find("a", {"class": "album"})["href"]
                IMAGE_URL = self.get_image(SONG_URL)

                #print(IMAGE_URL)
                self.connect_db(SONG_RANK, SONG_TITLE, SONG_URL, SONG_ARTIST, ARTIST_URL, ALBUM_TITLE, ALBUM_URL, IMAGE_URL)
                #print(SONG_RANK + " : " + SONG_TITLE + " : " + SONG_ARTIST + " : " + ALBUM_TITLE +
                #      "\n" + SONG_URL + "\n" + ARTIST_URL + "\n" + ALBUM_URL)
            f = open("./../../manual_active_log.txt", "a")
            f.write("table : bugs_music_rank UPDATED" + "\n")
            print("table : bugs_music_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def get_image(self, URL):
        header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
        req = requests.get(URL, headers=header)  ## 주간 차트를 크롤링 할 것임
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')

        return soup.select("li.big > a > img")[0]["src"]

    def connect_db(self, rank_number, song_title, song_url, song_artist, artist_url, album_title, album_url, image_url):

        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        if int(rank_number) == 1:
            sql = """delete from bugs_music_rank"""
            curs.execute(sql)

        sql = """insert into bugs_music_rank (rank, song_title, song_url, song_artist, artist_url, album_title, album_url, image_url) values (%s, %s, %s, %s, %s, %s, %s, %s)"""
        curs.execute(sql, (rank_number, song_title, song_url, song_artist, artist_url, album_title, album_url, image_url))
        '''
        sql = """select song_title from bugs_music_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == song_title:
            #print("same bugs music")
            pass
        else:
            #print(str(rank_number) + " : " + song_title + " : " + song_artist + " : " + album_title)
            sql = """update bugs_music_rank set song_title=%s, song_url=%s, song_artist=%s, artist_url=%s, album_title=%s, album_url=%s, image_url=%s where rank=%s"""
            curs.execute(sql, (song_title, song_url, song_artist, artist_url, album_title, album_url, image_url, rank_number))
        '''
        conn.commit()
        conn.close()
