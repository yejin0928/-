<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>배너</title>
	<style>
	
	body {
  font-family: "Helvetica";
}

.title {
  text-align: center;
  font-family: "Verdana";
  color: #e9cbd1;
}

a {
  text-decoration: none;
  color: white;
}

.desc {
  text-align: center;
}

.nav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  text-align: center;
}

li {
  display: inline;
  
  padding: 5px 10px 5px 10px;
  background-color: #c8e2ef;
  color: white;
  border-radius: 4px;
  font-size: 1.2rem;
}

li:hover {
  background-color: #ebeff8;
}

	</style>
</head>
<body>
	<% 
		String session_id = (String)session.getAttribute("user"); 
		String session_name = (String)session.getAttribute("name");
		
		String log;
  	
		if(session_id==null){
			log="<a href=login.jsp>로그인</a>";
		} else {
			log="<a href=logout.jsp>로그아웃</a>";
		}
	%>
	
	<a href="main.jsp"><h1 class="title">냉장고를 부탁해</h1></a>
<nav>
  <ul class="nav">
    <li><%=log%></li>
    <a href="update.jsp"><li>회원 정보수정</li></a>
    <a href="list.jsp"><li>내 냉장고</li></a>
    <a href="recipeList.jsp"><li>레시피 검색</li></a>
    <a href="expired.jsp"><li>유통기한 지난 음식모음</li></a>
  </ul>
</nav>
<br>
<hr width="50%">



</body>
</html>



