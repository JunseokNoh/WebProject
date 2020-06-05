import crawling_naver_move_rank


def main():
    naverMovieRank = crawling_naver_move_rank.NaverMovieCrawling('https://movie.naver.com/movie/sdb/rank/rmovie.nhn',
                                                                 'https://movie.naver.com/',
                                                                 'localhost',
                                                                 'yoobi',
                                                                 'toor',
                                                                 'jsp_db',
                                                                 'utf8')

    naverMovieRank.crawler()


main()
