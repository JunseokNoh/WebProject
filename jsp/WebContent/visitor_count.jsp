<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Count page</title>
</head>
<body>
<%
	Connection con = null;
	int temp;
	PreparedStatement total_count_PS = null;
	ResultSet total_count_RS = null;

	PreparedStatement today_count_PS = null;
	ResultSet today_count_RS = null;

	PreparedStatement update_total_PS = null;
	int update_total_RS;
	
	PreparedStatement update_today_PS = null;
	int update_today_RS;

	String MYSQL_SERVER = "hackery00bi.iptime.org:6666";
	String MYSQL_SERVER_USERNAME = "yoobi";
	String MYSQL_SERVER_PASSWORD = "toor";
	String MYSQL_DATABASE = "jsp_db";
	String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);

	//get Count
	String total_query = "select count from visitor_count where type='total'";
	total_count_PS = con.prepareStatement(total_query);
	total_count_RS = total_count_PS.executeQuery();
	total_count_RS.next();
	int total_count = total_count_RS.getInt("count");

	String today_query = "select count from visitor_count where type='today'";
	today_count_PS = con.prepareStatement(today_query);
	today_count_RS = today_count_PS.executeQuery();
	today_count_RS.next();
	int today_count = today_count_RS.getInt("count");

	//update Counter
	String update_total = "update visitor_count set count=? where type='total'";
	update_total_PS = con.prepareStatement(update_total);
	update_total_PS.setInt(1, total_count+1);
	update_total_RS = update_total_PS.executeUpdate();
	if (update_total_RS == 1) {
		System.out.println("success total-count updating");
	}
	
	String update_today = "update visitor_count set count=? where type='today'";
	update_today_PS = con.prepareStatement(update_today);
	update_today_PS.setInt(1, today_count+1);
	update_today_RS = update_today_PS.executeUpdate();
	if (update_today_RS == 1) {
		System.out.println("success today-count updating");
	}
%>
<hr>
<p style="text-align:center; font-size:20px;"><strong>TODAY <%=today_count+1%> TOTAL <%=total_count+1 %></strong></p>
<br>
<br>
</body>
</html>
