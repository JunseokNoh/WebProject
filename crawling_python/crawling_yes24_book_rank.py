import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class Yes24BookCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div#bestList > ol > li")
            # print(soup)

            for i in range(len(soup)):
                soup[i] = soup[i].select("p")

                BOOK_TITLE = soup[i][2].find("a").get_text()
                BOOK_URL = "http://www.yes24.com" + soup[i][2].find("a")["href"]

                temp = soup[i][3].get_text().split("|");
                BOOK_AUTHOR = temp[0][0:len(temp[0]) - 3]
                BOOK_PUBLISHER = temp[1][1:]

                self.connect_db(i, BOOK_TITLE, BOOK_URL, BOOK_AUTHOR, BOOK_PUBLISHER, "", "")
                #print(str(i + 1) + " : " + BOOK_TITLE + " : " + BOOK_URL + " : " + BOOK_AUTHOR + " : " + BOOK_PUBLISHER)

        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, book_title, book_info_url, book_author, book_publisher, tmp6, tmp7):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        #sql = """insert into yes24_book_rank (rank, title, url, author, publisher) values (%s, %s, %s, %s, %s)"""
        #curs.execute(sql, (rank_number, book_title, book_info_url, book_author, book_publisher))

        sql = """select title from yes24_book_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == book_title:
            print("same yes24")
        else:
            sql = """update yes24_book_rank set title=%s, url=%s, author=%s, publisher=%s where rank=%s"""
            curs.execute(sql, (book_title, book_info_url, book_author, book_publisher, rank_number))

        conn.commit()
        conn.close()