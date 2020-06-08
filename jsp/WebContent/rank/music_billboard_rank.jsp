<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOVIE RANKING</title>
</head>
<body>
	<%
		Connection con = null;
		PreparedStatement PS = null;
		ResultSet RS = null;
		try
		{
			String MYSQL_SERVER ="hackery00bi.iptime.org:6666";
			String MYSQL_SERVER_USERNAME = "yoobi";
			String MYSQL_SERVER_PASSWORD = "toor";
			String MYSQL_DATABASE = "jsp_db";
			String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);

			String query = "select timedata from time_data where type='1w'";
			PS = con.prepareStatement(query);
			RS = PS.executeQuery();
			RS.next();
			String time = RS.getString("timedata");	
			
			
			query = "select * from billboard_music_rank";
			PS = con.prepareStatement(query);
			RS = PS.executeQuery();
	%>
			기준 날짜 : <%=time%>
			<table border="1">
				<tr>
					<td>rank</td>
					<td>title</td>
					<td>artist</td>
				</tr>
	<%
			int count = 0;
			while(RS.next())
			{
				String rank = RS.getString("rank");
				String title = RS.getString("title");
				String artist = RS.getString("artist");
	%>
				<tr>
					<td><%=rank%></td>
					<td><%=title%></td>
					<td><%=artist%></td>
				</tr>
	<%
				count++;
			}
		}
		catch(Exception ErrMsg)
		{
//			ErrMsg.printStackTrace();
			out.println(ErrMsg);
		}
	
	%>
</body>
</html>
