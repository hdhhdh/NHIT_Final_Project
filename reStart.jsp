<%@page import="java.util.ArrayList"%>
<%@page import="service.routeViewService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
	routeViewService rvs = new routeViewService();

	ArrayList<String> start = rvs.viewStart();
	for(int i=0; i<start.size(); i++){
		out.println("<button class='getStart' onclick='setStart(this)'>"+start.get(i)+"</button>");
	}
%>