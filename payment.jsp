<%@page import="service.routeViewService"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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

	String bus_id = request.getParameter("bus_id");
	String[] seat_num = request.getParameterValues("seat_num");// 좌석번호들
	String payment = request.getParameter("totalPay");	// 총 가격
	String[] prices = request.getParameterValues("price");
	
	int route_id= Integer.parseInt(request.getParameter("route"));
	
	String bus_time = request.getParameter("bus_time");	// 출발시간o
	String bus_stat = request.getParameter("bus_stat");	// 등급o
	String bus_co = request.getParameter("bus_co");		// 회사o
	
	routeViewService rvs = new routeViewService();
	String start = rvs.getRoute(route_id).getRoute_start();
	String end = rvs.getRoute(route_id).getRoute_end();
%>


<!doctype html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700" rel="stylesheet">

	<link rel="stylesheet" href="css/reset.css"> <!-- CSS reset -->
	<link rel="stylesheet" href="css/style.css"> <!-- Resource style -->
	<link rel="stylesheet" href="css/view.css">
	<title>결제 화면</title>
</head>
<body>

<header class="cd-auto-hide-header">
	<div class="logo">
		<div id="wrap">
			<a href="index.jsp">
			<div id="app">
				<script type="text/javascript" src="js/logo_main_effect.js"></script>
		 	</div>
			</a>
		</div>	 
	</div>

	<nav class="cd-primary-nav">
		<a href="#cd-navigation" class="nav-trigger">
			<span>
				<em aria-hidden="true"></em>
				Menu
			</span>
		</a> <!-- .nav-trigger -->

		<ul id="cd-navigation">
      <li><a href="logout.jsp">로그아웃</a></li>
      <li><a href="myPage/lookUpTicket.jsp">회원정보</a></li>
		</ul>
	</nav> <!-- .cd-primary-nav -->

	<nav class="cd-secondary-nav">
		<ul>
			<li><a>노선조회</a></li>
			<li><a>버스조회</a></li>
			<li><a>좌석선택</a></li>
			<li><a class="active">결제확인</a></li>
		</ul>
	</nav> <!-- .cd-secondary-nav -->
</header> <!-- .cd-auto-hide-header -->
	<style>
	/* 화면 사이즈 조절 */
	@media 
	only screen and (max-width: 760px),
	(min-device-width: 768px) and (max-device-width: 1024px)  {

	table{
	}
	/* Force table to not be like tables anymore */
	table, thead, tbody, th, td, tr { 
		display: block; 
	}
	
	/* Hide table headers (but not display: none;, for accessibility) */
	thead tr { 
		position: absolute;
		top: -9999px;
		left: -9999px;
	}
	
	tr {
		border: none;
		padding:10px;
		margin:10px;
	}
	
	td { 
		/* Behave  like a "row" */
		border: none;
		position: relative;
		padding:0;
		margin:0;
		padding-left: 30%; 
		font-size:18px;
		
		
	}
	
	td:before { 
		/* Now like a table header */
		position: absolute;
		/* Top/left values mimic padding */
		border:none;
		top: 6px;
		left: 6px;
		width: 45%; 
		padding-right: 10px; 
		white-space: nowrap;
	}
	#selec{
		height:150px;
	}
	/*
	Label the data
	*/
	td:nth-of-type(1):before { font-weight:bold; content: "출발지"; }
	td:nth-of-type(2):before { font-weight:bold; content: "도착지"; }
	td:nth-of-type(3):before { font-weight:bold; content: "출발시간"; }
	td:nth-of-type(4):before { font-weight:bold; content: "요금"; }
}
	@media screen and (min-width:760px) {
		/* 화면의 사이즈가 560px 이상일 경우 table의 텍스트를 가운데 정렬 한다.*/
		.ui-responsive th, .ui-responsive td {
			text-align:center;
		}
	}
	
	/* 테이블 디자인 */
	table {
		width:100%;
		vertical-align:middle;
	}
	
	th {
		background:linear-gradient(#333333 0%, #444444 100%);
		color:#FFFFFF;
		vertical-align:middle;
		font-weight:bold;
		height:60px;
		font-size:20px;
		
	}
	
	td {
		vertical-align:middle;
		height:40px;
		margin-bottom:5px;
	}
	tr{
		padding:10px;
		margin:10px;
		border: 0.5px solid #d3d3d3;
	  	background-color:#f1f1f1;
		cursor:pointer;
	}
	
	/* 홀수행 백그루안드 색상 */
	tr:hover{
	  box-shadow: 1px 1px 20px #d3d3d3;
	  background-color:#ddd;
	  
	}
	.col-item{
	  display: inline-block;
	  	min-width:200px;
	  	min-height:100px;
	    padding: 20px;
	    border-top: 1px solid #d3d3d3;
	    font-size: 15px;
	    width: 100%;
	    text-align:center;
	}
	
	.col-item:hover{
	  box-shadow: 1px 1px 20px #d3d3d3;
	  background-color:#ddd;
	}
		
	.card-title{
	  color:black;
	  font-size: 24px;
	  font-weight: bold;
	  margin-top:15px;
	}
</style>
<main class="cd-main-content sub-nav">
<div class="state">	
		<div data-role="content" >
			<div id="selec">
				<div class="col-item">
					<div class="card-block">
						<div class="card-title">
							결제 진행하기
						</div>
						<div clas="card-text">
						</div>
					</div>
				</div>
			</div>

			<table data-role="table" class="ui-responsive">
           		<thead>
           			<tr>
           			<th>버스시간</th>
           			<th>출발지</th>
           			<th>도착지</th>
           			<th>좌석</th>
           			<th>버스등급</th>
           			<th>버스회사</th>
           			<th>요금</th>
           			</tr>
           		</thead>
           		<tbody>
           		<tr class="tds">
				<%
				out.println("<td>"+bus_time+"</td>");
				out.println("<td>"+start+"</td>");
				out.println("<td>"+end+"</td>");
				out.println("<td>");
				for(int i=0; i<seat_num.length; i++){
					out.println(seat_num[i]);
					if(i != seat_num.length-1){
						out.println(", ");
					}
				}
				out.println("</td>");
				switch(bus_stat){
				case "1":
					out.println("<td>일반</td>");
					break;
				case "2":
					out.println("<td>우등</td>");
					break;
				case "3":
					out.println("<td>프리미엄</td>");
					break;
				}
				out.println("<td>"+bus_co+"</td>");
				out.println("<td>"+payment+"</td>");
				out.println("</tr>");
				
				%>
				<tr><td colspan='7' style="text-align:center; cursor:pointer;" onclick="pay_submits();">
					<form action="payment_Process.jsp" id="form_set" method="post">
						<%
						for(int i=0; i<seat_num.length; i++){
							out.println("<input type='hidden' name='seat_num' value='"+seat_num[i]+"'>");
							out.println("<input type='hidden' name='prices' value='"+prices[i]+"'>");
						}
						%>
						<input type="hidden" name="bus_id" value=<%=bus_id %>>
						<input type="hidden" name="payment" value=<%=payment %>>
						결제하기
					</form>
				</td></tr>
				</tbody>
        	</table>
        </div>
	</div>
	<script>
		function pay_submits(){
			document.getElementById('form_set').submit();
		}
	</script>
</main> <!-- .cd-main-content -->
<script src="js/main.js"></script> <!-- Resource jQuery -->
</body>
</html>
