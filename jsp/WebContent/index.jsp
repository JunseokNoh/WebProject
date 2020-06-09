<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
------------------------------------------------------------
* @설명 : 일별 박스오피스 REST 호출 - 서버측에서 호출하는 방식 예제
------------------------------------------------------------
-->

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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	 
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

<nav class="navbar navbar-expand-md navbar-light navbar-velosofy" style="background-color : #81ecec;"> 
	<div class="container"> 
<nav class="navbar navbar-light"> 
	<a class="navbar-brand " href="./index.jsp"> 
	<i class="fa fa-trophy" aria-hidden="true" style="width:30px"]></i>
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

<h1 class="poppins" style="font-size:50px;">실시간&nbsp<span id="keyword">포털&nbsp</span>순위</h1> 

<h2 class="lead text-muted">부제목 </h2> 
<!-- 
<a class="btn btn-primary my-2" href="https://www.velosofy.com/templates">Find a template</a> 
<a class="btn btn-secondary my-2" href="https://www.velosofy.com/submit">Submit a template</a> 
 -->
</div> 
</section> 

<div class="container pb-5"> 



<h3 class="py-4 poppins"><span class="text-primary">영화 차트</span> </h3>


<div class="row">

<!-- 

<div class="col-md-3 templates">
<a class="card mb-4 shadow-sm" href="/template/intro-template-130" title="FREE 2D Intro #130 | After Effects Template">
<img alt="FREE 2D Intro #130 | After Effects Template" class="hoverable" loading="lazy" src="https://i.ytimg.com/vi/vtucu0vNnl8/mqdefault.jpg" title="FREE 2D Intro #130 | After Effects Template" width="100%"/>
</a>
</div>

<div class="col-md-3 templates">
<a class="card mb-4 shadow-sm" href="/template/c4d-template-69" title="FREE 3D Intro #69 | Cinema 4D/AE Template">
<img alt="FREE 3D Intro #69 | Cinema 4D/AE Template" class="hoverable" loading="lazy" src="https://i.ytimg.com/vi/xCA1UJbR6P8/mqdefault.jpg" title="FREE 3D Intro #69 | Cinema 4D/AE Template" width="100%"/>
</a>
</div>

<div class="col-md-3 templates">
<a class="card mb-4 shadow-sm" href="/template/intro-template-129" title="FREE 2D Intro #129 | Sony Vegas/After Effects Template">
<img alt="FREE 2D Intro #129 | Sony Vegas/After Effects Template" class="hoverable" loading="lazy" src="https://i.ytimg.com/vi/6RYDBuX-qvE/mqdefault.jpg" title="FREE 2D Intro #129 | Sony Vegas/After Effects Template" width="100%"/>
</a>
</div>

<div class="col-md-3 templates">
<a class="card mb-4 shadow-sm" href="/template/c4d-template-68" title="FREE 3D Intro #68 | Cinema 4D/AE Template">
<img alt="FREE 3D Intro #68 | Cinema 4D/AE Template" class="hoverable" loading="lazy" src="https://i.ytimg.com/vi/71R1MC8Is44/mqdefault.jpg" title="FREE 3D Intro #68 | Cinema 4D/AE Template" width="100%"/>
</a>
</div>
 -->
 

</div>
<!-- 
<div class="text-right">
<a class="btn btn-primary" href="/templates/featured">
                Show 200 more featured templates
            </a>
</div>
 -->
 
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