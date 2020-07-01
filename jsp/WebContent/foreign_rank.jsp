<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


	<%
		Connection con = null;
		//Naver
		PreparedStatement Trends_PS = null;
		ResultSet Trends_RS = null;
		//Zum
		PreparedStatement Music_PS = null;
		ResultSet Music_RS = null;
		
		PreparedStatement Movie_PS = null;
		ResultSet Movie_RS = null;
		
		PreparedStatement Book_PS = null;
		ResultSet Book_RS = null;
		
		String MYSQL_SERVER ="hackery00bi.iptime.org:6666";
		String MYSQL_SERVER_USERNAME = "yoobi";
		String MYSQL_SERVER_PASSWORD = "toor";
		String MYSQL_DATABASE = "jsp_db";
		String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);
		
		//Trends//
		String trends_query = "select timedata from time_data where type='10m'";
		Trends_PS = con.prepareStatement(trends_query);
		Trends_RS = Trends_PS.executeQuery();
		Trends_RS.next();
		String trends_time = Trends_RS.getString("timedata");

		trends_query = "select * from google_trends_us_rank";
		Trends_PS = con.prepareStatement(trends_query);
		Trends_RS = Trends_PS.executeQuery();
		
		//Music//
		String music_query = "select timedata from time_data where type='1d'";
		Music_PS = con.prepareStatement(music_query);
		Music_RS = Music_PS.executeQuery();
		Music_RS.next();
		String music_time = Music_RS.getString("timedata");
		
		music_query = "select * from billboard_music_rank";
		Music_PS = con.prepareStatement(music_query);
		Music_RS = Music_PS.executeQuery();
		
		//Movie//
		String movie_query = "select timedata from time_data where type='1d'";
		Movie_PS = con.prepareStatement(movie_query);
		Movie_RS = Movie_PS.executeQuery();
		Movie_RS.next();
		String movie_time = Movie_RS.getString("timedata");
		
		movie_query = "select * from boxoffice_movie_us_rank";
		Movie_PS = con.prepareStatement(movie_query);
		Movie_RS = Movie_PS.executeQuery();
		
		//Book//
		String book_query = "select timedata from time_data where type='1d'";
		Book_PS = con.prepareStatement(book_query);
		Book_RS = Book_PS.executeQuery();
		Book_RS.next();
		String book_time = Book_RS.getString("timedata");
		
		book_query = "select * from amazon_book_rank";
		Book_PS = con.prepareStatement(book_query);
		Book_RS = Book_PS.executeQuery();
		
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");
		
	%>
			
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>랭킹.pw</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>

<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/> 
<link href="https://www.velosofy.com/css/app.css" rel="stylesheet"/> 
<script src="./js/script.js"></script>
<script src="https://www.w3schools.com/lib/w3.js"></script>
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

<body id="header">

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

<jsp:include page="header.jsp" flush="true"/>

<main> 

<section id="landing" style="height"> 

<div class="container"> 

<h1 class="poppins" style="font-size:50px;">해외 차트</h1> 
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
			<option value="1">네이버</option>
			<option value="2">Zum</option>
			<option value="3">구글</option>
			<option value="4">네이트</option>
		</select>
	</div>
	-->
	<br>

	<div id="div1" class="col-md-6 templates" style="width:100%;">

			<h3>Google Trends</h3>
			<h6 style="text-align:right;"><%=trends_time%></h6>
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
			while(Trends_RS.next())
			{
				String rank = Trends_RS.getString("rank");
				String title = Trends_RS.getString("title");
				String url = Trends_RS.getString("url");
				url = url.replaceAll(" ", "+");
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

					<td style="font-weight:700;width:30%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
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
	<h3>Boxoffice</h3>
			<h6 style="text-align:right;"><%=movie_time%></h6>
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
			while(Movie_RS.next())
			{
				String rank = Movie_RS.getString("rank");
				String title = Movie_RS.getString("title");
				String attendance = Movie_RS.getString("attendance");
				String director_name = Movie_RS.getString("director_name");
				String actor_names = Movie_RS.getString("actor_names");
				String url = Movie_RS.getString("url");
				String image_url = Movie_RS.getString("image_url");
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

					<td width="110"><a href=<%=url%> style="font-size:20px;font-weight:700" target="_blank"><img src="<%=image_url%>" width="80" height="120"></a></td>
					<td><a href=<%=url%> style=" font-weight:1000" target="_blank"><%=title%></a><br><br>
					<a style="font-size:13px; font-weight:400"target="_blank"><div style="width:230px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;">감독: <%=director_name%></div></a>
					<a style="font-size:13px; font-weight:400"target="_blank"><div style="width:230px;white-space:nowrap; overflow:hidden;text-overflow:ellipsis;">배우: <%=actor_names%></div></a><br>
					<a style="font-size:13px; font-weight:15"target="_blank"><%=attendance%></a></td>
					
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
		<h3>Billboard Music</h3>
			<h6 style="text-align:right;"><%=music_time%></h6>
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
			while(Music_RS.next())
			{
				String rank = Music_RS.getString("rank");
				String title = Music_RS.getString("song_title");
				String artist = Music_RS.getString("song_artist");
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

	<br>
	<div id="div4" class="col-md-6 templates" style="width:100%;">
		<h3>Amazon Best Seller</h3>
			<h6 style="text-align:right;"><%=book_time%></h6>
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
			while(Book_RS.next())
			{
				String rank = Book_RS.getString("rank");
				String title = Book_RS.getString("title");
				String url = Book_RS.getString("url");
				String author = Book_RS.getString("author");
				String image_url = Book_RS.getString("image_url");

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

					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="110" height="110"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=author%>
						</a>
					</td>
				</tr>
	<%
				count++;
			}

	%>
			</table>
		<br><br>
	</div>


<div w3-include-html="./nav/foriegn_nav.html"></div>
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

	<jsp:include page="visitor_count.jsp" flush="true"/>

</body>
</html>
