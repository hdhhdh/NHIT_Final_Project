<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 페이지 -->

<%

//로그인 검증
	
	if(session.getAttribute("id") != null){
		out.println("<script>alert('이미 로그인되어있습니다.'); location.href='index.jsp';</script>");
	}

	String re = "ok";
	re = request.getParameter("re");
	
	if(re != null && re.equals("error")){
		out.println("<script>alert('로그인해주세요.');</script>");
	}
%>

<!DOCTYPE html>
<html lang="ko" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/login_form_css.css?v">
    <link rel="stylesheet" href="css/login_effect_css.css">

    <title>NH Bus Log-in</title>
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
        <form action="login_Process.jsp" method="post" class="form form--login">
          <div class="form__field">
            <label class="fontawesome-user" for="login__username"><span class="hidden">ID</span></label>
            <input id="login__username" type="text" class="form__input" name="id" placeholder="Username" required>
          </div>
          <div class="form__field">
            <label class="fontawesome-lock" for="login__password"><span class="hidden">Password</span></label>
            <input id="login__password" type="password" class="form__input" name="pw" placeholder="Password" required>
          </div>
          <div class="form__field">
            <input type="submit" value="Log In">
          </div>
        </form>
        <p class="text--center">ID가 없으면 <span class="fontawesome-arrow-right"></span><a href="signup.jsp">회원가입</a> </p>
      </div>
    </div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 
<script>
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
            InputEvent2({input: $("#login__username"), dataType: "AN"});
        } catch (e) {
            console.log(e);
        }
    });
</script>
  </body>
</html>