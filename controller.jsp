<%@page import="model.BoardVO"%>
<%@page import="model.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error/error.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bDAO" class="model.BoardDAO"></jsp:useBean>
<jsp:useBean id="bVO" class="model.BoardVO"></jsp:useBean>
<jsp:useBean id="mDAO" class="model.MemberDAO"></jsp:useBean>
<jsp:useBean id="mVO" class="model.MemberVO"></jsp:useBean>
<jsp:setProperty property="*" name="bVO" />
<jsp:setProperty property="*" name="mVO" />
<jsp:useBean id="user" class="model.MemberVO" scope="session"></jsp:useBean>
<%
// 어떤 요청을 받았는지 파악
// -> 해당 요청을 수행
String action = request.getParameter("action");
String id = user.getMid();
String role = user.getRole();
if (action.equals("login")) {
	MemberVO vo = mDAO.selectOne(mVO);
	if (vo != null) {
		session.setAttribute("user", vo);
		response.sendRedirect("controller.jsp?action=main");

	} else {
		out.println("<script>alert('아이디나 비밀번호가 올바르지 않습니다.');</script>");
		out.println("<script>history.go(-1);</script>");

	}
} else if (action.equals("reg")) {
	if (mDAO.insert(mVO)) {
		response.sendRedirect("login.jsp");
	} else {
		throw new Exception("insert 오류");
	}

} else if (action.equals("mypage")) {
	MemberVO vo = mDAO.selectOne(mVO);
	if (vo != null) {
		request.setAttribute("data", vo);
		pageContext.forward("mypage.jsp");
	} else {
		response.sendRedirect("controller.jsp?action=main");
	}
} else if (action.equals("main")) {

	ArrayList<BoardVO> datas = bDAO.selectAll(bVO);
	request.setAttribute("datas", datas);
	pageContext.forward("main.jsp"); // forward 액션
} else if (action.equals("insert")) {
	if (bDAO.insert(bVO)) {
		response.sendRedirect("controller.jsp?action=main");
	} else {
		throw new Exception("insert 오류");
	}
} else if (action.equals("search")) {
	ArrayList<BoardVO> datas = bDAO.selectAll(bVO);
	request.setAttribute("datas", datas);
	pageContext.forward("main.jsp");
} else if (action.equals("board")) {
	BoardVO data = bDAO.selectOne(bVO);
	if (data == null) {
		response.sendRedirect("controller.jsp?action=main");
	}
	request.setAttribute("data", data);
	pageContext.forward("board.jsp");
} else if (action.equals("update")) {
	if (id.equals(bVO.getWriter())) {
		if (bDAO.update(bVO)) {
	response.sendRedirect("controller.jsp?action=main");
		} else {
	throw new Exception("update 오류");
		}
	}else{
		out.println("<script>alert('권한이 없습니다.');</script>");
		out.println("<script>history.go(-1);</script>");
	}
} else if (action.equals("delete")) {
	if (role.equals("ADMIN")) {
		if (bDAO.delete(bVO)) {
	response.sendRedirect("controller.jsp?action=main");
		} else {
	throw new Exception("delete 오류");
		}
	} else {
		if (id.equals(bVO.getWriter())) {
	if (bDAO.delete(bVO)) {
		response.sendRedirect("controller.jsp?action=main");
	} else {
		throw new Exception("delete 오류");
	}
		} else {
	out.println("<script>alert('권한이 없습니다.');</script>");
	out.println("<script>history.go(-1);</script>");
		}
	}
} else if (action.equals("mupdate")) {
	if (mDAO.update(mVO)) {
		session.invalidate(); // 세션 정보 전체 제거하기
		response.sendRedirect("login.jsp");
	} else {
		throw new Exception("mupdate 오류");
	}
} else if (action.equals("mdelete")) {
	if (mDAO.delete(mVO)) {
		session.invalidate();
		response.sendRedirect("login.jsp");
	} else {
		throw new Exception("mdelete 오류");
	}
} else {

	out.println("<script>alert('action 파라미터 값이 올바르지 않습니다..');</script>");
}
%>