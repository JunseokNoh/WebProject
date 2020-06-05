import pymysql
import requests
from bs4 import BeautifulSoup
from datetime import datetime
from abc import *


class Crawling:
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        self.__RESULT_PATH = './crawling_result/'
        self.__MAIN_URL = main_url
        self.__ARTICLE_URL = article_url
        self.__DB_HOST = db_host
        self.__DB_USER = db_user
        self.__DB_PW = db_pw
        self.__DB_NAME = db_name
        self.__DB_CHARSET = db_charset

    @abstractmethod
    def crawler(self):
        pass

    def error_logging(self, text):
        fe = open(self.RESULT_PATH + "error_log/error_log.txt", 'a', encoding='utf-8')
        fe.write("{} {} {}\n".format(datetime.now(), self.ARTICLE_URL, text))
        fe.close()

    @abstractmethod
    def connect_db(self, i, movie_title, movie_info_url):
        pass
