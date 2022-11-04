<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>銷售類型佔比</title>
</head>
<body>
	<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>
	<div align='center'>
		<select name="TotalOrAnalyze"
			onchange="location.href=this.options[this.selectedIndex].value">
			<optgroup label="銷售總數">
				<option value="http://localhost:8080/my-app/barchar">長條圖</option>
				<option value="http://localhost:8080/my-app/piechar" selected="true">圓餅圖</option>
			</optgroup>
			<optgroup label="銷售分析">
				<option value="http://localhost:8080/my-app/day7search">七天內銷售</option>
				<option value="http://localhost:8080/my-app/monthsearch">本月銷售</option>
			</optgroup>
		</select>
	</div>

	<div align='center'>
		<div id="myPlot" style="width: 50%; max-width: 500px"></div>

		<script>
			var food = null;
			var xhr1 = new XMLHttpRequest();
			xhr1.open("Get", "<c:url value='/product/searchgroup1' />", true);
			xhr1.send();
			xhr1.onreadystatechange = function() {
				if (xhr1.readyState == 4 && xhr1.status == 200) {
					food = JSON.parse(xhr1.responseText);

					var sport = null;
					var xhr2 = new XMLHttpRequest();
					xhr2.open("Get", "<c:url value='/product/searchgroup2' />",
							true);
					xhr2.send();
					xhr2.onreadystatechange = function() {
						if (xhr2.readyState == 4 && xhr2.status == 200) {
							sport = JSON.parse(xhr2.responseText);

							var house = null;
							var xhr3 = new XMLHttpRequest();
							xhr3.open("Get",
									"<c:url value='/product/searchgroup3' />",
									true);
							xhr3.send();
							xhr3.onreadystatechange = function() {
								if (xhr3.readyState == 4 && xhr3.status == 200) {
									house = JSON.parse(xhr3.responseText);

									var other = null;
									var xhr4 = new XMLHttpRequest();
									xhr4
											.open(
													"Get",
													"<c:url value='/product/searchgroup4' />",
													true);
									xhr4.send();
									xhr4.onreadystatechange = function() {
										if (xhr4.readyState == 4
												&& xhr4.status == 200) {
											other = JSON
													.parse(xhr4.responseText);

											var xArray = [ "其他種類", "食品",
													"家庭用品", "運動用品" ];
											var yArray = [ other, food, house,
													sport ];

											var layout = {
												title : "銷售類型佔比",
												height: 500,
												width: 600,
												font : {
													family : 'Courier New, monospace',
													size : 20
												}
											};

											var data = [ {
												labels : xArray,
												values : yArray,
												type : "pie"
											} ];

											Plotly.newPlot("myPlot", data,
													layout);

											console.log(food, sport, house,
													other)
										}
									}
								}
							}
						}
					}
				}
			}
		</script>

		<input type="button"
			onclick="location.href='http://localhost:8080/my-app/mainsearch'"
			value="主查詢" />

	</div>

</body>
</html>