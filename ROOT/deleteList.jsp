<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>


<%
     



      String User_id =  request.getParameter("User_id");
      String refrigerator_foodpurchasedate = request.getParameter("refrigerator_foodpurchasedate");
      String refrigerator_foodname = new String(request.getParameter("refrigerator_foodname").getBytes("8859_1"),"utf-8");
       
      String refrigerator_foodbestbefore = request.getParameter("refrigerator_foodbestbefore");
        
     
     
      Connection myConn = null; 
      PreparedStatement pstmt = null;
      ResultSet rs = null;
   
      try
      {
        String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
        String user="ST2019112007"; // 본인 아이디(ex.ST0000000000)
        String passwd="ST2019112007"; // 본인 패스워드(ex.ST0000000000)
        String dbdriver = "oracle.jdbc.driver.OracleDriver";    
    
        Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
  
           
        String mySQL = "delete from refrigerator where refrigerator_foodpurchasedate='" + refrigerator_foodpurchasedate + "' and User_id='" + User_id + "' and refrigerator_foodname='" + refrigerator_foodname + "'";
                        
                        pstmt = myConn.prepareStatement(mySQL);
                        
                        pstmt.executeUpdate();
%>

 
<script>
	alert("음식이 삭제되었습니다.");  
   
    location.href = "list.jsp";
    
          

</script>

<%
        System.out.println(mySQL);   
      }catch(SQLException ex){
        String sMessage;
		
		if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
        else sMessage="잠시 후 다시 시도하십시오"+"/"+refrigerator_foodname
        +"/"+refrigerator_foodbestbefore+"/"+refrigerator_foodpurchasedate;	
     
%>
<script>
	alert("<%= sMessage %>");    
	location.href = "list.jsp";
</script>
<%	
	} finally {
		if (pstmt != null)   try { 	pstmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
