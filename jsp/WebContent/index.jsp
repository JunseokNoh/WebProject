<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!--
------------------------------------------------------------
* @설명 : 일별 박스오피스 REST 호출 - 서버측에서 호출하는 방식 예제
------------------------------------------------------------
-->
	<%
		Connection con = null;
		//실검
		PreparedStatement Naver_PS = null;
		ResultSet Naver_RS = null;
		//
		PreparedStatement Zum_PS = null;
		ResultSet Zum_RS = null;
		
		PreparedStatement Nate_PS = null;
		ResultSet Nate_RS = null;
		
		PreparedStatement Google_PS = null;
		ResultSet Google_RS = null;
		/////음악
		PreparedStatement Melon_PS = null;
		ResultSet Melon_RS = null;
		
		PreparedStatement Bugs_PS = null;
		ResultSet Bugs_RS = null;
		
		PreparedStatement Genie_PS = null;
		ResultSet Genie_RS = null;
		
		PreparedStatement Billboard_PS = null;
		ResultSet Billboard_RS = null;		
		///영화
		PreparedStatement Boxoffice_PS = null;
		ResultSet Boxoffice_RS = null;
		
		PreparedStatement Naver_movie_PS = null;
		ResultSet Naver_movie_RS = null;
		
		PreparedStatement Daum_PS = null;
		ResultSet Daum_RS = null;
		
		PreparedStatement Naver_rate_PS = null;
		ResultSet Naver_rate_RS = null;
		///도서
		PreparedStatement Inter_PS = null;
		ResultSet Inter_RS = null;
		
		PreparedStatement Kyobo_PS = null;
		ResultSet Kyobo_RS = null;
		
		PreparedStatement Yes_PS = null;
		ResultSet Yes_RS = null;
		
		PreparedStatement Aladin_PS = null;
		ResultSet Aladin_RS = null;
		
		
		String MYSQL_SERVER ="hackery00bi.iptime.org:6666";
		String MYSQL_SERVER_USERNAME = "yoobi";
		String MYSQL_SERVER_PASSWORD = "toor";
		String MYSQL_DATABASE = "jsp_db";
		String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);
		//실검///////////
		String naver_query = "select timedata from time_data where type='1m'";
		Naver_PS = con.prepareStatement(naver_query);
		Naver_RS = Naver_PS.executeQuery();
		Naver_RS.next();
		String naver_time = Naver_RS.getString("timedata");

		naver_query = "select * from naver_trends_rank";
		Naver_PS = con.prepareStatement(naver_query);
		Naver_RS = Naver_PS.executeQuery();
		//zum//
		String zum_query = "select * from zum_trends_rank";
		Zum_PS = con.prepareStatement(zum_query);
		Zum_RS = Zum_PS.executeQuery();
		//nate//
		String nate_query = "select * from nate_trends_rank";
		Nate_PS = con.prepareStatement(nate_query);
		Nate_RS = Nate_PS.executeQuery();
		
		//google//
		String Google_query = "select timedata from time_data where type='10m'";
		Google_PS = con.prepareStatement(Google_query);
		Google_RS = Google_PS.executeQuery();
		Google_RS.next();
		String Google_time = Google_RS.getString("timedata");
		
		Google_query = "select * from google_trends_rank";
		Google_PS = con.prepareStatement(Google_query);
		Google_RS = Google_PS.executeQuery();
		////음악/////
		/*멜론*/
		String Melon_query = "select timedata from time_data where type='1h'";
		Melon_PS = con.prepareStatement(Melon_query);
		Melon_RS = Melon_PS.executeQuery();
		Melon_RS.next();
		String Melon_time = Melon_RS.getString("timedata");	
			
		Melon_query = "select * from melon_music_rank";
		Melon_PS = con.prepareStatement(Melon_query);
		Melon_RS = Melon_PS.executeQuery();
		
		/*벅스*/
		String Bugs_query = "select timedata from time_data where type='1h'";
		Bugs_PS = con.prepareStatement(Bugs_query);
		Bugs_RS = Bugs_PS.executeQuery();
		Bugs_RS.next();
		String Bugs_time = Bugs_RS.getString("timedata");	
			
		Bugs_query = "select * from bugs_music_rank";
		Bugs_PS = con.prepareStatement(Bugs_query);
		Bugs_RS = Bugs_PS.executeQuery();
		
		/*지니 뮤직*/
		String Genie_query = "select timedata from time_data where type='1h'";
		Genie_PS = con.prepareStatement(Genie_query);
		Genie_RS = Genie_PS.executeQuery();
		Genie_RS.next();
		String Genie_time = Genie_RS.getString("timedata");	
			
		Genie_query = "select * from genie_music_rank";
		Genie_PS = con.prepareStatement(Genie_query);
		Genie_RS = Genie_PS.executeQuery();
				
		/*빌보드*/
		String Billboard_query = "select timedata from time_data where type='1w'";
		Billboard_PS = con.prepareStatement(Billboard_query);
		Billboard_RS = Billboard_PS.executeQuery();
		Billboard_RS.next();
		String Billboard_time = Billboard_RS.getString("timedata");
	
		Billboard_query = "select * from billboard_music_rank";
		Billboard_PS = con.prepareStatement(Billboard_query);
		Billboard_RS = Billboard_PS.executeQuery();
	
		///영화
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
		String Naver_movie_query = "select timedata from time_data where type='1d'";
		Naver_movie_PS = con.prepareStatement(Naver_movie_query);
		Naver_movie_RS = Naver_movie_PS.executeQuery();
		Naver_movie_RS.next();
		String Naver_movie_time = Naver_movie_RS.getString("timedata");	
		
		Naver_movie_query = "select * from naver_movie_rank";
		Naver_movie_PS = con.prepareStatement(Naver_movie_query);
		Naver_movie_RS = Naver_movie_PS.executeQuery();
		
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
		
		// 도서 
		/*인터 파크*/
		String Inter_query = "select timedata from time_data where type='1d'";
		Inter_PS = con.prepareStatement(Inter_query);
		Inter_RS = Inter_PS.executeQuery();
		Inter_RS.next();
		String Inter_time = Inter_RS.getString("timedata");	
			
		Inter_query = "select * from interpark_book_rank";
		Inter_PS = con.prepareStatement(Inter_query);
		Inter_RS = Inter_PS.executeQuery();
		
		/*교보 문고*/
		String Kyobo_query = "select timedata from time_data where type='1d'";
		Kyobo_PS = con.prepareStatement(Kyobo_query);
		Kyobo_RS = Kyobo_PS.executeQuery();
		Kyobo_RS.next();
		String Kyobo_time = Kyobo_RS.getString("timedata");	
			
		Kyobo_query = "select * from kyobo_book_rank";
		Kyobo_PS = con.prepareStatement(Kyobo_query);
		Kyobo_RS = Kyobo_PS.executeQuery();
		
		/*예스24*/
		String Yes_query = "select timedata from time_data where type='1d'";
		Yes_PS = con.prepareStatement(Yes_query);
		Yes_RS = Yes_PS.executeQuery();
		Yes_RS.next();
		String Yes_time = Yes_RS.getString("timedata");	
			
		Yes_query = "select * from yes24_book_rank";
		Yes_PS = con.prepareStatement(Yes_query);
		Yes_RS = Yes_PS.executeQuery();
		
		/*알라딘*/
		String Aladin_query = "select timedata from time_data where type='1d'";
		Aladin_PS = con.prepareStatement(Aladin_query);
		Aladin_RS = Aladin_PS.executeQuery();
		Aladin_RS.next();
		String Aladin_time = Aladin_RS.getString("timedata");	
			
		Aladin_query = "select * from aladin_book_rank";
		Aladin_PS = con.prepareStatement(Aladin_query);
		Aladin_RS = Aladin_PS.executeQuery();
		
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");
		
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

