<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
<head><title>사용자 정보수정</title></head>
<body>
<%@ include file="top.jsp" %>
<%
	if (session_id==null) response.sendRedirect("login.jsp");

	Connection myConn = null;     
	Statement stmt = null;	
	ResultSet myResultSet = null; 
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
    mySQL = "select User_id, User_name, User_pwd from R_USER where User_id='" + session_id + "'" ;
	myResultSet = stmt.executeQuery(mySQL);
	if (myResultSet.next()) {	
		String User_id = myResultSet.getString("User_id");
		String User_name = myResultSet.getString("User_name");
		String User_pwd = myResultSet.getString("User_pwd");
		

	

%>

<form method="post" action="update_verify.jsp">
  <input type="hidden" name="User_id" size="30" value="<%= session_id %>">
  <table width="75%" align="center" border>
      <tr><th>이름</th>
         <td><input type="text" name="User_name" size="10" value="<%= User_name %>"> </td>
     </tr>
     <tr><th>패스워드</th>
         <td><input type="password" name="User_pwd" size="20"  value="<%= User_pwd %>"></td>
     </tr>
			   
<%
}	
	stmt.close();  
	myConn.close();
%>
<tr>
	<td colspan="2" align="center">
	<input type="submit" value="수정">
	</td> 
</tr>
</table></form></body></html>
