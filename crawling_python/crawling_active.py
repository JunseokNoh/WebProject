import crawling_naver_move_rank
import crawling_zum_trends_rank

def main():
    naverMovieRank = crawling_naver_move_rank.NaverMovieCrawling('https://movie.naver.com/movie/sdb/rank/rmovie.nhn',
                                                                 'https://movie.naver.com/',
                                                                 'localhost',
                                                                 'yoobi',
                                                                 'toor',
                                                                 'jsp_db',
                                                                 'utf8')

    zumTrendsRank = crawling_zum_trends_rank.ZumTrendsCrawling( 'http://issue.zum.com/daily/',
                                                                 'https://movie.naver.com/',
                                                                 'localhost',
                                                                 'yoobi',
                                                                 'toor',
                                                                 'jsp_db',
                                                                 'utf8')

    naverMovieRank.crawler()
    zumTrendsRank.crawler()


main()
