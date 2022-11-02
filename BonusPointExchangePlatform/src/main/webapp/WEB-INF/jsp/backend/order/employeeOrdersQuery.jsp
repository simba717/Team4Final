<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">
<title>訂單管理</title>

<!-- CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
 
<script>
	window.onload = function() {
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/getAllOrders.json' />", true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var content = "<table id='idtable' class='table table-bordered table-sm'>";
					content += "<thead><tr style='background-color: lightblue'><th>訂單號碼</th><th>總金額</th><th>會員</th>" 
							 + "<th>訂購時間</th><th>訂購狀態</th><th>明細</th></tr></thead>";
				var json = JSON.parse(xhr.responseText);				
				console.log(json);
				for (var i = 0; i < json.orders.length; i++) {
					content += "<tbody><tr><td>" + json.orders[i].orders.order_token + "</td>"
							+ "<td align='right'>" + json.orders[i].orders.sub_total + "</td>"
							+ "<td>" + json.orders[i].orders.member.name + "</td>" 
							+ "<td>" + json.orders[i].orders.update_at + "</td>" 
							+ "<td>" + json.orders[i].orders.order_status + "</td>"
							+ "<td><a class='btn btn-primary' data-id='"+i+"' role='button'>明細</a></td></tr></tbody>";
				}
				content += "</table>";
				var divs = document.getElementById("somedivS");
				divs.innerHTML = content;
				
				/*分隔線*/
				var divdetail = $("#detail");
				var divd = $("a.btn.btn-primary");
				
				divd.on("click",function(){
					var dataId = $(this).attr("data-id");
					console.log(dataId);
					
					var content1 = "<table id='idtable' class='table table-bordered table-sm'>";
						content1 += "<thead><tr style='background-color: lightblue'><th>品名</th><th>內容</th><th>數量</th><th>合計金額</th></tr></thead>";
												
						for(var i = 0; i < json.orders[dataId].orders.order_detail.length; i++){
							content1 += "<tbody><tr><td>" + json.orders[dataId].orders.order_detail[i].product_name + "</td>"
									 + "<td>" + json.orders[dataId].orders.order_detail[i].product_content + "</td>"
									 + "<td align='right'>" + json.orders[dataId].orders.order_detail[i].quantity + "</td>" 
									 + "<td align='right'>" + json.orders[dataId].orders.order_detail[i].total + "</td></tr></tbody>";	 
						}
						
						for(var i = 0; i < json.orders[dataId].orders.payment.length; i++){
							content1 += "<tfoot><tr><th style='background-color: lightyellow'>支付方式</th><td>" + json.orders[dataId].orders.payment[i].payment + "</td>";
							
							if(json.orders[dataId].orders.payment[i].payment == "紅利點數"){
								content1 += "<th style='background-color: lightyellow'>付款金額</th><td align='right'>" + (-json.orders[dataId].orders.payment[i].wallet.bonus_point) + "</td></tr>";	
							} else if(json.orders[dataId].orders.payment[i].payment == "儲值金"){
								content1 += "<th style='background-color: lightyellow'>付款金額</th><td align='right'>" + (-json.orders[dataId].orders.payment[i].wallet.wallet_amount) + "</td></tr>";
							} else{
								content1 += "<th style='background-color: lightyellow'>付款金額</th><td align='right'>" + (-json.orders[dataId].orders.payment[i].wallet.credit_card_amount) + "</td></tr>";
							}									  
						}						
						
						content1 += "</tfoot></table>";					
					divdetail.html(content1);					
				})
				
			}
			
		}
		
	}	
</script>
</head>
<body>
<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>	
<div align='center'>
	搜尋：<input type="text" name="query" id='query'>
	<input type='submit' id='queryData' value="查詢">	<br><br> 
	<div class='col-lg-12 grid-margin stretch-card'>
		<div class='card'>
			<div class='card-body'>				
   				<h2 class='card-title'>訂單資料總覽</h2>   				   				
   				<div class='table-responsive pt-3'>
					<div id='somedivS'></div>
					<hr>
					<div id='detail'></div>
				</div>
 			</div>
		</div>
	</div>		
