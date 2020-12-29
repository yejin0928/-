<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
<head><title>냉장고 리스트</title></head>
<style>body {
	font-family: "Helvetica";
  }
  .desc {
	text-align: center;
	color:black;
  }
li {
	display: inline;
	
	padding: 5px 10px 5px 10px;
	background-color: #f9e2b4;
	color: white;
	border-radius: 4px;
	font-size: 1.2rem;
  }
  .na1 {
  list-style-type: none;
  margin: 0;
  padding: 0;
  text-align: center;
  }
  </style>
<body>
<%@ include file="top.jsp" %>
<ul class="na1">	
<a href="recipeList.jsp"><p class="desc"><li>다른 레시피 검색</li></p></a></ul>
<%
	if (session_id==null) response.sendRedirect("login.jsp");
	String dish = new String(request.getParameter("REFRIGERATOR_FOODNAME").getBytes("8859_1"),"utf-8");
	Connection myConn = null;     
	Statement stmt = null;	
	ResultSet myResultSet = null; 
	CallableStatement statement = null;
	String mySQL = "";

	String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="ST2019112007"; // 본인 아이디(ex.ST0000000000)
	String passwd="ST2019112007"; // 본인 패스워드(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    

	try {
  	    Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
	    stmt = myConn.createStatement();	
    } catch(SQLException ex) {
	    System.err.println("SQLException: " + ex.getMessage());
	}
	statement=myConn.prepareCall("begin getRecipe(?); end;");
	statement.registerOutParameter(1,oracle.jdbc.OracleTypes.CURSOR);
	statement.execute();
	myResultSet=(ResultSet)statement.getObject(1);

	while (myResultSet.next()) {
		String gredients=myResultSet.getString("gredients");
		String recipe=myResultSet.getString("recipe");
		String name=myResultSet.getString("dishesname");
		name=name.trim();
		if(name.equals(dish)){
        	
%>



  <table width="75%" align="center" border>
      <tr><th>요리명</th>
         <td><%= name %></td></tr>
	 
		 <tr><th>재료</th>
		<td><%= gredients %> </td></tr>
	
		<tr><th>레시피</th>
		<td><%= recipe %> </td></tr>
	
	 
</table>
	
<%
	}
}	
	statement.close();  
	myConn.close();
%>

</body></html>
