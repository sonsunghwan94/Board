<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<form action="controller.jsp" method="post">
<input type="hidden" name="action" value="login">
<table>
	<tr>
		<td>아이디:</td>
		<td><input type="text" name="mid" required></td>
	</tr>
	<tr>
		<td>비밀번호:</td>
		<td><input type="password" name="mpw" required></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="로그인">
		</td>
	</tr>
</table>
</form>
<hr>
<a href="reg.jsp">회원가입하기</a>
</body>
</html>