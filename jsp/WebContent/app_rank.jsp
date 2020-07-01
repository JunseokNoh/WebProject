<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
		Connection con = null;
		PreparedStatement Googleplay_app0_PS = null;
		ResultSet Googleplay_app0_RS = null;
		PreparedStatement Googleplay_app1_PS = null;
		ResultSet Googleplay_app1_RS = null;
		PreparedStatement Googleplay_app2_PS = null;
		ResultSet Googleplay_app2_RS = null;
		
		PreparedStatement Appstore_app0_PS = null;
		ResultSet Appstore_app0_RS = null;
		PreparedStatement Appstore_app1_PS = null;
		ResultSet Appstore_app1_RS = null;
		PreparedStatement Appstore_app2_PS = null;
		ResultSet Appstore_app2_RS = null;
		
		PreparedStatement Onestore_app0_PS = null;
		ResultSet Onestore_app0_RS = null;
		PreparedStatement Onestore_app1_PS = null;
		ResultSet Onestore_app1_RS = null;
		PreparedStatement Onestore_app2_PS = null;
		ResultSet Onestore_app2_RS = null;
		
		String MYSQL_SERVER ="hackery00bi.iptime.org:6666";
		String MYSQL_SERVER_USERNAME = "yoobi";
		String MYSQL_SERVER_PASSWORD = "toor";
		String MYSQL_DATABASE = "jsp_db";
		String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);

		/*googleplay*/
		String Googleplay_query = "select timedata from time_data where type='1d'";
		Googleplay_app0_PS = con.prepareStatement(Googleplay_query);
		Googleplay_app0_RS = Googleplay_app0_PS.executeQuery();
		Googleplay_app0_RS.next();
		String Googleplay_time = Googleplay_app0_RS.getString("timedata");	
			
		Googleplay_query = "select * from googleplay_app_rank where rank_type='0'";
		Googleplay_app0_PS = con.prepareStatement(Googleplay_query);
		Googleplay_app0_RS = Googleplay_app0_PS.executeQuery();
		
		Googleplay_query = "select * from googleplay_app_rank where rank_type='1'";
		Googleplay_app1_PS = con.prepareStatement(Googleplay_query);
		Googleplay_app1_RS = Googleplay_app1_PS.executeQuery();
		
		Googleplay_query = "select * from googleplay_app_rank where rank_type='2'";
		Googleplay_app2_PS = con.prepareStatement(Googleplay_query);
		Googleplay_app2_RS = Googleplay_app2_PS.executeQuery();
		
		/*Appstore*/
		String Appstore_query = "select timedata from time_data where type='1d'";
		Appstore_app0_PS = con.prepareStatement(Appstore_query);
		Appstore_app0_RS = Appstore_app0_PS.executeQuery();
		Appstore_app0_RS.next();
		String Appstore_time = Appstore_app0_RS.getString("timedata");	
			
		Appstore_query = "select * from appstore_app_rank where rank_type='0'";
		Appstore_app0_PS = con.prepareStatement(Appstore_query);
		Appstore_app0_RS = Appstore_app0_PS.executeQuery();
		
		Appstore_query = "select * from appstore_app_rank where rank_type='1'";
		Appstore_app1_PS = con.prepareStatement(Appstore_query);
		Appstore_app1_RS = Appstore_app1_PS.executeQuery();
		
		Appstore_query = "select * from appstore_app_rank where rank_type='2'";
		Appstore_app2_PS = con.prepareStatement(Appstore_query);
		Appstore_app2_RS = Appstore_app2_PS.executeQuery();
		
		/*Onestore*/
		String Onestore_query = "select timedata from time_data where type='1d'";
		Onestore_app0_PS = con.prepareStatement(Onestore_query);
		Onestore_app0_RS = Onestore_app0_PS.executeQuery();
		Onestore_app0_RS.next();
		String Onestore_time = Onestore_app0_RS.getString("timedata");	
			
		Onestore_query = "select * from onestore_app_rank where rank_type='0'";
		Onestore_app0_PS = con.prepareStatement(Onestore_query);
		Onestore_app0_RS = Onestore_app0_PS.executeQuery();
		
		Onestore_query = "select * from onestore_app_rank where rank_type='1'";
		Onestore_app1_PS = con.prepareStatement(Onestore_query);
		Onestore_app1_RS = Onestore_app1_PS.executeQuery();
		
		Onestore_query = "select * from onestore_app_rank where rank_type='2'";
		Onestore_app2_PS = con.prepareStatement(Onestore_query);
		Onestore_app2_RS = Onestore_app2_PS.executeQuery();
	%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>랭킹.pw</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>

<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/> 
<link href="https://www.velosofy.com/css/app.css" rel="stylesheet"/> 

<meta charset="utf-8"/> <meta content="width=device-width, initial-scale=1" name="viewport"/> 
	  
<!-- 추가해야할거 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/table.css">

<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script src="https://www.w3schools.com/lib/w3.js"></script>

