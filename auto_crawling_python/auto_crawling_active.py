# trend
import crawling_google_trends_rank
import crawling_nate_trends_rank
import crawling_naver_trends_rank
import crawling_zum_trends_rank

# Music
import crawling_bugs_music_rank
import crawling_genie_music_rank
import crawling_melon_music_rank
import crawling_flo_music_rank

# Movie
import crawling_boxoffice_movie_rank
import crawling_naver_movie_rank
import crawling_naver_movie_rating_rank
import crawling_daum_movie_rank

# Book
import crawling_aladin_book_rank
import crawling_kyobo_book_rank
import crawling_yes24_book_rank
import crawling_interpark_book_rank

# App
import crawling_appstore_app_rank
import crawling_googleplay_app_rank
import crawling_onestore_app_rank

# Game
import crawling_appstore_game_rank
import crawling_googleplay_game_rank
import crawling_onestore_game_rank

# Overseas
import crawling_billboard_music_rank
import crawling_boxoffice_movie_us_rank
import crawling_google_trends_us_rank
import crawling_amazon_book_rank

import db_time_value_set

import datetime
import time


def main():
    today = datetime.datetime.now().strftime("%Y-%m-%d")

    # Trends Fields
    googleTrendsRank = crawling_google_trends_rank.GoogleTrendsCrawling(
        'https://trends.google.co.kr//trends/api/dailytrends?hl=ko&tz=-540&geo=KR&ns=15',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

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

    setTimeDate = db_time_value_set.DBTimeValueSet('hackery00bi.iptime.org',
                                                   '6666',
                                                   'yoobi',
                                                   'toor',
                                                   'jsp_db',
                                                   'utf8')

    # Music Fields
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

    floMusicRank = crawling_flo_music_rank.FloMusicCrawling(
        'https://www.music-flo.com/api/display/v1/browser/chart/1/track/list?size=100&timestamp=1593522061633',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    # Movie Fields
    boxofficeMovieRank = crawling_boxoffice_movie_rank.BoxofficeMovieCrawling(
        'https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&query=%EB%B0%95%EC%8A%A4%EC%98%A4%ED%94%BC%EC%8A%A4%20%ED%9D%A5%ED%96%89%EC%88%9C%EC%9C%84',
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

    naverMovieRatingRank = crawling_naver_movie_rating_rank.NaverMovieRatingCrawling(
        'https://movie.naver.com/movie/sdb/rank/rmovie.nhn?sel=cur',
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

    # Book Fields
    aladinBookRank = crawling_aladin_book_rank.AladinBookCrawling(
        'https://www.aladin.co.kr/shop/common/wbest.aspx?BestType=Bestseller&BranchType=1&CID=0',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    kyoboBookRank = crawling_kyobo_book_rank.KyoboBookCrawling(
        'http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf',
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

    interBookRank = crawling_interpark_book_rank.InterparkBookCrawling(
        'http://book.interpark.com/display/collectlist.do?_method=bestsellerHourNew&bookblockname=b_gnb&booklinkname=%BA%A3%BD%BA%C6%AE%C1%B8&bid1=bgnb_mn&bid2=LiveRanking&bid3=main&bid4=001#',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    # App
    googleplayAppRank = crawling_googleplay_app_rank.GoogleplayAppCrawling(
        'https://www.mobileindex.com/app/get_rank_all?rt=r&mk=2&c=kr&t=app&rs=100&d=' + today,
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    appstoreAppRank = crawling_appstore_app_rank.AppstoreAppCrawling(
        'https://www.mobileindex.com/app/get_rank_all?rt=r&mk=1&c=kr&t=app&rs=100&d=' + today,
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    onestoreAppRank = crawling_onestore_app_rank.OnestoreAppCrawling(
        'https://www.mobileindex.com/app/get_rank_all?rt=r&mk=6&c=kr&t=app&rs=100&d=' + today,
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    # Game
    googleplayGameRank = crawling_googleplay_game_rank.GoogleplayGameCrawling(
        'https://www.mobileindex.com/app/get_rank_all?rt=r&mk=2&c=kr&t=game&rs=100&d=' + today,
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    appstoreGameRank = crawling_appstore_game_rank.AppstoreGameCrawling(
        'https://www.mobileindex.com/app/get_rank_all?rt=r&mk=1&c=kr&t=game&rs=100&d=' + today,
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    onestoreGameRank = crawling_onestore_game_rank.OnestoreGameCrawling(
        'https://www.mobileindex.com/app/get_rank_all?rt=r&mk=6&c=kr&t=game&rs=100&d=' + today,
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    # Overseas
    googleTrendsUSRank = crawling_google_trends_us_rank.GoogleTrendsUSCrawling(
        'https://trends.google.co.kr//trends/api/dailytrends?hl=ko&tz=-540&geo=US&ns=15',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    boxofficeMovieUSRank = crawling_boxoffice_movie_us_rank.BoxofficeMovieUSCrawling(
        'https://www.imdb.com/chart/boxoffice?pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=4da9d9a5-d299-43f2-9c53-f0efa18182cd&pf_rd_r=VFM1Y18W9AQXQZW0QD8P&pf_rd_s=right-4&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_ql_1',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    billboardMusicRank = crawling_billboard_music_rank.BillboardMusicCrawling(
        'https://www.billboard.com/charts/hot-100',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    amazonBookRank = crawling_amazon_book_rank.AmazonBookCrawling(
        'https://www.amazon.com/best-sellers-books-Amazon/zgbs/books',
        'hackery00bi.iptime.org',
        '6666',
        'yoobi',
        'toor',
        'jsp_db',
        'utf8')

    f = open("./../../active_log.txt", "a")
    f.write("\n##### start #####\n")
    print("\n##### start #####")
    time_for_log = datetime.datetime.now()
    f.write(str(time_for_log) + "\n\n")
    print(str(time_for_log) + "\n")
    f.close()

    check = time_for_log.minute + 1

    while True:
        # 1m
        now = datetime.datetime.now()

        setTimeDate.connect_db("1m")
        setTimeDate.connect_db("10m")
        setTimeDate.connect_db("1h")
        setTimeDate.connect_db("1d")

        if now.minute == check:
            check = now.minute + 1

            if now.minute == 0 and (6 < now.hour <= 24 or now.hour == 1):
                # 1h without am2 ~ am6
                # Music
                bugsMusicRank.crawler()
                melonMusicRank.crawler()
                genieMusicRank.crawler()
                floMusicRank.crawler()

                #Movie
                naverMovieRank.crawler()
                naverMovieRatingRank.crawler()
                daumMovieRank.crawler()
                boxofficeMovieRank.crawler()

                #Book
                aladinBookRank.crawler()
                yes24BookRank.crawler()
                interBookRank.crawler()
                kyoboBookRank.crawler()

                #App
                appstoreAppRank.crawler()
                googleplayAppRank.crawler()
                onestoreAppRank.crawler()

                #Game
                appstoreGameRank.crawler()
                googleplayGameRank.crawler()
                onestoreGameRank.crawler()

                #Overseas
                billboardMusicRank.crawler()
                googleTrendsUSRank.crawler()
                amazonBookRank.crawler()
                boxofficeMovieUSRank.crawler()

            if now.minute % 10 == 0:
                # 10m
                googleTrendsRank.crawler()
                zumTrendsRank.crawler()
                nateTrendsRank.crawler()

            # 1m
            naverTrendsRank.crawler()

        if now.minute == 59:
            check = 0
        time.sleep(1)


main()
