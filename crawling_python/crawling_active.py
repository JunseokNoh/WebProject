import crawling_billboard_music_rank
import crawling_bugs_music_rank
import crawling_genie_music_rank
import crawling_melon_music_rank
import crawling_nate_trends_rank
import crawling_naver_movie_rank
import crawling_naver_trends_rank
import crawling_zum_trends_rank


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
    # naverMovieRank.crawler()
    # zumTrendsRank.crawler()
    # naverTrendsRank.crawler()
    # nateTrendsRank.crawler()

    # billboardMusicRank.crawler()

    #bugsMusicRank.crawler()
    '''
    genieMusicRank.crawler()
    melonMusicRank.crawler()
    '''

def set_time_db():
    pass

main()
