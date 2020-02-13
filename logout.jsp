<!-- 로그인 검증 과정 -->
<!-- 입력된 id, pw를 가지고 LoginService 객체를 통해 userDAO.userLogin() 메소드를 호출하여 로그인 정보를 검증한다.
		로그인에 문제가 없으면, 세션에 id를 등록한다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.userDAO" %> 
<%
	// userDAO에서 로그인 수행.
	
	if(session.getAttribute("id") == null){
		out.println("<script>alert('로그인되어있지 않습니다.'); location.href='login.jsp';</script>");
	}
	else{
		session.invalidate();
		response.sendRedirect("index.jsp");
	}
 
%>