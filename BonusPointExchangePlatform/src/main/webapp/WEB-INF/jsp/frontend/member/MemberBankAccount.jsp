<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.1.js"
	integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI="
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title></title>

<style>
#container {
	display: flex;
	display: -webkit-flex;
	flex-direction: row;
	flex-wrap: nowrap;
	justify-content: flex-start;
	align-items: flex-start;
	display: -webkit-flex;
}

.arrow-left {
	background-color: white;
	border-right: 1px 0px 1px 0px solid black;
	font-color: black;
	vertial-align: middle;
	display: inline-block;
	display: flex;
	content: "";
	margin-top: 5px;
}

.arrow-right {
	background-color: white;
	border-left: 1px 0px 1px 0px solid black;
	font-color: black;
	vertial-align: middle;
	display: inline-block;
	display: flex;
	content: "";
	margin-top: 5px;
}

.arrow-number {
	background-color: white;
	font-color: black;
	vertial-align: middle;
	display: inline-block;
	align: center;
	display: flex;
	content: "";
	margin-top: 5px;
	width: 35px;
}



</style>
<script type="text/javaScript">
//*************載入頁面後立刻觸發功能**********
window.onload = function() {
	var btn= document.getElementById("btn");
	var div1 = document.getElementById("resp");
	var value = document.getElementById("bank_amount");
	var showmessage = document.getElementById("showmessage");
	var showbank=document.getElementById("showbank");
	var xhr = new XMLHttpRequest();
	var showbydate= document.getElementById("showbydate");
	
	//**************選定日期按下查詢紅利點數全部紀錄**********
	showbydate.addEventListener('click', page1);
	
	
	
	
	
		
	

	
	

 	//**************載入頁面執行儲值金全部紀錄**********
	page();
	
 	
 	//**************載入紅利點數**********
 	bonusTotal();
	
	
	//**************儲值金跳分頁按鈕事件**********
	$("#page_ul li").click(function(){
		var pageNum=$(this).text();
		gotoPage(pageNum);
	});

	
	$("#page_prev").click(function(){
		if(currentPage==1){
		}else{
			gotoPage(--currentPage);
		}
	});
	
	$("#page_next").click(function(){
		if(currentPage==pageTotal){
		}else{
			gotoPage(++currentPage);
		}
	});	
	
	//**************紅利點數跳分頁按鈕事件**********
	
	$("#page_ul1 li").click(function() {
		var pageNum1 = $(this).text();
		gotoPage1(pageNum1);
	});

	$("#page_prev1").click(function() {
		if (currentPage1 == 1) {
		} else {
			gotoPage1(--currentPage1);
		}
	});

	$("#page_next1").click(function() {
		if (currentPage1 == pageTotal1) {
		} else {
			gotoPage1(++currentPage1);
		}
	});
	
	//**************紅利點數排序按鈕事件**********
	$("input[name=flexRadioDefault]").change(function() {
		orderby = $("input:radio:checked[name='flexRadioDefault']").val();
		
		var url = "<c:url value='/frontend/bonuslist'/>"
		date1=$("#date1").val();
		date2=$("#date2").val();
			var object={'account':{'id':2},
				'orderby':orderby,
				'selected':selected,
				'date1' :date1,
				'date2' :date2
			}
					
			var json=JSON.stringify(object);	
			console.log(json)


		$.ajax({

					url : url,
					method : 'post',
					data : json,
					contentType : 'application/json;charset=UTF-8',
					dataType : 'json',
					error : function() {
						alert("ajax error")
					},

					success : function(data) {
						if(data==null){
							$("#table1 tbody").append($("<h3 style='color:red;display: flex; justify-content: center;'>無相關紀錄</h3>"))
						}
						console.log(data)
						rowTotal1 = data.length;
						pageTotal1 = Math.ceil(rowTotal1 / pageSize1);
						currentPage1 = 1;
						if (pageTotal1 == 1) {
							$("#page_ul1").empty();
							$("#table1 tbody").empty();
							if(rowTotal1 == 0 ){
								$("#table1 tbody").append($("<tr><td style='align:center;color:red' colspan='7'>無相關紀錄</td><tr>"))
							}
							for (var i = 0; i < pageSize1; i++) {
									$("#table1 tbody")
											.append(
													$("<tr><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].wallet.id
															+ "</td><td>"
															+ data[i].name
															+ "</td><td>"
															+ data[i].wallet.source_type
															+ "</td><td>"
															+ data[i].wallet.bonus_point
															+ "</td><td>"
															+ data[i].usecardamount
															+ "</td><td>"
															+ data[i].gameName
															+ "</td><td>"
															+ data[i].create_at
															+ "</td></tr>"));
							}
						} else {
							$("#page_ul1").empty();
							$("#table1 tbody").empty();
							if(rowTotal1 == 0 ){
								$("#table1 tbody").append($("<tr><td style='align:center;color:red' colspan='7'>無相關紀錄</td><tr>"))
							}
							for (var i = 0; i < pageSize1; i++) {
								$("#table1 tbody")
								.append(
										$("<tr><td>"
												+ (i + 1)
												+ "</td><td style='display:none'>"
												+ data[i].wallet.id
												+ "</td><td>"
												+ data[i].name
												+ "</td><td>"
												+ data[i].wallet.source_type
												+ "</td><td>"
												+ data[i].wallet.bonus_point
												+ "</td><td>"
												+ data[i].usecardamount
												+ "</td><td>"
												+ data[i].gameName
												+ "</td><td>"
												+ data[i].create_at
												+ "</td></tr>"));
							}
							for (var i = 1; i < pageTotal1 + 1; i++) {
								$("#page_ul1")
										.append(
												$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"
														+ i
														+ "</span></button></li>"));

							}
							
							$("#page_ul1 li").click(function() {
								var pageNum1 = $(this).text();
								gotoPage1(pageNum1);
							});

						}

					}
				})
		
	});
	
	//**************紅利點數選項按鈕事件**********
	select = document.getElementById("select");
	select.addEventListener('change',function(e) {
		selected = $("#select").find(':selected').text();
		
		date1=$("#date1").val();
		date2=$("#date2").val();
		var url = "<c:url value='/frontend/bonuslist'/>"
			var object={'account':{'id':2},
				'orderby':orderby,
				'selected':selected,
				'date1' :date1,
				'date2' :date2
				
			}
			var json=JSON.stringify(object);	
			console.log(json)


		$.ajax({

					url : url,
					method : 'post',
					data : json,
					contentType : 'application/json;charset=UTF-8',
					dataType : 'json',
					error : function() {
						alert("ajax error")
					},

					success : function(data) {
						
						console.log(data)
						rowTotal1 = data.length;
						pageTotal1 = Math.ceil(rowTotal1 / pageSize1);
						currentPage1 = 1;
						console.log(rowTotal1)
						console.log(pageTotal1)
						if (pageTotal1 == 1) {
							$("#page_ul1").empty();
							$("#table1 tbody").empty();
							if(rowTotal1 == 0 ){
								$("#table1 tbody").append($("<tr><td style='align:center;color:red' colspan='7'>無相關紀錄</td><tr>"))
							}
							for (var i = 0; i < pageSize1; i++) {
									$("#table1 tbody")
											.append(
													$("<tr><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].wallet.id
															+ "</td><td>"
															+ data[i].name
															+ "</td><td>"
															+ data[i].wallet.source_type
															+ "</td><td>"
															+ data[i].wallet.bonus_point
															+ "</td><td>"
															+ data[i].usecardamount
															+ "</td><td>"
															+ data[i].gameName
															+ "</td><td>"
															+ data[i].create_at
															+ "</td></tr>"));
							}
						} else {
							$("#page_ul1").empty();
							$("#table1 tbody").empty();
							if(rowTotal1 == 0 ){
								$("#table1 tbody").append($("<tr><td style='align:center;color:red' colspan='7'>無相關紀錄</td><tr>"))
							}
							for (var i = 0; i < pageSize1; i++) {
								$("#table1 tbody")
								.append(
										$("<tr><td>"
												+ (i + 1)
												+ "</td><td style='display:none'>"
												+ data[i].wallet.id
												+ "</td><td>"
												+ data[i].name
												+ "</td><td>"
												+ data[i].wallet.source_type
												+ "</td><td>"
												+ data[i].wallet.bonus_point
												+ "</td><td>"
												+ data[i].usecardamount
												+ "</td><td>"
												+ data[i].gameName
												+ "</td><td>"
												+ data[i].create_at
												+ "</td></tr>"));
							}
 							
							for (var i = 1; i < pageTotal1 + 1; i++) {
								$("#page_ul1")
										.append(
												$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"
														+ i
														+ "</span></button></li>"));

							}
							$("#page_ul1 li").click(function() {
								var pageNum1 = $(this).text();
								gotoPage1(pageNum1);
							});

						}

					}
				})
	})
	//***********按鈕顯示/隱藏*************
	function Show_Hidden(showbank){
		 if(showbank.style.visibility=="visible") {
			 showmessage.value="顯示"
			 showbank.style.visibility='hidden';
		 }else{
			 showbank.style.visibility='visible';
			 showmessage.value="隱藏"
		 }
		}
	
	
		//*****輸入金額時隨時更新兌換儲值金金額及得到的紅利點數*******
		addEventListener('keyup',(event) => { 
			var bank_amount = document.getElementById("bank_amount").value;
			var wallet_amount = bank_amount;
			var bonus =bank_amount;
			var div3 = document.getElementById("resp2");
			var div4 = document.getElementById("resp3");
			div3.innerHTML = "<font color='red'>$ "+ wallet_amount +"</font>";
			div4.innerHTML = "<font color='red'>$ "+  bonus + "</font>";
		});
		
		
		//******************按下按鈕顯示銀行帳號資訊***************
		showmessage.onclick = function(){
			$("#showbank").empty();
			var url="<c:url value='/frontend/bank'/>"
			var obj = {
			'account':{'id':2}
			}
			var json=JSON.stringify(obj);
			console.log(json)
			$.ajax({
				url:url,
				method:'post',
				data:json,
				contentType:'application/json;charset=UTF-8',
				dataType:'json',
				error:function(){
					alert("ajax error")
				},
				
				success:function(data){
				console.log(data)
					
				var context1;
				if(data==null){
					context1="<h3 style='color:red'>無相關資料</h3>"
				}else{
				
				context1 = "<table class='table table-warning' style='height:50px;width:400px;border:2px solid black'>"
					 +"<tr><td style='border:2px solid black'>銀行名稱 :</td><td style='border:2px solid black'>"+data.name+"</td></tr><tr><td style='border:2px solid black'>銀行代碼 :</td><td style='border:2px solid black'>"+data.bank_code
					 +"</td></tr><tr><td style='border:2px solid black'>銀行帳戶 :</td><td style='border:2px solid black'>"+data.account_no+"</td></tr><tr><td style='border:2px solid black'>帳戶總額 :</td><td style='border:2px solid black'>"+data.amount+"</td></tr></table><br><br>"
				}
				
				showbank.innerHTML=context1;   

				Show_Hidden(showbank);
				return false;
				}

				
			})	
		
	}

	
}



