<%@page import="service.routeViewService"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="dao.routeDAO" %>
<%@ page import="dto.route" %>
<%@ page import="service.routeViewService" %>
<%@ page import="java.util.ArrayList" %>

<!-- 메인 화면 ( 노선 검색 ) -->

<!doctype html>
<html lang="ko" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	
	<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.css"/>	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700">

	<link rel="stylesheet" href="css/popup.css?ver">
	<link rel="stylesheet" href="./css/reset.css"> <!-- CSS reset -->
	<link rel="stylesheet" href="/Kobus/css/style.css?"> <!-- Resource style -->
	<link rel="stylesheet" href="./css/item.css">
	
     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<title>NH Bus</title>
	<style>
		.selection{
			overflow:auto;
		}
		button,
		button::after {
		  -webkit-transition: all 0.3s;
			-moz-transition: all 0.3s;
		  -o-transition: all 0.3s;
			transition: all 0.3s;
			
		  widht:100px;
		  height:40px;
		}
		
		button {
		  background: none;
		  border: 2px solid #333;
		  border-radius: 5px;
		  width:90%;
		  height:60px;
		  color: #000;
		  display: block;
		  font-size: 20px;
		  font-weight: bold;
		  margin: 5px;
		  padding: 2px 4px;
		  position: relative;
		  text-transform: uppercase;
		}
		
		button::before,
		button::after {
		  color:#fff;
		  background: #aaa;
		  content: '';
		  position: absolute;
		  z-index: -1;
		}
		
		button:hover {
		  color: #fff;
		}
					
		/* BUTTON 3 */
		.getStart::after{
		  height: 0;
		  left: 50%;
		  top: 50%;
		  width: 0;
		}
		
		.getStart:hover:after {
		  height: 100%;
		  left: 0;
		  top: 0;
		  width: 100%;
		}
		
		/* BUTTON 4 */
		.getEnd::before {
		  height: 100%;
		  left: 0;
		  top: 0;
		  width: 100%;
		}
		
		.getEnd::after {
		  background: #fff;
		  height: 100%;
		  left: 0;
		  top: 0;
		  width: 100%;
		}
		
		.getEnd:hover:after {
		  height: 0;
		  left: 50%;
		  top: 50%;
		  width: 0;
		}

					
	</style>
	
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
		<%
			if(session.getAttribute("id") == null){
				out.println("<li><a href='login.jsp'>로그인</a></li>");
			}
			else{
				out.println("<li><a href='logout.jsp'>로그아웃</a></li>");
			}
		%>
      <li><a href="myPage/lookUpTicket.jsp">회원정보</a></li>
		</ul>
	</nav> <!-- .cd-primary-nav -->

	<nav class="cd-secondary-nav">
		<ul>
			<li><a class="active">노선조회</a></li>
			<li><a>버스조회</a></li>
			<li><a>좌석선택</a></li>
			<li><a>결제확인</a></li>
		</ul>
	</nav> <!-- .cd-secondary-nav -->
</header> <!-- .cd-auto-hide-header -->


<main class="cd-main-content sub-nav main">
	<form id="route_form" name="route_form" action="busTime.jsp" method="post">
	<div class="state">
		<ul class="list-row">
			
			<a href="javascript:toggleModal();">
				<li class="col-item-left">
					<div class="card-block">
						<div class="card-title">
							<input type="text" id="start" name="start" class="inputDat" placeholder="출발지" readonly required>
							<span class="css-arrow"></span>
							
						</div>
					</div>
				</li>
			</a>
			<a href="javascript:toggleModal();">
				<li class="col-item-right">
					<div class="card-block">
						<div class="card-title">
							<input type="text" id="end" name="end" class="inputDat" placeholder="도착지" readonly required>
							<span class="css-arrow"></span>
						</div>
					</div>
				</li>
			</a>
			<a href="javascript:void(0);">
				<li class="col-item-left">
					<div class="card-block">
						<div class="card-title">
							<input type="text" id="date" name="date" class="inputDat" placeholder="날짜" required>
							<span class="css-arrow"></span>
						</div>
					</div>
				</li>
			</a>
			<a href="javascript:void(0)" onclick="submit();">
				<li class="col-item-right">
					<div class="card-block">
						<div class="card-title">
							<input type="text" class="inputDat" value="조회하기" readonly >
							<span class="css-arrow"></span>
						</div>
					</div>
				</li>
			</a>
			</ul>
		</div>
	</form>
</main> <!-- .cd-main-content -->
             

<!-- 팝업 될 레이어 -->
     <div class="modal">
         <div class="modal-content">
             <span class="close-button">&times;</span>
             	<div class="selection">
				</div>
         </div>
     </div>
<script type="text/javascript">

	function submit(){
		var form = document.getElementById("route_form");
		var start = document.getElementById("start").value;
		var end = document.getElementById("end").value;
		var date = document.getElementById("date").value;
		if(start != "" && end != "" && date != "")
			form.submit();
	}

	flatpickr("#date",{
		minDate: "today"
	});

	 var modal = document.querySelector('.modal');
     var closeButton = document.querySelector(".close-button");

    //console.log(modal);

    function toggleModal() {
         modal.classList.toggle("show-modal");
     }

    function windowOnClick(event) {
         if (event.target == modal) {
        	 cancelClick();
         }
     }

     closeButton.addEventListener("click", cancelClick);
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
	}
	
	function setEnd(button){
		document.getElementById("end").value = button.innerHTML;
		toggleModal();
		getStart();
	}
	
	// 출발지 선택
    function getStart(){
    	$.ajax({
            url: "reStart.jsp",
            type:"POST",
            cache: false,
            success: function(data){
              $('.selection').html(data);
            }
          });
    }
 	
	// 도착지 선택
    function getEnd(){
        $.ajax({
          url: "reEnd.jsp?start="+document.getElementById("start").value,
          type:"POST",
          cache: false,
          success: function(data){
            $('.selection').html(data);
          }
        });
    }
	window.onload=function(){
		getStart();
	}

</script>
<script src="js/main.js"></script> <!-- Resource jQuery -->
</body>
</html>
