<%@page import="dto.statistics_payment"%>
<%@page import="dto.manageRoute"%>
<%@page import="service.routeViewService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="dao.routeDAO" %>
<%@ page import="dao.managerDAO" %>
<%@ page import="dto.route" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.manageDetail" %>
<%@ page import="dto.statistics_payment" %>
<%@ page import="dto.statistics_refund" %>

<%
	managerDAO mDAO = new managerDAO();
	String m_id = (String)session.getAttribute("id");
	String m_name = (String)session.getAttribute("name");
	
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	
%>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>������ ������</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand" href="index.html">������ ������</a><button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button
            ><!-- Navbar Search-->
            
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">������ ���</div>
                            <a class="nav-link" href="manage_tables.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                	��ü �뼱��ȸ</a>
                                	
                            <a class="nav-link" href="addNewBus.jsp">	<!-- ���� �߰��ϴ� jsp���Ϸ� -->
                            <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                	���� �߰�</a>
                                	
                            <a class="nav-link" href="statisticsIndex.jsp">	<!-- ���� ��� ��ȸ�ϴ� jsp���Ϸ� -->
                            <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                	���� ��� Ȯ��</a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as: <%= m_name %></div>
                        
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">�뼱 �������� ��ȸ</h1>
                        <div class="card mb-4">
                            <div class="card-body">������ ������������ ��ü�뼱�� ��ȸ�ϰų� ���� �߰� �� ������踦 Ȯ���� �� �ֽ��ϴ�.</div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header"><i class="fas fa-table mr-1"></i>��ü�뼱 ���</div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <%
            	                    		
                                    		routeViewService rVS = new routeViewService();
            	                    		
                                    		int route_id = rVS.searchId(start, end);
                                        
                                        	statistics_payment sp = rVS.calc_payment(route_id, fromDate, toDate);
                                        	statistics_refund sr = rVS.calc_refund(route_id, fromDate, toDate);
                                        
                                        %>

                                            <tr>
                                                <th>�뼱</th>
                                                <th>�߱� Ƚ��</th>
                                                <th>�߱� �Ѿ�</th>
                                                <th>��� Ƚ��</th>
                                                <th>������ �Ѿ�</th>
                                                <th>�� ����</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>�뼱</th>
                                                <th>�߱� Ƚ��</th>
                                                <th>�߱� �Ѿ�</th>
                                                <th>��� Ƚ��</th>
                                                <th>������ �Ѿ�</th>
                                                <th>�� ����</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                        <%
                                        		out.println("<tr>");
                                				out.println("<td>"+start+"->"+end+"</td>");
                                        		out.println("<td>"+sp.getCount()+"</td>");
                                        		out.println("<td>"+sp.getPayment()+"</td>");
                                        		out.println("<td>"+sr.getCount()+"</td>");
                                        		out.println("<td>"+sr.getRefund()+"</td>");
                                        		out.println("<td>"+(sp.getPayment()+sr.getRefund())+"</td>");
                                        		out.println("</tr>");
                                        %>
                                        </tbody>
                                    </table>
								</div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <!-- ���̺� ��� ��� ���-->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/datatables-demo.js"></script>
    </body>
</html>