<body>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
 <!-- 추가해야할거 -->
 <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>

<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-40481198-1', 'auto');
    ga('send', 'pageview');
</script>

<div id="app"> 

<nav class="navbar navbar-expand-md navbar-light navbar-velosofy"> 
	<div class="container"> 
<nav class="navbar navbar-light"> 
		<a class="navbar-brand " href="./index.jsp"> 
		<i class="fa fa-trophy" aria-hidden="true" style="width:30px"></i>
		홈페이지이름
		</a> 
	</a> 
</nav> 

<button aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler" data-target="#navbarSupportedContent" data-toggle="collapse" type="button"> 
<span class="navbar-toggler-icon"></span> </button> 

<div class="collapse navbar-collapse" id="navbarSupportedContent"> 

<ul class="navbar-nav mr-auto"> 

<li class="nav-item"> 
<a class="nav-link" href="./trend_rank.jsp">실시간 랭킹</a> 
</li> 
<li class="nav-item"> 
<a class="nav-link" href="./music_rank.jsp">음악 차트</a> 
</li> 
<li class="nav-item"> 
<a class="nav-link" href="./movie_rank.jsp">영화 차트</a> 
</li> 
<li class="nav-item"> 
<a class="nav-link" href="./book_rank.jsp">도서 차트</a> 
</li> 
	<li class="nav-item"> 
	<a class="nav-link" href="">자유게시판(준비중)</a> 
	</li> 
