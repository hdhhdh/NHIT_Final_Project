<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="service.LookUpService" %>
<%@ page import="dto.myTickets" %>
<%@ page import="dto.myCancel" %>
<%@ page import="java.util.ArrayList" %>
<%
	String user_id = request.getParameter("user_id");
	LookUpService lus = new LookUpService();
	ArrayList<myTickets> tics = lus.selectUserTicket(user_id);
	for(int i=0; i<tics.size(); i++){
		out.println("<tr onClick=\"getHistory("
			+tics.get(i).getTicket_id()+", '"
			+tics.get(i).getBus_time()+"', '"
			+tics.get(i).getR_start()+"', '"
			+tics.get(i).getR_end()+"', "
			+tics.get(i).getTicket_seat()+", "
			+tics.get(i).getBus_stat()+", '"
			+tics.get(i).getBus_co()+"', '"
			+tics.get(i).getTicket_time()+"', "
			+tics.get(i).getTicket_pay()	
		+");\">");
		out.println("<td>"+tics.get(i).getR_start()+"</td>");
		out.println("<td>"+tics.get(i).getR_end()+"</td>");
		out.println("<td>"+tics.get(i).getBus_time()+"</td>");
		out.println("<td>"+tics.get(i).getTicket_pay()+"</td>");
		out.println("</tr>");
	}

%>
				