import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class InterparkBookCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, article_url, db_host, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("div.rankBestContentList > ol > li")
            # print(soup)

            for i in range(len(soup)):
                BOOK_TITLE = soup[i].find("div", {"class": "itemName"}).find("strong").get_text()
                BOOK_URL = "http://book.interpark.com" + soup[i].find("a")["href"]

                BOOK_AUTHOR = soup[i].find("div", {"class": "itemMeta"}).find("span", {"class": "author"}).get_text()
                BOOK_PUBLISHER = soup[i].find("div", {"class": "itemMeta"}).find("span",{"class": "company"}).get_text()

                self.connect_db(i, BOOK_TITLE, BOOK_URL, BOOK_AUTHOR, BOOK_PUBLISHER)
                #print(str(i + 1) + " : " + BOOK_TITLE + " : " + BOOK_URL + " : " + BOOK_AUTHOR + " : " + BOOK_PUBLISHER)

        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, book_title, book_info_url, book_author, book_publisher):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        sql = """select title from interpark_book_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == book_title:
            print("same interpark")
        else:
            sql = """update interpark_book_rank set title=%s, url=%s, author=%s, publisher=%s where rank=%s"""
            curs.execute(sql, (book_title, book_info_url, book_author, book_publisher, rank_number))

        conn.commit()
        conn.close()