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
                IMAGE_URL = self.get_image(BOOK_URL)
                self.connect_db(i, BOOK_TITLE, BOOK_URL, BOOK_AUTHOR, BOOK_PUBLISHER, IMAGE_URL, "", "")
                #print(str(i + 1) + " : " + BOOK_TITLE + " : " + BOOK_URL + " : " + BOOK_AUTHOR + " : " + BOOK_PUBLISHER)
            f = open("./active_log.txt", "a")
            f.write("table : yes24_book_rank UPDATED" + "\n")
            print("table : yes24_book_rank UPDATED")
            f.close()
        except Exception as e:
            super().error_logging(str(e))
            print("Error Detected")

    def get_image(self, URL):
        URL = URL
        header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
        req = requests.get(URL, headers=header)  ## 주간 차트를 크롤링 할 것임
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')
        #print(soup)
        soup = soup.select("em.imgBdr")
        return soup[0].find("img")["src"]

    def connect_db(self, i, book_title, book_info_url, book_author, book_publisher, image_url, tmp7, tmp8):
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
            #print("same yes24")
            pass
        else:
            #print(str(rank_number) + " : " + book_title + " : " + " : " + book_author + " : " + book_publisher)
            sql = """update yes24_book_rank set title=%s, url=%s, author=%s, publisher=%s, image_url=%s where rank=%s"""
            curs.execute(sql, (book_title, book_info_url, book_author, book_publisher, image_url, rank_number))

        conn.commit()
        conn.close()