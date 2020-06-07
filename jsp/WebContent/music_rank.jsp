<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!--
------------------------------------------------------------
* @설명 : 일별 박스오피스 REST 호출 - 서버측에서 호출하는 방식 예제
------------------------------------------------------------
-->
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
	String Melon_query = "select timedata from time_data where type='10m'";
	Melon_PS = con.prepareStatement(Melon_query);
	Melon_RS = Melon_PS.executeQuery();
	Melon_RS.next();
	String time = Melon_RS.getString("timedata");	
		
	Melon_query = "select * from melon_music_rank";
	Melon_PS = con.prepareStatement(Melon_query);
	Melon_RS = Melon_PS.executeQuery();
	
	/*벅스*/
	String Bugs_query = "select timedata from time_data where type='10m'";
	Bugs_PS = con.prepareStatement(Bugs_query);
	Bugs_RS = Bugs_PS.executeQuery();
	Bugs_RS.next();
	String Bugs_time = Bugs_RS.getString("timedata");	
		
	Bugs_query = "select * from bugs_music_rank";
	Bugs_PS = con.prepareStatement(Bugs_query);
	Bugs_RS = Bugs_PS.executeQuery();
	
	/*지니 뮤직*/
	String Genie_query = "select timedata from time_data where type='10m'";
	Genie_PS = con.prepareStatement(Genie_query);
	Genie_RS = Genie_PS.executeQuery();
	Genie_RS.next();
	String Genie_time = Genie_RS.getString("timedata");	
		
	Genie_query = "select * from genie_music_rank";
	Genie_PS = con.prepareStatement(Genie_query);
	Genie_RS = Genie_PS.executeQuery();
			
	/*빌보드*/
	String Billboard_query = "select * from billboard_music_rank";
	Billboard_PS = con.prepareStatement(Billboard_query);
	Billboard_RS = Billboard_PS.executeQuery();

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
	<img alt="Free Video Templates" class="d-inline-block align-top" height="30" src="https://www.velosofy.com/img/logo.png" title="Free Video Templates" width="30"/> 
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

<h1 class="poppins" style="font-size:50px;">실시간&nbsp<span>음악&nbsp</span>순위</h1> 

<h2 class="lead text-muted">부제목 </h2> 
<!-- 
<a class="btn btn-primary my-2" href="https://www.velosofy.com/templates">Find a template</a> 
<a class="btn btn-secondary my-2" href="https://www.velosofy.com/submit">Submit a template</a> 
 -->
</div> 
</section> 

<div class="container pb-5"> 





<div class="row">

	<div class="col-md-3 templates" style="width:100%;">
	<h3 class="py-4 poppins"><span class="text-primary">멜론 차트</span> </h3>
		<div>기준 날짜 : <%=time%></div>
			<table class="table table-striped table-hover" border="1">
				<tr>
					<td>rank</td>
					<td>title</td>
					<td>artist</td>
					
				</tr>
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
	%>
				<tr>
					<td><%=rank%></td>
					<td><a href=<%=title_url%> target="_blank"><%=title%></a></td>
					<td><a href=<%=artist_url%> target="_blank"><%=artist%></a></td>
									</tr>
	<%
				count++;
			}
			
	%>
		</table>
		<br><br>
	</div>

	<br>
	<div class="col-md-3 templates" style="width:100%;">
	<h3 class="py-4 poppins"><span class="text-primary">벅스 차트</span> </h3>
		<div>기준 날짜 : <%=Bugs_time%></div>
			<table border="1">
				<tr>
					<td>rank</td>
					<td>title</td>
					<td>artist</td>

				</tr>
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
	%>
				<tr>
					<td><%=rank%></td>
					<td><a href=<%=title_url%> target="_blank"><%=title%></a></td>
					<td><a href=<%=artist_url%> target="_blank"><%=artist%></a></td>
									</tr>
	<%
				count++;
			}
	
	%>
		</table>
		<br><br>
	</div>

	<br>
	<div class="col-md-3 templates" style="width:100%;">
	<h3 class="py-4 poppins"><span class="text-primary">지니 차트</span> </h3>
		<div>기준 날짜 : <%=Genie_time%></div>
			<table border="1">
				<tr>
					<td>rank</td>
					<td>title</td>
					<td>artist</td>
				</tr>
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
	%>
				<tr>
					<td><%=rank%></td>
					<td><a href=<%=title_url%> target="_blank"><%=title%></a></td>
					<td><a href=<%=artist_url%> target="_blank"><%=artist%></a></td>
				</tr>
	<%
				count++;
			}
	%>
		</table>
		<br><br>
	</div>

	<br>
	<div class="col-md-3 templates" style="width:100%;">
		<h3 class="py-4 poppins"><span class="text-primary">빌보드 차트</span> </h3>
			기준 날짜 : <%= sf.format(nowTime) %>
			<table border="1">
				<tr>
					<td>rank</td>
					<td>title</td>
					<td>artist</td>
				</tr>
	<%
			count = 0;
			while(Billboard_RS.next())
			{
				String rank = Billboard_RS.getString("rank");
				String title = Billboard_RS.getString("title");
				String artist = Billboard_RS.getString("artist");
	%>
				<tr>
					<td><%=rank%></td>
					<td><%=title%></td>
					<td><%=artist%></td>
				</tr>
	<%
				count++;
			}
	%>
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