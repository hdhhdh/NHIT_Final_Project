<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 회원가입 -->
<!-- 회원 가입 페이지 -->
<!DOCTYPE html>
<%
	if(session.getAttribute("id") != null){
		out.println("<script>alert('이미 로그인되어있습니다.'); location.href='index.jsp';</script>");
	}
%>
<html lang="ko" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/login_form_css.css?ver">
    <link rel="stylesheet" href="css/login_effect_css.css">
    <title>NH Bus 회원가입</title>
  </head>
  <body class="align">
    <div class="top">
      <div id="wrap">
      
        <div id="app" onclick="location.href='index.jsp'" style="cursor:pointer;"></div>
      </div>
      <script type="text/javascript" src="js/logo_effect.js"></script>
    </div>


    <div class="site__container">
      <div class="grid__container">
        <form action="signUp_Process.jsp" method="post" id="sign_form" class="form form--login">
          <div class="form__field">
            <label class="fontawesome-user" for="login__username"><span class="hidden">ID</span></label>
            <input id="signup__username" type="text" class="form__input" name="id" placeholder="ID" required maxlength="12">
          </div>
          <div class="form__field">
            <label class="fontawesome-lock" for="login__password"><span class="hidden">Password</span></label>
            <input id="signup__password" type="password" class="form__input" name="pw" placeholder="Password" required maxlength="12">
          </div>
          <div class="form__field">
            <label class="fontawesome-play" for="name"><span class="hidden">Name</span></label>
            <input id="signup_name" type="text" class="form__input" name="name" placeholder="Name" required maxlength="5">
          </div>
          <div class="form__field">
            <label class="fontawesome-circle" for="age"><span class="hidden">age</span></label>
            <input id="signup_age" type="text" class="form__input" name="age" placeholder="Age" onKeyDown="this.value=this.value.replace(/[^0-9]/g,'');" required maxlength="3">
          </div>
          <div class="form__fiel">
            <p class="btn-switch" style="text-algin:center;">
				<input type="radio" id="yes" name="gender" class="btn-switch__radio btn-switch__radio_yes" value="0" CHECKED/>
				<input type="radio" id="no" name="gender" class="btn-switch__radio btn-switch__radio_no" value="1"/>            	
				<label for="yes" class="btn-switch__label btn-switch__label_yes"><span class="btn-switch__txt">남자</span></label>
          		<label for="no" class="btn-switch__label btn-switch__label_no"><span class="btn-switch__txt">여자</span></label>						
          	</p>
          </div>
          <div class="form__field">
            <input type="button" onclick="submits();" value="Sign Up">
          </div>
          
        </form>
         <p class="text--center">ID는 영문 + 숫자, 최대 12 글자 </p>
         <p class="text--center">ID, PW 는 최소 7글자 </p>
      </div>
    </div>
    
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 
<script>
	function submits(){
		var form = document.getElementById("sign_form");
		var id = document.getElementById("signup__username").value.length;
		var pw = document.getElementById("signup__password").value.length;
		var name = document.getElementById("signup_name").value.length;
		var age = document.getElementById("signup_age").value.length;
		if(id > 6 && pw > 6 && name > 0 && age > 0){
			form.submit();
		}
		else{
			alert('제대로 입력해주세요.');
		}
	}

    function InputEvent2(conditions) {
        var $input = conditions.input;
        var dataType = conditions.dataType;
        var eventType = conditions.eventType;
 
        if ((!eventType)) {
            eventType = "keyup";
        }
 
        var handlerFunc = conditions.handler;
        if ((!handlerFunc)) {
            handlerFunc = function (event) {
 
                if (dataType == "AN") {
                    regEx = /[^a-z0-9]/gi;
                } else {
                    throw {error: "IlregalDataType", errorMsg: "dataType(" + dataType + ") is incorrect"}
                }
                remainOnlyTargetValue2(regEx, $input, event);
            };
        }
        $input.on(eventType, handlerFunc);
    }
 
    function remainOnlyTargetValue2(regEx, $input, event) {
        if ((!(event.keyCode >= 34 && event.keyCode <= 40)) && event.keyCode != 16) {
            var inputVal = $input.val();
            if (regEx.test(inputVal)) {
                $input.val(inputVal.replace(regEx, ''));
            }
        }
    }
 
    $(document).ready(function () {
        try {
            InputEvent2({input: $("#signup__username"), dataType: "AN"});
        } catch (e) {
            console.log(e);
        }
    });
    
    
    function InputEvent(conditions) {
        var $input = conditions.input;
        var dataType = conditions.dataType;
        var eventType = conditions.eventType;
 
        if ((!eventType)) {
            eventType = "keyup";
        }
 
        var handlerFunc = conditions.handler;
        if ((!handlerFunc)) {
            handlerFunc = function (event) {
 
                if (dataType == "HA") {
                    regEx = /[a-z0-9]/gi;
                } else {
                    throw {error: "IlregalDataType", errorMsg: "dataType(" + dataType + ") is incorrect"}
                }
                remainOnlyTargetValue(regEx, $input, event);
            };
        }
        $input.on(eventType, handlerFunc);
    }
 
    function remainOnlyTargetValue(regEx, $input, event) {
        if ((!(event.keyCode >= 34 && event.keyCode <= 40)) && event.keyCode != 16) {
            var inputVal = $input.val();
            if (regEx.test(inputVal)) {
                $input.val(inputVal.replace(regEx, ''));
            }
        }
    }
 
    $(document).ready(function () {
        try {
            InputEvent({input: $("#signup_name"), dataType: "HA"});
        } catch (e) {
            console.log(e);
        }
    });
</script>
 
  </body>
</html>