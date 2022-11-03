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
<title>會員遊戲紀錄</title>
<script>
	window.onload = function() {
		var xhr = new XMLHttpRequest();
		xhr.open("GET",
				"<c:url value='/frontend/campaign/memberGameRecords' />", true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var content = "<table id='idtable' class='table table-bordered table-sm'>";
				content += "<thead><tr style='background-color: lightblue'><th>遊戲名稱</th><th>遊戲得分</th><th>遊戲時間</th>"
						+ "<th>取得紅利</th></tr></thead>";
				var games = JSON.parse(xhr.responseText);

				for (var i = 0; i < games.length; i++) {
					content += "<tbody><tr>" + "<td>" + games[i].gameName
							+ "</td>" + "<td>" + games[i].gameScore + "</td>"
							+ "<td>" + games[i].playTime + "</td>" + "<td>"
							+ games[i].bonusPoint + "</td>" + "</tr></tbody>";
				}
				content += "</table>";

				var divs = document.getElementById("content");
				divs.innerHTML = content;

			}
		}
	}
</script>
</head>
<body>
	<jsp:include page="../../layout/Navbar.jsp"></jsp:include>
	<div id='wrapper' align='center'>
		<div id="header">
			<h1>遊戲紀錄列表</h1>
			<hr>
		</div>
		<div id="container">
			<div id="content">
				<div id='contents'></div>
			</div>
		</div>
	</div>
</body>
</html>