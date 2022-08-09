<%@page import="model.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="datas" class="java.util.ArrayList" scope="request"></jsp:useBean>
    <jsp:useBean id="user" class="model.MemberVO" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
</head>
<body>


<h1><a href='controller.jsp?action=mypage&mid=<%=user.getMid()%>&mpw=<%=user.getMpw()%>'><%=user.getMname()%> 님 환영합니다!</a></h1>

<hr>
<table border="2">
	<tr>
		<th>번 호</th><th>제 목</th><th>작성자</th>
	</tr>
<%
	for(BoardVO v:(ArrayList<BoardVO>)datas){
		
%>
	<tr>
		<th><a href="controller.jsp?action=board&bid=<%=v.getBid() %>"><%=v.getBid() %></a></th>
		<th><%=v.getTitle() %></th>
		<th><%=v.getWriter() %></th>
	</tr>
<%
	}
%>
</table>
<hr>
	<form action="controller.jsp">
		<input type="hidden" name="action" value="search">
		<input type="text" name="title">
		<input type="submit" value="검색하기">
	</form>
<% 
	if(user.getMname()==null){
		out.println("<a href='login.jsp'>로그인하기</a>");
	}else{
		out.println("<a href='login.jsp'>로그아웃하기</a>");
	}
%>

<a href="form.jsp">새로운 글 작성하기</a>

</body>
</html>