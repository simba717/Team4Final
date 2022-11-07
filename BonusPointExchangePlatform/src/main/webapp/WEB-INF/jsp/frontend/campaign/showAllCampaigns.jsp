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
<title>活動總覽</title>
<script>
	window.onload = function() {
		var xhr = new XMLHttpRequest();
		xhr.open("GET",
				"<c:url value='/frontend/campaign/getCampaigns' />", true);
		xhr.send();
		xhr.onload = function() {
			if (xhr.status == 200) {
				var content = "<table id='idtable' class='table table-bordered table-sm'>";
				content += "<thead><tr style='background-color: coral'>"
					+ "<th>活動名稱</th>"
					+ "<th>活動用圖</th>" 
					+ "<th>活動內容</th>" 
					+ "<th>開始時間</th>" 
					+ "<th>結束時間</th>" 
					+ "</tr></thead>";
			var campaigns = JSON.parse(xhr.responseText);
			let imageURL = "data:image/jpg;base64,";
			for (var i = 0; i < campaigns.length; i++) {
				content += "<tbody><tr>" 
						+ "<td width='200'>" + campaigns[i].campaignName + "</td>"
						+ "<td width='600'><img width='600' height='400'" + " src='" + imageURL + campaigns[i].campaignPhoto + "'></td>"
						+ "<td>" + campaigns[i].campaignContent + "</td>"
						+ "<td width='100'>" + campaigns[i].campaignStart_at + "</td>"
						+ "<td width='100'>" + campaigns[i].campaignEnd_at + "</td>"
						+ "</tr></tbody>";
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
			<h1>活動總覽</h1>
			<hr>
		</div>
		<div id="container">
			<div id="content"></div>
		</div>
	</div>
</body>
</html>