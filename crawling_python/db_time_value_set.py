import pymysql
import time

class DBTimeValueSet:
    def __init__(self, db_host, db_port, db_user, db_pw, db_name, db_charset):
        self.__DB_HOST = db_host
        self.__DB_PORT = db_port
        self.__DB_USER = db_user
        self.__DB_PW = db_pw
        self.__DB_NAME = db_name
        self.__DB_CHARSET = db_charset

    def connect_db(self, type):
        conn = pymysql.connect(host=self.DB_HOST(),
                               port=int(self.DB_PORT()),
                               user=self.DB_USER(),
                               password=self.DB_PW(),
                               db=self.DB_NAME(),
                               charset=self.DB_CHARSET())
        curs = conn.cursor()

        print(type)
        if type == '1m':
            now = time.localtime()
            now = "%04d/%02d/%02d %02d:%02d" % (now.tm_year, now.tm_mon, now.tm_mday, now.tm_hour, now.tm_min)
            sql = """update time_data set timedata=%s where type=%s"""
            curs.execute(sql, (now, type))
            print('1m updated')

        elif type == '10m':
            now = time.localtime()
            now = "%04d/%02d/%02d %02d:%02d" % (now.tm_year, now.tm_mon, now.tm_mday, now.tm_hour, now.tm_min)
            sql = """update time_data set timedata=%s where type=%s"""
            curs.execute(sql, (now, type))
            print('10m updated')

        elif type == '1h':
            now = time.localtime()
            now = "%04d/%02d/%02d %02d" % (now.tm_year, now.tm_mon, now.tm_mday, now.tm_hour)
            sql = """update time_data set timedata=%s where type=%s"""
            curs.execute(sql, (now, type))
            print('1h updated')

        elif type == '1d':
            now = time.localtime()
            now = "%04d/%02d/%02d" % (now.tm_year, now.tm_mon, now.tm_mday)
            sql = """update time_data set timedata=%s where type=%s"""
            curs.execute(sql, (now, type))
            print('1d updated')

        elif type == '1w':
            now = time.localtime()
            now = "%04d/%02d/%02d" % (now.tm_year, now.tm_mon, now.tm_mday)
            sql = """update time_data set timedata=%s where type=%s"""
            curs.execute(sql, (now, type))
            print('1w updated')

        conn.commit()
        conn.close()

    def DB_HOST(self):
        return self.__DB_HOST

    def DB_PORT(self):
        return self.__DB_PORT

    def DB_USER(self):
        return self.__DB_USER

    def DB_PW(self):
        return self.__DB_PW

    def DB_NAME(self):
        return self.__DB_NAME

    def DB_CHARSET(self):
        return self.__DB_CHARSET