<!-- 예매 취소 -->
<%@page import="service.CancelService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="service.LookUpService" %>
<%@ page import="dto.myTickets" %>
<%@ page import="dto.myCancel" %>
<%@ page import="java.util.ArrayList" %>
<%
	//로그인 검증
	
	String user_id = "";
	
	if(session.getAttribute("id") != null){
		user_id = (String)session.getAttribute("id");
	}
	else{
		response.sendRedirect("/Kobus/login.jsp?re=error");
	}
	
	int ticket_id = Integer.parseInt(request.getParameter("delete"));

	CancelService cs = new CancelService();
	cs.cancelProcess(ticket_id, user_id);
	response.sendRedirect("lookUpTicket.jsp");
%>