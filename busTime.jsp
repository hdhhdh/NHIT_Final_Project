<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="service.routeViewService"%>
<%@ page import = "service.TicketingService" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "dto.bus" %>
<%@ page import = "dto.route" %>
<%@ page import = "java.util.*" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!-- 버스 시간표 화면 -->


<%
// 로그인 검증

	String user_id = "";
	
	if(session.getAttribute("id") != null){
		user_id = (String)session.getAttribute("id");
	}
	else{
		response.sendRedirect("login.jsp?re=error");
	}
	
//	노선 id 값을 가상으로 설정하고 진행.
	
	routeViewService rvs = new routeViewService();
	
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String date = request.getParameter("date");
	
	if(start.equals(end)){
		response.sendRedirect("index.jsp");
	}
	
	Date day = null;
	try{
		day = new SimpleDateFormat("yyyy-MM-dd").parse(date);
	}catch(ParseException e){
	}
	
	int route_id = rvs.searchId(start, end);
	route rt = rvs.getRoute(route_id);
	
	out.println(start+end+route_id);
	
	TicketingService ts = new TicketingService();
	ArrayList<bus> busIndex = ts.routeProcess(route_id, date);

	int price1 = rt.getRoute_price();
	int price2 = rt.getRoute_price()*12/10;
	int price3 = rt.getRoute_price()*15/10;
	
%>
<!doctype html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<link href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700" rel="stylesheet">

	<link rel="stylesheet" href="css/style.css"> <!-- Resource style -->
	<title>NH Bus</title>
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
			<li><a class="active">버스조회</a></li>
			<li><a>좌석선택</a></li>
			<li><a>결제확인</a></li>
		</ul>
	</nav> <!-- .cd-secondary-nav -->
</header> <!-- .cd-auto-hide-header -->


<style>
	.state{
	  margin-left: 20%;
	  margin-right: 20%;
	  margin-top: 5%;
	  min-width:500px;
	  display:table;
	}
	.container{
		min-width:950px;
	}
      #jb-content {
        display: inline-block;

      	min-width:600px;
        width: 60%;
        heigth:100%;
        padding: 20px;
        margin-left:20px;'
        margin-bottom: 20px;
        float: right;
        border: 1px solid #bcbcbc;
      }
      #jb-sidebar {
        display: inline-block;

	text-align:center;
      	min-width:300px;
        width: 30%;
        heigth:100%;
        padding: 20px;
        margin-left:10px;
        margin-bottom: 20px;
        float: left;
        border: 1px solid #bcbcbc;
      }
      
.col-item{
  display: inline-block;
  	min-width:200px;
    padding: 20px;
    border-top: 1px solid #d3d3d3;
    font-size: 15px;
    width: 100%;
}

.col-item:hover{
	box-shadow: 1px 1px 20px #d3d3d3;
	background-color:#ddd;
}

.inputDat{
  border: 0px;
  background-color:rgba(0,0,0,0);
  
  color:black;
  font-size: 24px;
  font-weight: bold;
  width:100%;
  cursor:pointer;
}

.inputDat:focus{
	outline:none;
}
.navs{
}
.navs li{
	text-align:left;
    list-style: none;
	font-size:20px;
    vertical-align: middle;
    padding: 0px 5px 6px 0px;
    margin-bottom:5px;
}
</style>
	  
<main class="cd-main-content sub-nav main">
	<div class="state">
	<div class="container">
		<div id="jb-sidebar">
			<h2>버스 시간표</h2>
			<ul class="navs">
				<li>출발지 : <%=start %></li>
				<li>도착지 : <%=end %></li>
				<li>소요시간 : <%=rt.getRoute_time() %></li>
				<li>일반 요금 : <%=price1 %>원</li>
				<li>우등 요금 : <%=price2 %>원</li>
				<li>프리미엄 요금 : <%=price3 %>원</li>
			</ul>
	     </div>
	     <div id="jb-content">
			<div style=" text-align:center">
			<input type="text" id="date" name="date" class="inputDat" placeholder="날짜" required>
			<hr>
			
			<div>
				<div style="width:33%; float:left">출발</div>
				<div style="width:33%; float:left">고속사</div>
				<div style="width:33%; float:left">등급</div>
			</div>
			<div style="margin: 80px">
			</div>
			
				<form action="choiceSeat.jsp" id="bus_form" name="bus_form" method="post">
				<%
				for(int i =0; i<busIndex.size(); i++)
				{	
					try{	
					
						String grade = "";
					
						Date bus_time = new SimpleDateFormat("yyyy-MM-dd").parse(busIndex.get(i).getBus_start());
						int indexstart = busIndex.get(i).getBus_start().indexOf(" ");	//시간만 띄우는 방법이 없어 
						int indexend = busIndex.get(i).getBus_start().lastIndexOf(":");	//서브스트링으로 시간, 분 잘라냄
						String rr = busIndex.get(i).getBus_start().substring(indexstart + 1, indexend);
						

						int comp = day.compareTo(bus_time);
						if(comp == 0){
							
							switch(busIndex.get(i).getBus_stat()){
							case 1:
								grade = "일반";
								break;
							case 2:
								grade = "우등";
								break;
							case 3:
								grade = "프리미엄";
								break;
							}
					
				%>
				<a href="javascript:void(0);" onclick="choiceBus(<% out.print(busIndex.get(i).getBus_id()+", "+busIndex.get(i).getBus_stat()+", '"+busIndex.get(i).getBus_start()+"', '"+busIndex.get(i).getBus_co()+"'"); %>);" class="col-item">
					<div style="width:33%; float:left; font-size:20px;"><%=rr %></div>
					<div style="width:33%; float:left; font-size:20px;"><% out.println(busIndex.get(i).getBus_co()); %></div>
					<div style="width:33%; float:left; font-size:20px;"><%=grade %></div>
				</a>
				<%
						}
					}catch(ParseException e){
						out.println("error  "+e.getMessage());
					}
				}
				%>
				<input type="hidden" id="bus_id" name="bus_id">
				<input type="hidden" id="bus_grade" name="bus_grade">
				<input type="hidden" id="bus_time" name="bus_time">
				<input type="hidden" id="company" name="company">
				<input type="hidden" id="route" name="route" value=<%out.println(start+"/"+end); %>>
				<input type="hidden" id="price" name="price" value=<%out.println(price1); %>>
				<input type="hidden" id="route_id" name="route_id" value=<%=route_id %>>
				
				</form>
			</div>
		</div>
		</div>
	</div>
</main>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
	var dates = document.getElementById('date');
	dates.value = '<%=date%>';

	if( !window.jQuery ) document.write('<script src="js/jquery-3.0.0.min.js"><\/script>');
	flatpickr("#date");
	
	var busId = document.getElementById('bus_id');
	var busGr = document.getElementById('bus_grade');
	var busTr = document.getElementById('bus_time');
	var busCo = document.getElementById('company');
	
	
	
	function choiceBus(id, grade, time, com){
		busCo.value = com;
		busId.value = id;
		busGr.value = grade;
		busTr.value = time;
		alert('버스를 선택하셨습니다. 원하는 좌석을 선택하세요');
		document.getElementById("bus_form").submit();
	}
</script>
<script src="js/main.js"></script> <!-- Resource jQuery -->
</body>
</html>
