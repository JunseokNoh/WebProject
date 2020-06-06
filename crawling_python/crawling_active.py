import crawling_billboard_music_rank
import crawling_bugs_music_rank
import crawling_genie_music_rank
import crawling_melon_music_rank
import crawling_nate_trends_rank
import crawling_naver_movie_rank
import crawling_naver_trends_rank
import crawling_zum_trends_rank
import db_time_value_set

import datetime
import time


def main():
    # Movie Fields
    naverMovieRank = crawling_naver_movie_rank.NaverMovieCrawling('https://movie.naver.com/movie/sdb/rank/rmovie.nhn',
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
    '''
    genieMusicRank = crawling_genie_music_rank.GenieMusicCrawling('https://www.genie.co.kr/chart/top200',
                                                                  'https://www.genie.co.kr/chart/top200',
                                                                  'yoobi',
                                                                  'toor',
                                                                  'jsp_db',
                                                                  'utf8')

    melonMusicRank = crawling_melon_music_rank.MelonMusicCrawling('https://www.melon.com/chart/index.htm',
                                                                  'https://www.melon.com/chart/index.htm',
                                                                  'yoobi',
                                                                  'toor',
                                                                  'jsp_db',
                                                                  'utf8')
                                                                  
    
    '''
    setTimeDate = db_time_value_set.DBTimeValueSet('hackery00bi.iptime.org',
                                                   '6666',
                                                   'yoobi',
                                                   'toor',
                                                   'jsp_db',
                                                   'utf8')

    while True:
        onehundredsixtyeightTime = 0
        while onehundredsixtyeightTime < 168:
            twentyfourTime = 0
            while twentyfourTime < 24:
                sixTime = 0
                while sixTime < 6:
                    tenTime = 0
                    while tenTime < 10:
                        # 1m
                        # naverTrendsRank.crawler()
                        setTimeDate.connect_db("1m")
                        time.sleep(60)
                        tenTime += 1
                    # 10m
                    # zumTrendsRank.crawler()
                    # nateTrendsRank.crawler()
                    setTimeDate.connect_db("10m")
                    sixTime += 1

                # 1h
                now = time.localtime()
                if 1 < now.tm_hour < 7:
                    continue
                # bugsMusicRank.crawler()
                '''
                genieMusicRank.crawler()
                melonMusicRank.crawler()
                '''
                setTimeDate.connect_db("1h")
                twentyfourTime += 1
            # 1d
            # naverMovieRank.crawler()
            setTimeDate.connect_db("1d")
            onehundredsixtyeightTime += 1
        # 1w
        # billboardMusicRank.crawler()
        setTimeDate.connect_db("1w")


def set_time_db():
    pass


main()
