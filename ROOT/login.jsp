<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head><title>냉장고 로그인</title></head>
<body>
	<table width="75%" align="center" bgcolor="#d3e1ee" border>
	 	<tr>
			<td><div align="center">냉장고에 로그인하세요.</div></td>
		</tr>
	</table>
	<table width="75%" align="center" border>
		<form method=post" action="login_verify.jsp">
			<tr>
				<td><div align="center">아이디</div></td>
				<td><div align="center"><input type="text" name="userID"></div></td>
			</tr>
			<tr>
				<td><div align="center">패스워드</div></td>
				<td><div align="center"><input type="password" name="userPassword"></div></td>
			</tr>
			<tr>
				<td colspan=2>
					<div align="center">
						<input type="submit" name="submit" value="로그인">
						<input type="reset" value="취소">
					</div>
				</td>
			</tr>
		</form>
	</table>
</body>
</html>

