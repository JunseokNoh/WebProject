<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	Connection con = null;

	PreparedStatement reset_total_PS = null;
	int reset_total_RS;

	PreparedStatement reset_today_PS = null;
	int reset_today_RS;

	String MYSQL_SERVER = "hackery00bi.iptime.org:6666";
	String MYSQL_SERVER_USERNAME = "yoobi";
	String MYSQL_SERVER_PASSWORD = "toor";
	String MYSQL_DATABASE = "jsp_db";
	String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);

	String update_total = "update visitor_count set count=? where type='total'";
	reset_total_PS = con.prepareStatement(update_total);
	reset_total_PS.setInt(1, 0);
	reset_total_RS = reset_total_PS.executeUpdate();
	if (reset_total_RS == 1) {
		System.out.println("success total-count updating");
	}

	String update_today = "update visitor_count set count=? where type='today'";
	reset_today_PS = con.prepareStatement(update_today);
	reset_today_PS.setInt(1, 0);
	reset_today_RS = reset_today_PS.executeUpdate();
	if (reset_today_RS == 1) {
		System.out.println("success today-count updating");
	}
%>
</body>
</html>