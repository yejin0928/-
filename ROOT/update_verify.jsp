<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title>사용자 정보 수정 verify</title></head>
<body>
<%
	String User_id = request.getParameter("User_id");
	String User_name = new String(request.getParameter("User_name").getBytes("8859_1"),"utf-8"); 
	String User_pwd = new String(request.getParameter("User_pwd"));	
		


	Connection myConn = null;  
	Statement stmt = null;  
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
    mySQL = "update R_USER ";
	mySQL = mySQL + " set User_name ='" + User_name + "' , " ;	
	mySQL = mySQL + " User_pwd ='" + User_pwd + "' where User_id='" + User_id + "' "; 
	try {		
		stmt.executeQuery(mySQL);  
%>

<script>
	alert("수정되었습니다.");       
	location.href="update.jsp";
</script>
<%    
	} catch(SQLException ex) {
		String sMessage;
		if (ex.getErrorCode() == 20290) sMessage="패스워드는 길이가 4이상이어야 합니다.";
		else if (ex.getErrorCode() == 20291) sMessage="이름은 기존과 동일하게 변경될 수 없습니다.";
		else sMessage="잠시 후 다시 시도하십시오";	
%>
<script>
	alert("<%= sMessage %>");    
	location.href = "update.jsp";
</script>
<%	
	} finally {
		if (stmt != null)   try { 
				stmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
</body></html>
