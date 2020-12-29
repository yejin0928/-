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
  }li {
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
}</style>

<body>
	
	
<%@ include file="top.jsp" %>
<ul class="na1">
<a href="reviseList.jsp"><p class="desc"><li>음식 추가하기</li></p></a></ul>
<%
	if (session_id==null) response.sendRedirect("login.jsp");

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
	statement=myConn.prepareCall("begin getList(?,?); end;");
	statement.setString(1,session_id);
	statement.registerOutParameter(2,oracle.jdbc.OracleTypes.CURSOR);
	statement.execute();
	myResultSet=(ResultSet)statement.getObject(2);

	while (myResultSet.next()) {
		String food_name=myResultSet.getString("refrigerator_foodname");
		String food_best=myResultSet.getString("refrigerator_foodbestbefore");
		String food_purchase=myResultSet.getString("refrigerator_foodpurchasedate");
		food_best=food_best.substring(0, 10);
		food_purchase = food_purchase.substring(0, 10);
        	
%>
 <form method="post" action="deleteList.jsp">
 <input type="hidden" name="User_id" size="30" value="<%= session_id %>">
  <table width="75%" align="center" border>
      <tr><th>음식명</th>
         <td><input type="text" name="refrigerator_foodname" size="" value="<%= food_name %>" readonly> </td>
         <th>구입일자</th>
        <td><input type="text" name="refrigerator_foodpurchasedate" size="" value="<%= food_purchase %>"readonly> </td>
        <th>유통기한</th>
		<td><input type="text" name="refrigerator_foodbestbefore" size="" value="<%= food_best %>"readonly> </td> 
		<td colspan="2" align="center">
				<input type="submit" value="삭제">
				</td> 
	 </tr>
	 
</table>
	</form>
<%
	}	
	stmt.close();  
	myConn.close();
%>

</body></html>
