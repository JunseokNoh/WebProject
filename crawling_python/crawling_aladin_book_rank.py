import pymysql
import requests
from bs4 import BeautifulSoup
from abc import *

import crawling


class AladinBookCrawling(crawling.Crawling, ABC):
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        super().__init__(main_url, db_host, db_port, db_user, db_pw, db_name, db_charset)

    def crawler(self):
        try:
            url = super().MAIN_URL()
            req = requests.get(url)
            cont = req.content
            soup = BeautifulSoup(cont, 'lxml')

            # print(soup)
            soup = soup.select("form#Myform > div.ss_book_box")

            for i in range(len(soup)):
                try:
                    IMAGE_URL = soup[i].find("img", {"class": "i_cover"})["src"]
                except Exception as e:
                    #soup[i] = soup[i].select("span")
                    IMAGE_URL = soup[i].find("img")["src"]
                    if IMAGE_URL[-3:] == "png":
                        continue
                soup[i] = soup[i].select("div.ss_book_list")
                soup[i] = soup[i][0].select("ul > li")

                if len(soup[i]) == 5:
                    index = 1
                elif len(soup[i]) == 4:
                    index = 0

                temp = soup[i][index + 1].select("a")
                BOOK_TITLE = soup[i][index].find("a", {"class": "bo3"}).find("b").get_text()
                BOOK_URL = soup[i][index].find("a", {"class": "bo3"})["href"]
                BOOK_AUTHOR = temp[0].get_text()
                BOOK_PUBLISHER = temp[1].get_text()

                BOOK_PUBLICATION_DATE = soup[i][index + 1].get_text()
                BOOK_PUBLICATION_DATE = BOOK_PUBLICATION_DATE.split("|")[2][1:]
                #print(IMAGE_URL)
                self.connect_db(i, BOOK_TITLE, BOOK_URL, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_PUBLICATION_DATE, IMAGE_URL, "")
                #print(str(i + 1) + " : " + BOOK_TITLE + " : " + BOOK_URL + " : " + BOOK_AUTHOR + " : " + BOOK_PUBLISHER + " : " + BOOK_PUBLICATION_DATE)
            f = open("./../../active_log.txt", "a")
            f.write("table : aladin_book_rank UPDATED" + "\n")
            print("table : aladin_book_rank UPDATED")
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

        #sql = """insert into aladin_book_rank (rank, title, url, author, publisher, date) values (%s, %s, %s, %s, %s, %s)"""
        #curs.execute(sql, (rank_number, book_title, book_info_url, book_author, book_publisher, book_publication_date))

        sql = """select title from aladin_book_rank where rank = %s"""
        curs.execute(sql, rank_number)
        row = curs.fetchone()
        if row[0] == book_title:
            #print("same aladin")
            pass
        else:
            #print(str(i + 1) + " : " + book_title + " : " + book_info_url + " : " + book_author + " : " + book_publisher + " : " + book_publication_date)
            sql = """update aladin_book_rank set title=%s, url=%s, author=%s, publisher=%s, date=%s, image_url=%s where rank=%s"""
            curs.execute(sql, (book_title, book_info_url, book_author, book_publisher, book_publication_date, image_url, rank_number))


        conn.commit()
        conn.close()