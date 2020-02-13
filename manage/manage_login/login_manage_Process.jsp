<!-- 관리자 로그인 검증 과정 -->
<!-- 입력된 id, pw를 가지고 LoginService 객체를 통해 managerDAO.managerLogin() 메소드를 호출하여 로그인 정보를 검증한다.
      로그인에 문제가 없으면, 세션에 id를 등록한다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.managerDAO" %> 
<%
   // userDAO에서 로그인 수행.
   managerDAO maD = new managerDAO();

    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    out.println("아이디 : " + id + " 비밀번호 : " + pw);
   // id와 pw가 존재한다면, 로그인 성공.
   if(maD.managerLogin(id, pw)){
		session.setAttribute("id", id) ;
		session.setAttribute("name", maD.get().getM_name());
		response.sendRedirect("../manage_lookup/manage_tables.jsp");
   }
   else{
		out.print("<script>alert('로그인 실패'); history.back();</script>");
   }
   
 
%>