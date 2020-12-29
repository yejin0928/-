<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");

	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;

	String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user = "ST2019112007"; // 본인 아이디(ex.STxxxxxxxxxx)
	String passwd = "ST2019112007"; // 본인 패스워드(ex.STxxxxxxxxxx)
	String dbdriver = "oracle.jdbc.OracleDriver";

	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();

	mySQL = "select User_id, User_name from R_USER where User_id='" + userID + "' and User_pwd='" + userPassword + "'";

	ResultSet myResultSet = stmt.executeQuery(mySQL);

	if (myResultSet.next()) {
		session.setAttribute("user", userID);
		String name= myResultSet.getString(2);
		session.setAttribute("name", name);
		response.sendRedirect("main.jsp");
	} else {
%>

<script>
	alert("사용자아이디 혹은 암호가 틀렸습니다.");
	location.href = "login.jsp";
</script>
<%
	}
	stmt.close();
	myConn.close();
%>
