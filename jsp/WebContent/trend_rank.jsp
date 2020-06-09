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
		//Naver
		PreparedStatement Naver_PS = null;
		ResultSet Naver_RS = null;
		//Zum
		PreparedStatement Zum_PS = null;
		ResultSet Zum_RS = null;
		
		PreparedStatement Nate_PS = null;
		ResultSet Nate_RS = null;
		
		PreparedStatement Google_PS = null;
		ResultSet Google_RS = null;
		
		String MYSQL_SERVER ="hackery00bi.iptime.org:6666";
		String MYSQL_SERVER_USERNAME = "yoobi";
		String MYSQL_SERVER_PASSWORD = "toor";
		String MYSQL_DATABASE = "jsp_db";
		String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);
		//Naver//
		String naver_query = "select * from naver_trends_rank";
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
		String time = Google_RS.getString("timedata");
		
		Google_query = "select * from google_trends_rank";
		Google_PS = con.prepareStatement(Google_query);
		Google_RS = Google_PS.executeQuery();
		
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

<h1 class="poppins" style="font-size:50px;">실시간&nbsp<span>포털&nbsp</span>순위</h1> 

<h2 class="lead text-muted">부제목 </h2> 
<!-- 
<a class="btn btn-primary my-2" href="https://www.velosofy.com/templates">Find a template</a> 
<a class="btn btn-secondary my-2" href="https://www.velosofy.com/submit">Submit a template</a> 
 -->
</div> 
</section> 

<div class="container pb-5"> 






<div class="row">
	
	<div class="col-md-3 templates" >
			<h3>네이버</h3>
			<h6 style="text-align:right;"><%=time%></h6>
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
			while(Naver_RS.next())
			{
				String rank = Naver_RS.getString("rank");
				String title = Naver_RS.getString("title");
				String url = Naver_RS.getString("url");
				url = url.replaceAll(" ", "+");
	%>
				<tbody>
				<tr>
					<td style="text-align:center;font-weight:700;width:5%;"><%=rank%></td>
					<td style="font-weight:700;width:30%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
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
	
	<div class="col-md-3 templates" style="width:100%;">
			<h3>Zum</h3>
			<h6 style="text-align:right;"><%=time%></h6>
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
					<td style="text-align:center;font-weight:700;width:5%;"><%=rank%></td>
					<td style="font-weight:700;width:30%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
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
	<div class="col-md-3 templates" style="width:100%;">
			<h3>구글</h3>
			<h6 style="text-align:right;"><%=time%></h6>
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
					<td style="text-align:center;font-weight:700;width:5%;"><%=rank%></td>
					<td style="font-weight:700;width:30%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
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
	<div class="col-md-3 templates" style="width:100%;">
		<h3>네이트</h3>
			<h6 style="text-align:right;"><%=time%></h6>
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
			while(Nate_RS.next())
			{
				String rank = Nate_RS.getString("rank");
				String title = Nate_RS.getString("title");
				String url = "https://search.daum.net/nate?thr=sbma&w=tot&q=" + title.replaceAll(" ","+");

	%>
			<tbody>
				<tr>
					<td style="text-align:center;font-weight:700;width:5%;"><%=rank%></td>
					<td style="font-weight:700;width:30%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
			}

	%>
			</tbody>
			</table>
		<br><br>
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