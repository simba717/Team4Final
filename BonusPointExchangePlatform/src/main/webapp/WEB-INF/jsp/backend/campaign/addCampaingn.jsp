<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">
<!-- CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous">
	
</script>
<title>新增會員活動</title>
</head>
<body>
<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>
	<div id='wrapper' align='center'>
		<div id="header">
			<h1>新增會員活動</h1>
			<hr>
		</div>
		<div id="container" align="center">
			<div id="content">
			<form>
			<label for="campaingnName">活動名稱:</label>
			<input id="campaingnName" type="text" name="campaingnName" /> 
			
			
			</form>
			</div>
		</div>
	</div>
</body>
</html>