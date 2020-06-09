<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--
------------------------------------------------------------
* @설명 : 일별 박스오피스 REST 호출 - 서버측에서 호출하는 방식 예제
------------------------------------------------------------
-->
<%
	// 파라메터 설정
	String targetDt = request.getParameter("targetDt") == null ? "20200531" : request.getParameter("targetDt"); //조회일자
	String itemPerPage = request.getParameter("itemPerPage") == null ? "10"
			: request.getParameter("itemPerPage"); //결과row수
	String multiMovieYn = request.getParameter("multiMovieYn") == null ? ""
			: request.getParameter("multiMovieYn"); //“Y” : 다양성 영화 “N” : 상업영화 (default : 전체)
	String repNationCd = request.getParameter("repNationCd") == null ? "" : request.getParameter("repNationCd"); //“K: : 한국영화 “F” : 외국영화 (default : 전체)
	String wideAreaCd = request.getParameter("wideAreaCd") == null ? "" : request.getParameter("wideAreaCd"); //“0105000000” 로서 조회된 지역코드

	// 발급키
	String key = "e6de7638b492bfab3dff9ab47c1f62c8";
	// KOBIS 오픈 API Rest Client를 통해 호출
	KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);

	// 일일 박스오피스 서비스 호출 (boolean isJson, String targetDt, String itemPerPage,String multiMovieYn, String repNationCd, String wideAreaCd)
	String dailyResponse = service.getDailyBoxOffice(true, targetDt, itemPerPage, multiMovieYn, repNationCd,
			wideAreaCd);

	// Json 라이브러리를 통해 Handling
	ObjectMapper mapper = new ObjectMapper();
	HashMap<String, Object> dailyResult = mapper.readValue(dailyResponse, HashMap.class);

	request.setAttribute("dailyResult", dailyResult);

	// KOBIS 오픈 API Rest Client를 통해 코드 서비스 호출 (boolean isJson, String comCode )
	String codeResponse = service.getComCodeList(true, "0105000000");
	HashMap<String, Object> codeResult = mapper.readValue(codeResponse, HashMap.class);
	request.setAttribute("codeResult", codeResult);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
</head>
<body>
	<c:out value="${dailyResult.boxOfficeResult.boxofficeType}" />
	<c:out value="${dailyResult.boxOfficeResult.showRange}" />
	<br />
	<table border="1">
		<tr>
			<td>순위</td>
			<td>영화명</td>
		</tr>
		<c:if test="${not empty dailyResult.boxOfficeResult.dailyBoxOfficeList}">
			<c:forEach items="${dailyResult.boxOfficeResult.dailyBoxOfficeList}" var="boxoffice">
				<tr>
					<td>
						<c:out value="${boxoffice.rank }" />
					</td>
					<td>
						<c:out value="${boxoffice.movieNm }" />
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>

</body>
</html>