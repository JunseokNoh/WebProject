<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
		Connection con = null;
		PreparedStatement Boxoffice_PS = null;
		ResultSet Boxoffice_RS = null;
		
		PreparedStatement Naver_PS = null;
		ResultSet Naver_RS = null;
		
		PreparedStatement Daum_PS = null;
		ResultSet Daum_RS = null;
		
		PreparedStatement Naver_rate_PS = null;
		ResultSet Naver_rate_RS = null;
		
		String MYSQL_SERVER ="hackery00bi.iptime.org:6666";
		String MYSQL_SERVER_USERNAME = "yoobi";
		String MYSQL_SERVER_PASSWORD = "toor";
		String MYSQL_DATABASE = "jsp_db";
		String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);
		/*박스오피스*/
		String Boxoffice_query = "select timedata from time_data where type='1d'";
		Boxoffice_PS = con.prepareStatement(Boxoffice_query);
		Boxoffice_RS = Boxoffice_PS.executeQuery();
		Boxoffice_RS.next();
		String Boxoffice_time = Boxoffice_RS.getString("timedata");	
		
		Boxoffice_query = "select * from boxoffice_movie_rank";
		Boxoffice_PS = con.prepareStatement(Boxoffice_query);
		Boxoffice_RS = Boxoffice_PS.executeQuery();
		/*네이버 영화*/
		String Naver_query = "select timedata from time_data where type='1d'";
		Naver_PS = con.prepareStatement(Naver_query);
		Naver_RS = Naver_PS.executeQuery();
		Naver_RS.next();
		String Naver_time = Naver_RS.getString("timedata");	
		
		Naver_query = "select * from naver_movie_rank";
		Naver_PS = con.prepareStatement(Naver_query);
		Naver_RS = Naver_PS.executeQuery();
		
		/*다음 영화*/
		String Daum_query = "select timedata from time_data where type='1d'";
		Daum_PS = con.prepareStatement(Daum_query);
		Daum_RS = Daum_PS.executeQuery();
		Daum_RS.next();
		String Daum_time = Daum_RS.getString("timedata");	
		
		Daum_query = "select * from daum_movie_rank";
		Daum_PS = con.prepareStatement(Daum_query);
		Daum_RS = Daum_PS.executeQuery();
		
		/*네이버 영화 평점순*/
		String Naver_rate_query = "select timedata from time_data where type='1d'";
		Naver_rate_PS = con.prepareStatement(Naver_rate_query);
		Naver_rate_RS = Naver_rate_PS.executeQuery();
		Naver_rate_RS.next();
		String Naver_rate_time = Naver_rate_RS.getString("timedata");	
		
		Naver_rate_query = "select * from naver_movie_rating_rank";
		Naver_rate_PS = con.prepareStatement(Naver_rate_query);
		Naver_rate_RS = Naver_rate_PS.executeQuery();
	%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<meta content="@VelosofyYT" name="twitter:creator"/> 
<meta content="https://www.velosofy.com/img/card.png" name="twitter:image:src"/> 
<meta content="228490107301532" property="fb:admins"/> 
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/> 
<link href="https://www.velosofy.com/css/app.css" rel="stylesheet"/> 

	<meta charset="utf-8"/> <meta content="width=device-width, initial-scale=1" name="viewport"/> 
	  

<script src="https://www.w3schools.com/lib/w3.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<!-- 추가해야할거 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/table.css">

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

<div id="app"> 

<nav class="navbar navbar-expand-md navbar-light navbar-velosofy"> 
	<div class="container"> 
<nav class="navbar navbar-light"> 
	<a class="navbar-brand " href="./index.jsp"> 
		<i class="fa fa-trophy" aria-hidden="true" style="width:30px"></i>
		홈페이지이름
		</a> 
</nav> 

<button aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler" data-target="#navbarSupportedContent" data-toggle="collapse" type="button"> 
<span class="navbar-toggler-icon"></span> </button> 

<div class="collapse navbar-collapse" id="navbarSupportedContent"> 

<ul class="navbar-nav mr-auto"> 
<li class="nav-item dropdown"> 
<a aria-expanded="false" aria-haspopup="true" class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" id="category-dropdown"> 카테고리 </a> 
<div aria-labelledby="category-dropdown" class="dropdown-menu dropdown-menu-right mt-n1"> 
<a class="dropdown-item " href="./trend_rank.jsp" >실시간 랭킹</a> 
<a class="dropdown-item " href="./music_rank.jsp" >음악 차트</a> 
<a class="dropdown-item " href="./movie_rank.jsp" >영화 차트</a> 
<a class="dropdown-item " href="./book_rank.jsp" >도서 차트</a> 
</div> 
</li> 
<li class="nav-item"> 
<a class="nav-link" href="https://www.velosofy.com/templates">자유게시판</a> 
</li> 
</ul> 