</div>
<script>
document.getElementById("queryData").addEventListener('click', query);

function query() {
	$("#detail").empty();
	search = document.getElementById("query").value;
	var xhr1 = new XMLHttpRequest();
	let char = search.charAt(0);
	/*訂單號碼、訂購時間*/
	if(char >= 0 && char <= 9) {		
		xhr1.open("Get", "<c:url value='/orders/searchOrder=' />" + search , true);
		xhr1.send();
	} else {
		xhr1.open("Get", "<c:url value='/orders/searchMember=' />" + search , true);
		xhr1.send();
	}
	
	xhr1.onreadystatechange = function() {
		if (xhr1.readyState == 4 && xhr1.status == 200) {
			var content = "<table id='idtable' class='table table-bordered table-sm'>";
				content += "<thead><tr style='background-color: lightblue'><th>訂單號碼</th><th>總金額</th><th>會員</th>" 
						 + "<th>訂購時間</th><th>訂購狀態</th><th>明細</th></tr></thead>";
			var orders = JSON.parse(xhr1.responseText);
			console.log(orders)
			
			for(var i = 0; i < orders.orders.length; ++i) {
				content += "<tbody><tr><td>" + orders.orders[i].orders.order_token + "</td>"
				+ "<td align='right'>" + orders.orders[i].orders.sub_total + "</td>"
				+ "<td>" + orders.orders[i].orders.member.name + "</td>" 
				+ "<td>" + orders.orders[i].orders.update_at + "</td>" 
				+ "<td>" + orders.orders[i].orders.order_status + "</td>"
				+ "<td><a class='btn btn-primary' data-id='"+i+"' role='button'>明細</a></td></tr></tbody>";
			}
			
			content += "</table>";
			var divs = document.getElementById("somedivS");
			divs.innerHTML = content;
			
			/*分隔線*/
			var divdetail = $("#detail");
			var divd = $("a.btn.btn-primary");
			
			divd.on("click",function(){
				var dataId = $(this).attr("data-id");
				console.log(dataId);
				
				var content1 = "<table id='idtable' class='table table-bordered table-sm'>";
					content1 += "<thead><tr style='background-color: lightblue'><th>品名</th><th>內容</th><th>數量</th><th>合計金額</th></tr></thead>";
											
					for(var i = 0; i < orders.orders[dataId].orders.order_detail.length; i++){
						content1 += "<tbody><tr><td>" + orders.orders[dataId].orders.order_detail[i].product_name + "</td>"
								 + "<td>" + orders.orders[dataId].orders.order_detail[i].product_content + "</td>"
								 + "<td align='right'>" + orders.orders[dataId].orders.order_detail[i].quantity + "</td>" 
								 + "<td align='right'>" + orders.orders[dataId].orders.order_detail[i].total + "</td></tr></tbody>";	 
					}
					
					for(var i = 0; i < orders.orders[dataId].orders.payment.length; i++){
						content1 += "<tfoot><tr><th style='background-color: lightyellow'>支付方式</th><td>" + orders.orders[dataId].orders.payment[i].payment + "</td>";
						
						if(orders.orders[dataId].orders.payment[i].payment == "紅利點數"){
							content1 += "<th style='background-color: lightyellow'>付款金額</th><td align='right'>" + (-orders.orders[dataId].orders.payment[i].wallet.bonus_point) + "</td></tr>";	
						} else if(orders.orders[dataId].orders.payment[i].payment == "儲值金"){
							content1 += "<th style='background-color: lightyellow'>付款金額</th><td align='right'>" + (-orders.orders[dataId].orders.payment[i].wallet.wallet_amount) + "</td></tr>";
						} else{
							content1 += "<th style='background-color: lightyellow'>付款金額</th><td align='right'>" + (-orders.orders[dataId].orders.payment[i].wallet.credit_card_amount) + "</td></tr>";
						}									  
					}						
					
					content1 += "</tfoot></table>";					
				divdetail.html(content1);
			})
			
		}
	}
	
}
</script>
</body>
</html>