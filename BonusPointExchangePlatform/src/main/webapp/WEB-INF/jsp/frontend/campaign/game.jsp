<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>商城小遊戲</title>
</head>
<body>
	<jsp:include page="../../layout/Navbar.jsp"></jsp:include>
	<h1 align='center'>本月遊戲: 採集魔水晶</h1>
	<hr>
	
	
	<div id="game" align='center'>
	<img src="${contextRoot}/img2/game2.png" style="width:1000px">
		<iframe src="https://syuan0902.github.io/" width=1200 height=1000></iframe>
	</div>



<script>
	function GetScore(score) {
    var point = score;
    window.alert('恭喜大大獲得分數: ' + point + '分');
  };

</script>
</body>
</html>