<ul class="navbar-nav ml-auto"> 
<li class="nav-item"> 
<a class="nav-link" href="https://www.velosofy.com/login">로그인</a> 
</li> 
<li class="nav-item"> <a class="nav-link" href="https://www.velosofy.com/register">회원가입</a> 
</li> 
</ul> 

</div> 

</div> 
</nav> 

<main> 

<section id="landing" style="height"> 

<div class="container"> 

<h1 class="poppins" style="font-size:50px;">실시간&nbsp<span>영화&nbsp</span>순위</h1> 
<br>

</div> 
</section> 

<div class="container pb-5"> 






<div class="row">
	<!-- yoobi delete it
	 <div class="col-md-12 templates"> 
		<select class="select_box1" name="select" onchange="fnMove(value)">
		  <option>선택</option>
		  <option value="1">박스오피스</option>
		  <option value="2">인기검색어</option>
		  <option value="3">예매율</option>
		  <option value="4">평점순</option>
		</select>
	</div>
	-->
	<br>

<div id="div1" class="col-md-6 templates" style="width:100%;">
			<h3>박스오피스</h3>
			<h6><%=Boxoffice_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
						<th class="table-th" style="width:10%; text-align:center;">관객수</th>
					</tr>
				</thead>
			-->
	<%
			int count = 0;
			while(Boxoffice_RS.next())
			{
				String rank = Boxoffice_RS.getString("rank");
				String title = Boxoffice_RS.getString("title");
				String attendance = Boxoffice_RS.getString("attendance");
				String url = Boxoffice_RS.getString("url");
				String image_url = Boxoffice_RS.getString("image_url");
	%>
				<tr>
					<td style="text-align:center; font-weight:700;"><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a><br>
					<a  style="font-size:13px; font-weight:10"target="_blank"><%=attendance%></a>
					</td>
				</tr>
	<%
				count++;
				if(count >= 20){
					break;
				}
			}
	
	%>
	</table>
	<br><br>
</div>

	<br>
	<div id="div2" class="col-md-6 templates" style="width:100%;">
			<h3>네이버(조회순)</h3>
			<h6><%=Naver_time%></h6>
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
			while(Naver_RS.next())
			{
				String rank = Naver_RS.getString("rank");
				String title = Naver_RS.getString("title");
				String url = "https://movie.naver.com" + Naver_RS.getString("url");
	%>

				<tr>
					<td style="text-align:center; font-weight:700"><%=rank%></td>
					<td><img src="./movie_image.jpg" width="100" height="150"><br><a href=<%=url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
					</td>
				</tr>
	<%
				count++;
				if(count >= 20){
					break;
				}
			}
	
	%>
	</table>
	<br><br>
</div>

<br>
<div id="div3" class="col-md-6 templates" style="width:100%;">
			<h3>다음(예매율)</h3>
			<h6><%=Daum_time%></h6>
			<table class="table table-hover">
			<!--
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
						<th class="table-th" style="width:10%; text-align:center;">관객수</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Daum_RS.next())
			{
				String rank = Daum_RS.getString("rank");
				String title = Daum_RS.getString("title");
				String ticketing = Daum_RS.getString("ticketing");
				String url = Daum_RS.getString("url");	%>
				<tr>
					<td style="text-align:center; font-weight:700"><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
					<a  style="font-size:13px; font-weight:10"target="_blank"><%=ticketing%></a>
					</td>
				</tr>
	<%
				count++;
				if(count >= 20){
					break;
				}
			}
	
	%>
	</table>
	<br><br>
</div>

<br>
<div id="div4" class="col-md-6 templates" style="width:100%;">
			<h3>네이버(평점순)</h3>
			<h6><%=Naver_rate_time%></h6>
			<table class="table table-hover">
				<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
						<th class="table-th" style="width:10%; text-align:center;">평 점</th>
					</tr>
				</thead>
				-->
	<%
			count = 0;
			while(Naver_rate_RS.next())
			{
				String rank = Naver_rate_RS.getString("rank");
				String title = Naver_rate_RS.getString("title");
				String rating = Naver_rate_RS.getString("rating");
				String url = Naver_rate_RS.getString("url");	%>
				<tr>
					<td style="text-align:center; font-weight:700"><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
					<a  style="font-size:13px; font-weight:10"target="_blank"><%=rating%></a>
					</td>
				</tr>
	<%
				count++;
				if(count >= 20){
					break;
				}
			}
	
	%>
	</table>
	<br><br>
</div>

<div w3-include-html="./nav/movie_nav.html"></div>
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


	
</body>
</html>
