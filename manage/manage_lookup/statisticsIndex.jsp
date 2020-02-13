<%@page import="dto.manageRoute"%>
<%@page import="service.routeViewService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="dao.routeDAO" %>
<%@ page import="dao.managerDAO" %>
<%@ page import="dto.route" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.manageDetail" %>
<%
	managerDAO mDAO = new managerDAO();

	String m_id = "";
	String m_name = "";
	if(session.getAttribute("id") != null){
		m_id = (String)session.getAttribute("id");
		m_name = (String)session.getAttribute("name");
	}
	else{
		response.sendRedirect("/Kobus/manage/manage_login/login_manage.jsp");
	}
%>
<!DOCTYPE html>
<html lang="ko">
<style>
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
    <head>        
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>관리자 페이지</title>
        	
        <link rel="stylesheet" href="css/popup.css">
        <link rel="stylesheet" href="css/styles.css"/>
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
                        
                        <a href="/Kobus/manage/manage_login/logout_mange.jsp">
                        <div class="small">Logged in as: <%= m_name %>
                       </div>
                       </a>
                        
                    </div>
                </nav>
            </div>
            
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
         <style>
			/*datepicker에서 사용한 이미지 버튼 style적용*/
			img.ui-datepicker-trigger {
				margin-left:5px; vertical-align:middle; cursor:pointer;
			}
		</style>  
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">매출 통계 확인</h1>
                        <div class="card mb-4">
                            <div class="card-body">관리자 페이지에서는 전체노선을 조회하거나 배차 추가 및 매출통계를 확인할 수 있습니다.</div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header"><i class="fas fa-table mr-1"></i>전체 매출 내용</div>
                            <div class="card-body">
                                <div class="table-responsive">
                                <form action="statisticsLookup.jsp" id="satis_form" method="post">
                                    <!-- 출발지 / 도착지 / 앞 날짜 / 뒷 날짜 를 선택하고 그 사이의 매출 통계를 출력함. -->
                                    <input onclick="toggleModal();" type="text" id="start" name="start" class="inputs" placeholer="출발지" readonly>
                                    <input onclick="toggleModal();" type="text" id="end" name="end" class="inputs" placeholer="도착지" readonly>
                                    <input type="text" name="fromDate" id="fromDate">
		  							<input type="text" name="toDate" id="toDate"><input type="submit" value="조회하기">
		  						</form>
								</div>
									<!-- 팝업 될 레이어 -->
						     <div class="card-body modal">
						         <div class="modal-content">
						             <span class="close-button">&times;</span>
						             	<div class="selection">
						             		
										</div>
						         </div>
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
		<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
		<!-- datepicker 한국어로 -->
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
		
        <script type="text/javascript">

    	function submit(){
    		var form = document.getElementById("route_form");
    		var start = document.getElementById("start").value;
    		var end = document.getElementById("end").value;
    		var date = document.getElementById("date").value;
    		if(start != "" && end != "" && date != "")
    			form.submit();
    	}

        $(function() {
			
			
			//오늘 날짜를 출력
			$("#today").text(new Date().toLocaleDateString());

		    //datepicker 한국어로 사용하기 위한 언어설정
			$.datepicker.setDefaults($.datepicker.regional['ko']); 
			
			// 시작일(fromDate)은 종료일(toDate) 이후 날짜 선택 불가
			// 종료일(toDate)은 시작일(fromDate) 이전 날짜 선택 불가

			//시작일.
			$('#fromDate').datepicker({				// 달력을 표시할 타이밍 (both: focus or button)
				dateFormat: "yy-mm-dd",				// 날짜의 형식
				changeMonth: true,					// 월을 이동하기 위한 선택상자 표시여부
				//minDate: 0,						// 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
				onClose: function( selectedDate ) {	
					// 시작일(fromDate) datepicker가 닫힐때
					// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
					$("#toDate").datepicker( "option", "minDate", selectedDate );
				}				
			});

			//종료일
			$('#toDate').datepicker({
				dateFormat: "yy-mm-dd",
				changeMonth: true,
				//minDate: 0, // 오늘 이전 날짜 선택 불가
				onClose: function( selectedDate ) {
					// 종료일(toDate) datepicker가 닫힐때
					// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
					$("#fromDate").datepicker( "option", "maxDate", selectedDate );
				}				
			});
		});

   		var modal = document.querySelector('.modal');
        var closeButton = document.querySelector(".close-button");


       function toggleModal() {
            modal.classList.toggle("show-modal");
            modal.classList.toggle("modal");
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
   	
       function getStart(){
       	$.ajax({
               url: "/Kobus/reStart.jsp",
               type:"POST",
               cache: false,
               success: function(data){
                 $('.selection').html('출발지 선택'+data);
               }
             });
       }
    	
       function getEnd(){
           $.ajax({
             url: "/Kobus/reEnd.jsp?start="+document.getElementById("start").value,
             type:"POST",
             cache: false,
             success: function(data){
               $('.selection').html('도착지 선택'+data);
             }
           	 
           });
       }
        window.onload=function(){
     	  	getStart();
        }
        </script>
    </body>
</html>
