<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
		<a class="navbar-brand " href="./m"> 
		<i class="fa fa-trophy" aria-hidden="true" style="width:30px"></i>
		랭킹.pw
		</a> 
</nav> 

<button aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler" data-target="#navbarSupportedContent" data-toggle="collapse" type="button"> 
<span class="navbar-toggler-icon"></span> </button> 

<div class="collapse navbar-collapse" id="navbarSupportedContent"> 
<ul class="navbar-nav mr-auto"> 

<li class="nav-item"> 
<a class="nav-link" href="./t">실검 차트</a> 
</li> 
<li class="nav-item"> 
<a class="nav-link" href="./mu">음악 차트</a> 
</li> 
<li class="nav-item"> 
<a class="nav-link" href="./mo">영화 차트</a> 
</li> 
<li class="nav-item"> 
<a class="nav-link" href="./b">도서 차트</a> 
<li class="nav-item"> 
<a class="nav-link" href="./a">앱 차트</a> 
</li> 
<li class="nav-item"> 
<a class="nav-link" href="./ag">모바일 게임 차트</a> 
</li> 

<ul class="navbar-nav ml-auto"> 
	<li class="nav-item"> 
		<a class="nav-link" href="./f">해외 차트</a> 
	</li> 
</ul> 

</div> 

</div> 
</nav> 

</body>
</html>
