import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class KyoboBookCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div#main_contents > ul.list_type01 > li")
            # print(soup)

            for i in range(len(soup)):
                BOOK_TITLE = soup[i].find("div", {"class": "title"}).find("strong").get_text()
                BOOK_URL = soup[i].find("div", {"class": "title"}).find("a")["href"]

                temp = soup[i].find("div", {"class": "author"}).get_text().lstrip().rstrip().split("|")
                BOOK_AUTHOR = temp[0].split("\r")[0]
                BOOK_PUBLISHER = temp[1].split("\r")[0]
                BOOK_PUBLICATION_DATE = temp[2].split("\r")[0][1:]
                IMAGE_URL = soup[i].find("img")["src"]
                self.connect_db(i, BOOK_TITLE, BOOK_URL, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_PUBLICATION_DATE, IMAGE_URL, "")
                #print(str(i + 1) + " : " + BOOK_TITLE + " : " + BOOK_URL + " : " + BOOK_AUTHOR + " : " + BOOK_PUBLISHER + " : " + BOOK_PUBLICATION_DATE)
            f = open("./../../manual_active_log.txt", "a")
            f.write("table : kyobo_book_rank UPDATED" + "\n")
            print("table : kyobo_book_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, book_title, book_info_url, book_author, book_publisher, book_publication_date, image_url, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """delete from kyobo_book_rank"""
        curs.execute(sql)

        sql = """insert into kyobo_book_rank (rank, title, url, author, publisher, date, image_url) values (%s, %s, %s, %s, %s, %s, %s)"""
        curs.execute(sql, (rank_number, book_title, book_info_url, book_author, book_publisher, book_publication_date, image_url))
        '''
        sql = """select title from kyobo_book_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == book_title:
            #print("same kyobo")
            pass
        else:
            #print(str(rank_number) + " : " + book_title + " : " + book_author + " : " + book_publisher + " : " + book_publication_date)
            sql = """update kyobo_book_rank set title=%s, url=%s, author=%s, publisher=%s, date=%s, image_url=%s where rank=%s"""
            curs.execute(sql, (book_title, book_info_url, book_author, book_publisher, book_publication_date, image_url, rank_number))
        '''
        conn.commit()
        conn.close()