<style type="text/css">

	#movie_1{
		width:100%;
	}
	
	#landing .container{
		padding-top:10px;
		padding-bottom:10px
	}
</style>
	
</head>

<body id="header">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
 <!-- 추가해야할거 -->
 <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script src="./js/script.js"></script>

<jsp:include page="header.jsp" flush="true"/>

</div> 
</nav> 

<main> 

<section id="landing" style="height"> 

<div class="container"> 

<h1 class="poppins" style="font-size:50px;">앱 차트</h1> 
<br>

</div> 
</section> 

<div class="container pb-5"> 


<div class="row">
	<!-- yoobi delete it
	 <div class="col-md-12 templates"> 
		<select class="select_box1" name="select" onchange="fnMove(value)">
		  <option>선택</option>
		  <option value="1">인터파크</option>
		  <option value="2">교보문고</option>
		  <option value="3">YES24</option>
		  <option value="4">알라딘</option>
		</select>
	</div>
	-->
	<br>
	<div id="div1" class="col-md-4 templates" style="width:100%;">

			<h3>무료순위<a style="font-size: medium; font-weight:bold">(Google Play)</a></h3>
			<h6 style="text-align:right;"><%=Googleplay_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			int count = 0;
			while(Googleplay_app0_RS.next())
			{
				String rank = Googleplay_app0_RS.getString("rank");
				String name = Googleplay_app0_RS.getString("name");
				String rank_type = Googleplay_app0_RS.getString("rank_type");
				String url = Googleplay_app0_RS.getString("url");
				String publisher = Googleplay_app0_RS.getString("publisher");
				String image_url = Googleplay_app0_RS.getString("image_url");

	%>
				<tr>
	<%
				if(rank.equals("1"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("2"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("3"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="45" height="45"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>
					
					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=url%> style="font-size:13px;font-weight:700;" target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=name%></div></a><br>
					<a style="font-size:11px; font-weight:10"target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=publisher%></div></a></td>
					
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>


<br>

<div id="div2" class="col-md-4 templates" style="width:100%;">

			<h3>유료순위<a style="font-size: medium; font-weight:bold">(Google Play)</a></h3>
			<h6 style="text-align:right;"><%=Googleplay_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Googleplay_app1_RS.next())
			{
				String rank = Googleplay_app1_RS.getString("rank");
				String name = Googleplay_app1_RS.getString("name");
				String rank_type = Googleplay_app1_RS.getString("rank_type");
				String url = Googleplay_app1_RS.getString("url");
				String publisher = Googleplay_app1_RS.getString("publisher");
				String image_url = Googleplay_app1_RS.getString("image_url");

	%>
				<tr>
	<%
				if(rank.equals("1"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("2"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("3"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="45" height="45"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=url%> style="font-size:13px;font-weight:700;" target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=name%></div></a><br>
					<a style="font-size:11px; font-weight:10"target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=publisher%></div></a></td>
					
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>

<br>

<div id="div3" class="col-md-4 templates" style="width:100%;">

			<h3>매출순위<a style="font-size: medium; font-weight:bold">(Google Play)</a></h3>
			<h6 style="text-align:right;"><%=Googleplay_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Googleplay_app2_RS.next())
			{
				String rank = Googleplay_app2_RS.getString("rank");
				String name = Googleplay_app2_RS.getString("name");
				String rank_type = Googleplay_app2_RS.getString("rank_type");
				String url = Googleplay_app2_RS.getString("url");
				String publisher = Googleplay_app2_RS.getString("publisher");
				String image_url = Googleplay_app2_RS.getString("image_url");

	%>
				<tr>
	<%
				if(rank.equals("1"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("2"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("3"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="45" height="45"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=url%> style="font-size:13px;font-weight:700;" target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=name%></div></a><br>
					<a style="font-size:11px; font-weight:10"target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=publisher%></div></a></td>
					
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>
	
<br>
	<div id="div4" class="col-md-4 templates" style="width:100%;">

			<h3>무료순위<a style="font-size: medium; font-weight:bold">(App Store)</a></h3>
			<h6 style="text-align:right;"><%=Appstore_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Appstore_app0_RS.next())
			{
				String rank = Appstore_app0_RS.getString("rank");
				String name = Appstore_app0_RS.getString("name");
				String rank_type = Appstore_app0_RS.getString("rank_type");
				String url = Appstore_app0_RS.getString("url");
				String publisher = Appstore_app0_RS.getString("publisher");
				String image_url = Appstore_app0_RS.getString("image_url");

	%>
				<tr>
	<%
				if(rank.equals("1"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("2"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("3"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="45" height="45"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>
					
					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=url%> style="font-size:13px;font-weight:700;" target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=name%></div></a><br>
					<a style="font-size:11px; font-weight:10"target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=publisher%></div></a></td>
					
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>


<br>

<div id="div5" class="col-md-4 templates" style="width:100%;">

			<h3>유료순위<a style="font-size: medium; font-weight:bold">(App Store)</a></h3>
			<h6 style="text-align:right;"><%=Appstore_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Appstore_app1_RS.next())
			{
				String rank = Appstore_app1_RS.getString("rank");
				String name = Appstore_app1_RS.getString("name");
				String rank_type = Appstore_app1_RS.getString("rank_type");
				String url = Appstore_app1_RS.getString("url");
				String publisher = Appstore_app1_RS.getString("publisher");
				String image_url = Appstore_app1_RS.getString("image_url");

	%>
				<tr>
	<%
				if(rank.equals("1"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("2"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("3"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="45" height="45"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=url%> style="font-size:13px;font-weight:700;" target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=name%></div></a><br>
					<a style="font-size:11px; font-weight:10"target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=publisher%></div></a></td>
					
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>

<br>

<div id="div6" class="col-md-4 templates" style="width:100%;">

			<h3>매출순위<a style="font-size: medium; font-weight:bold">(App Store)</a></h3>
			<h6 style="text-align:right;"><%=Appstore_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Appstore_app2_RS.next())
			{
				String rank = Appstore_app2_RS.getString("rank");
				String name = Appstore_app2_RS.getString("name");
				String rank_type = Appstore_app2_RS.getString("rank_type");
				String url = Appstore_app2_RS.getString("url");
				String publisher = Appstore_app2_RS.getString("publisher");
				String image_url = Appstore_app2_RS.getString("image_url");

	%>
				<tr>
	<%
				if(rank.equals("1"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("2"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("3"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="45" height="45"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=url%> style="font-size:13px;font-weight:700;" target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=name%></div></a><br>
					<a style="font-size:11px; font-weight:10"target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=publisher%></div></a></td>
					
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>

<br>

	<div id="div7" class="col-md-4 templates" style="width:100%;">

			<h3>무료순위<a style="font-size: medium; font-weight:bold">(One Store)</a></h3>
			<h6 style="text-align:right;"><%=Onestore_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Onestore_app0_RS.next())
			{
				String rank = Onestore_app0_RS.getString("rank");
				String name = Onestore_app0_RS.getString("name");
				String rank_type = Onestore_app0_RS.getString("rank_type");
				String url = Onestore_app0_RS.getString("url");
				String publisher = Onestore_app0_RS.getString("publisher");
				String image_url = Onestore_app0_RS.getString("image_url");

	%>
				<tr>
	<%
				if(rank.equals("1"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("2"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("3"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="45" height="45"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>
					
					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=url%> style="font-size:13px;font-weight:700;" target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=name%></div></a><br>
					<a style="font-size:11px; font-weight:10"target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=publisher%></div></a></td>
					
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>


<br>

<div id="div8" class="col-md-4 templates" style="width:100%;">

			<h3>유료순위<a style="font-size: medium; font-weight:bold">(One Store)</a></h3>
			<h6 style="text-align:right;"><%=Onestore_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Onestore_app1_RS.next())
			{
				String rank = Onestore_app1_RS.getString("rank");
				String name = Onestore_app1_RS.getString("name");
				String rank_type = Onestore_app1_RS.getString("rank_type");
				String url = Onestore_app1_RS.getString("url");
				String publisher = Onestore_app1_RS.getString("publisher");
				String image_url = Onestore_app1_RS.getString("image_url");

	%>
				<tr>
	<%
				if(rank.equals("1"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("2"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("3"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="45" height="45"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=url%> style="font-size:13px;font-weight:700;" target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=name%></div></a><br>
					<a style="font-size:11px; font-weight:10"target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=publisher%></div></a></td>
					
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>

<br>

<div id="div9" class="col-md-4 templates" style="width:100%;">

			<h3>매출순위<a style="font-size: medium; font-weight:bold">(One Store)</a></h3>
			<h6 style="text-align:right;"><%=Onestore_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Onestore_app2_RS.next())
			{
				String rank = Onestore_app2_RS.getString("rank");
				String name = Onestore_app2_RS.getString("name");
				String rank_type = Onestore_app2_RS.getString("rank_type");
				String url = Onestore_app2_RS.getString("url");
				String publisher = Onestore_app2_RS.getString("publisher");
				String image_url = Onestore_app2_RS.getString("image_url");

	%>
				<tr>
	<%
				if(rank.equals("1"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("2"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(rank.equals("3"))
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="45" height="45"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=url%> style="font-size:13px;font-weight:700;" target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=name%></div></a><br>
					<a style="font-size:11px; font-weight:10"target="_blank"><div style="width:180px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;"><%=publisher%></div></a></td>
					
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>	

<div w3-include-html="./nav/app_nav.html"></div>
<script>
	w3.includeHTML();
</script>

 
<div id="backtoTop" style=" position: fixed; bottom: 5px; right: 5px;">
	<a href="#header" style="color:black;"><i class="fa fa-chevron-up" style="width:50px; height:50px; font-size:35px; aria-hidden="true">
		</i>
	</a>
</div>
</div>

 
</div>

</main> 

<script src="https://www.velosofy.com/js/app.js"></script>

	<jsp:include page="visitor_count.jsp" flush="true"/>
</body>
</html>

