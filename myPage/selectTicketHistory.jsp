<!-- 예매 상세 내역 -->
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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

<!doctype html>
<html lang="ko" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	
	<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.css"/>	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700">

	<link rel="stylesheet" href="../css/popup.css">
	<link rel="stylesheet" href="../css/radio.css">
	
	<link rel="stylesheet" href="../css/reset.css"> <!-- CSS reset -->
	<link rel="stylesheet" href="../css/style.css"> <!-- Resource style -->
	<link rel="stylesheet" href="../css/item.css">
     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<title>NH Bus</title>
	

</head>
<body>
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
	
	.tds td { 
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
	.tds td:nth-of-type(1):before { font-weight:bold; content: "버스시간"; }
	.tds td:nth-of-type(2):before { font-weight:bold; content: "출발지"; }
	.tds td:nth-of-type(3):before { font-weight:bold; content: "도착지"; }
	.tds td:nth-of-type(4):before { font-weight:bold; content: "좌석"; }
	.tds td:nth-of-type(5):before { font-weight:bold; content: "등급"; }
	.tds td:nth-of-type(6):before { font-weight:bold; content: "회사"; }
	.tds td:nth-of-type(7):before { font-weight:bold; content: "요금"; }
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
			<li><a>조회내역</a></li>
			<li><a class="active" >예매상세</a></li>
		</ul>
	</nav> <!-- .cd-secondary-nav -->
</header> <!-- .cd-auto-hide-header -->



<main class="cd-main-content sub-nav main">
             
<%
	String ticket_id = request.getParameter("ticket_id");
	String bus_time = request.getParameter("bus_time");
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String seat_num = request.getParameter("seat_num");
	String bus_stat = request.getParameter("bus_stat");
	String bus_co = request.getParameter("bus_co");
	String ticketing_time = request.getParameter("ticketing_time");
	String payment = request.getParameter("payment");
	
	// 오늘 날짜를 불러오고, 만약 bus_time이 오늘 날짜보다 이후인 경우에는 취소를 할 수 없다.
	Date today = new Date();
	Date day = null;
	try{
		day = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(bus_time);
	}catch(ParseException e){
	}
	// 오늘 날짜를 버스 시간과 비교한다.
	int comp = today.compareTo(day);
%>
	<div class="state">	
		<div data-role="content" >
			<div id="selec">
				<a onclick="history.back();">
				<div class="col-item">
					<div class="card-block">
						<div class="card-title">
							예매 내역
						</div>
						<div clas="card-text">
							<%=ticketing_time %>
						</div>
					</div>
				</div>
				</a>
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
				out.println("<td>"+seat_num+"</td>");
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
					if(comp < 0 ){
				%>
				<tr><td colspan='7' style="text-align:center;">
				<form action="processCancelTicket.jsp" method="post">
					<input type="hidden" name="delete" value=<%=ticket_id %>>
					<input type="submit" value="삭제"> 
				</form>
				</td></tr>
				<%
					}
				%>
				</tbody>
        	</table>
        </div>
	</div>
</main> <!-- .cd-main-content -->
<script type="text/javascript">

	flatpickr("#date");

	 var modal = document.querySelector('.modal');

    //console.log(modal);

    function toggleModal() {
         modal.classList.toggle("show-modal");
     }

    function windowOnClick(event) {
         if (event.target == modal) {
             toggleModal();
         }
     }

     closeButton.addEventListener("click", cancelClick);
     cancel.addEventListener("click", cancelClick);
     window.addEventListener("click", windowOnClick);
     
    function cancelClick(){
    	toggleModal();
		document.getElementById("start").value = "";
		document.getElementById("start").placeholder= "출발지";
		document.getElementById("end").value = "";		
		document.getElementById("end").placeholder= "도착지";
		getStart();
    }
     
	function setStart(button){
		document.getElementById("start").value = button.innerHTML;
	    getEnd();
	    $('.selection').html('출발지 선택'+data);
	}
	
	function setEnd(button){
		document.getElementById("end").value = button.innerHTML;
		toggleModal();
		getStart();
	}
	
    function getStart(){
    	$.ajax({
            url: "reStart.jsp",
            type:"POST",
            cache: false,
            success: function(data){
              $('.selection').html('출발지 선택'+data);
            }
          });
    }
 	
    function getEnd(){
        $.ajax({
          url: "reEnd.jsp?start="+document.getElementById("start").value,
          type:"POST",
          cache: false,
          success: function(data){
            $('.selection').html('도착지 선택'+data);
          }
        });
    }

</script>
<script src="../js/main.js"></script> <!-- Resource jQuery -->
</body>
</html>
