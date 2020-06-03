<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<TABLE border="1">
		<%

       for(int k=1;k<3;k++){

    %>
		<TR>
			<TD><%= k %></TD>
		</TR>
		<%

    }

      %>
	</TABLE>
</body>
</html>