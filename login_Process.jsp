<!-- 로그인 검증 과정 -->
<!-- 입력된 id, pw를 가지고 LoginService 객체를 통해 userDAO.userLogin() 메소드를 호출하여 로그인 정보를 검증한다.
		로그인에 문제가 없으면, 세션에 id를 등록한다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.userDAO" %> 
<%
	// userDAO에서 로그인 수행.
	
	if(session.getAttribute("id") != null){
		out.println("<script>alert('이미 로그인되어있습니다.'); location.href='index.jsp';</script>");
	}

	userDAO usD = new userDAO();
    String id = request.getParameter("id");
	String pw = request.getParameter("pw");
   
	// id와 pw가 존재한다면, 로그인 성공.
	if(usD.userLogin(id, pw)){
	    session.setAttribute("id", id) ;
		session.setAttribute("name", usD.getUser().getU_name());
		response.sendRedirect("index.jsp");
	}
	else{
		out.print("<script>alert('아이디 혹은 비밀번호가 틀립니다.'); location.href='login.jsp';</script>");
	}
	
 
%>