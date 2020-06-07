import crawling_boxoffice_movie_rank
import crawling_naver_movie_rank
import crawling_naver_movie_rating_rank
import crawling_daum_movie_rank
import crawling_nate_trends_rank
import crawling_naver_trends_rank
import crawling_zum_trends_rank
import crawling_billboard_music_rank
import crawling_bugs_music_rank
import crawling_genie_music_rank
import crawling_melon_music_rank
import crawling_aladin_book_rank
import crawling_kyobo_book_rank
import crawling_yes24_book_rank
import crawling_interpark_book_rank
import db_time_value_set

import datetime
import time


def main():
    # Movie Fields
    boxofficeMovieRank = crawling_boxoffice_movie_rank.BoxofficeMovieCrawling('https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&query=%EB%B0%95%EC%8A%A4%EC%98%A4%ED%94%BC%EC%8A%A4%20%ED%9D%A5%ED%96%89%EC%88%9C%EC%9C%84',
                                                                              'hackery00bi.iptime.org',
                                                                              '6666',
                                                                              'yoobi',
                                                                              'toor',
                                                                              'jsp_db',
                                                                              'utf8')

    naverMovieRank = crawling_naver_movie_rank.NaverMovieCrawling('https://movie.naver.com/movie/sdb/rank/rmovie.nhn',
                                                                  'hackery00bi.iptime.org',
                                                                  '6666',
                                                                  'yoobi',
                                                                  'toor',
                                                                  'jsp_db',
                                                                  'utf8')

    naverMovieRatingRank = crawling_naver_movie_rating_rank.NaverMovieRatingCrawling('https://movie.naver.com/movie/sdb/rank/rmovie.nhn?sel=cur',
                                                                                     'hackery00bi.iptime.org',
                                                                                     '6666',
                                                                                     'yoobi',
                                                                                     'toor',
                                                                                     'jsp_db',
                                                                                     'utf8')

    daumMovieRank = crawling_daum_movie_rank.DaumMovieCrawling('http://ticket2.movie.daum.net/Movie/MovieRankList.aspx',
                                                               'hackery00bi.iptime.org',
                                                               '6666',
                                                               'yoobi',
                                                               'toor',
                                                               'jsp_db',
                                                               'utf8')

    # Trends Fields

    zumTrendsRank = crawling_zum_trends_rank.ZumTrendsCrawling('http://issue.zum.com/daily/',
                                                               'hackery00bi.iptime.org',
                                                               '6666',
                                                               'yoobi',
                                                               'toor',
                                                               'jsp_db',
                                                               'utf8')

    naverTrendsRank = crawling_naver_trends_rank.NaverTrendsCrawling(
        'https://datalab.naver.com/keyword/realtimeList.naver?entertainment=-2&groupingLevel=0&marketing=-2&news=-2&sports=-2&where=main',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    nateTrendsRank = crawling_nate_trends_rank.NateTrendsCrawling('https://www.nate.com/',
                                                                  'hackery00bi.iptime.org',
                                                                  '6666',
                                                                  'yoobi',
                                                                  'toor',
                                                                  'jsp_db',
                                                                  'utf8')

    # Music Fields
    billboardMusicRank = crawling_billboard_music_rank.BillboardMusicCrawling(
        'https://www.billboard.com/charts/hot-100',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    bugsMusicRank = crawling_bugs_music_rank.BugsMusicCrawling('https://music.bugs.co.kr/chart',
                                                               'hackery00bi.iptime.org',
                                                               '6666',
                                                               'yoobi',
                                                               'toor',
                                                               'jsp_db',
                                                               'utf8')

    melonMusicRank = crawling_melon_music_rank.MelonMusicCrawling('https://www.melon.com/chart/index.htm',
                                                                  'hackery00bi.iptime.org',
                                                                  '6666',
                                                                  'yoobi',
                                                                  'toor',
                                                                  'jsp_db',
                                                                  'utf8')

    genieMusicRank = crawling_genie_music_rank.GenieMusicCrawling('https://www.genie.co.kr/chart/top200',
                                                                  'hackery00bi.iptime.org',
                                                                  '6666',
                                                                  'yoobi',
                                                                  'toor',
                                                                  'jsp_db',
                                                                  'utf8')

    # Book Fields
    aladinBookRank = crawling_aladin_book_rank.AladinBookCrawling('https://www.aladin.co.kr/shop/common/wbest.aspx?BestType=Bestseller&BranchType=1&CID=0',
                                                                  'hackery00bi.iptime.org',
                                                                  '6666',
                                                                  'yoobi',
                                                                  'toor',
                                                                  'jsp_db',
                                                                  'utf8')

    kyoboBookRank = crawling_kyobo_book_rank.KyoboBookCrawling('http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf',
                                                               'hackery00bi.iptime.org',
                                                               '6666',
                                                               'yoobi',
                                                               'toor',
                                                               'jsp_db',
                                                               'utf8')

    yes24BookRank = crawling_yes24_book_rank.Yes24BookCrawling('http://www.yes24.com/24/Category/BestSeller',
                                                               'hackery00bi.iptime.org',
                                                               '6666',
                                                               'yoobi',
                                                               'toor',
                                                               'jsp_db',
                                                               'utf8')

    interBookRank = crawling_interpark_book_rank.InterparkBookCrawling('http://book.interpark.com/display/collectlist.do?_method=bestsellerHourNew&bookblockname=b_gnb&booklinkname=%BA%A3%BD%BA%C6%AE%C1%B8&bid1=bgnb_mn&bid2=LiveRanking&bid3=main&bid4=001#',
                                                                       'hackery00bi.iptime.org',
                                                                       '6666',
                                                                       'yoobi',
                                                                       'toor',
                                                                       'jsp_db',
                                                                       'utf8')


    setTimeDate = db_time_value_set.DBTimeValueSet('hackery00bi.iptime.org',
                                                   '6666',
                                                   'yoobi',
                                                   'toor',
                                                   'jsp_db',
                                                   'utf8')

    #boxofficeMovieRank.crawler()
    #naverMovieRank.crawler()
    #naverMovieRatingRank.crawler()
    #daumMovieRank.crawler()
    #zumTrendsRank.crawler()
    #naverTrendsRank.crawler()
    #nateTrendsRank.crawler()
    #billboardMusicRank.crawler()
    #bugsMusicRank.crawler()
    #melonMusicRank.crawler()
    #genieMusicRank.crawler()
    #aladinBookRank.crawler()
    #kyoboBookRank.crawler()
    #yes24BookRank.crawler()
    interBookRank.crawler()

main()