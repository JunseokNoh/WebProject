
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.*" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
		
		PreparedStatement flo_PS = null;
		ResultSet flo_RS = null;
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
				
		/*플로*/
		String flo_query = "select timedata from time_data where type='1h'";
		flo_PS = con.prepareStatement(flo_query);
		flo_RS = flo_PS.executeQuery();
		flo_RS.next();
		String flo_time = flo_RS.getString("timedata");
	
		flo_query = "select * from flo_music_rank";
		flo_PS = con.prepareStatement(flo_query);
		flo_RS = flo_PS.executeQuery();
	
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
		SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 kk:mm:ss");
		
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

<jsp:include page="header.jsp" flush="true"/>

<main> 

<section id="landing" style="height"> 

<div class="container"> 

<!-- 
<a class="btn btn-primary my-2" href="https://www.velosofy.com/templates">Find a template</a> 
<a class="btn btn-secondary my-2" href="https://www.velosofy.com/submit">Submit a template</a> 
 -->
</div> 
</section> 

<div class="container pb-5"> 



	<br>
<div class="row">

	<div id="div5" class="col-md-6 templates" style="" >
	<div id="div0" class="col-md-12 templates" >
		<h3 class="poppins" style=""><img src="./top1_trophy.png" width="45" height="45"> 실시간 검색 TOP3<a id="lookMore" href="./trend_rank.jsp" style="font-size: medium;"> 더 보기</a></h3> 
		
	</div>
			
	<div id="div1" class="col-md-12 templates" style="display : inline-block;">

			<table id="naver" class="table table-hover">
	<%
			int count = 0;
	
			String[] Naver_Url_list = new String[3];
			String[] Naver_Title_list = new String[3];
			
			while(Naver_RS.next())
			{
				String rank = Naver_RS.getString("rank");
				String title = Naver_RS.getString("title");
				String url = Naver_RS.getString("url");
				url = url.replaceAll(" ", "+");
				String Id = Integer.toString(count);
				Naver_Url_list[count] = url;
				Naver_Title_list[count] = title;
				count++;
				if(count >= 3)
					break;
			}
	%>
			<tbody id="naver_tbody">
				<tr id="naver_0">
					<td style="width:25%">네이버</td>
					<td style="width:10%; float:left; font-weight:bold;">1</td>
					<td style="font-weight:700;width:75%;"><a href=<%=Naver_Url_list[0]%> target="_blank"><%=Naver_Title_list[0]%></a></td>
				</tr>
			</tbody>

			
		</table>
			<script type="text/javascript">
					var naver_url = ["<%=Naver_Url_list[0]%>","<%=Naver_Url_list[1]%>","<%=Naver_Url_list[2]%>" ];
					var naver_title = ["<%=Naver_Title_list[0]%>","<%=Naver_Title_list[1]%>","<%=Naver_Title_list[2]%>" ];
					var naver_index = 1;
					var naver_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#naver_tbody").empty(
								);
							
							naver_rank = naver_index + 1;
							$("#naver_tbody").append(
									"<tr id=naver_" + naver_index + ">"+
										 
										" </td>" +" <td style='width:25%;'> " + " 네이버 " + 
										" </td>" +
										"<td style='width:10%; float:left; font-weight:bold;'>" + naver_rank +"</td>"+
										"<td style='font-weight:700; width:75%; margin:10%;'>" + "<a href=" + naver_url[naver_index]+ " target='_blank'>" + naver_title[naver_index] + "</a>"
										+"</td>"
									+"</tr>"
								);
							naver_index ++;
							if(naver_index == 3){
								naver_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>
	

	
	<div id="div2" class="col-md-12 templates" style="display : inline-block;">
			<table class="table table-hover">

	<%
			count = 0;
			String[] Zum_Url_list = new String[3];
			String[] Zum_Title_list = new String[3];
	
			while(Zum_RS.next())
			{
				String rank = Zum_RS.getString("rank");
				String title = Zum_RS.getString("title");
				String url = Zum_RS.getString("url");
				url = url.replaceAll(" ", "+");	
				Zum_Url_list[count] = url;
				Zum_Title_list[count] = title;
				
				count++;
				if(count >= 3)
					break;
			}
		
		
	%>
				<tbody id="Zum_tbody">
					<tr id="Zum_0">
						<td style="width:25%">Zum</td>
						<td style="width:10%; float:left; font-weight:bold;">1</td>
						<td style="font-weight:700;width:75%;"><a href=<%=Zum_Url_list[0]%> target="_blank"><%=Zum_Title_list[0]%></a></td>
					</tr>
				</tbody>
			</table>
			<script type="text/javascript">
					var Zum_url = ["<%=Zum_Url_list[0]%>","<%=Zum_Url_list[1]%>","<%=Zum_Url_list[2]%>" ];
					var Zum_title = ["<%=Zum_Title_list[0]%>","<%=Zum_Title_list[1]%>","<%=Zum_Title_list[2]%>" ];
					var Zum_index = 1;
					var Zum_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Zum_tbody").empty(
								);
							
							Zum_rank = Zum_index + 1;
							$("#Zum_tbody").append(
									"<tr id=Zum_" + Zum_index + ">"+
										 
										" </td>" +" <td style='width:25%;'> " + " Zum " + 
										" </td>" +
										"<td style='width:10%; float:left; font-weight:bold;'>" + Zum_rank +"</td>"+
										"<td style='font-weight:700; width:75%; margin:10%;'>" + "<a href=" + Zum_url[Zum_index]+ " target='_blank'>" + Zum_title[Zum_index] + "</a>"
										+"</td>"
									+"</tr>"
								);
							Zum_index ++;
							if(Zum_index == 3){
								Zum_index = 0;
							}
							
						},5000);
						
					});
			</script>
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
			String[] Google_Url_list = new String[3];
			String[] Google_Title_list = new String[3];
			
			while(Google_RS.next())
			{
				String rank = Google_RS.getString("rank");
				String title = Google_RS.getString("title");				
				String url = Google_RS.getString("url");
				url = url.replaceAll(" ", "+");
				Google_Url_list[count] = url;
				Google_Title_list[count] = title;
	%>

	<%
				count++;
				if(count >= 3)
					break;
			}
	%>
				<tbody id="Google_tbody">
					<tr id="Google_0">
						<td style="width:25%">구글</td>
						<td style="width:10%; float:left; font-weight:bold;">1</td>
						<td style="font-weight:700;width:75%;"><a href=<%=Google_Url_list[0]%> target="_blank"><%=Google_Title_list[0]%></a></td>
					</tr>
				</tbody>
			</table>
			<script type="text/javascript">
					var Google_url = ["<%=Google_Url_list[0]%>","<%=Google_Url_list[1]%>","<%=Google_Url_list[2]%>" ];
					var Google_title = ["<%=Google_Title_list[0]%>","<%=Google_Title_list[1]%>","<%=Google_Title_list[2]%>" ];
					var Google_index = 1;
					var Google_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Google_tbody").empty(
								);
							
							Google_rank = Google_index + 1;
							$("#Google_tbody").append(
									"<tr id=Google_" + Google_index + ">"+
										 
										" </td>" +" <td style='width:25%;'> " + " 구글 " + 
										" </td>" +
										"<td style='width:10%; float:left; font-weight:bold;'>" + Google_rank +"</td>"+
										"<td style='font-weight:700; width:75%; margin:10%;'>" + "<a href=" + Google_url[Google_index]+ " target='_blank'>" + Google_title[Google_index] + "</a>"
										+"</td>"
									+"</tr>"
								);
							Google_index ++;
							if(Google_index == 3){
								Google_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>

	<div id="div4" class="col-md-12 templates" style="display : inline-block;">
			<table class="table table-hover">
	<%
			count = 0;
			String[] Nate_Url_list = new String[3];
			String[] Nate_Title_list = new String[3];
			
			while(Nate_RS.next())
			{
				String rank = Nate_RS.getString("rank");
				String title = Nate_RS.getString("title");
				String url = "https://search.daum.net/nate?thr=sbma&w=tot&q=" + title.replaceAll(" ","+");
				Nate_Url_list[count] = url;
				Nate_Title_list[count] = title;
	%>
	<%
				count++;
				if(count >= 3)
					break;
			}

	%>
				<tbody id="Nate_tbody">
					<tr id="Nate_0">
						<td style="width:25%">네이트</td>
						<td style="width:10%; float:left; font-weight:bold;">1</td>
						<td style="font-weight:700;width:75%;"><a href=<%=Nate_Url_list[0]%> target="_blank"><%=Nate_Title_list[0]%></a></td>
					</tr>
				</tbody>
			
			</table>
			<script type="text/javascript">
					var Nate_url = ["<%=Nate_Url_list[0]%>","<%=Nate_Url_list[1]%>","<%=Nate_Url_list[2]%>" ];
					var Nate_title = ["<%=Nate_Title_list[0]%>","<%=Nate_Title_list[1]%>","<%=Nate_Title_list[2]%>" ];
					var Nate_index = 1;
					var Nate_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Nate_tbody").empty(
								);
							
							Nate_rank = Nate_index + 1;
							$("#Nate_tbody").append(
									"<tr id=Nate_" + Nate_index + ">"+
										 
										" </td>" +" <td style='width:25%;'> " + " 네이트 " + 
										" </td>" +
										"<td style='width:10%; float:left; font-weight:bold;'>" + Nate_rank +"</td>"+
										"<td style='font-weight:700; width:75%; margin:10%;'>" + "<a href=" + Nate_url[Nate_index]+ " target='_blank'>" + Nate_title[Nate_index] + "</a>"
										+"</td>"
									+"</tr>"
								);
							Nate_index ++;
							if(Nate_index == 3){
								Nate_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>
	<br><br>
	</div>
	
	<div id="div5" class="col-md-6 templates" >
	<div id="div0" class="col-md-12 templates" >
		<h3 class="poppins" style=""><img src="./top1_trophy.png" width="45" height="45"> 음악 TOP3<a id="lookMore" href="./music_rank.jsp" style="font-size: medium;"> 더 보기</a></h3> 
	</div>
	
	<div id="div1" class="col-md-12 templates" style="display : inline-block;">
		
			<table class="table table-hover">
	<%
			count = 0;
	
			String[] Melon_artist_list = new String[3];
			String[] Melon_artistURL_list = new String[3];
			
			String[] Melon_Title_list = new String[3];
			String[] Melon_TitleURL_list = new String[3];
			
			String[] Melon_albumURL_list = new String[3];
			String[] Melon_imageURL_list = new String[3];
			
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
				
				Melon_artist_list[count] = artist;
				Melon_artistURL_list[count] = artist_url;
					
				Melon_Title_list[count] = title;
				Melon_TitleURL_list[count] = title_url;
				
				Melon_albumURL_list[count] = album_url;
				Melon_imageURL_list[count] = image_url;
	%>
				
	<%
				count++;
				if(count >= 3)
					break;
			}
			
	%>
					<tbody id="Melon_tbody">
						<tr id="Melon_0">
							<td style="width:20%;">멜론</td>
							<td style="width:10%; float:left; font-weight:bold;">1</td>
							<td>
								<a href=<%=Melon_TitleURL_list[0]%> style=" font-weight:700" target="_blank"><img src=<%=Melon_imageURL_list[0]%> width="60" height="60"></a>
							</td>
							<td style="width:70%;"><a href=<%=Melon_TitleURL_list[0]%> style=" font-weight:700;" target="_blank"><%=Melon_Title_list[0]%></a>
							<br>
							<a href=<%=Melon_artistURL_list[0]%> style="font-size:13px; font-weight:10;"target="_blank"><%=Melon_artist_list[0]%></a>
							</td>
							
						</tr>
					</tbody>
			</table>
		<script type="text/javascript">
					var Melon_artist = ["<%=Melon_artist_list[0]%>","<%=Melon_artist_list[1]%>","<%=Melon_artist_list[2]%>" ];
					var Melon_artist_URL = ["<%=Melon_artistURL_list[0]%>","<%=Melon_artistURL_list[1]%>","<%=Melon_artistURL_list[2]%>" ];
					
					var Melon_title = ["<%=Melon_Title_list[0]%>","<%=Melon_Title_list[1]%>","<%=Melon_Title_list[2]%>" ];
					var Melon_title_URL = ["<%=Melon_TitleURL_list[0]%>","<%=Melon_TitleURL_list[1]%>","<%=Melon_TitleURL_list[2]%>" ];
					
					var Melon_album_URL = ["<%=Melon_albumURL_list[0]%>","<%=Melon_albumURL_list[1]%>","<%=Melon_albumURL_list[2]%>" ];
					var Melon_image_URL = ["<%=Melon_imageURL_list[0]%>","<%=Melon_imageURL_list[1]%>","<%=Melon_imageURL_list[2]%>" ];
					
					var Melon_index = 1;
					var Melon_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Melon_tbody").empty(
								);
							
							Melon_rank = Melon_index + 1;
							$("#Melon_tbody").append(
									"<tr id= Melon_" + Melon_index +">"+
										"<td style='width:20%;'>" + "멜론" + "</td>"
										+"<td style='width:10%; float:left; font-weight:bold;'>" +Melon_rank+ "</td>"+
										"<td>"+
											"<a href=" + Melon_title_URL[Melon_index] + " style='font-weight:bold'"+ "target='_blank'>" + "<img src=" + Melon_image_URL[Melon_index] + 
											"width='60' height='60'></a>"
										+"</td>"+
										"<td style='width:70%;'>" + "<a href=" + Melon_title_URL[Melon_index]+ " style='font-weight:bold;'" + "target='_blank'>" + Melon_title[Melon_index] + "</a>"
										+"<br>"
										+"<a href=" + Melon_artist_URL[Melon_index]+ " style='font-size:13px; font-weight:10;'" + "target='_blank'>"+ Melon_artist[Melon_index] +"</a>"
										+"</td>"
									+"</tr>"
								);
							Melon_index ++;
							if(Melon_index == 3){
								Melon_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>	
	
	<div id="div2" class="col-md-12 templates" style="display : inline-block;">
			<table class="table table-hover">
	<%
			count = 0;
	
			String[] Genie_artist_list = new String[3];
			String[] Genie_artistURL_list = new String[3];
			
			String[] Genie_Title_list = new String[3];
			String[] Genie_TitleURL_list = new String[3];
			
			String[] Genie_albumURL_list = new String[3];
			String[] Genie_imageURL_list = new String[3];
	
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
				
				Genie_artist_list[count] = artist;
				Genie_artistURL_list[count] = artist_url;
					
				Genie_Title_list[count] = title;
				Genie_TitleURL_list[count] = title_url;
				
				Genie_albumURL_list[count] = album_url;
				Genie_imageURL_list[count] = image_url;
	%>
	<%
				count++;
				if(count >= 3)
					break;
			}
	%>
					<tbody id="Genie_tbody">
						<tr id="Genie_0">
							<td style="width:20%;">지니</td>
							<td style="width:10%; float:left; font-weight:bold;">1</td>
							<td>
								<a href=<%=Genie_TitleURL_list[0]%> style=" font-weight:700" target="_blank"><img src=<%=Genie_imageURL_list[0]%> width="60" height="60"></a>
							</td>
							<td style="width:70%;"><a href=<%=Genie_TitleURL_list[0]%> style=" font-weight:700;" target="_blank"><%=Genie_Title_list[0]%></a>
							<br>
							<a href=<%=Genie_artistURL_list[0]%> style="font-size:13px; font-weight:10;"target="_blank"><%=Genie_artist_list[0]%></a>
							</td>
							
						</tr>
					</tbody>
		</table>
		<script type="text/javascript">
					var Genie_artist = ["<%=Genie_artist_list[0]%>","<%=Genie_artist_list[1]%>","<%=Genie_artist_list[2]%>" ];
					var Genie_artist_URL = ["<%=Genie_artistURL_list[0]%>","<%=Genie_artistURL_list[1]%>","<%=Genie_artistURL_list[2]%>" ];
					
					var Genie_title = ["<%=Genie_Title_list[0]%>","<%=Genie_Title_list[1]%>","<%=Genie_Title_list[2]%>" ];
					var Genie_title_URL = ["<%=Genie_TitleURL_list[0]%>","<%=Genie_TitleURL_list[1]%>","<%=Genie_TitleURL_list[2]%>" ];
					
					var Genie_album_URL = ["<%=Genie_albumURL_list[0]%>","<%=Genie_albumURL_list[1]%>","<%=Genie_albumURL_list[2]%>" ];
					var Genie_image_URL = ["<%=Genie_imageURL_list[0]%>","<%=Genie_imageURL_list[1]%>","<%=Genie_imageURL_list[2]%>" ];
					
					var Genie_index = 1;
					var Genie_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Genie_tbody").empty(
								);
							
							Genie_rank = Genie_index + 1;
							$("#Genie_tbody").append(
									"<tr id= Genie_" + Genie_index +">"+
										"<td style='width:20%;'>" + "지니" + "</td>"
										+"<td style='width:10%; float:left; font-weight:bold;'>" +Genie_rank+ "</td>"+
										"<td>"+
											"<a href=" + Genie_title_URL[Genie_index] + " style='font-weight:bold'"+ "target='_blank'>" + "<img src="+Genie_image_URL[Genie_index]+ 
											" width='60' height='60'></a>"
										+"</td>"+
										"<td style='width:70%;'>" + "<a href=" + Genie_title_URL[Genie_index]+ " style='font-weight:bold;'" + "target='_blank'>" + Genie_title[Genie_index] + "</a>"
										+"<br>"
										+"<a href=" + Genie_artist_URL[Genie_index]+ " style='font-size:13px; font-weight:10;'" + "target='_blank'>"+ Genie_artist[Genie_index] +"</a>"
										+"</td>"
									+"</tr>"
								);
							Genie_index ++;
							if(Genie_index == 3){
								Genie_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>
	
	<div id="div3" class="col-md-12 templates" style="display:inline-block;">
		
			<table class="table table-hover">

	<%
			count = 0;
	
			String[] Bugs_artist_list = new String[3];
			String[] Bugs_artistURL_list = new String[3];
			
			String[] Bugs_Title_list = new String[3];
			String[] Bugs_TitleURL_list = new String[3];
			
			String[] Bugs_albumURL_list = new String[3];
			String[] Bugs_imageURL_list = new String[3];

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
				
				Bugs_artist_list[count] = artist;
				Bugs_artistURL_list[count] = artist_url;
					
				Bugs_Title_list[count] = title;
				Bugs_TitleURL_list[count] = title_url;
				
				Bugs_albumURL_list[count] = album_url;
				Bugs_imageURL_list[count] = image_url;
	%>
	
	
	<%
				count++;
				if(count >= 3)
					break;
			}
	
	%>
						<tbody id="Bugs_tbody">
						<tr id="Bugs_0">
							<td style="width:20%;">벅스</td>
							<td style="width:10%; float:left; font-weight:bold;">1</td>
							<td>
								<a href=<%=Bugs_TitleURL_list[0]%> style=" font-weight:700" target="_blank"><img src=<%=Bugs_imageURL_list[0]%> width="60" height="60"></a>
							</td>
							<td style="width:70%;"><a href=<%=Bugs_TitleURL_list[0]%> style=" font-weight:700;" target="_blank"><%=Bugs_Title_list[0]%></a>
							<br>
							<a href=<%=Bugs_artistURL_list[0]%> style="font-size:13px; font-weight:10;"target="_blank"><%=Bugs_artist_list[0]%></a>
							</td>
							
						</tr>
					</tbody>
		</table>
		<script type="text/javascript">
					var Bugs_artist = ["<%=Bugs_artist_list[0]%>","<%=Bugs_artist_list[1]%>","<%=Bugs_artist_list[2]%>" ];
					var Bugs_artist_URL = ["<%=Bugs_artistURL_list[0]%>","<%=Bugs_artistURL_list[1]%>","<%=Bugs_artistURL_list[2]%>" ];
					
					var Bugs_title = ["<%=Bugs_Title_list[0]%>","<%=Bugs_Title_list[1]%>","<%=Bugs_Title_list[2]%>" ];
					var Bugs_title_URL = ["<%=Bugs_TitleURL_list[0]%>","<%=Bugs_TitleURL_list[1]%>","<%=Bugs_TitleURL_list[2]%>" ];
					
					var Bugs_album_URL = ["<%=Bugs_albumURL_list[0]%>","<%=Bugs_albumURL_list[1]%>","<%=Bugs_albumURL_list[2]%>" ];
					var Bugs_image_URL = ["<%=Bugs_imageURL_list[0]%>","<%=Bugs_imageURL_list[1]%>","<%=Bugs_imageURL_list[2]%>" ];
					
					var Bugs_index = 1;
					var Bugs_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Bugs_tbody").empty(
								);
							
							Bugs_rank = Bugs_index + 1;
							$("#Bugs_tbody").append(
									"<tr id= Bugs_" + Bugs_index +">"+
										"<td style='width:20%;'>" + "벅스" + "</td>"
										+"<td style='width:10%; float:left; font-weight:bold;'>" +Bugs_rank+ "</td>"+
										"<td>"+
											"<a href=" + Bugs_title_URL[Bugs_index] + " style='font-weight:bold'"+ "target='_blank'>" + "<img src="+Bugs_image_URL[Bugs_index]+ 
											" width='60' height='60'></a>"
										+"</td>"+
										"<td style='width:70%;'>" + "<a href=" + Bugs_title_URL[Bugs_index]+ " style='font-weight:bold;'" + "target='_blank'>" + Bugs_title[Bugs_index] + "</a>"
										+"<br>"
										+"<a href=" + Bugs_artist_URL[Bugs_index]+ " style='font-size:13px; font-weight:10;'" + "target='_blank'>"+ Bugs_artist[Bugs_index] +"</a>"
										+"</td>"
									+"</tr>"
								);
							Bugs_index ++;
							if(Bugs_index == 3){
								Bugs_index = 0;
							}
							
						},5000);
						
					});
			</script>
			
	</div>

	<div id="div4" class="col-md-12 templates" style="display:inline-block;">
		<table class="table table-hover">

	<%
			count = 0;
			
			String[] flo_artist_list = new String[3];
			String[] flo_artistURL_list = new String[3];
			
			String[] flo_Title_list = new String[3];
			String[] flo_TitleURL_list = new String[3];
			
			String[] flo_albumURL_list = new String[3];
			String[] flo_imageURL_list = new String[3];

			while(flo_RS.next())
			{
				String rank = flo_RS.getString("rank");
				String title = flo_RS.getString("song_title");
				String title_url = flo_RS.getString("song_url");
				String artist = flo_RS.getString("song_artist");
				String artist_url = flo_RS.getString("artist_url");
				String album = flo_RS.getString("album_title");
				String album_url = flo_RS.getString("album_url");
				String image_url = flo_RS.getString("image_url");
				
				flo_artist_list[count] = artist;
				flo_artistURL_list[count] = artist_url;
					
				flo_Title_list[count] = title;
				flo_TitleURL_list[count] = title_url;
				
				flo_albumURL_list[count] = album_url;
				flo_imageURL_list[count] = image_url;
	%>
				
	<%
				count++;
				if(count >= 3)
					break;
			}
	%>
				<tbody id = "flo_tbody">
				<tr id="flo_0">
							<td style="width:20%;">플로</td>
							<td style="width:10%; float:left; font-weight:bold;">1</td>
							<td>
								<a href=<%=flo_TitleURL_list[0]%> style=" font-weight:700" target="_blank"><img src=<%=flo_imageURL_list[0]%> width="60" height="60"></a>
							</td>
							<td style="width:70%;"><a href=<%=flo_TitleURL_list[0]%> style=" font-weight:700;" target="_blank"><%=flo_Title_list[0]%></a>
							<br>
							<a href=<%=flo_artistURL_list[0]%> style="font-size:13px; font-weight:10;"target="_blank"><%=flo_artist_list[0]%></a>
							</td>
							
				</tr>
				</tbody>
				
			</table>
			<script type="text/javascript">
					var flo_artist = ["<%=flo_artist_list[0]%>","<%=flo_artist_list[1]%>","<%=flo_artist_list[2]%>" ];
					var flo_artist_URL = ["<%=flo_artistURL_list[0]%>","<%=flo_artistURL_list[1]%>","<%=flo_artistURL_list[2]%>" ];
					
					var flo_title = ["<%=flo_Title_list[0]%>","<%=flo_Title_list[1]%>","<%=flo_Title_list[2]%>" ];
					var flo_title_URL = ["<%=flo_TitleURL_list[0]%>","<%=flo_TitleURL_list[1]%>","<%=flo_TitleURL_list[2]%>" ];
					
					var flo_album_URL = ["<%=flo_albumURL_list[0]%>","<%=flo_albumURL_list[1]%>","<%=flo_albumURL_list[2]%>" ];
					var flo_image_URL = ["<%=flo_imageURL_list[0]%>","<%=flo_imageURL_list[1]%>","<%=flo_imageURL_list[2]%>" ];
					
					var flo_index = 1;
					var flo_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#flo_tbody").empty(
								);
							
							flo_rank = flo_index + 1;
							$("#flo_tbody").append(
									"<tr id= flo_" + flo_index +">"+
										"<td style='width:20%;'>" + "플로" + "</td>"
										+"<td style='width:10%; float:left; font-weight:bold;'>" +flo_rank+ "</td>"+
										"<td>"+
											"<a href=" + flo_title_URL[flo_index] + " style='font-weight:bold'"+ "target='_blank'>" + "<img src="+flo_image_URL[flo_index]+ 
											" width='60' height='60'></a>"
										+"</td>"+
										"<td style='width:70%;'>" + "<a href=" + flo_title_URL[flo_index]+ " style='font-weight:bold;'" + "target='_blank'>" + flo_title[flo_index] + "</a>"
										+"<br>"
										+"<a href=" + flo_artist_URL[flo_index]+ " style='font-size:13px; font-weight:10;'" + "target='_blank'>"+ flo_artist[flo_index] +"</a>"
										+"</td>"
									+"</tr>"
								);
							flo_index ++;
							if(flo_index == 3){
								flo_index = 0;
							}
							
						},5000);
						
					});
			</script>
			
	</div>
	<br><br>
	</div>
	
	<div id="div5" class="col-md-6 templates" >
		<div id="div0" class="col-md-12 templates" >
		<h3 class="poppins" style=""><img src="./top1_trophy.png" width="45" height="45"> 영화 TOP3<a id="lookMore" href="./movie_rank.jsp" style="font-size: medium;"> 더 보기</a></h3> 
			<br>
		</div>
	
	<div id="div1" class="col-md-5 templates" style="display : inline-block;">
			<div id="div1" class="col-md-12 templates" >박스오피스</div>
			<table class="table table-hover">
	<%
			count = 0;
	
			String[] Boxoffice_rank_list = new String[3];
			String[] Boxoffice_title_list = new String[3];
			
			String[] Boxoffice_attendance_list = new String[3];
			String[] Boxoffice_url_list = new String[3];
			
			String[] Boxoffice_image_url_list = new String[3];
			
			while(Boxoffice_RS.next())
			{
				String rank = Boxoffice_RS.getString("rank");
				String title = Boxoffice_RS.getString("title");
				String attendance = Boxoffice_RS.getString("attendance");
				String url = Boxoffice_RS.getString("url");
				String image_url = Boxoffice_RS.getString("image_url");
				
				Boxoffice_rank_list[count] = rank;
				Boxoffice_title_list[count] = title;
				Boxoffice_attendance_list[count] = attendance;
				Boxoffice_url_list[count] = url;
				Boxoffice_image_url_list[count] = image_url;
	%>
				
	<%
				count++;
				if(count >= 3){
					break;
				}
			}
	
	%>
				<tbody id = "Boxoffice_tbody">
					<tr id = "Boxoffice_0">
						<td style="width:10%; float:left; font-weight:bold;">1</td>
						<td><a href=<%=Boxoffice_url_list[0]%> style=" font-weight:700;" target="_blank"><img src="<%=Boxoffice_image_url_list[0]%>" width="100" height="150"></a><br><a href=<%=Boxoffice_url_list[0]%> style=" font-weight:700;" target="_blank"><%=Boxoffice_title_list[0]%></a><br>
						<a style="font-size:13px; font-weight:10" target="_blank"><%=Boxoffice_attendance_list[0]%></a>
						</td>
					</tr>
				</tbody>
	</table>
			<script type="text/javascript">
					var Boxoffice_rank = ["<%=Boxoffice_rank_list[0]%>","<%=Boxoffice_rank_list[1]%>","<%=Boxoffice_rank_list[2]%>" ];
					var Boxoffice_title = ["<%=Boxoffice_title_list[0]%>","<%=Boxoffice_title_list[1]%>","<%=Boxoffice_title_list[2]%>" ];
					
					var Boxoffice_attendance = ["<%=Boxoffice_attendance_list[0]%>","<%=Boxoffice_attendance_list[1]%>","<%=Boxoffice_attendance_list[2]%>" ];
					var Boxoffice_url = ["<%=Boxoffice_url_list[0]%>","<%=Boxoffice_url_list[1]%>","<%=Boxoffice_url_list[2]%>" ];
					
					var Boxoffice_image_url = ["<%=Boxoffice_image_url_list[0]%>","<%=Boxoffice_image_url_list[1]%>","<%=Boxoffice_image_url_list[2]%>" ];

					var Boxoffice_index = 1;
					var Boxoffice_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Boxoffice_tbody").empty(
								);
							
							Boxoffice_rank = Boxoffice_index + 1;
							$("#Boxoffice_tbody").append(
									
									"<tr id = Boxoffice_" + Boxoffice_index + ">"
										+ "<td style='width:10%; float:left; font-weight:bold;'>"+ Boxoffice_rank+"</td>"
										+ "<td><a href=" + Boxoffice_url[Boxoffice_index] + " style=' font-weight:700;' target='_blank'>"
										+"<img src=" + Boxoffice_image_url[Boxoffice_index] + " width='100' height='150'></a>"
										+"<br><a href="+ Boxoffice_url[Boxoffice_index] + " style=' font-weight:700;' target='_blank'>"+ 
										Boxoffice_title[Boxoffice_index]+ "</a><br>" +
										"<a style='font-size:13px; font-weight:10' target='_blank'>" + Boxoffice_attendance[Boxoffice_index]+ "</a>"
										+ "</td>"
									+"</tr>"
								
								);
							Boxoffice_index ++;
							if(Boxoffice_index == 3){
								Boxoffice_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>	
	
	<div id="div2" class="col-md-5 templates" style="display : inline-block;">
			<div id="div1" class="col-md-12 templates" >예매율</div>
			<table class="table table-hover">
	<%
			count = 0;
	
			String[] Daum_rank_list = new String[3];
			String[] Daum_title_list = new String[3];
			
			String[] Daum_ticketing_list = new String[3];
			String[] Daum_url_list = new String[3];
			
			String[] Daum_image_url_list = new String[3];
	
			while(Daum_RS.next())
			{
				String rank = Daum_RS.getString("rank");
				String title = Daum_RS.getString("title");
				String ticketing = Daum_RS.getString("ticketing");
				String url = Daum_RS.getString("url");
				String image_url = Daum_RS.getString("image_url");
				
				Daum_rank_list[count] = rank;
				Daum_title_list[count] = title;
				Daum_ticketing_list[count] = ticketing;
				Daum_url_list[count] = url;
				Daum_image_url_list[count] = image_url;
	%>

	<%
				count++;
				
				if(count >= 3){
					break;
				}
			}
	%>
			<tbody id = "Daum_tbody">
				<tr id = "Daum_0">
					<td style="width:10%; float:left; font-weight:bold;">1</td>
					<td><a href=<%=Daum_url_list[0]%> style=" font-weight:700;" target="_blank"><img src="<%=Daum_image_url_list[0]%>" width="100" height="150"></a><br><a href=<%=Daum_url_list[0]%> style=" font-weight:700;" target="_blank"><%=Daum_title_list[0]%></a><br>
					<a style="font-size:13px; font-weight:10" target="_blank"><%=Daum_ticketing_list[0]%></a>
					</td>
				</tr>
			</tbody>
	</table>
		<script type="text/javascript">
					var Daum_rank = ["<%=Daum_rank_list[0]%>","<%=Daum_rank_list[1]%>","<%=Daum_rank_list[2]%>" ];
					var Daum_title = ["<%=Daum_title_list[0]%>","<%=Daum_title_list[1]%>","<%=Daum_title_list[2]%>" ];
					
					var Daum_ticketing = ["<%=Daum_ticketing_list[0]%>","<%=Daum_ticketing_list[1]%>","<%=Daum_ticketing_list[2]%>" ];
					var Daum_url = ["<%=Daum_url_list[0]%>","<%=Daum_url_list[1]%>","<%=Daum_url_list[2]%>" ];
					
					var Daum_image_url = ["<%=Daum_image_url_list[0]%>","<%=Daum_image_url_list[1]%>","<%=Daum_image_url_list[2]%>" ];

					var Daum_index = 1;
					var Daum_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Daum_tbody").empty(
								);
							
							Daum_rank = Daum_index + 1;
							$("#Daum_tbody").append(
									
									"<tr id = Daum_" + Daum_index + ">"
										+ "<td style='width:10%; float:left; font-weight:bold;'>"+ Daum_rank+"</td>"
										+ "<td><a href=" + Daum_url[Daum_index] + " style=' font-weight:700;' target='_blank'>"
										+"<img src=" + Daum_image_url[Daum_index] + " width='100' height='150'></a>"
										+"<br><a href="+ Daum_url[Daum_index] + " style=' font-weight:700;' target='_blank'>"+ 
										Daum_title[Daum_index]+ " </a><br>" +
										"<a style='font-size:13px; font-weight:10' target='_blank'>" + Daum_ticketing[Daum_index]+ "</a>"
										+ "</td>"
									+"</tr>"
								
								);
							Daum_index ++;
							if(Daum_index == 3){
								Daum_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>
	
	<div id="div3" class="col-md-5 templates" style="display:inline-block;">
		<div id="div1" class="col-md-12 templates" >평점순</div>
			<table class="table table-hover">

	<%
			count = 0;
	
			String[] Naver_rate_rank_list = new String[3];
			String[] Naver_rate_title_list = new String[3];
			
			String[] Naver_rate_rating_list = new String[3];
			String[] Naver_rate_url_list = new String[3];
			
			String[] Naver_rate_image_url_list = new String[3];
		
			while(Naver_rate_RS.next())
			{
				String rank = Naver_rate_RS.getString("rank");
				String title = Naver_rate_RS.getString("title");
				String rating = Naver_rate_RS.getString("rating");
				String url = Naver_rate_RS.getString("url");
				String image_url = Naver_rate_RS.getString("image_url");
				
				Naver_rate_rank_list[count] = rank;
				Naver_rate_title_list[count] = title;
				Naver_rate_rating_list[count] = rating;
				Naver_rate_url_list[count] = url;
				Naver_rate_image_url_list[count] = image_url;
	%>

	<%
				count++;
				if(count >= 3){
					break;
				}
			}
	
	%>
			<tbody id = "Naver_rate_tbody">
				<tr id = "Naver_rate_0">
					<td style="width:10%; float:left; font-weight:bold;">1</td>
					<td><a href=<%=Naver_rate_url_list[0]%> style=" font-weight:700;" target="_blank"><img src="<%=Naver_rate_image_url_list[0]%>" width="100" height="150"></a><br><a href=<%=Naver_rate_url_list[0]%> style=" font-weight:700;" target="_blank"><%=Naver_rate_title_list[0]%></a><br>
					<a style="font-size:13px; font-weight:10" target="_blank"><%=Naver_rate_rating_list[0]%></a>
					</td>
				</tr>
			</tbody>
	</table>
		<script type="text/javascript">
					var Naver_rate_rank = ["<%=Naver_rate_rank_list[0]%>","<%=Naver_rate_rank_list[1]%>","<%=Naver_rate_rank_list[2]%>" ];
					var Naver_rate_title = ["<%=Naver_rate_title_list[0]%>","<%=Naver_rate_title_list[1]%>","<%=Naver_rate_title_list[2]%>" ];
					
					var Naver_rate_rating = ["<%=Naver_rate_rating_list[0]%>","<%=Naver_rate_rating_list[1]%>","<%=Naver_rate_rating_list[2]%>" ];
					var Naver_rate_url = ["<%=Naver_rate_url_list[0]%>","<%=Naver_rate_url_list[1]%>","<%=Naver_rate_url_list[2]%>" ];
					
					var Naver_rate_image_url = ["<%=Naver_rate_image_url_list[0]%>","<%=Naver_rate_image_url_list[1]%>","<%=Naver_rate_image_url_list[2]%>" ];

					var Naver_rate_index = 1;
					var Naver_rate_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Naver_rate_tbody").empty(
								);
							
							Naver_rate_rank = Naver_rate_index + 1;
							$("#Naver_rate_tbody").append(
									
									"<tr id = Naver_rate_" + Naver_rate_index + ">"
										+ "<td style='width:10%; float:left; font-weight:bold;'>"+ Naver_rate_rank+"</td>"
										+ "<td><a href=" + Naver_rate_url[Naver_rate_index] + " style=' font-weight:700;' target='_blank'>"
										+"<img src=" + Naver_rate_image_url[Naver_rate_index] + " width='100' height='150'></a>"
										+"<br><a href="+ Naver_rate_url[Naver_rate_index] + " style=' font-weight:700;' target='_blank'>"+ 
										Naver_rate_title[Naver_rate_index]+ " </a><br>" +
										"<a style='font-size:13px; font-weight:10' target='_blank'>" + Naver_rate_rating[Naver_rate_index]+ "</a>"
										+ "</td>"
									+"</tr>"
								
								);
							Naver_rate_index ++;
							if(Naver_rate_index == 3){
								Naver_rate_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>

	<div id="div4" class="col-md-5 templates" style="display:inline-block;">
		<div id="div1" class="col-md-12 templates" >조회순</div>
			<table class="table table-hover">
	<%
			count = 0;
	
			String[] Naver_movie_rank_list = new String[3];
			String[] Naver_movie_title_list = new String[3];
			
			String[] Naver_movie_url_list = new String[3];
			
			String[] Naver_movie_image_url_list = new String[3];
	
			while(Naver_movie_RS.next())
			{
				String rank = Naver_movie_RS.getString("rank");
				String title = Naver_movie_RS.getString("title");
				String url = "https://movie.naver.com" + Naver_movie_RS.getString("url");
				String image_url = Naver_movie_RS.getString("image_url");
				
				Naver_movie_rank_list[count] = rank;
				Naver_movie_title_list[count] = title;
				Naver_movie_url_list[count] = url;
				Naver_movie_image_url_list[count] = image_url;
	%>


	<%
				count++;
				if(count >= 3){
					break;
				}
			}
	
	%>
			<tbody id = "Naver_movie_tbody">
				<tr id = "Naver_movie_0">
					<td style="width:10%; float:left; font-weight:bold;">1</td>
					<td><a href=<%=Naver_movie_url_list[0]%> style=" font-weight:700;" target="_blank"><img src="<%=Naver_movie_image_url_list[0]%>" width="100" height="150"></a><br>
					<a href=<%=Naver_movie_url_list[0]%> style=" font-weight:700;" target="_blank"><%=Naver_movie_title_list[0]%></a><br>
					
					</td>
				</tr>
			</tbody>
	</table>
			<script type="text/javascript">
					var Naver_movie_rank = ["<%=Naver_movie_rank_list[0]%>","<%=Naver_movie_rank_list[1]%>","<%=Naver_movie_rank_list[2]%>" ];
					var Naver_movie_title = ["<%=Naver_movie_title_list[0]%>","<%=Naver_movie_title_list[1]%>","<%=Naver_movie_title_list[2]%>" ];
					
					var Naver_movie_url = ["<%=Naver_movie_url_list[0]%>","<%=Naver_movie_url_list[1]%>","<%=Naver_movie_url_list[2]%>" ];
					
					var Naver_movie_image_url = ["<%=Naver_movie_image_url_list[0]%>","<%=Naver_movie_image_url_list[1]%>","<%=Naver_movie_image_url_list[2]%>" ];

					var Naver_movie_index = 1;
					var Naver_movie_rank = 0;

					$(document).ready(function(){

						setInterval(function()
						{
							$("#Naver_movie_tbody").empty(
								);
							
							Naver_movie_rank = Naver_movie_index + 1;
							$("#Naver_movie_tbody").append(
									
									"<tr id = Naver_rate_" + Naver_movie_index + ">"
										+ "<td style='width:10%; float:left; font-weight:bold;'>"+ Naver_movie_rank+"</td>"
										+ "<td><a href=" + Naver_movie_url[Naver_movie_index] + " style=' font-weight:700;' target='_blank'>"
										+"<img src=" + Naver_movie_image_url[Naver_movie_index] + " width='100' height='150'></a>"
										+"<br><a href="+ Naver_movie_url[Naver_movie_index] + " style=' font-weight:700;' target='_blank'>"+ 
										Naver_movie_title[Naver_movie_index]+ " </a><br>" +
										
										 "</td>"
									+"</tr>"
								
								);
							Naver_movie_index ++;
							if(Naver_movie_index == 3){
								Naver_movie_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>

	</div>
	
		<div id="div5" class="col-md-6 templates" >
		<div id="div0" class="col-md-12 templates" >
		<h3 class="poppins" style=""><img src="./top1_trophy.png" width="45" height="45"> 도서 TOP3<a id="lookMore" href="./book_rank.jsp" style="font-size: medium;"> 더 보기</a></h3> 
		<br>
		</div>
	
		<div id="div1" class="col-md-5 templates" style="display : inline-block;">
			<div id="div1" class="col-md-12 templates" >인터파크</div>
				<table class="table table-hover">

	<%
			
			count = 0;
			
			String[] Inter_rank_list = new String[3];
			String[] Inter_title_list = new String[3];
			String[] Inter_url_list = new String[3];
			String[] Inter_author_list = new String[3];
			String[] Inter_publisher_list = new String[3];
			String[] Inter_image_url_list = new String[3];
			
			while(Inter_RS.next())
			{
				String rank = Inter_RS.getString("rank");
				String title = Inter_RS.getString("title");
				String url = Inter_RS.getString("url");
				String author = Inter_RS.getString("author");
				String publisher = Inter_RS.getString("publisher");
				String image_url = Inter_RS.getString("image_url");
				
				Inter_rank_list[count] = rank;
				Inter_title_list[count] = title;
				Inter_url_list[count]  = url;
				Inter_author_list[count]  = author;
				Inter_publisher_list[count]  = publisher;
				Inter_image_url_list[count]  = image_url;
	%>

	<%
				count++;
				if(count >= 3)
					break;
			}
	%>
			<tbody id="Inter_tbody">
				<tr id="Inter_0"> 
					<td style="width:10%; float:left; font-weight:bold;">1</td>
					<td><a href=<%=Inter_url_list[0]%> style=" font-weight:700;" target="_blank"><img src=<%=Inter_image_url_list[0]%> width="100" height="150"></a><br><a href=<%=Inter_url_list[0]%> style=" font-weight:700;" target="_blank"><%=Inter_title_list[0]%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=Inter_author_list[0]%>
						</a>
					</td>
				</tr>
			</tbody>
	</table>
		<script type="text/javascript">
					
					var Inter_rank= ["<%=Inter_rank_list[0]%>","<%=Inter_rank_list[1]%>","<%=Inter_rank_list[2]%>" ];
					var Inter_title = ["<%=Inter_title_list[0]%>","<%=Inter_title_list[1]%>","<%=Inter_title_list[2]%>" ];
					var Inter_url  = ["<%=Inter_url_list[0]%>","<%=Inter_url_list[1]%>","<%=Inter_url_list[2]%>" ];
					var Inter_author  = ["<%=Inter_author_list[0]%>","<%=Inter_author_list[1]%>","<%=Inter_author_list[2]%>" ];
					var Inter_publisher  = ["<%=Inter_publisher_list[0]%>","<%=Inter_publisher_list[1]%>","<%=Inter_publisher_list[2]%>" ];
					var Inter_image_url  = ["<%=Inter_image_url_list[0]%>","<%=Inter_image_url_list[1]%>","<%=Inter_image_url_list[2]%>" ];

					var Inter_index = 1;
					var Inter_rank = 0;
					
					$(document).ready(function(){

						setInterval(function()
						{
							$("#Inter_tbody").empty(
									
							);
							
							Inter_rank = Inter_index + 1;
							
							$("#Inter_tbody").append(
								"<tr id=Inter_" + Inter_index + ">" 
									+ "<td style='width:10%; float:left; font-weight:bold;'>"+ Inter_rank +"</td>"
									+ "<td>" + "<a href=" + Inter_url[Inter_index] + " style='font-weight:700;' target='_blank'>"
									+ "<img src=" + Inter_image_url[Inter_index] + " width='100' height='150'></a>"
									+ "<br>" 
									+"<a href=" + Inter_url[Inter_index] + " style='font-weight:700;' target='_blank'>" + Inter_title[Inter_index] + "</a>"
										+"<br>"
									 + "<a style='font-size:13px; font-weight:10' target='_blank'>"+ Inter_author[Inter_index]
									+"</a>"
									+ "</td>"	
								+"</tr>"
							);
							
							Inter_index ++;
							if(Inter_index == 3){
								Inter_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>	
	
	<div id="div2" class="col-md-5 templates" style="display : inline-block;">
		<div id="div1" class="col-md-12 templates" >교보 문고</div>
		<table class="table table-hover">

	<%
			count = 0;
	
			String[] Kyobo_rank_list = new String[3];
			String[] Kyobo_title_list = new String[3];
			String[] Kyobo_url_list = new String[3];
			String[] Kyobo_author_list = new String[3];
			String[] Kyobo_publisher_list = new String[3];
			String[] Kyobo_image_url_list = new String[3];

			while(Kyobo_RS.next())
			{
				String rank = Kyobo_RS.getString("rank");
				String title = Kyobo_RS.getString("title");
				String url = Kyobo_RS.getString("url");
				String author = Kyobo_RS.getString("author");
				String publisher = Kyobo_RS.getString("publisher");
				String image_url = Kyobo_RS.getString("image_url");
				
				Kyobo_rank_list[count] = rank;
				Kyobo_title_list[count] = title;
				Kyobo_url_list[count]  = url;
				Kyobo_author_list[count]  = author;
				Kyobo_publisher_list[count]  = publisher;
				Kyobo_image_url_list[count]  = image_url;


	%>		

	<%
				count++;
				if(count >= 3)
					break;
			}
	%>
	
		
			<tbody id="Kyobo_tbody">
				<tr id="Kyobo_0"> 
					<td style="width:10%; float:left; font-weight:bold;">1</td>
					<td><a href=<%=Kyobo_url_list[0]%> style=" font-weight:700;" target="_blank"><img src=<%=Kyobo_image_url_list[0]%> width="100" height="150"></a><br><a href=<%=Kyobo_url_list[0]%> style=" font-weight:700;" target="_blank"><%=Kyobo_title_list[0]%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=Kyobo_author_list[0]%>
						</a>
					</td>
				</tr>
			</tbody>
		
	</table>
		
<script type="text/javascript">
					
					var Kyobo_rank= ["<%=Kyobo_rank_list[0]%>","<%=Kyobo_rank_list[1]%>","<%=Kyobo_rank_list[2]%>" ];
					var Kyobo_title = ["<%=Kyobo_title_list[0]%>","<%=Kyobo_title_list[1]%>","<%=Kyobo_title_list[2]%>" ];
					var Kyobo_url  = ["<%=Kyobo_url_list[0]%>","<%=Kyobo_url_list[1]%>","<%=Kyobo_url_list[2]%>" ];
					var Kyobo_author  = ["<%=Kyobo_author_list[0]%>","<%=Kyobo_author_list[1]%>","<%=Kyobo_author_list[2]%>" ];
					var Kyobo_publisher  = ["<%=Kyobo_publisher_list[0]%>","<%=Kyobo_publisher_list[1]%>","<%=Kyobo_publisher_list[2]%>" ];
					var Kyobo_image_url  = ["<%=Kyobo_image_url_list[0]%>","<%=Kyobo_image_url_list[1]%>","<%=Kyobo_image_url_list[2]%>" ];

					var Kyobo_index = 1;
					var Kyobo_rank = 0;
					
					$(document).ready(function(){

						setInterval(function()
						{
							$("#Kyobo_tbody").empty(
									
							);
							
							Kyobo_rank = Kyobo_index + 1;
							
							$("#Kyobo_tbody").append(
								"<tr id=Kyobo_" + Kyobo_index + ">" 
									+ "<td style='width:10%; float:left; font-weight:bold;'>"+ Kyobo_rank +"</td>"
									+ "<td>" + "<a href=" + Kyobo_url[Kyobo_index] + " style='font-weight:700;' target='_blank'>"
									+ "<img src=" + Kyobo_image_url[Kyobo_index] + " width='100' height='150'></a>"
									+ "<br>" 
									+"<a href=" + Kyobo_url[Kyobo_index] + " style='font-weight:700;' target='_blank'>" + Kyobo_title[Kyobo_index] + "</a>"
										+"<br>"
									 + "<a style='font-size:13px; font-weight:10' target='_blank'>"+ Kyobo_author[Kyobo_index]
									+"</a>"
									+ "</td>"	
								+"</tr>"
							);
							
							Kyobo_index ++;
							if(Kyobo_index == 3){
								Kyobo_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>
	
	<div id="div3" class="col-md-5 templates" style="display:inline-block;">
			<div id="div1" class="col-md-12 templates" >YES24</div>
			<table class="table table-hover">

	<%
			count = 0;
	
			String[] Yes_rank_list = new String[3];
			String[] Yes_title_list = new String[3];
			String[] Yes_url_list = new String[3];
			String[] Yes_author_list = new String[3];
			String[] Yes_publisher_list = new String[3];
			String[] Yes_image_url_list = new String[3];

			while(Yes_RS.next())
			{
				String rank = Yes_RS.getString("rank");
				String title = Yes_RS.getString("title");
				String url = Yes_RS.getString("url");
				String author = Yes_RS.getString("author");
				String publisher = Yes_RS.getString("publisher");
				String image_url = Yes_RS.getString("image_url");
				
				Yes_rank_list[count] = rank;
				Yes_title_list[count] = title;
				Yes_url_list[count]  = url;
				Yes_author_list[count]  = author;
				Yes_publisher_list[count]  = publisher;
				Yes_image_url_list[count]  = image_url;


	%>

	<%
				count++;
				if(count >= 3)
					break;
			}
	%>
		<tbody id="Yes_tbody">
				<tr id="Yes_0"> 
					<td style="width:10%; float:left; font-weight:bold;">1</td>
					<td><a href=<%=Yes_url_list[0]%> style=" font-weight:700;" target="_blank"><img src=<%=Yes_image_url_list[0]%> width="100" height="150"></a><br><a href=<%=Yes_url_list[0]%> style=" font-weight:700;" target="_blank"><%=Yes_title_list[0]%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=Yes_author_list[0]%>
						</a>
					</td>
				</tr>
			</tbody>
	</table>
		
<script type="text/javascript">
					
					var Yes_rank= ["<%=Yes_rank_list[0]%>","<%=Yes_rank_list[1]%>","<%=Yes_rank_list[2]%>" ];
					var Yes_title = ["<%=Yes_title_list[0]%>","<%=Yes_title_list[1]%>","<%=Yes_title_list[2]%>" ];
					var Yes_url  = ["<%=Yes_url_list[0]%>","<%=Yes_url_list[1]%>","<%=Yes_url_list[2]%>" ];
					var Yes_author  = ["<%=Yes_author_list[0]%>","<%=Yes_author_list[1]%>","<%=Yes_author_list[2]%>" ];
					var Yes_publisher  = ["<%=Yes_publisher_list[0]%>","<%=Yes_publisher_list[1]%>","<%=Yes_publisher_list[2]%>" ];
					var Yes_image_url  = ["<%=Yes_image_url_list[0]%>","<%=Yes_image_url_list[1]%>","<%=Yes_image_url_list[2]%>" ];

					var Yes_index = 1;
					var Yes_rank = 0;
					
					$(document).ready(function(){

						setInterval(function()
						{
							$("#Yes_tbody").empty(
									
							);
							
							Yes_rank = Yes_index + 1;
							
							$("#Yes_tbody").append(
								"<tr id=Yes_" + Yes_index + ">" 
									+ "<td style='width:10%; float:left; font-weight:bold;'>"+ Yes_rank +"</td>"
									+ "<td>" + "<a href=" + Yes_url[Yes_index] + " style='font-weight:700;' target='_blank'>"
									+ "<img src=" + Yes_image_url[Yes_index] + " width='100' height='150'></a>"
									+ "<br>" 
									+"<a href=" + Yes_url[Yes_index] + " style='font-weight:700;' target='_blank'>" + Yes_title[Yes_index] + "</a>"
										+"<br>"
									 + "<a style='font-size:13px; font-weight:10' target='_blank'>"+ Yes_author[Yes_index]
									+"</a>"
									+ "</td>"	
								+"</tr>"
							);
							
							Yes_index ++;
							if(Yes_index == 3){
								Yes_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>

	<div id="div4" class="col-md-5 templates" style="display:inline-block;">
		<div id="div1" class="col-md-12 templates" >알라딘</div>
		<table class="table table-hover" >
	
	<%
			count = 0;
			String[] Aladin_rank_list = new String[3];
			String[] Aladin_title_list = new String[3];
			String[] Aladin_url_list = new String[3];
			String[] Aladin_author_list = new String[3];
			String[] Aladin_publisher_list = new String[3];
			String[] Aladin_image_url_list = new String[3];

			while(Aladin_RS.next())
			{
				String rank = Aladin_RS.getString("rank");
				String title = Aladin_RS.getString("title");
				String url = Aladin_RS.getString("url");
				String author = Aladin_RS.getString("author");
				String publisher = Aladin_RS.getString("publisher");
				String image_url = Aladin_RS.getString("image_url");
				
				Aladin_rank_list[count] = rank;
				Aladin_title_list[count] = title;
				Aladin_url_list[count]  = url;
				Aladin_author_list[count]  = author;
				Aladin_publisher_list[count]  = publisher;
				Aladin_image_url_list[count]  = image_url;


	%>

	<%
				count++;
				if(count >= 3)
					break;
			}
	%>
		
			<tbody id="Aladin_tbody">
				<tr id="Aladin_0"> 
					<td style="width:10%; float:left; font-weight:bold;">1</td>
					<td><a href=<%=Aladin_url_list[0]%> style=" font-weight:700;" target="_blank"><img src=<%=Aladin_image_url_list[0]%> width="100" height="150"></a><br><a href=<%=Aladin_url_list[0]%> style=" font-weight:700;" target="_blank"><%=Aladin_title_list[0]%></a>	
						<br>
						<a style="font-size:13px; font-weight:10" target="_blank">
							<%=Aladin_author_list[0]%>
						</a>
					</td>
				</tr>
			</tbody>
	</table>
		
<script type="text/javascript">
					
					var Aladin_rank= ["<%=Aladin_rank_list[0]%>","<%=Aladin_rank_list[1]%>","<%=Aladin_rank_list[2]%>" ];
					var Aladin_title = ["<%=Aladin_title_list[0]%>","<%=Aladin_title_list[1]%>","<%=Aladin_title_list[2]%>" ];
					var Aladin_url  = ["<%=Aladin_url_list[0]%>","<%=Aladin_url_list[1]%>","<%=Aladin_url_list[2]%>" ];
					var Aladin_author  = ["<%=Aladin_author_list[0]%>","<%=Aladin_author_list[1]%>","<%=Aladin_author_list[2]%>" ];
					var Aladin_publisher  = ["<%=Aladin_publisher_list[0]%>","<%=Aladin_publisher_list[1]%>","<%=Aladin_publisher_list[2]%>" ];
					var Aladin_image_url  = ["<%=Aladin_image_url_list[0]%>","<%=Aladin_image_url_list[1]%>","<%=Aladin_image_url_list[2]%>" ];

					var Aladin_index = 1;
					var Aladin_rank = 0;
					
					$(document).ready(function(){

						setInterval(function()
						{
							$("#Aladin_tbody").empty(
									
							);
							
							Aladin_rank = Aladin_index + 1;
							
							$("#Aladin_tbody").append(
								"<tr id=Aladin_" + Aladin_index + ">" 
									+ "<td style='width:10%; float:left; font-weight:bold;'>"+ Aladin_rank +"</td>"
									+ "<td>" + "<a href=" + Aladin_url[Aladin_index] + " style='font-weight:700;' target='_blank'>"
									+ "<img src=" + Aladin_image_url[Aladin_index] + " width='100' height='150'></a>"
									+ "<br>" 
									+"<a href=" + Aladin_url[Aladin_index] + " style='font-weight:700;' target='_blank'>" + Aladin_title[Aladin_index] + "</a>"
										+"<br>"
									 + "<a style='font-size:13px; font-weight:10' target='_blank'>"+ Aladin_author[Aladin_index]
									+"</a>"
									+ "</td>"	
								+"</tr>"
							);
							
							Aladin_index ++;
							if(Aladin_index == 3){
								Aladin_index = 0;
							}
							
						},5000);
						
					});
			</script>
	</div>
	
	</div>

<script type="text/javascript" src="./js/slide.js"></script>
 
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

	<jsp:include page="visitor_count.jsp" flush="true"/>

</body>
</html>
