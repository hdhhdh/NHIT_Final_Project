<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.PaymentService" %>
<!-- 결제 진행 입력 페이지 -->
<%

	//로그인 검증
	
	String user_id = "";
	
	if(session.getAttribute("id") != null){
		user_id = (String)session.getAttribute("id");
	}
	else{
		response.sendRedirect("login.jsp?re=error");
	}
	
	int bus_id = Integer.parseInt(request.getParameter("bus_id"));
	String[] seat_num = request.getParameterValues("seat_num");
	String[] prices = request.getParameterValues("prices");
	int payment = Integer.parseInt(request.getParameter("payment"));
	
	PaymentService ps = new PaymentService();
	
	out.println("<script>");
	out.println("alert('"+ps.ticketingProcess(bus_id, seat_num, user_id, prices, payment)+"');");
	out.println("location.href='lookUpTicket.jsp';");
	

	out.println("</script>");
%>