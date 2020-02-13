<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="dao.managerDAO"%>
<%@ page import="service.routeViewService" %>
<%
   routeViewService rVS = new routeViewService();

   String start = request.getParameter("start");
   String end = request.getParameter("end");
   int route_id = rVS.searchId(start, end);
   
   String startTime = request.getParameter("startTime");
   String busGrade = request.getParameter("busGrade");
   int real_busGrade = Integer.parseInt(busGrade); // 버스등급 1, 2, 3으로 입력받은거 String -> int
   String busCompany = request.getParameter("busCompany");
   
   if(start == null || end == null || startTime == null || busGrade == null || busCompany == null)
   {
      out.print("<script>alert('배차추가 실패'); history.back();</script>");
   }
   else
   {
      rVS.addBus(route_id, startTime, real_busGrade, busCompany);
      
      response.sendRedirect("./manage_tables.jsp");
   }
   
%>