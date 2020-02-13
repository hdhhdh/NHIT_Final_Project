<!-- 회원가입 검증 및  DB 등록 -->
<!-- SignUpService 객체를 통해 userDAO.userSignUp() 함수를 호출하고, 회원가입 정보를 DB에 등록하게 된다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.userDAO" %> 
<%
	// userDAO에서 로그인 수행.
	
	userDAO usD = new userDAO();
    String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	
	int age = Integer.parseInt(request.getParameter("age"));
	int gender = Integer.parseInt(request.getParameter("gender"));
	//남자 = 0
	//여자 = 1
	
	// id와 pw가 존재한다면, 로그인 성공.
	try{
		if(usD.userSignUp(id, pw, name, age, gender) == true){
			out.print("<script>alert('회원가입 성공'); location.href='login.jsp'</script>");
		}
	else{
		out.print("<script>alert('회원가입 실패'); history.back();</script>");
	}
	}catch(Exception e){
		out.println(e.getMessage());
	}
 
%>