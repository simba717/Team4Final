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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous">
	
</script>
<title>遊戲紅利查詢</title>
<script>
	window.onload = function() {
		var xhr = new XMLHttpRequest();
		xhr.open("GET",
				"<c:url value='/backend/campaign/getGameBonusOfAllMember' />",
				true);
		xhr.send();
		xhr.onload = function() {
			if (xhr.status == 200) {
				var content = "<table id='idtable' class='table table-bordered table-sm'>";
				content += "<thead><tr style='background-color: lightblue'>"
						+ "<th>會員ID</th>"
						+ "<th>會員名稱</th>" 
						+ "<th>遊戲名稱</th>" 
						+ "<th>遊戲時間</th>"
						+ "<th>發放紅利</th>" 
						+ "</tr></thead>";
				var games = JSON.parse(xhr.responseText);

				for (var i = 0; i < games.length; i++) {
					content += "<tbody><tr>" 
							+ "<td>" + games[i].memberId
							+ "<td>" + games[i].memberName
							+ "</td>" + "<td>" + games[i].gameType + "</td>"
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
	<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>
	<div id="wrapper" align='center'>
		<div id="header">
			<h1>遊戲發放紅利列表</h1>
			<hr>
		</div>
		<div id="container">
			<div id="content"></div>
			<h2 align='left'>總發放紅利</h2>
			<div id="sum"></div>
			<br> <br> <br>
			<h1>查詢單一會員取得紅利</h1>

			<label for="memberId">會員ID:</label> <input id="memberIdText"
				type="text" name="memberId" /> <input id='searchBtn' type='submit'
				value="查詢" class="btn btn-primary" /> <input id='clearBtn'
				type='button' value="清除查詢" class="btn btn-primary" /> <br>
			<hr>
			<div id="content2"></div>
		</div>
	</div>
	<script>
		//用會員id搜尋
		var searchBtn = document.getElementById("searchBtn");

		searchBtn.addEventListener('click', query);
		function query() {
			$("#content2").empty();
			//取得輸入值
			searchData = document.getElementById("memberIdText").value;

			var xhr = new XMLHttpRequest();
			xhr.open("GET",
					"<c:url value='/backend/campaign/getGameBonusOfOneMember?member_id='/>"
							+ searchData, true);
			xhr.send();
			xhr.onreadystatechange = function() {

				//顯示資料
				if (xhr.readyState == 4 && xhr.status == 200) {
					var content = "<table id='idtable' class='table table-bordered table-sm'>";
					content += "<thead><tr style='background-color: lightblue'>"
							+ "<th>會員ID</th>"
							+ "<th>會員名稱</th>"
							+ "<th>遊戲名稱</th>"
							+ "<th>遊戲時間</th>"
							+ "<th>發放紅利</th>"
							+ "</tr></thead>";
					var games = JSON.parse(xhr.responseText);

					for (var i = 0; i < games.length; i++) {
						content += "<tbody><tr>" 
								+ "<td>" + games[i].memberId + "</td>" 
								+ "<td>" + games[i].memberName + "</td>" 
								+ "<td>" + games[i].gameType
								+ "</td>" + "<td>" + games[i].playTime
								+ "</td>" + "<td>" + games[i].bonusPoint
								+ "</td>" + "</tr></tbody>";
					}
					content += "</table>";

					var divs = document.getElementById("content2");
					divs.innerHTML = content;

				}

				
				
			}
		}
	</script>
</body>
</html>