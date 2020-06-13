<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	Connection con = null;
	PreparedStatement Melon_PS = null;
	ResultSet Melon_RS = null;
	
	PreparedStatement Bugs_PS = null;
	ResultSet Bugs_RS = null;
	
	PreparedStatement Genie_PS = null;
	ResultSet Genie_RS = null;
	
	PreparedStatement Billboard_PS = null;
	ResultSet Billboard_RS = null;
	
	String MYSQL_SERVER ="hackery00bi.iptime.org:6666";
	String MYSQL_SERVER_USERNAME = "yoobi";
	String MYSQL_SERVER_PASSWORD = "toor";
	String MYSQL_DATABASE = "jsp_db";
	String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);
	
	/*멜론*/
	String Melon_query = "select timedata from time_data where type='1h'";
	Melon_PS = con.prepareStatement(Melon_query);
	Melon_RS = Melon_PS.executeQuery();
	Melon_RS.next();
	String time = Melon_RS.getString("timedata");	
		
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

<li class="nav-item"> 
<a class="nav-link" href="./trend_rank.jsp">실검 차트</a> 
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
	<a class="nav-link">자유게시판(준비중)</a> 
	</li> 
</ul>

<ul class="navbar-nav ml-auto"> 
<li class="nav-item"> 
<a class="nav-link">로그인(준비중)</a> 
</li> 
<li class="nav-item"> <a class="nav-link">회원가입(준비중)</a> 
</li> 
</ul> 

</div> 

</div> 
</nav> 

<main> 

<section id="landing" style="height"> 

<div class="container"> 

<h1  class="poppins" style="font-size:50px;">음악 차트</h1> 
<br>
<!-- 
<a class="btn btn-primary my-2" href="https://www.velosofy.com/templates">Find a template</a> 
<a class="btn btn-secondary my-2" href="https://www.velosofy.com/submit">Submit a template</a> 
 -->
</div> 
</section>

	
	
<div class="container pb-5"> 


<div class="row">
	<!-- yoobi delete it
	 <div class="col-md-12 templates"> 
		<select class="select_box1" name="select" onchange="fnMove(value)">
		  <option>선택</option>
		  <option value="1">멜론</option>
		  <option value="2">지니</option>
		  <option value="3">벅스</option>
		  <option value="4">빌보드</option>
		</select>
	</div>
	-->
	<br>
	<div id="div1" class="col-md-6 templates" style="width:100%;">
		<h3 >멜론 차트</h3>
		<h6><%=time%>시</h6>
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
			int count = 0;
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
	<%
				if(count == 0)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(count == 1)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(count == 2)
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
					<td><a href=<%=title_url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=title_url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
					<a href=<%=artist_url%> style="font-size:13px; font-weight:10"target="_blank"><%=artist%></a></td>
					
				</tr>
	<%
				count++;
			}
			
	%>
		</table>
		<br><br>
	</div>
	
	<br>
	<div id="div2" class="col-md-6 templates" style="width:100%;">
		<h3 >지니 차트</h3>
		<h6><%=Genie_time%>시</h6>
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
	<%
				if(count == 0)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(count == 1)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(count == 2)
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
					<td><a href=<%=title_url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=title_url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
					<a href=<%=artist_url%> style="font-size:13px; font-weight:10"target="_blank"><%=artist%></a>
					</td>
				</tr>
	<%
				count++;
			}
	%>
		</table>
		<br><br>
	</div>
	
	<br>
	<div id="div3" class="col-md-6 templates" style="width:100%;">
		<h3 >벅스 차트</h3>
		<h6><%=Bugs_time%>시</h6>
		
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
	<%
				if(count == 0)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(count == 1)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(count == 2)
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

					<td><a href=<%=title_url%> style=" font-weight:700" target="_blank"><img src="<%=image_url%>" width="60" height="60"></a></td>
					<td><a href=<%=title_url%> style=" font-weight:700" target="_blank"><%=title%></a><br>
					<a href=<%=artist_url%> style="font-size:13px; font-weight:10"target="_blank"><%=artist%></a>
					</td>
				</tr>
	<%
				count++;
			}
	
	%>
		</table>
		<br><br>
	</div>

	<br>
	<div id="div4" class="col-md-6 templates" style="width:100%;">
				<h3 >빌보드 차트</h3>
		<h6><%=Billboard_time%></h6>
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
	<%
				if(count == 0)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="45" height="45"></td>

	<%
				}
				else if(count == 1)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="45" height="45"></td>

	<%
				}
				else if(count == 2)
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

					<td ><a style=" font-weight:700"><%=title%></a><br>
					<a style="font-size:13px; font-weight:10"><%=artist%></a></td>
				</tr>
	<%
				count++;
			}
	%>
			</table>
		<br><br>
	</div>

<script type="text/javascript" src="./js/slide.js"></script>
 
<div w3-include-html="./nav/music_nav.html"></div>
<script>
	w3.includeHTML();
</script>

 
<div id="backtoTop" style=" position: fixed; bottom: 5px; right: 5px;">
	<a href="#header" style="color:black;"><i class="fa fa-chevron-up" style="width:50px; height:50px; font-size:35px; aria-hidden="true"></i></a>
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
   
</script>

	<jsp:include page="visitor_count.jsp" flush="true"/>
</body>
</html>
