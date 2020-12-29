<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    <script type="text/javascript">
    

function foodKindChange(e) {
    var apple = ["사과파이","사과잼"];
    var carrot = ["당근머핀","당근쿠키"];

    var target = document.getElementById("REFRIGERATOR_FOODNAME");

    if(e.value == "사과") var d = apple;
    else if(e.value == "당근") var d = carrot;
   
    target.options.length = 0;

    for (x in d) {
        var opt = document.createElement("option");
        opt.value = d[x];
        opt.innerHTML = d[x];
        target.appendChild(opt);
    }   
}
    </script>
<head><title>냉장고 음식 추가</title>
    
    
    </head>
<body>
<%@ include file="top.jsp" %>
<%
	if (session_id==null) response.sendRedirect("login.jsp");
    String average_bestbefore ="";
    String food_name ="";
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
   
    mySQL = "select average_bestbefore, food_name from food";
    myResultSet = stmt.executeQuery(mySQL);
    ArrayList<String[]> list = new ArrayList<String[]>();  
	while (myResultSet.next()) {	
         
        average_bestbefore = myResultSet.getString("average_bestbefore");
        food_name = myResultSet.getString("food_name");
        list.add(new String[]{average_bestbefore, food_name});                                       
    
    }
%>

<form method="post" action="recipe.jsp">
  <input type="hidden" name="User_id" size="30" value="<%= session_id %>">
  <table width="75%" align="center" border>
     
     <tr><th>레시피 검색</th>
        <td>
            <label for="REFRIGERATOR_FOODKIND">재료 선택</label>
            <select class="form-control" id="REFRIGERATOR_FOODKIND" name="REFRIGERATOR_FOODKIND" onchange="foodKindChange(this)">
                <option value="사과">사과</option>
                <option value="당근">당근</option>
            </select>
            <label for="REFRIGERATOR_FOODNAME">요리 선택</label>
            <select class="form-control" id="REFRIGERATOR_FOODNAME" name="REFRIGERATOR_FOODNAME">
              <option>선택해주세요.</option>
            </select>
            
        </td>       
       
    </tr>
     
       
      
        
            
       
        
       
			   
<%

	stmt.close();  
	myConn.close();
%>

<tr>
	<td colspan="2" align="center">
	<input type="submit" value="검색">
	</td> 
</tr>
</table></form> 

</body></html>
