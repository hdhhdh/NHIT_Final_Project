<%@page import="java.util.ArrayList"%>
<%@page import="service.routeViewService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
	String start = request.getParameter("start");
	routeViewService rvs = new routeViewService();
	
	ArrayList<String> end = rvs.viewEnd(start);
	
	for(int i=0; i<end.size(); i++){
		out.println("<button class='getEnd' onclick='setEnd(this)'>"+end.get(i)+"</button>");
	}
%>