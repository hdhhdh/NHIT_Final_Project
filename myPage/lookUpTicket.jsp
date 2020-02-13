<!-- 본인 예매 내역 조회 화면 -->
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!-- 마이 페이지 -->
<!doctype html>
<html lang="ko" class="no-js">
<head>
<%

	//로그인 검증

	String user_id = "";
	
	if(session.getAttribute("id") != null){
		user_id = (String)session.getAttribute("id");
	}
	else{
		response.sendRedirect("/Kobus/login.jsp?re=error");
	}
	
%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.css"/>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
	
	<script src="../js/main.js"></script> <!-- Resource jQuery -->
	
	<link href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700" rel="stylesheet">

	<link rel="stylesheet" href="../css/reset.css"> <!-- CSS reset -->
	<link rel="stylesheet" href="../css/style.css"> <!-- Resource style -->
	<link rel="stylesheet" href="../css/item.css">
	<title>마이페이지</title>
	
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
	}
	
	.col-item:hover{
	  box-shadow: 1px 1px 20px #d3d3d3;
	  background-color:#ddd;
	}
		
</style>
</head>
<body onload="getTicket('<%=user_id%>')";>

<header class="cd-auto-hide-header">
	<div class="logo">
		<div id="wrap">
			<a href="/Kobus/index.jsp">
			<div id="app">
				<script type="text/javascript" src="/Kobus/js/logo_main_effect.js"></script>
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
      <li><a href="/Kobus/logout.jsp">로그아웃</a></li>
      <li><a href="/Kobus/index.jsp">노선조회</a></li>
		</ul>
	</nav> <!-- .cd-primary-nav -->

	<nav class="cd-secondary-nav">
		<ul>
			<li><a class="active">조회내역</a></li>
			<li><a>예매상세</a></li>
		</ul>
	</nav> <!-- .cd-secondary-nav -->
</header> <!-- .cd-auto-hide-header -->


<style>
</style>

<main class="cd-main-content sub-nav">
	<div class="state">
			
		<div data-role="content" >
		<div id="selec">
			<a onclick="getTicket('<%=user_id%>')">
			<div class="col-item-left">
				<div class="card-block">
					<div class="card-title">
						<%=session.getAttribute("name") %>님 예매 내역
					</div>
				</div>
			</div>
			</a>
			<a onclick="getCancel('<%=user_id%>')">
			<div class="col-item-right">
				<div class="card-block">
					<div class="card-title">
						<%=session.getAttribute("name") %>님 취소 내역
					</div>
				</div>
			</div>
			</a>
			</div>
			<table data-role="table" class="ui-responsive">
				<thead>
					<tr>
						<th>출발지</th>
						<th>도착지</th>
						<th>출발시간</th>
						<th><div id="pr">금액</div></th>
					</tr>
				</thead>
				<tbody id="print">
				
				</tbody>
			</table>
			<form action="selectTicketHistory.jsp" id="myForm" method="post">
				<input type="hidden" name="ticket_id" id="ticket_id">
				<input type="hidden" name="bus_time" id="bus_time">
				<input type="hidden" name="start" id="start">
				<input type="hidden" name="end" id="end">
				<input type="hidden" name="seat_num" id="seat_num">
				<input type="hidden" name="bus_stat" id="bus_stat">
				<input type="hidden" name="bus_co" id="bus_co">
				<input type="hidden" name="ticketing_time" id="ticketing_time">
				<input type="hidden" name="payment" id="payment">
			</form>
		</div>
	
	</div>
</main> <!-- .cd-main-content -->
<script>
	
	function getTicket(id){
		document.getElementById('pr').innerText = "요금";
		$.ajax({
	        url: "reTicket.jsp",
	        type:"POST",
	        data:{"user_id":id},
	        cache: false,
	        success: function(data){
		        $('#print').html(data);
	        }
	      });
	}

	function getCancel(id){
		document.getElementById('pr').innerText = "수수료";
		$.ajax({
	        url: "reCancel.jsp",
	        type:"POST",
	        data:{"user_id":id},
	        cache: false,
	        success: function(data){
	          $('#print').html(data);
	        }
	      });
	}
	
	function getHistory(id, time, start, end, seat, stat, co, t_time, pay){
		
		document.getElementById("ticket_id").value = id;
		document.getElementById("bus_time").value = time;
		document.getElementById("start").value = start;
		document.getElementById("end").value = end;
		document.getElementById("seat_num").value = seat;
		document.getElementById("bus_stat").value = stat;
		document.getElementById("bus_co").value = co;
		document.getElementById("ticketing_time").value = t_time;
		document.getElementById("payment").value = pay;
		
		document.getElementById("myForm").submit()
	}
</script>
</body>
</html>