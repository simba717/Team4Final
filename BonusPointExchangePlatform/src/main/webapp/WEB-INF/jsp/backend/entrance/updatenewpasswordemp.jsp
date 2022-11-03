<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');


* {
	box-sizing: border-box;
}

.loginbody {
	background: #f6f5f7;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	font-family: 'Montserrat', sans-serif;
	height: 70vh;
	margin: -20px 0 50px;
}


.logingh1 {
	font-weight: bold;
	margin: 0;
}

.logingh2 {
	text-align: center;
}


.loginp {
	font-size: 14px;
	font-weight: 100;
	line-height: 20px;
	letter-spacing: 0.5px;
	margin: 20px 0 30px;
	color:white;
}


.logina {
	color: #333;
	font-size: 14px;
	text-decoration: none;
	margin: 15px 0;
}

.loginbutton {
	border-radius: 20px;
	border: 1px solid #FF4B2B;
	background-color: #FF4B2B;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	padding: 12px 45px;
	letter-spacing: 1px;
	text-transform: uppercase;
	transition: transform 80ms ease-in;
}

button:active {
	transform: scale(0.95);
}

button:focus {
	outline: none;
}

.signupbutton {
	border-radius: 20px;
	border: 1px solid #FFFFFF;
	background-color: transparent;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	padding: 12px 45px;
	letter-spacing: 1px;
	text-transform: uppercase;
	transition: transform 80ms ease-in;
}

button.ghost {
	background-color: transparent;
	border-color: #FFFFFF;
}

.loginform {
	background-color: #FFFFFF;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 50px;
	height: 100%;
	text-align: center;
}

input {
	background-color: #eee;
	border: none;
	padding: 12px 15px;
	margin: 8px 0;
	width: 100%;
}

.logincontainer {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px
		rgba(0, 0, 0, 0.22);
	position: relative;
	overflow: hidden;
	width: 768px;
	max-width: 100%;
	min-height: 480px;
}

.form-logincontainer {
	position: absolute;
	top: 0;
	height: 100%;
	transition: all 0.6s ease-in-out;
}

.sign-in-container {
	left: 0;
	width: 100%;
	z-index: 2;
}

.logincontainer.right-panel-active .sign-in-container {
	transform: translateX(100%);
}

.sign-up-container {
	left: 0;
	width: 50%;
	opacity: 0;
	z-index: 1;
}

.logincontainer.right-panel-active .sign-up-container {
	transform: translateX(100%);
	opacity: 1;
	z-index: 5;
	animation: show 0.6s;
}

@
keyframes show { 0%, 49.99% {
	opacity: 0;
	z-index: 1;
}

50
%
,
100
%
{
opacity
:
1;
z-index
:
5;
}
}
.overlay-logincontainer {
	position: absolute;
	top: 0;
	left: 50%;
	width: 50%;
	height: 100%;
	overflow: hidden;
	transition: transform 0.6s ease-in-out;
	z-index: 100;
}

.logincontainer.right-panel-active .loginoverlay-container {
	transform: translateX(-100%);
}

