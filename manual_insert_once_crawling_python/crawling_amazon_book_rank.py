import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class AmazonBookCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("ol#zg-ordered-list > li > span > div > span.aok-inline-block.zg-item")
            #print(soup)

            for i in range(len(soup)):
                BOOK_TITLE = soup[i].select("a.a-link-normal > div")[0].get_text().lstrip()
                BOOK_TITLE = BOOK_TITLE[:len(BOOK_TITLE)-1].rstrip()
                BOOK_URL = "https://www.amazon.com/" + soup[i].select("a.a-link-normal")[0]["href"]
                BOOK_AUTHOR = soup[i].select("div > span")[0].get_text()
                IMAGE_URL = soup[i].select("a.a-link-normal > span > div > img")[0]["src"]
                self.connect_db(i, BOOK_TITLE, BOOK_URL, BOOK_AUTHOR, IMAGE_URL, "", "", "")
                # print(str(i + 1) + " : " + BOOK_TITLE + " : " + BOOK_URL + " : " + BOOK_AUTHOR)
            f = open("./../../active_log.txt", "a")
            f.write("table : amazon_book_rank UPDATED" + "\n")
            print("table : amazon_book_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def connect_db(self, i, book_title, book_info_url, book_author, image_url, tmp6, tmp7, tmp8):
        rank_number = i + 1
        conn = pymysql.connect(host=super().DB_HOST(),
                               port=int(super().DB_PORT()),
                               user=super().DB_USER(),
                               password=super().DB_PW(),
                               db=super().DB_NAME(),
                               charset=super().DB_CHARSET())
        curs = conn.cursor()

        #sql = """insert into amazon_book_rank (rank, title, url, author) values (%s, %s, %s, %s)"""
        #curs.execute(sql, (rank_number, book_title, book_info_url, book_author))

        sql = """select title from amazon_book_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == book_title:
            #print("same amazon")
            pass
        else:
            #print(str(rank_number) + " : " + book_title + " : " + book_info_url + " : " + book_author)
            sql = """update amazon_book_rank set title=%s, url=%s, author=%s, image_url=%s where rank=%s"""
            curs.execute(sql, (book_title, book_info_url, book_author, image_url, rank_number))

        conn.commit()
        conn.close()