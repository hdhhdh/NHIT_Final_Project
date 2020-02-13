<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="service.LookUpService" %>
<%@ page import="dto.myTickets" %>
<%@ page import="dto.myCancel" %>
<%@ page import="java.util.ArrayList" %>
<%
	String user_id = request.getParameter("user_id");
	LookUpService lus = new LookUpService();
	ArrayList<myCancel> can = lus.selectUserCancel(user_id);
	for(int i=0; i<can.size(); i++){
		out.println("<tr onClick=\"getCancelHistory('"
			+can.get(i).getBus_time()+"', '"
			+can.get(i).getR_start()+"', '"
			+can.get(i).getR_end()+"', "
			+can.get(i).getCancel_seat()+", "
			+can.get(i).getBus_stat()+", '"
			+can.get(i).getBus_co()+"', '"
			+can.get(i).getCancel_time()+"', "
			+can.get(i).getCancel_ref()	
		+");\">");
		out.println("<td>"+can.get(i).getR_start()+"</td>");
		out.println("<td>"+can.get(i).getR_end()+"</td>");
		out.println("<td>"+can.get(i).getBus_time()+"</td>");
		out.println("<td>"+can.get(i).getCancel_ref()+"</td>");
		out.println("</tr>");
	}

%>
				