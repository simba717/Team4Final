<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員登入</title>
</head>
<body>
	<h1>會員登入</h1>
	<form action="home" method="post">
		<section>
			<label>帳號</label>
			<div>
				<input type="text" name="account" placeholder="請輸入您的帳號" />
				<div id="nullaccount"></div>
			</div>
		</section>
		<section>
			<label>密碼</label>
			<div>
				<input type="password" name="password" maxlength="16"
					placeholder="請輸入您的密碼" />
				<div id="nullpassword"></div>

			</div>
		</section>
		<input type="Submit" value="提交"> 
		
		
			<a href="register">註冊</a>
			<a href="updatepassword">忘記密碼</a>
		
			
			
			
	</form>
<jsp:include page="../../layout/footer.jsp"></jsp:include>
</body>
</html>