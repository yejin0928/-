<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head><title>냉장고를 부탁해</title>
	<style>
body {
  font-family: "Helvetica";
}
.desc {
  text-align: center;
}
div { text-align: center; }
	</style>
</head>
<body>
	<%@ include file="top.jsp" %>
	
	
	<table id="a"  align="center" >
		
	<% if(session_id != null) {%> 
		
		<tr>
			<p class="desc"><%=session_name%>님 냉장고를 확인하세요</p>
			
		</tr>	
	<% } else {	%>
		
		<p class="desc">로그인하세요</p>
		</tr>
	
	<% } %>
	<div><img  src="refrigerator.png"></div>
	</table>
</body>
</html>