</ul>

<ul class="navbar-nav ml-auto"> 
<li class="nav-item"> 
<a class="nav-link" href="">로그인(준비중)</a> 
</li> 
<li class="nav-item"> <a class="nav-link" href="">회원가입(준비중)</a> 
</li> 
</ul> 

</div> 
</div>
</nav>

<main> 

<section id="landing" style="height"> 

<div class="container"> 

<br>
<!-- 
<a class="btn btn-primary my-2" href="https://www.velosofy.com/templates">Find a template</a> 
<a class="btn btn-secondary my-2" href="https://www.velosofy.com/submit">Submit a template</a> 
 -->
</div> 
</section> 

<div class="container pb-5"> 




<div class="row">

	<div id="div5" class="col-md-6 templates" style="" >
	<div id="div0" class="col-md-12 templates" >
		<h3 class="poppins" style="">실시간&nbsp<span>포털&nbsp</span>순위<a id="lookMore" href="./music_rank_jsp">더 보기</a></h3> 
		<br>
	</div>
	
	<div id="div1" class="col-md-12 templates" style="display : inline-block;">

			<table class="table table-hover">
	<%
			int count = 0;
			while(Naver_RS.next())
			{
				String rank = Naver_RS.getString("rank");
				String title = Naver_RS.getString("title");
				String url = Naver_RS.getString("url");
				url = url.replaceAll(" ", "+");
	%>

				<tr>
					<td style="width:20%; ">네이버</td>
					<td style="width:5%; text-align:center;font-weight:700;width:5%;"><%=rank%></td>
					<td style="font-weight:700;width:80%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}

		
	%>
		</table>
	</div>
	
	<div id="div2" class="col-md-12 templates" style="display : inline-block;">
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
			while(Zum_RS.next())
			{
				String rank = Zum_RS.getString("rank");
				String title = Zum_RS.getString("title");
				String url = Zum_RS.getString("url");
				url = url.replaceAll(" ", "+");	
	%>
				<tbody>
				<tr>
					<td style="width:20%;">Zum</td>
					<td style="text-align:center;font-weight:700;width:5%;"><%=rank%></td>
					<td style="font-weight:700;width:80%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}
		
		
	%>
				</tbody>
	</table>
	</div>
	<div></div>
	<div id="div3" class="col-md-12 templates" style="display : inline-block;">
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
			while(Google_RS.next())
			{
				String rank = Google_RS.getString("rank");
				String title = Google_RS.getString("title");				
				String url = Google_RS.getString("url");
				url = url.replaceAll(" ", "+");
	%>
				<tbody>
				<tr>
					<td style="width:20%">구글</td>
					<td style="text-align:center;font-weight:700;width:5%;"><%=rank%></td>
					<td style="font-weight:700;width:80%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
			if(count >= 1)
				break;
			}

	%>
			</tbody>
			</table>
	</div>

	<div id="div4" class="col-md-12 templates" style="display : inline-block;">
			<table class="table table-hover">
	<%
			count = 0;
			while(Nate_RS.next())
			{
				String rank = Nate_RS.getString("rank");
				String title = Nate_RS.getString("title");
				String url = "https://search.daum.net/nate?thr=sbma&w=tot&q=" + title.replaceAll(" ","+");

	%>
			<tbody>
				<tr>	
					<td style="width:20%">네이트</td>
					<td style="text-align:center;font-weight:700;width:5%;"><%=rank%></td>
					<td style="font-weight:700;width:80%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}

	%>
			</tbody>
			</table>
	</div>
	<br><br>
	</div>
	
	<div id="div5" class="col-md-6 templates" >
	<div id="div0" class="col-md-12 templates" >
		<h3 class="poppins" style="">실시간&nbsp<span>음악&nbsp</span>순위<a id="lookMore" href="./music_rank_jsp">더 보기</a></h3> 
		<br>
	</div>
	
	<div id="div1" class="col-md-12 templates" style="display : inline-block;">
		
			<table class="table table-hover">
				<!--  
				<thead>	
				<tr class="table-info">
					<th class="table-th" style="width:5%; text-align:center;">순위</th>
					<th class="table-th" style="width:5%; text-align:center;">제목</th>
					<th class="table-th" style="width:5%; text-align:center;">아티스트</th>
				</tr>
				</thead>
				-->
	<%
			count = 0;
			while(Melon_RS.next())
			{
				String rank = Melon_RS.getString("rank");
				String title = Melon_RS.getString("song_title");
				String title_url = Melon_RS.getString("song_url");
				String artist = Melon_RS.getString("song_artist");
				String artist_url = Melon_RS.getString("artist_url");
				String album = Melon_RS.getString("album_title");
				String album_url = Melon_RS.getString("album_url");
				String image_url = Melon_RS.getString("image_url");
	%>
				<tr>
					<td style="width:20%;">멜론</td>
					<td style="width:5%; text-align:center; font-weight:700"><%=rank%></td>
					
					<td style="width:70%;"><a href=<%=title_url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
					<a href=<%=artist_url%> style="font-size:13px; font-weight:10"target="_blank"><%=artist%></a></td>
					
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}
			
	%>
		</table>
	</div>	
	
	<div id="div2" class="col-md-12 templates" style="display : inline-block;">
			<table class="table table-hover">
			<!-- 
			<thead>
				<tr class="table-info">
					<th class="table-th" style="width:5%; text-align:center;">순위</th>
					<th class="table-th" style="width:5%; text-align:center;">제목</th>
					<th class="table-th" style="width:5%; text-align:center;">아티스트</th>
				</tr>
			</thead>
			 -->
	<%
			count = 0;
			while(Genie_RS.next())
			{
				String rank = Genie_RS.getString("rank");
				String title = Genie_RS.getString("song_title");
				String title_url = Genie_RS.getString("song_url");
				String artist = Genie_RS.getString("song_artist");
				String artist_url = Genie_RS.getString("artist_url");
				String album = Genie_RS.getString("album_title");
				String album_url = Genie_RS.getString("album_url");
				String image_url = Genie_RS.getString("image_url");
	%>
				<tr>
					<td style="width:20%;">지니</td>
					<td style="width:5%; text-align:center; font-weight:700"><%=rank%></td>
					
					<td style="width:70%;"><a href=<%=title_url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
					<a href=<%=artist_url%> style="font-size:13px; font-weight:10"target="_blank"><%=artist%></a>
					</td>
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}
	%>
		</table>
	</div>
	
	<div id="div3" class="col-md-12 templates" style="display:inline-block;">
		
			<table class="table table-hover">
			<!-- 
				<thead>
				<tr class="table-info">
					<th class="table-th" style="width:5%; text-align:center;">순위</th>
					<th class="table-th" style="width:5%; text-align:center;">제목</th>
					<th class="table-th" style="width:5%; text-align:center;">아티스트</th>
				</tr>
				</thead>
			 -->
	<%
			count = 0;
			while(Bugs_RS.next())
			{
				String rank = Bugs_RS.getString("rank");
				String title = Bugs_RS.getString("song_title");
				String title_url = Bugs_RS.getString("song_url");
				String artist = Bugs_RS.getString("song_artist");
				String artist_url = Bugs_RS.getString("artist_url");
				String album = Bugs_RS.getString("album_title");
				String album_url = Bugs_RS.getString("album_url");
				String image_url = Bugs_RS.getString("image_url");
	%>
				<tr>
					<td style="width:20%;">벅스</td>
					<td style="width:5%; text-align:center; font-weight:700"><%=rank%></td>
					<td style="width:70%;" ><a href=<%=title_url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
					<a href=<%=artist_url%> style="font-size:13px; font-weight:10"target="_blank"><%=artist%></a>
					</td>
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}
	
	%>
		</table>
	</div>

	<div id="div4" class="col-md-12 templates" style="display:inline-block;">
		<table class="table table-hover">
			<!-- 
			<thead>
			<tr class="table-info">
				<th class="table-th" style="width:5%; text-align:center;">순위</th>
				<th class="table-th" style="width:5%; text-align:center;">제목</th>
				<th class="table-th" style="width:5%; text-align:center;">아티스트</th>
			</tr>
			</thead>
			 -->
	<%
			count = 0;
			while(Billboard_RS.next())
			{
				String rank = Billboard_RS.getString("rank");
				String title = Billboard_RS.getString("title");
				String artist = Billboard_RS.getString("artist");
	%>
				<tr>
					<td style="fwidth:20%;">빌보드</td>
					<td style="width:5%; text-align:center; font-weight:700"><%=rank%></td>
					<td style="width:70%;"><a style=" font-weight:700"><%=title%></a><br>
					<a style="font-size:13px; font-weight:10"><%=artist%></a></td>
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}
	%>
			</table>
	</div>
	<br><br>
	</div>
	
	<div id="div5" class="col-md-6 templates" >
		<div id="div0" class="col-md-12 templates" >
			<h3 class="poppins" style="">실시간&nbsp<span>영화&nbsp</span>순위<a id="lookMore" href="./music_rank_jsp">더 보기</a></h3> 
			<br>
		</div>
	
	<div id="div1" class="col-md-5 templates" style="display : inline-block;">
			<div id="div1" class="col-md-12 templates" >박스오피스</div>
			<table class="table table-hover">
	<%
			count = 0;
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
					<a style="font-size:13px; font-weight:10" target="_blank"><%=attendance%></a>
					</td>
				</tr>
	<%
				count++;
				if(count >= 1){
					break;
				}
			}
	
	%>
	</table>
	</div>	
	
	<div id="div2" class="col-md-5 templates" style="display : inline-block;">
			<div id="div1" class="col-md-12 templates" >예매율</div>
			<table class="table table-hover">
	<%
			count = 0;
			while(Daum_RS.next())
			{
				String rank = Daum_RS.getString("rank");
				String title = Daum_RS.getString("title");
				String ticketing = Daum_RS.getString("ticketing");
				String url = Daum_RS.getString("url");
				String image_url = Daum_RS.getString("image_url");
	%>
				<tr>
					<td style="text-align:center; font-weight:700"><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a><br>
					<a  style="font-size:13px; font-weight:10"target="_blank"><%=ticketing%></a>
					</td>
				</tr>
	<%
				count++;
				if(count >= 1){
					break;
				}
			}
	
	%>
	</table>
	</div>
	
	<div id="div3" class="col-md-5 templates" style="display:inline-block;">
		<div id="div1" class="col-md-12 templates" >평점순</div>
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
				String url = Naver_rate_RS.getString("url");
				String image_url = Naver_rate_RS.getString("image_url");
	%>
				<tr>
					<td style="text-align:center; font-weight:700"><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a><br>
					<a  style="font-size:13px; font-weight:10"target="_blank"><%=rating%></a>
					</td>
				</tr>
	<%
				count++;
				if(count >= 1){
					break;
				}
			}
	
	%>
	</table>
	</div>

	<div id="div4" class="col-md-5 templates" style="display:inline-block;">
		<div id="div1" class="col-md-12 templates" >조회순</div>
			<table class="table table-hover">
	<%
			count = 0;
			while(Naver_movie_RS.next())
			{
				String rank = Naver_movie_RS.getString("rank");
				String title = Naver_movie_RS.getString("title");
				String url = "https://movie.naver.com" + Naver_movie_RS.getString("url");
				String image_url = Naver_movie_RS.getString("image_url");
	%>

				<tr>
					<td style="text-align:center; font-weight:700"><%=rank%></td>
					<td><a href=<%=url%> target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
						<a style="font-size:13px; font-weight:10"><br></a>
					</td>
				</tr>
	<%
				count++;
				if(count >= 1){
					break;
				}
			}
	
	%>
	</table>
	
	</div>

	</div>
	
		<div id="div5" class="col-md-6 templates" >
		<div id="div0" class="col-md-12 templates" >
		<h3 class="poppins" style="">실시간&nbsp<span>도서&nbsp</span>순위<a id="lookMore" href="./music_rank_jsp">더 보기</a></h3> 
		<br>
		</div>
	
	<div id="div1" class="col-md-5 templates" style="display : inline-block;">
			<div id="div1" class="col-md-12 templates" >인터파크</div>
			<table class="table table-hover">

	<%
			
			count = 0;
			while(Inter_RS.next())
			{
				String rank = Inter_RS.getString("rank");
				String title = Inter_RS.getString("title");
				String url = Inter_RS.getString("url");
				String author = Inter_RS.getString("author");
				String publisher = Inter_RS.getString("publisher");
				String image_url = Inter_RS.getString("image_url");
				/* yoobi delete it
				author = "저자 : "+ author + "\n출판사 : " + publisher;
				*/
	%>
				<tr>
					<td style="font-weight:700; text-align:center; " title='<%=author%>'><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=author%>
						<a>
					</td>
					
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}
	%>
	</table>
	</div>	
	
	<div id="div2" class="col-md-5 templates" style="display : inline-block;">
		<div id="div1" class="col-md-12 templates" >교보 문고</div>
		<table class="table table-hover">

	<%
			count = 0;
			while(Kyobo_RS.next())
			{
				String rank = Kyobo_RS.getString("rank");
				String title = Kyobo_RS.getString("title");
				String url = Kyobo_RS.getString("url");
				String author = Kyobo_RS.getString("author");
				String publisher = Kyobo_RS.getString("publisher");
				String image_url = Kyobo_RS.getString("image_url");
	%>		
				<tr>
					<td style="font-weight:700; text-align:center;" title='<%=author%>'><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=author%>
						<a>
					</td>
					
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}
	%>
	</table>
	</div>
	
	<div id="div3" class="col-md-5 templates" style="display:inline-block;">
			<div id="div1" class="col-md-12 templates" >YES24</div>
			<table class="table table-hover">
			<!--
				<thead>
					<tr class="table-info">
						<th style="width:5%; text-align:center;">순 위</th>
						<th style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Yes_RS.next())
			{
				String rank = Yes_RS.getString("rank");
				String title = Yes_RS.getString("title");
				String url = Yes_RS.getString("url");
				String author = Yes_RS.getString("author");
				String publisher = Yes_RS.getString("publisher");
				String image_url = Yes_RS.getString("image_url");
	%>
				<tr>
					<td style="font-weight:700; text-align:center; width:5%;" title='<%=author%>'><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=author%>
						</a>
					</td>
					
				</tr>
	<%
				count++;
				if(count >= 1)
					break;
			}
	%>
	</table>
	</div>

	<div id="div4" class="col-md-5 templates" style="display:inline-block;">
		<div id="div1" class="col-md-12 templates" >알라딘</div>
		<table class="table table-hover" >

	<%
			count = 0;
			while(Aladin_RS.next())
			{
				String rank = Aladin_RS.getString("rank");
				String title = Aladin_RS.getString("title");
				String url = Aladin_RS.getString("url");
				String author = Aladin_RS.getString("author");
				String publisher = Aladin_RS.getString("publisher");
				String image_url = Aladin_RS.getString("image_url");
	%>
				<tr>
					<td style="font-weight:700; text-align:center;" title='<%=author%>'><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=author%>
						<a>
					</td>
					
				</tr>

	<%
				count++;
				if(count >= 1)
					break;
			}
	%>
	</table>
	</div>
	
	</div>

<script type="text/javascript" src="./js/slide.js"></script>
 
<div w3-include-html="./nav/trend_nav.html"></div>
<script>
	w3.includeHTML();
</script>

 
<div id="backtoTop" style=" position: fixed; bottom: 5px; right: 5px;">
	<a href="#header" style="color:black;"><i class="fa fa-chevron-up" style="width:50px; height:50px; font-size:35px; aria-hidden="true">
		</i>
	</a>
</div>

<!-- 
<div class="text-right">
<a class="btn btn-primary" href="/templates/featured">
                Show 200 more featured templates
            </a>
</div>
 -->
 
 </div>
 
</div> 


</main> 

<script src="https://www.velosofy.com/js/app.js"></script>

<script>
    const keywords = ["포털 ", "음악 ", "영화 ", "도서 "];
    $(document).ready(function() {
        let i = 1;
        setInterval(function() {
            const newKeyword = keywords[i];
            $("#keyword").animate({ opacity: 0 }, function() {
                $(this).text(newKeyword).animate({ opacity: 1 });
            });
            if (i+1 === keywords.length) {
                i = 0;
            } else {
                i++;
            }
        }, 3500);
    });
</script>

</body>
</html>