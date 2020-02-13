<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="service.routeViewService"%>
<%@ page import="service.TicketingService" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.ticket" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<!doctype html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<script type="text/javascript" src="//code.jquery.com/jquery.min.js"></script>
	<link href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700" rel="stylesheet">

	<link rel="stylesheet" href="css/style.css"> <!-- Resource style -->
	<link rel="stylesheet" href="css/view.css">
	
	<title>좌석 선택 화면</title>
	<!-- 좌석 선택 -->
<style>
	#main{
		float:right;
		position:relative;
		left:-50%;
	}

	#seat_form{
		float:left;
		position:relative;
		width:400px;
		padding:10px 5% 10% 5%;
		margin: 10px;
		text-align:center;
		left:50%;
	}

	table{
		margin:auto;
		width:80%;
	}
	
	td{
		vertical-align:middle;
	}
	
	#general_bus td{
		width:50px;
		height:40px;
		margin:5px;
		font-size:20;
		text-align:center;
	}
	#first_bus{
		border-spacing:5px;
	}
	#first_bus td{
		width:60px;
		height:45px;
		margin:5px;
		padding:5px;
		font-size:25;
		text-align:center;
	}
	#premium_bus{
		border-spacing:10px;
	}
	#premium_bus td{
		width:60px;
		height:50px;
		margin:5px;
		padding:5px;
		font-size:25;
		text-align:center;
	}
	td{
		border-radius:10px;
	}

	.seat{
		border:1px solid black;
		cursor:pointer;
	}
	.Noseat{
		border:1px solid gray;
		color:gray;
		background:#DDD;
	}

	.checked_td{
		font-weight:bold;
		background-color: #f8914f;
	}

	.button{
		margin:0;
		padding:0;
		font-size:30;
		width:80%;
		height:60px;
	}
</style>
<%


	String user_id = "";
	
	if(session.getAttribute("id") != null){
		user_id = (String)session.getAttribute("id");
	}
	else{
		response.sendRedirect("login.jsp?re=error");
	}

	//출발지 및 도착지 정보 같이 전송
	int bus_id = Integer.parseInt(request.getParameter("bus_id"));
	int bus_gr = Integer.parseInt(request.getParameter("bus_grade"));
	String bus_tr = request.getParameter("bus_time");
	int bus_pr = Integer.parseInt(request.getParameter("price"));
	String bus_co = request.getParameter("company");
	
	String route = request.getParameter("route");
	String route_id = request.getParameter("route_id");
	
	switch(bus_gr){
	case 1:
		break;
	case 2:
		bus_pr = bus_pr*12/10;
		break;
	case 3:
		bus_pr = bus_pr*15/10;
		break;
		default:
			out.println("<script>alert('잘못된 경로로 접근하셨습니다.'); location.href='index.jsp';</script>");
	}
	
	
	int seat = 0;
	
	TicketingService ts = new TicketingService(bus_id);

%>
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
			<li><a class="active">좌석선택</a></li>
			<li><a>결제확인</a></li>
		</ul>
	</nav> <!-- .cd-secondary-nav -->
</header> <!-- .cd-auto-hide-header -->
<main class="cd-main-content sub-nav">


	<div class="view_box">
		<div class="view_title">
			좌석 선택
		</div>
		<div class="view_info">
			<strong><%=route %></strong>
			<span><%=bus_tr %></span>
		</div>
		<div class="view_content">
			
			<div id='main'>
	<form id='seat_form' action='payment.jsp' method='POST'>
	<input type='hidden' name='bus_id' value=<%=bus_id %>>
	<input type='hidden' name='busPayment' value="">
	<input type='hidden' name='totalPay' value='0'>
	<%
	// 버스 등급에 따라 다른 버스 좌석표를 보여준다. * 일반 : 45 (5*11) , 우등 : 28 (4*9), 프리미엄 : 21 (4*7)
	
	switch(bus_gr){
		case 1:	// 일반
			out.print("<table id='general_bus'>");
			for(int i=1; i<11; i++){
				out.println("<tr>");
				for(int j=1; j<5; j++){
					if(ts.viewSeat(++seat))
						out.println("<td class='Noseat'>"+seat+"</td>");
					else
						out.println("<td class='seat'>"+seat+"</td>");
					if(j == 2){
						out.println("<td class='nodis'></td>");
					}
				}
				out.println("</tr>");
			}
			// 맨 뒷줄
			while(seat<45){
				if(ts.viewSeat(++seat))
					out.println("<td class='Noseat'>"+seat+"</td>");
				else
					out.println("<td class='seat'>"+seat+"</td>");
			}
			break;
			
		case 2:	// 우등
			out.println("<table id='first_bus'>");
			for(int i=1; i<9; i++){
				out.println("<tr>");
				for(int j=1; j<4; j++){
					if(ts.viewSeat(++seat))
						out.println("<td class='Noseat'>"+seat+"</td>");
					else
						out.println("<td class='seat'>"+seat+"</td>");
					if(j == 2){
						out.println("<td class='nodis'></td>");
					}
				}
				out.println("</tr>");
			}
			// 맨 뒷줄
			while(seat<28){
				if(ts.viewSeat(++seat))
					out.println("<td class='Noseat'>"+seat+"</td>");
				else
					out.println("<td class='seat'>"+seat+"</td>");
			}
			break;
			
		case 3:	// 프리미엄
			out.println("<table id='premium_bus'>");
			for(int i=1; i<8; i++){
				out.println("<tr>");
				for(int j=1; j<4; j++){
					if(ts.viewSeat(++seat))
						out.println("<td class='Noseat'>"+seat+"</td>");
					else
						out.println("<td class='seat'>"+seat+"</td>");
					if(j == 2){
						out.println("<td class='nodis'></td>");
					}
				}
				out.println("</tr>");
			}
			break;
			
		default:// 예외
	}
%>
	</table>
	<div id='price_'>
		<h3>가격 : 0원</h3>
	</div>
	<input type="submit" class='button' value="선택">
	<input type="hidden" name="busRound" value="">
	<input type="hidden" name="bus_stat" value=<%=bus_gr %>>
	<input type="hidden" name="bus_time" value=<%=bus_tr %>>
	<input type="hidden" name="route" value=<%=route_id %>>
	<input type="hidden" name="bus_co" value=<%=bus_co %>>
	</form>
	</div>
		</div>
	</div>
</main> <!-- .cd-main-content -->

<script>
	var selected_seat = 0;
	var ticketPay = <%=bus_pr%>;
	$('.seat').click(function(){
		var i = $(this).html();
		$(this).toggleClass("checked_td");
		if($(this).children('input').length < 1){
			$(this).append("<input type='hidden' name='seat_num' value='"+i+"'>");
			$(this).append("<input type='hidden' name='price' value='"+10000+"'>");
			price(++selected_seat);
		}
		else{
			$(this).children().remove();
			price(--selected_seat);
		}
	});

	function price(seat){
		var price = seat*ticketPay;
		var box = $('#price_');
		box.html("<h3>가격 : "+price+"원</h3>");
		$('input[name=totalPay]').val(price);
	}
</script>
<script src="js/main.js"></script> <!-- Resource jQuery -->
</body>
</html>
