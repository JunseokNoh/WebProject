"""
::: CONTENTS :::
Project		: naver_movie_rank_crawling
Version		: ver.20200603
Filename	: naver_movie_rank_crawling_ver.1.py
Date		: 2020/06/03
Purpose		: get naver moive rank
Programmer	: Yoobi (hackery00bi@gmail.com)
Reviewer	:
PatchNote   :
- ver.20200603 -
(1) crawling naver movie rank data
(2) connect DB & insert data to MYSQL

"""

import pymysql
import requests
from bs4 import BeautifulSoup
from datetime import datetime

RESULT_PATH = './crawling_result/'
MAIN_URL = 'https://movie.naver.com/movie/bi/mi/basic.nhn?code=182835'
DATE = 0
ARTICLE_URL = ''


def main():
    crawler()


# crawling web site
def crawler():
    global ARTICLE_URL

    try:
        '''
        header = {
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36',
            'Content-type': 'application/x-www-form-urlencoded',
            'Origin': 'http://www.kobis.or.kr',
            'Referer': 'http://www.kobis.or.kr/kobis/business/main/main.do',
            'Accept-Encoding': 'gzip, deflate',
            'Accept-Language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7,zh-CN;q=0.6,zh;q=0.5'
        }
        '''
        header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'}
        req = requests.get(MAIN_URL, headers=header)  ## 주간 차트를 크롤링 할 것임
        #req = requests.get(MAIN_URL)#, headers=header)  ## 주간 차트를 크롤링 할 것임
        cont = req.content
        soup = BeautifulSoup(cont, 'lxml')

        print(soup)

        soup = str(soup)
        '''
        soup = soup.split('"date"')
        #soup = soup[1].split('"')
        print(soup)
        print("####")
        print(soup[1])
        #print(soup)


        # soup = soup.select("span.ellip.per90")

        # print(soup)
        
        for i in range(len(soup)):
            RANK_URL = soup[i].find("a")["href"]
            RANK_NAME = soup[i].find("a")["title"]
            # connect_db(i, RANK_NAME, RANK_URL)
            print(str(i + 1) + " : " + RANK_NAME + " : " + RANK_URL)
        '''
    except Exception as e:
        error_logging(str(e))
        print("Error Detected")


# get news div ID = articleBodyContents
def get_news(n_url):
    global date
    breq = requests.get(n_url)
    bsoup = BeautifulSoup(breq.content, 'lxml')
    date = bsoup.select("div#wrap > div#content > div.clear.tp_5 > p.conTop2 > span")
    date = date[0]
    date = str(date)[68:75]
    # print(date)

    text = bsoup.select("div#wrap > div#content > div.bodyarea")
    text = text[0]
    # print(text)
    f = open(RESULT_PATH + date + ".txt", 'a', encoding='utf-8')

    f.write("{}\n".format(text))

    f.close()


# error logging
def error_logging(text):
    fe = open(RESULT_PATH + "error_log/error_log.txt", 'a', encoding='utf-8')
    fe.write("{} {} {}\n".format(datetime.now(), ARTICLE_URL, text))
    fe.close()


def connect_db(i, movie_title, movie_info_url):
    rank_number = i + 1
    conn = pymysql.connect(host='localhost', user='yoobi', password='toor', db='jsp_db', charset='utf8')

    curs = conn.cursor()

    sql = """insert into naver_movie_rank(rank, title, url) values (%s, %s, %s)"""
    curs.execute(sql, (rank_number, movie_title, movie_info_url))
    conn.commit()
    conn.close()


main()
