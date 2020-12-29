<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title>냉장고 추가 verify</title></head>
<body>
<%
	String USER_ID =  request.getParameter("User_id");
	String REFRIGERATOR_FOODPURCHASEDATE = request.getParameter("REFRIGERATOR_FOODPURCHASEDATE");
	String REFRIGERATOR_FOODNAME = new String(request.getParameter("REFRIGERATOR_FOODNAME").getBytes("8859_1"),"utf-8");
	String REFRIGERATOR_FOODBESTBEFORE = request.getParameter("REFRIGERATOR_FOODBESTBEFORE");
	


	Connection myConn = null;  

		
	ResultSet myResultSet = null;  
	String mySQL = "";
	CallableStatement statement = null;
    String result = "";
	
	String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="ST2019112007"; // 본인 아이디(ex.ST0000000000)
	String passwd="ST2019112007"; // 본인 패스워드(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    

	try {
		Class.forName(dbdriver);
		myConn =  DriverManager.getConnection (dburl, user, passwd);
	} catch(SQLException ex) {
		System.err.println("SQLException: " + ex.getMessage());
	}
   
	try {	
	if(REFRIGERATOR_FOODBESTBEFORE==null){
	
	statement=myConn.prepareCall("{call insert_food(?,?,?,?,?)}");
	statement.setString(1,REFRIGERATOR_FOODNAME);
	statement.setString(2,REFRIGERATOR_FOODPURCHASEDATE);
	statement.setString(3,"1999-12-12");
	statement.setString(4,USER_ID);
	statement.registerOutParameter(5,java.sql.Types.VARCHAR);
	statement.executeUpdate();
	result=statement.getString(5);
	}
	else{
	
	statement=myConn.prepareCall("{call insert_food(?,?,?,?,?)}");
	statement.setString(1,REFRIGERATOR_FOODNAME);
	statement.setString(2,REFRIGERATOR_FOODPURCHASEDATE);
	statement.setString(3,REFRIGERATOR_FOODBESTBEFORE);
	statement.setString(4,USER_ID);
	statement.registerOutParameter(5,java.sql.Types.VARCHAR);
	statement.executeUpdate();
	result=statement.getString(5);

	}

%>

<script>
	alert("<%= result %>");  
	location.href="list.jsp";
</script>
<%    
	} catch(SQLException ex) {
		String sMessage;
		if (ex.getErrorCode() == 20293) 
		sMessage="유통기한은 구매날짜 후여야 합니다";
		else sMessage="잠시 후 다시 시도하십시오";
%>
<script>
	
	alert("<%= sMessage %>");    
	location.href = "list.jsp";
</script>
<%	
	} finally {
		if (statement != null)   try {
				statement.close();
				  myConn.close(); }
		catch(SQLException ex) {
			
		 }
	}
%>
</body></html>
