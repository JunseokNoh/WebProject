import pymysql
import requests
from bs4 import BeautifulSoup
from datetime import datetime
from abc import *


class Crawling:
<<<<<<< Updated upstream
    def __init__(self, main_url, article_url, db_host, db_user, db_pw, db_name, db_charset):
        self.__RESULT_PATH = './crawling_result/'
        self.__MAIN_URL = main_url
        self.__ARTICLE_URL = article_url
        self.__DB_HOST = db_host
=======
    def __init__(self, main_url, db_host, db_port, db_user, db_pw, db_name, db_charset):
        self.__RESULT_PATH = './crawling_result/'
        self.__MAIN_URL = main_url
        self.__DB_HOST = db_host
        self.__DB_PORT = db_port
>>>>>>> Stashed changes
        self.__DB_USER = db_user
        self.__DB_PW = db_pw
        self.__DB_NAME = db_name
        self.__DB_CHARSET = db_charset

    @abstractmethod
    def crawler(self):
        pass

    def error_logging(self, text):
        fe = open(self.RESULT_PATH() + "error_log/error_log.txt", 'a', encoding='utf-8')
        fe.write("{} {}\n".format(datetime.now(), text))
        fe.close()

    @abstractmethod
    def connect_db(self, i, movie_title, movie_info_url):
        pass

    def RESULT_PATH(self):
        return self.__RESULT_PATH

    def MAIN_URL(self):
        return self.__MAIN_URL

<<<<<<< Updated upstream
    def ARTICLE_URL(self):
        return self.__ARTICLE_URL

    def DB_HOST(self):
        return self.__DB_HOST

=======
    def DB_HOST(self):
        return self.__DB_HOST

    def DB_PORT(self):
        return self.__DB_PORT

>>>>>>> Stashed changes
    def DB_USER(self):
        return self.__DB_USER

    def DB_PW(self):
        return self.__DB_PW

    def DB_NAME(self):
        return self.__DB_NAME

    def DB_CHARSET(self):
        return self.__DB_CHARSET

