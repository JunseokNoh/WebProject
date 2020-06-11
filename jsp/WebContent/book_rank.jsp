<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
		Connection con = null;
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
					<a class="dropdown-item" href="./trend_rank.jsp" >실시간 랭킹</a> 
					<a class="dropdown-item" href="./music_rank.jsp" >음악 차트</a> 
					<a class="dropdown-item" href="./movie_rank.jsp" >영화 차트</a> 
					<a class="dropdown-item" href="./book_rank.jsp" >도서 차트</a> 
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
		<li class="nav-item"> 
			<a class="nav-link" href="https://www.velosofy.com/register">회원가입</a> 
		</li> 
	</ul> 

</div> 

</div> 
</nav> 

<main> 

<section id="landing" style="height"> 

<div class="container"> 

<h1 class="poppins" style="font-size:50px;">실시간&nbsp<span>도서&nbsp</span>순위</h1> 
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
	
	<div id="div1" class="col-md-6 templates">
			<h3>인터파크</h3>
			<h6><%=Inter_time%></h6>
			<table class="table table-hover">
				<!-- 
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:5%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
				 -->
	<%
			
			int count = 0;
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
					<td style="font-weight:700; text-align:center; width:5%;" title='<%=author%>'><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=author%>
						<a>
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
<div id="div2" class="col-md-6 templates" >
	<!-- <h3 class="py-4 poppins"><span class="text-primary">교보 문고</span> </h3>  -->
			<h3>교보문고</h3>
			<h6><%=Kyobo_time%></h6>
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
			while(Kyobo_RS.next())
			{
				String rank = Kyobo_RS.getString("rank");
				String title = Kyobo_RS.getString("title");
				String url = Kyobo_RS.getString("url");
				String author = Kyobo_RS.getString("author");
				String publisher = Kyobo_RS.getString("publisher");
				String image_url = Kyobo_RS.getString("image_url");
	%>		
			<tbody>
				<tr>
					<td style="font-weight:700; text-align:center; width:5%;" title='<%=author%>'><%=rank%></td>
					<td><a href=<%=url%> style=" font-weight:700;" target="_blank"><img src="<%=image_url%>" width="100" height="150"></a><br><a href=<%=url%> style=" font-weight:700;" target="_blank"><%=title%></a><br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=author%>
						</a>
				</tr>
	<%
				count++;
			}
	%>
			</tbody>
	</table>
	<br><br>
</div>

<br>
<div id="div3" class="col-md-6 templates" style="width:100%;">
	<!-- <h3 class="py-4 poppins"><span class="text-primary">YES24</span> </h3> -->
			<h3>YES24</h3>
			<h6><%=Yes_time%></h6>
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
	%>
			<tbody>
				<tr>
					<td style="font-weight:700; text-align:center; width:5%;" title='<%=author%>'><%=rank%></td>
					<td style=" font-weight:700; width:30%;">
						<a href=<%=url%> target="_blank">
							<%=title%>
						</a>
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=author%>
						<a>
					</td>
				</tr>
	<%
				count++;
			}
	%>
			</tbody>
	</table>
	<br><br>
</div>

<br>
<div id="div4" class="col-md-6 templates" >
	<!-- <h3 class="py-4 poppins"><span class="text-primary">알라딘</span> </h3> -->
			<h3>알라딘</h3>
			<h6><%=Aladin_time%></h6>
			<table class="table table-hover" >
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
			while(Aladin_RS.next())
			{
				String rank = Aladin_RS.getString("rank");
				String title = Aladin_RS.getString("title");
				String url = Aladin_RS.getString("url");
				String author = Aladin_RS.getString("author");
				String publisher = Aladin_RS.getString("publisher");
	%>
				<tr>
					<td style="font-weight:700; text-align:center; width:5%;" title='<%=author%>'><%=rank%></td>
					<td style=" font-weight:700; width:30%;">
						<a href=<%=url%> target="_blank">
							<%=title%>
						</a>
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=author%>
						<a>
					</td>
				</tr>
	<%
				count++;
			}
	%>
	</table>
	<br><br>
</div>

<div w3-include-html="./nav/book_nav.html"></div>
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

