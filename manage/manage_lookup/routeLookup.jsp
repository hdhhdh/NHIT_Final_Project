<%@page import="dto.manageRoute"%>
<%@page import="service.routeViewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.routeDAO" %>
<%@ page import="dao.managerDAO" %>
<%@ page import="dto.route" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.manageDetail" %>
<%
	managerDAO mDAO = new managerDAO();
	String m_id = (String)session.getAttribute("id");
	String m_name = (String)session.getAttribute("name");
%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>관리자 페이지</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand" href="index.html">관리자 페이지</a><button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button
            ><!-- Navbar Search-->
            
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">관리자 기능</div>
                            <a class="nav-link" href="manage_tables.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                	전체 노선조회</a>
                                	
                            <a class="nav-link" href="addNewBus.jsp">	<!-- 배차 추가하는 jsp파일로 -->
                            <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                	배차 추가</a>
                                	
                            <a class="nav-link" href="statisticsIndex.jsp">	<!-- 매출 통계 조회하는 jsp파일로 -->
                            <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                	매출 통계 확인</a>
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
                        <h1 class="mt-4">노선 세부정보 조회</h1>
                        <div class="card mb-4">
                            <div class="card-body">관리자 페이지에서는 전체노선을 조회하거나 배차 추가 및 매출통계를 확인할 수 있습니다.</div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header"><i class="fas fa-table mr-1"></i>전체노선 목록</div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <%
                                        	String start = request.getParameter("start");
                                    		String end = request.getParameter("end");
                                    		int bus_grade = Integer.parseInt(request.getParameter("grade"));
                                        	routeViewService rVS = new routeViewService();

                                        	int route_id = rVS.searchId(start, end);
                                        	ArrayList<manageDetail> d_table;
                                			d_table = rVS.call_detail(route_id, bus_grade);
                                        %>

                                            <tr>
                                                <th>버스ID</th>
                                                <th>출발시간</th>
                                                <th>버스 회사</th>
                                                <th>발권 수</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>버스ID</th>
                                                <th>출발시간</th>
                                                <th>버스 회사</th>
                                                <th>발권 수</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                        <%
                                        	for(int i = 0; i<d_table.size(); i++)
                                        	{
                                        %>
                                            <tr>
                                                <td><%= d_table.get(i).getB_id() %></td>
                                                <td><%= d_table.get(i).getS_time() %></td>
                                                <td><%= d_table.get(i).getC_name() %></td>
                                                <td><%= d_table.get(i).getT_count() %></td>
                                            </tr>
                                        <%
                                        	}
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
        <!-- 테이블 목록 기능 담당-->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/datatables-demo.js"></script>
    </body>
</html>
