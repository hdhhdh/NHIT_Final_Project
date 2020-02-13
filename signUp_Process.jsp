<!-- 회원가입 검증 및  DB 등록 -->
<!-- SignUpService 객체를 통해 userDAO.userSignUp() 함수를 호출하고, 회원가입 정보를 DB에 등록하게 된다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.userDAO" %> 
<%
   // userDAO에서 로그인 수행.
   	if(session.getAttribute("id") != null){
		out.println("<script>alert('이미 로그인되어있습니다.'); location.href='index.jsp';</script>");
	}
	request.setCharacterEncoding("utf-8");


   userDAO usD = new userDAO();
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");
   String name = request.getParameter("name");
   int age = Integer.parseInt(request.getParameter("age"));
   int gender = Integer.parseInt(request.getParameter("gender"));
   
   
   // id와 pw가 존재한다면, 로그인 성공.
   if(usD.userSignUp(id, pw, name, age, gender)){
   out.println("<script>alert('이름 : "+name+"'); location.href='login.jsp';</script>");
   }
   else{
      out.print("<script>alert('회원가입 실패'); location.href='signup.jsp';</script>");
   }
   
 
%>
