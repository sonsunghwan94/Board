<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="data" class="model.MemberVO" scope="request"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<script type="text/javascript">
	function del(){
		ans=confirm('정말 삭제하시겠습니까?');
		if(ans==true){
			document.bform.action.value="mdelete";
			document.bform.submit();
		}else{
			return;
		}
	}
</script>
<form name="bform" action="controller.jsp" method="post">
	<input type="hidden" name="action" value="mupdate">
	<input type="hidden" name="mid" value="<%=data.getMid()%>">
	<table border="1">
		<tr>
			<td>ID</td>
			<td><input type="text" name="mid" value="<%=data.getMid() %>" readonly></td>
		</tr>
		<tr>
			<td>PW</td>
			<td><input type="text" name="mpw" value="<%=data.getMpw() %>" required></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="mname" value="<%=data.getMname() %>" required></td>
		</tr>
		<tr>
			<td>계정권한</td>
			<td><input type="text" name="role" value="<%=data.getRole() %>" readonly></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="변경하기">&nbsp;&nbsp;<input type="button" value="회원탈퇴" onclick="del()">
			</td>
		</tr>
	</table>
</form>
	<a href="controller.jsp?action=main">메인으로 돌아가기</a>
</body>
</html>