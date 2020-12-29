<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
                $.datepicker.setDefaults($.datepicker.regional['ko']); 
                $( "#startDate" ).datepicker({
                     changeMonth: true, 
                     changeYear: true,
                     yearRange: 'c:c+10',
                     nextText: '다음 달',
                     prevText: '이전 달', 
                     dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                     dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                     monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                     monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                     dateFormat: "yy-mm-dd",
                   
                     
     
                });
                $( "#endDate" ).datepicker({
                     changeMonth: true, 
                     changeYear: true,
                     nextText: '다음 달',
                     prevText: '이전 달', 
                     dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                     dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                     monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                     monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                     dateFormat: "yy-mm-dd",
                  
                     yearRange: 'c:c+10',                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
                     
     
                });    
        });

function foodKindChange(e) {
    var fruit = ["오렌지","사과"];
    var vegi = ["오이","당근"];
    var fish = ["오징어","꽁치"];
    var meat = ["소고기","계란"];
    var milk = ["우유","치즈","요거트"];
    var sauce = ["케찹","마요네즈"];
    var salted = ["김치","매실장아찌"];
    var ready = ["돈까스"]; 
    var iced = ["냉동만두"]; 
    var bread = ["식빵"];
    var beverage = ["탄산음료"]; 
    var etc = ["두부"];

    var target = document.getElementById("REFRIGERATOR_FOODNAME");

    if(e.value == "과일") var d = fruit;
    else if(e.value == "채소") var d = vegi;
    else if(e.value == "수산") var d = fish;
    else if(e.value == "정육") var d = meat;
    else if(e.value == "유제품") var d = milk;
    else if(e.value == "양념류") var d = sauce;
    else if(e.value == "절임류") var d = salted;
    else if(e.value == "조리식품") var d = ready;
    else if(e.value == "냉동식품") var d = iced;
    else if(e.value == "빵류") var d = bread;
    else if(e.value == "음료") var d = beverage;
    else if(e.value == "기타") var d = etc;
   
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

<form method="post" action="insertFood.jsp">
  <input type="hidden" name="User_id" size="30" value="<%= session_id %>">
  <table width="75%" align="center" border>
      <tr><th>구입 날짜</th>
         <td> <input type="text" id="startDate" name="REFRIGERATOR_FOODPURCHASEDATE"></td>
     </tr>
     <tr><th>품목 선택</th>
        <td>
            <label for="REFRIGERATOR_FOODKIND">음식 종류</label>
            <select class="form-control" id="REFRIGERATOR_FOODKIND" name="REFRIGERATOR_FOODKIND" onchange="foodKindChange(this)">
                <option value="과일">과일</option>
                <option value="채소">채소</option>
                <option value="수산">수산</option>
                <option value="정육">정육</option>
                <option value="유제품">유제품</option>
                <option value="양념류">양념류</option>
                <option value="절임류">절임류</option>
                <option value="조리식품">조리식품</option>
                <option value="냉동식품">냉동식품</option>
                <option value="빵류">빵류</option>
                <option value="음료">음료</option>
                <option value="기타">기타</option>
            </select>
            <label for="REFRIGERATOR_FOODNAME">음식명</label>
            <select class="form-control" id="REFRIGERATOR_FOODNAME" name="REFRIGERATOR_FOODNAME">
              <option>선택해주세요.</option>
            </select>
            
        </td>       
       
    </tr>
     
       
      
        <tr><th>유통기한</th>
            <td>
                
                <input type="checkbox" id="em1" >
                <label>자동입력</label>
                <input type="text" id="endDate" name="REFRIGERATOR_FOODBESTBEFORE" value="">
               
                
            </td>       
            
        </tr>
        
       
			   
<%

	stmt.close();  
	myConn.close();
%>

<tr>
	<td colspan="2" align="center">
	<input type="submit" value="추가">
	</td> 
</tr>
</table></form> 

<script>
  
    // 직접입력
    $("#em").on('click',function(){
        var chk = $('input:checkbox[id="em"]').is(":checked");
        if(chk==true){
            $("#endDate").removeAttr('disabled'); 
        }else{
           
        }
    });
   
    // 자동입력
    $("#em1").on('click',function(){
        var chk = $('input:checkbox[id="em1"]').is(":checked");
        if(chk==true){
            $("#endDate").attr('disabled',true); 
        }else{
            $("#endDate").attr('disabled',false); 
        }
    });
   
    



</script></body></html>