.loginoverlay {
	background: #FF416C;
	background: -webkit-linear-gradient(to right, #FF4B2B, #FF416C);
	background: linear-gradient(to right, #FF4B2B, #FF416C);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 0 0;
	color: #FFFFFF;
	position: relative;
	left: -100%;
	height: 100%;
	width: 200%;
	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
}

.logincontainer.right-panel-active .loginoverlay {
	transform: translateX(50%);
}

.overlay-panel {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 40px;
	text-align: center;
	top: 0;
	height: 100%;
	width: 50%;
	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
}

.overlay-left {
	transform: translateX(-20%);
}

.logincontainer.right-panel-active .overlay-left {
	transform: translateX(0);
}

.overlay-right {
	right: 0;
	transform: translateX(0);
}

.logincontainer.right-panel-active .overlay-right {
	transform: translateX(20%);
}

.social-container {
	margin: 20px 0;
}

.social-container a {
	border: 1px solid #DDDDDD;
	border-radius: 50%;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	height: 40px;
	width: 40px;
}

</style>





</head>
<body>
<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>
<div class="loginbody">
	<h2 class="logingh2">員工更改密碼</h2>
	<div class="logincontainer" id="logincontainer">
	
		<div class="form-logincontainer sign-in-container">
				<form class="loginform" action="updatenewpasswordemp" method="post">
			
				<h1 class="logingh1">Check-Code</h1>
				
				<input type="text" name="checkcode" id="checkcode" placeholder="請輸入您的驗證碼" />
						<div id='resultCheckCode' style="height: 10px;"></div> 				
				<br>
				
				<input type="password" name="password" placeholder="請輸入您的新密碼" id="password" /> 
				<label style="color: gray; font-size: 10px; text-align: left;">(至少6個字且必須包含英數字、特殊字元[!@#$%^&*])</label>
				<span id="pwHelp"></span>
				
				<br>
				
				
				<button class="loginbutton" id="idsubmit" >確認修改</button>
		
			</form>
			
		</div>
	</div>
	</div>

	<script type="text/javascript">
	let pwdflag, checkCodeflag= false;


	document.getElementById("password").addEventListener("blur",function() {

		let pwId = document.getElementById("password");
	
		let pwVal = pwId.value;
		let pwLen = pwVal.length;
		let pwsp = document.getElementById("pwHelp");

		let pwCh, flag1 = false, flag2 = false, flag3 = false;
		let pwre = new RegExp(/[!@#$%^&*]/);

		if (pwVal == "") {
			pwsp.innerHTML = "  請輸入密碼";
			document.getElementById("pwHelp").style.color = "red";
			pwdflag = false;

		} else if (pwLen >= 6) {
			for (let k = 0; k < pwLen; k++) {
				let pwCh = pwVal.charAt(k).toUpperCase();
				if (pwCh >= "A" && pwCh <= "Z")
					flag1 = true;
				else if (pwCh >= "0" && pwCh <= "9")
					flag2 = true;
				else if (pwre.test(pwVal))
					flag3 = true;
				if (flag1 && flag2 && flag3 )
					break;

			}
			if (flag1 && flag2 && flag3 ) {
				pwsp.innerHTML = "  正確";
				document.getElementById("pwHelp").style.color = "green";
				console.log("success!!!!!!")
				pwdflag = true;
			} else if (flag1 && flag2) {
				pwsp.innerHTML = "  須包含特殊字元";
				document.getElementById("pwHelp").style.color = "red"
				pwdflag = false;

			} else if (flag2 && flag3) {
				pwsp.innerHTML = "  須包含英文字母";
				document.getElementById("pwHelp").style.color = "red"
				pwdflag = false;

			} else if (flag1 && flag3) {
				pwsp.innerHTML = "  須包含數字";
				document.getElementById("pwHelp").style.color = "red"
				pwdflag = false;

			} else if (flag1) {
				pwsp.innerHTML = "  須包含數字、特殊字元";
				document.getElementById("pwHelp").style.color = "red";
				pwdflag = false;

			} else if (flag2) {
				pwsp.innerHTML = "  須包含英文字母、特殊字元";
				document.getElementById("pwHelp").style.color = "red";
				pwdflag = false;

			} else {
				pwsp.innerHTML = "須包含英文字母、數字";
				document.getElementById("pwHelp").style.color = "red";
				pwdflag = false;

			}
		} else {
			pwsp.innerHTML = "  至少要6個字";
			document.getElementById("pwHelp").style.color = "red";
			pwdflag = false;

		}
	})
document.getElementById("password").addEventListener("blur", finalcheck)
	
	
		document.getElementById("checkcode").addEventListener("blur",function () {
			  var checkcodediv = document.getElementById("resultCheckCode");
			  var checkcodeValue = document.getElementById("checkcode").value;
			  if (!checkcodeValue) {					   
				  checkCodeflag=false;

				 checkcodediv.innerHTML = "<font color='blue' size='-1'>請輸入驗證碼...</font>";
				return;
			  }
			  var xhr = new XMLHttpRequest();
			  xhr.open("POST", "<c:url value='/checkCodeCheck'/>", true);
			  xhr.setRequestHeader("Content-Type",
						"application/x-www-form-urlencoded");
			  xhr.send("checkcode=" + checkcodeValue);
			  var message = "";
			  xhr.onreadystatechange = function() {
			    // 伺服器請求完成
			    if (xhr.readyState == 4 && xhr.status == 200) {
				   var result = JSON.parse(xhr.responseText);
				   if (result == true) {
					   checkCodeflag=true;
					  message = "<font color='green' size='-2'>驗證碼正確</font>";
				   }else {
					   checkCodeflag=false;

					  message = "<font color='red' size='-2'>驗證碼錯誤請重新輸入驗證碼</font>"; 
				   }
				   checkcodediv.innerHTML = message;
			    }
		   }
		 })
document.getElementById("checkcode").addEventListener("blur", finalcheck)

	
	
	
	
		function finalcheck() {
			if ( pwdflag && checkCodeflag) {
				document.getElementById("idsubmit").removeAttribute("disabled")
			} else {
				document.getElementById("idsubmit").setAttribute("disabled",
						"true");
			}
		}


</script>



</body>
</html>