// 	*********儲值金的變數***********
var pageTotal=0;
var rowTotal=0;
var currentPage=1;
var startRow=0;
var endRow=0;
var pageSize=5;
var x=0;


// 	*********紅利金的變數***********
var pageTotal1=0;
var rowTotal1=0;
var currentPage1=1;
var startRow1=0;
var endRow1=0;
var pageSize1=5;
var orderby = null;
var selected;
var date1;
var date2;









		
//	*********儲值金歷程的變數***********
function page(){
	var url = "<c:url value='/frontend/bankList'/>"
	var object={'account':{'id':2},
				"pagenumber":currentPage};
	var json=JSON.stringify(object);	
	console.log(json)
	
	$("#page_ul").empty();
	$.ajax({
		url:url,
		method:'post',
		data:json,
		contentType:'application/json;charset=UTF-8',
		dataType:'json',
		error:function(){
			alert("ajax error")
		},
		
		success:function(data){
			rowTotal=data.length;
			console.log(rowTotal)
			pageTotal=Math.ceil(rowTotal/pageSize);
			console.log(pageTotal)
			currentPage=1;
			$("#table tbody").empty();
		if(pageTotal==1){
			if(rowTotal == 0 ){
				$("#table tbody").append($("<tr><td style='align:center;color:red' colspan='7'>無相關紀錄</td><tr>"))
			}
				for(var i =0 ;i<pageSize;i++){
				$("#table tbody").append(
				$("<tr><td>"+(i+1)+"</td><td>" 
				+ data[i].name + "</td><td>"+ data[i].wallet_amount+"</td><td>"
			         + data[i].bonus + "</td><td>" +data[i].create_at+"</td></tr>")
			         
				);
			
			}
		}else{
			if(rowTotal == 0 ){
				$("#table tbody").append($("<tr><td style='align:center;color:red' colspan='7'>無相關紀錄</td><tr>"))
			}
			for(var i =0 ;i<pageSize;i++){
				$("#table tbody").append(
				$("<tr><td>"+(i+1)+"</td><td>" 
				+ data[i].name + "</td><td>"+  data[i].wallet_amount+"</td><td>"
			         +  data[i].bonus + "</td><td>" + data[i].create_at+"</td></tr>")
			         
				);
			}
		
			for(var i=1;i<pageTotal+1;i++){
				$("#page_ul").append(
						$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"+i+"</span></button></li>"));
			}
			
			$("#page_ul li").click(function(){
				var pageNum=$(this).text();
				gotoPage(pageNum);
			});
		
					
		
		}
		
		
		
		}
		
	})
}

//*********儲值金分頁按鈕跳頁***********
function gotoPage(pageNum){
	var url = "<c:url value='/frontend/bankList'/>"
	var object={'account':{'id':2},
					"pagenumber":currentPage};
	var json=JSON.stringify(object);	
	console.log(json)

	$.ajax({
		url:url,
		method:'post',
		data:json,
		contentType:'application/json;charset=UTF-8',
		dataType:'json',
		error:function(){
			alert("ajax error")
		},
		success:function(data){
			currentPage=pageNum;
			console.log(currentPage)
			startRow=pageSize*(pageNum-1);
			console.log(startRow)
			endRow=startRow+pageSize;
			console.log(endRow)
			endRow=(rowTotal>endRow)?endRow:rowTotal;
			$("#table tbody").empty();
		
			for(var i =startRow;i<endRow;i++){	
				$("#table tbody").append(
						$("<tr><td>"+(i+1)+"</td><td>" 
						+ data[i].name + "</td><td>"+data[i].wallet_amount+"</td><td>"
	 			         + data[i].bonus + "</td><td>" +data[i].create_at+"</td></tr>")
	 			 
						);
			}
		}
	});
}

//*********紅利點數分頁按鈕跳頁***********
function gotoPage1(pageNum1){
	date1=$("#date1").val();
	date2=$("#date2").val();
	var url = "<c:url value='/frontend/bonuslist'/>"
		var object={'account':{'id':2},
			'orderby':orderby,
			'selected':selected,
			'date1' :date1,
			'date2' :date2
		}		
		var json=JSON.stringify(object);	
		console.log(json)

	$.ajax({
		url:url,
		method:'post',
		data:json,
		contentType:'application/json;charset=UTF-8',
		dataType:'json',
		error:function(){
			alert("ajax error")
		},
		success:function(data){
			currentPage1=pageNum1;
			console.log(currentPage1)
			startRow1=pageSize1*(pageNum1-1);
			console.log(startRow1)
			endRow1=startRow1+pageSize1;
			console.log(endRow1)
			endRow1=(rowTotal1>endRow1)?endRow1:rowTotal1;
			$("#table1 tbody").empty();
		
			for(var i =startRow1;i<endRow1;i++){	
				$("#table1 tbody")
				.append(
						$("<tr><td>"
								+ (i + 1)
								+ "</td><td style='display:none'>"
								+ data[i].wallet.id
								+ "</td><td>"
								+ data[i].name
								+ "</td><td>"
								+ data[i].wallet.source_type
								+ "</td><td>"
								+ data[i].wallet.bonus_point
								+ "</td><td>"
								+ data[i].usecardamount
								+ "</td><td>"
								+ data[i].gameName
								+ "</td><td>"
								+ data[i].create_at
								+ "</td></tr>"));
			}
		}
	});
}

//**********儲值金兌換前做確認***********
function check(){
	var check = confirm("確定要兌換嗎?");
	
	if(check==true){
		newChange();
	}else{
		return false;
	}
	
}






//*********兌換儲值金***********
function newChange(){
	
	console.log(555)
		var value = document.getElementById("bank_amount").value;
		var url = "<c:url value='/edit/changeAmount'/>"
		var object={'account':{'id':2},
		"pagenumber":currentPage,
		"bank_amount":value};
		var json=JSON.stringify(object);	
		console.log(json)
		$.ajax({
		url:url,
		method:'post',
		data:json,
		contentType:'application/json;charset=UTF-8',
		dataType:'json',
		error:function(){
			alert("ajax error")
		},
		
		success:function(data){
			console.log(data);
			
		if(data[0]==null ){
			alert("兌換失敗 , 請確認銀行帳戶餘額")
		}else{
			console.log("22222222");
			rowTotal=data.length;
			console.log(rowTotal)
			pageTotal=Math.ceil(rowTotal/pageSize);
			console.log(pageTotal)
			currentPage=1;
			alert("兌換成功")
			$("#table tbody").empty();
		if(pageTotal==1){
			$("#page_ul").empty();
				for(var i =0 ;i<pageSize;i++){
				$("#table tbody").append(
				$("<tr><td>"+(i+1)+"</td><td>" 
				+ data[i].name + "</td><td>"+ data[i].wallet_amount+"</td><td>"
			         + data[i].bonus + "</td><td>" +data[i].create_at+"</td></tr>")
			         
				);
			
			}
		}else{
			$("#page_ul").empty();
			for(var i =0 ;i<pageSize;i++){
				$("#table tbody").append(
				$("<tr><td>"+(i+1)+"</td><td>" 
				+ data[i].name + "</td><td>"+  data[i].wallet_amount+"</td><td>"
			         +  data[i].bonus + "</td><td>" + data[i].create_at+"</td></tr>")
			         
				);
			}
		
			for(var i=1;i<pageTotal+1;i++){
				$("#page_ul").append(
						$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"+i+"</span></button></li>"));
			}
			
			$("#page_ul li").click(function(){
				var pageNum=$(this).text();
				gotoPage(pageNum);
			});
			
			
		
		}
		
		
		
		}
		window.location.reload();
		}
		
	})
}; 



//*********紅利金歷程的變數***********
function page1() {
	date1 = "";
	date2 = "";
	date1=$("#date1").val();
	date2=$("#date2").val();
	
	var url = "<c:url value='/frontend/bonuslist'/>"
		var object={'account':{'id':2},
			'orderby':orderby,
			'selected':selected,
			'date1' :date1,
			'date2' :date2
		}
				
		var json=JSON.stringify(object);	
		console.log(json)


	$.ajax({
				url : url,
				method : 'post',
				data : json,
				contentType : 'application/json;charset=UTF-8',
				dataType : 'json',
				error : function() {
					alert("ajax error")
				},

				success : function(data) {
					console.log(data)
					rowTotal1 = data.length;
					pageTotal1 = Math.ceil(rowTotal1 / pageSize1);
					currentPage1 = 1;
					if (pageTotal1 == 1) {
						$("#page_ul1").empty();
						$("#table1 tbody").empty();
						if(rowTotal1 == 0 ){
							$("#table1 tbody").append($("<tr><td style='align:center;color:red' colspan='7'>無相關紀錄</td><tr>"))
						}
						for (var i = 0; i < pageSize1; i++) {
								$("#table1 tbody")
										.append(
												$("<tr><td>"
														+ (i + 1)
														+ "</td><td style='display:none'>"
														+ data[i].wallet.id
														+ "</td><td>"
														+ data[i].name
														+ "</td><td>"
														+ data[i].wallet.source_type
														+ "</td><td>"
														+ data[i].wallet.bonus_point
														+ "</td><td>"
														+ data[i].usecardamount
														+ "</td><td>"
														+ data[i].gameName
														+ "</td><td>"
														+ data[i].create_at
														+ "</td></tr>"));
						}
					} else {
						$("#page_ul1").empty();
						$("#table1 tbody").empty();
						if(rowTotal1 == 0 ){
							$("#table1 tbody").append($("<tr><td style='align:center;color:red' colspan='7'>無相關紀錄</td><tr>"))
						}
						for (var i = 0; i < pageSize1; i++) {
							$("#table1 tbody")
							.append(
									$("<tr><td>"
											+ (i + 1)
											+ "</td><td style='display:none'>"
											+ data[i].wallet.id
											+ "</td><td>"
											+ data[i].name
											+ "</td><td>"
											+ data[i].wallet.source_type
											+ "</td><td>"
											+ data[i].wallet.bonus_point
											+ "</td><td>"
											+ data[i].usecardamount
											+ "</td><td>"
											+ data[i].gameName
											+ "</td><td>"
											+ data[i].create_at
											+ "</td></tr>"));
						}
						for (var i = 1; i < pageTotal1 + 1; i++) {
							$("#page_ul1")
									.append(
											$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"
													+ i
													+ "</span></button></li>"));

						}
						$("#page_ul1 li").click(function() {
							var pageNum1 = $(this).text();
							gotoPage1(pageNum1);
						});

					}

				}
			})
}

//**************顯示紅利點數加總**************

function bonusTotal(){
	$("#showbonus").empty();
	var url="<c:url value='/frontend/wallet'/>"
	var obj = {
	'account':{'id':2}
	}
	var json=JSON.stringify(obj);
	console.log(json)
	$.ajax({
		url:url,
		method:'post',
		data:json,
		contentType:'application/json;charset=UTF-8',
		dataType:'json',
		error:function(){
			alert("ajax error")
		},
		
		success:function(data){
		console.log(data)
		var context1;
		if(data.message!=null){
		context1= data.message;
		}else{
		context1 = data.bonusTotal;
		}
		
		$("#showbonus").attr("value",context1)   
		}

		
	})
}


</script>
</head>
<body>

	<jsp:include page="../../layout/Navbar.jsp"></jsp:include>
	<!--  Quote Request Start -->

	<!-- 		**************儲值金系統********** -->
	<div class="container-fluid my-5"
		style="background-color: #fff0ac; height: 500px">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-7 py-5 py-lg-0">
					<br>
					<h3 class="mb-4">
						您的銀行帳戶資訊 : <input type="button" id="showmessage" value="顯示" />
					</h3>

					<div class="mb-4" id="showbank"
						style="visibility: hidden; height: 200px"></div>
					<div class="row">
						<div class="col-sm-4">
							<h6 class="font-weight-bold mb-5">兌換儲值金:</h6>
							<h4 style="margin-top: -40px; height: 15px" id="resp2"
								class="text-primary mb-2" data-toggle="counter-up"></h4>
						</div>
						<div class="col-sm-4">
							<h6 class="font-weight-bold mb-5">將可獲得紅利點數:</h6>
							<h4 style="margin-top: -40px; height: 15px" id="resp3"
								class="text-primary mb-2" data-toggle="counter-up"></h4>
						</div>
					</div>
				</div>


				<div class="col-lg-5">
					<div class="bg-primary py-5 px-4 px-sm-5" style="height: 500px">
						<form class="py-5">
							<fieldset>
								<h1 style="display: flex; justify-content: center; color: white">儲值金兌換系統</h1>
								<br> <br>
								<h3 class="font-weight-bold mb-4">請輸入欲兌換的金額:</h3>
								<div class="form-group">
									<input id="bank_amount" type="text"
										class="form-control border-0 p-4" placeholder="$$$"
										required="required" />
								</div>
								<div
									style="display: flex; justify-content: center; margin-top: 30px">
									<button class="btn btn-dark btn-block border-0 py-3"
										type="button" id="btn" name="btn" 
										onclick="check();" >即刻兌換</button>
									<button style="margin-left: 10px"
										class="btn btn-dark btn-block border-0 py-3" type="button"
										id="btn1" name="btn" data-bs-toggle='modal'
										data-bs-target='#exampleModal' data-bs-whatever='@getbootstrap'>兌換紀錄查詢</button>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- 	<input type='button' value='編輯' class='btn btn-primary' data-bs-toggle='modal' data-bs-target='#exampleModal' data-bs-whatever='@getbootstrap' /> -->
	<div style="height: 600px" class="modal fade" id="exampleModal"
		data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #0066cc;">
					<h5 class="modal-title" id="exampleModalLabel" style="color: white">兌換紀錄瀏覽</h5>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>


				<div class="modal-body" style="text-align: center">
					<div class='table-responsive pt-3'>
						<table id="table" class='table table-bordered'>
							<thead>
								<tr>
									<th>#</th>
									<th>使用者</th>
									<th>儲值兌換金額</th>
									<th>獲得紅利點數</th>
									<th>兌換時間</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
				</div>
				<div class="modal-footer"
					style="display: flex; justify-content: center;">
					<div>
						<nav aria-label="Page navigation example"
							style="display: flex; justify-content: center;">
							<ul class="pagination navbar-center" style="margin: auto">
								<li class="page-item" id="page_prev"><button
										class="arrow-left">
										<span><<</span>
									</button></li>

								<li class="pagination" id="page_ul"></li>

								<li class="page-item" id="page_next"><button
										class="arrow-right">
										<span>>></span>
									</button></li>
							</ul>
						</nav>
					</div>

				</div>

			</div>
		</div>
	</div>


	<!-- 		**************紅利點數系統********** -->
	<div style="height: 600px">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-xl-6 col-lg-6 col-md-6">
					<div id="carouselExampleIndicators" class="carousel slide"
						data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleIndicators" data-slide-to="0"
								class="active"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner">
							<div class="carousel-item active" data-bs-interval="1000">
								<img src="img2/bonusphoto.png" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item">
								<img src="img2/bonusphoto.png" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item">
								<img src="img2/bonusphoto.png" src="..." class="d-block w-100"
									alt="...">
							</div>
						</div>
						<button class="carousel-control-prev" type="button"
							data-target="#carouselExampleIndicators" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-target="#carouselExampleIndicators" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</button>
					</div>
				</div>
				<div class="col-xl-5 col-lg-5 offset-lg-1 col-md-6">
					<div class="about_info">
						<div class="section_title mb-20px">
							<h1>您目前擁有的紅利 :</h1>
							<div>
								<input type="text"
									style="width: 200px; background-color: #e0e0e0; border-radius: 30px 30px 30px 30px;text-align:center"
									id="showbonus" value="" readonly>
							</div>
							<br> <br> <br>
							<h1>紅利紀錄查詢:</h1>
							<h6 style="font-size:14px; color:grey">( 無選取日期或選擇單個日期一律顯示全部 )</h6>
							<div id="container">
								<div style="width: 150px;">
									<span style="font-size: 20px; color: #c6a300">開始日期 :</span><input
										type="date" id="date1" name="date1" />
								</div>
								<div style="width: 150px; margin-left: 40px;">
									<span style="font-size: 20px; color: #c6a300">結束日期 :</span><input
										type="date" id="date2" name="date2" />
								</div>
								<div>
									<input
										style="margin-left: 20px; width: 60px; height: 60px; border-radius: 60px 60px 60px 60px;"
										type="button" class="btn btn-warning" data-bs-toggle='modal'
										data-bs-target='#exampleModal1' data-bs-whatever='@getbootstrap'
										value="查詢" id="showbydate"/>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- about_area_end -->

	<div style="height: 600px" class="modal fade" id="exampleModal1"
		data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document"
			style="text-align: center">
			<div class="modal-content" style="text-align: center">
				<div class="modal-header"
					style="background-color: #0066cc; text-align: center">
					<h5 class="modal-title" id="exampleModalLabel"
						style="color: white;">紅利獲得紀錄瀏覽</h5>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<br>
				<div
					style="justify-content: center; margin-left: 480px; width: 200px; height: 80px;">
					<select name="select" id="select">
						<option value="" disabled selected>依照獲取方式做查詢</option>
						<option value="1" id="1">儲值金兌換</option>
						<option value="2">活動獎勵</option>
						<option value="3">信用卡回饋</option>
						<option value="4">消費紀錄</option>
					</select>
					<div class="form-check" style="margin: 0 auto; width: 200px">
						<input style="text-align: right" class="form-check-input"
							type="radio" name="flexRadioDefault" id="flexRadioDefault1"
							value="DESC" checked> <label style="text-align: right"
							class="form-check-label" for="flexRadioDefault1">依最後編輯時間排序:
							新往舊</label>
					</div>

					<div class="form-check" style="margin: 0 auto; width: 200px">
						<input style="text-align: right" class="form-check-input"
							type="radio" name="flexRadioDefault" id="flexRadioDefault2"
							value="ASC"> <label style="text-align: right"
							class="form-check-label" for="flexRadioDefault2">依最後編輯時間排序:
							舊往新</label>
					</div>
				</div>
				<div class="modal-body" style="text-align: center">
					<div class='table-responsive pt-3'>
						<table id="table1" class='table table-bordered'>
							<thead>
								<tr>
									<th>#</th>
									<th>使用者</th>
									<th>獲得方式</th>
									<th>紅利點數</th>
									<th>刷卡金額</th>
									<th>參加活動</th>
									<th>取得日期</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
				</div>
				<div class="modal-footer"
					style="display: flex; justify-content: center;">
					<div>
						<nav aria-label="Page navigation example"
							style="display: flex; justify-content: center;">
							<ul class="pagination navbar-center" style="margin: auto">
								<li class="page-item" id="page_prev1"><button
										class="arrow-left">
										<span><<</span>
									</button></li>

								<li class="pagination" id="page_ul1"></li>

								<li class="page-item" id="page_next1"><button
										class="arrow-right">
										<span>>></span>
									</button></li>
							</ul>
						</nav>
					</div>

				</div>

			</div>
		</div>
	</div>

<script>

</script>
</body>

</html>