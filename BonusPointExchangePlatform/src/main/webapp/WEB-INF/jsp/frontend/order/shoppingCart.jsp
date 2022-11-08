<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shoppingCart</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<style>
 #showshow{
            font-weight: bold !important;
            font-family: Microsoft JhengHei !important;
    }
</style>
</head>
<body>
<jsp:include page="../../layout/Navbar.jsp"></jsp:include>

<div id="showshow" class="container-fluid" style="background-image:url(${contextRoot}/img2/haobacking.png) ;background-repeat: repeat-y;"></div>

<form  id="checkId" action="orders/checkoutCreditCard" method="post" enctype="multipart/form-data" class="visually-hidden">
<input type="text" name="sendBonus" id="sendBonus" />
<input type="text" name="sendWallet" id="sendWallet" />
<input type="text" name="sendCreditCard" id="sendCreditCard" />
<input type="submit" value="提交" >
</form>

<form  id="checkId2" action="orders/checkoutWallet" method="post" enctype="multipart/form-data" class="visually-hidden">
<input type="text" name="sendBonus2" id="sendBonus2" />
<input type="text" name="sendWallet2" id="sendWallet2" />
<input type="text" name="sendCreditCard2" id="sendCreditCard2" />
<input type="submit" value="提交" >
</form>
<jsp:include page="../../layout/footer.jsp"></jsp:include>
<script >
var remainingBonus = 0;
var remainingWallet = 0;
var bonusCheck = 0 ;
var re = /^\d{1,7}00$/;
var re2 = /^\d{1,9}$/;
var needPaid ;
var needPaid2 ;
window.onload = function(){
	let xhr = new XMLHttpRequest();
    xhr.open('GET', "<c:url value='/product/FrontendOrderDetailList' />", true);
    xhr.send();
    xhr.onreadystatechange = function () {
    	if (xhr.readyState == 4 && xhr.status == 200) {
    		showshow.innerHTML = displayData(xhr.responseText);
    		$(document).on("click","#dividend",function(){
    			//紅利checkbox判斷
                if ($(this).prop("checked")) {
                    $("#dividendValue").removeAttr("disabled")
                    bonusCheck = 2;
                } else {
                    $("#surplusDividend").addClass("invisible")
                    $("#dividendValue").attr("disabled", "disabled").val("")
                    $("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1)))
                    bonusCheck = 0 ;
                }
            })
//     		$("#dividend").click(function () {
//     			//紅利checkbox判斷
//                 if ($(this).prop("checked")) {
//                     $("#dividendValue").removeAttr("disabled")
//                 } else {
//                     $("#surplusDividend").addClass("invisible")
//                     $("#dividendValue").attr("disabled", "disabled").val("")
//                 }
//             })
            //紅利讀值
            $(document).on("blur","#dividendValue",function(){
            	$("#surplusDividend").removeClass("invisible")
                if (re.test($(this).val())) {   
                	if(parseInt($("#dividendValue").val())>parseInt(remainingBonus)){
                		$("#surplusDividend").css("color", "red").text("紅利點數餘額不足");
                		$("#surplusAmount").addClass("invisible")
                		bonusCheck = 2;
                	}else if((parseInt($("#dividendValue").val())/100)>=parseInt($("#totalPrice").text().substring(1))){
                		$("#dividendValue").val(parseInt($("#totalPrice").text().substring(1))*100)
                		$("#surplusDividend").css("color", "red").text("超過限制自動轉換，點數餘額:"+(remainingBonus-$("#dividendValue").val()));
                		$("#paymentAmount").val(0)
                		if($("#selectPayment :selected").val() == 1 ||$("#selectPayment :selected").val() == 2){
                			$("#surplusAmount").removeClass("invisible").css("color", "black").text("儲值金餘額:"+(remainingWallet-$("#paymentAmount").val()))
                		}
                		bonusCheck = 4;
                    }else{
                    	$("#surplusDividend").css("color", "black").text("紅利點數餘額:"+(remainingBonus-$("#dividendValue").val()));
                        bonusCheck = 1;
                        if ($("#selectPayment :selected").val() == 1) {
                        	needPaid = parseInt($("#dividendValue").val())/100;
                			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1))-needPaid)
                            $("#surplusAmount").addClass("invisible")
                            bonusCheck = 4;
                		} else if ($("#selectPayment :selected").val() == 2) {
                			needPaid = parseInt($("#dividendValue").val())/100;
                			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1))-needPaid)
                			if($("#paymentAmount").val()>remainingWallet){
                				$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
                				bonusCheck = 3;
                			}else{
                				$("#surplusAmount").removeClass("invisible").css("color", "black").text("儲值金餘額:"+(remainingWallet-$("#paymentAmount").val()))
                				bonusCheck = 4;
                			}
                		}
                    }
                }
                else {
                    if ($(this).val() == "") {
                        $("#surplusDividend").css("color", "red").text("不可為空白");
                    } else if (parseInt($(this).val()) > 999999999) {
                        $("#surplusDividend").css("color", "red").text("不可超過9位數");
                    } else if (re2.test($(this).val())) {
                        $("#surplusDividend").css("color", "red").text("單位以一百為基準");
                    } else {
                    	$("#surplusDividend").css("color", "red").text("請輸入數字");
                    }
                    bonusCheck = 2;
                }
            })
//             $("#dividendValue").blur(function () {
//                 $("#surplusDividend").removeClass("invisible")
//                 if (re.test($(this).val())) {   
//                 	if(parseInt($("#dividendValue").val())>parseInt(remainingBonus)){
//                 		$("#surplusDividend").css("color", "red").text("紅利點數餘額不足");
//                 		$("#surplusAmount").addClass("invisible")
//                 		bonusCheck = 2;
//                 	}else if((parseInt($("#dividendValue").val())/100)>parseInt($("#totalPrice").text().substring(1))){
//                 		$("#dividendValue").val(parseInt($("#totalPrice").text().substring(1))*100)
//                 		$("#surplusDividend").css("color", "red").text("超過限制自動轉換，點數餘額:"+(remainingBonus-$("#dividendValue").val()));
//                 		bonusCheck = 1;
//                     }else{
//                     	$("#surplusDividend").css("color", "black").text("紅利點數餘額:"+(remainingBonus-$("#dividendValue").val()));
//                         bonusCheck = 1;
//                         if ($("#selectPayment :selected").val() == 1) {
//                         	needPaid = parseInt($("#dividendValue").val())/100;
//                 			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1))-needPaid)
//                             $("#surplusAmount").addClass("invisible")
//                 		} else if ($("#selectPayment :selected").val() == 2) {
//                 			needPaid = parseInt($("#dividendValue").val())/100;
//                 			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1))-needPaid)
//                 			if($("#paymentAmount").val()>remainingWallet){
//                 				$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
//                 				bonusCheck = 3;
//                 			}else{
//                 				$("#surplusAmount").removeClass("invisible").css("color", "black").text("儲值金餘額:"+(remainingWallet-$("#paymentAmount").val()))
//                 			}
//                 		}
//                     }
//                 }
//                 else {
//                     if ($(this).val() == "") {
//                         $("#surplusDividend").css("color", "red").text("不可為空白");
//                     } else if (parseInt($(this).val()) > 999999999) {
//                         $("#surplusDividend").css("color", "red").text("不可超過9位數");
//                     } else if (re2.test($(this).val())) {
//                         $("#surplusDividend").css("color", "red").text("單位以一百為基準");
//                     } else {
//                     	$("#surplusDividend").css("color", "red").text("請輸入數字");
//                     }
//                     bonusCheck = 2;
//                 }
//             })
            //信用卡和儲蓄金讀值
            $(document).on("click change","#selectPayment",function(){ 
            	console.log(bonusCheck)
            	if(bonusCheck==3){
            		$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
            		if($("#selectPayment :selected").val() == 1){
            			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1)))
            			$("#surplusAmount").addClass("invisible")
            			bonusCheck = 0;
            		}
            		return;
            	}
            	if(bonusCheck==2){
            		$("#surplusDividend").css("color", "red").text("紅利格式輸入錯誤請重新輸入");
            		return;
            	}
            	if(bonusCheck==1 || bonusCheck==4){
            		bonusCheck = 4;
            		needPaid2 = parseInt($("#dividendValue").val())/100;
            		console.log(needPaid2)
            		if ($("#selectPayment :selected").val() == 1) {
            			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1))-needPaid2)
                        $("#surplusAmount").addClass("invisible")
            		} else if ($("#selectPayment :selected").val() == 2) {
            			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1))-needPaid2)
            			if($("#paymentAmount").val()>remainingWallet){
            				$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
            				bonusCheck = 3;
            			}else{
            				$("#surplusAmount").removeClass("invisible").css("color", "black").text("儲值金餘額:"+(remainingWallet-$("#paymentAmount").val()))
            			}
            		}
            	}
            	if(bonusCheck==0){
            		bonusCheck = 0;
            		if ($("#selectPayment :selected").val() == 1) {
            			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1)))
                        $("#surplusAmount").addClass("invisible")
            		} else if ($("#selectPayment :selected").val() == 2) {
            			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1)))
            			if($("#paymentAmount").val()>remainingWallet){
            				$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
            				bonusCheck = 3;
            			}else{
            				$("#surplusAmount").removeClass("invisible").css("color", "black").text("儲值金餘額:"+(remainingWallet-$("#paymentAmount").val()))
            			}
            		}
            	}
            })
//             $("#selectPayment").on("blur change", function () {
//             	var needPaid2 ;
//             	if(bonusCheck==3){
//             		$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
//             		return;
//             	}
//             	if(bonusCheck==2){
//             		$("#surplusDividend").css("color", "red").text("紅利格式輸入錯誤請重新輸入");
//             		return;
//             	}
//             	if(bonusCheck==1){
//             		needPaid2 = parseInt($("#dividendValue").val())/100;
//             		console.log(needPaid2)
//             		if ($("#selectPayment :selected").val() == 1) {
//             			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1))-needPaid2)
//                         $("#surplusAmount").addClass("invisible")
//             		} else if ($("#selectPayment :selected").val() == 2) {
//             			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1))-needPaid2)
//             			if($("#paymentAmount").val()>remainingWallet){
//             				$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
//             				bonusCheck = 3;
//             			}else{
//             				$("#surplusAmount").removeClass("invisible").css("color", "black").text("儲值金餘額:"+(remainingWallet-$("#paymentAmount").val()))
//             			}
//             		}
//             	}
//             	if(bonusCheck==0){
//             		if ($("#selectPayment :selected").val() == 1) {
//             			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1)))
//                         $("#surplusAmount").addClass("invisible")
//             		} else if ($("#selectPayment :selected").val() == 2) {
//             			$("#paymentAmount").val(parseInt($("#totalPrice").text().substring(1)))
//             			if($("#paymentAmount").val()>remainingWallet){
//             				$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
//             				bonusCheck = 3;
//             			}else{
//             				$("#surplusAmount").removeClass("invisible").css("color", "black").text("儲值金餘額:"+(remainingWallet-$("#paymentAmount").val()))
//             			}
//             		}
//             	}
//             })
            //訂單數量修改
            $(document).on("change  keyup","input[type='number']",function(){
            	let quantity = $(this).val()
            	console.log(quantity);
            	console.log($(this).attr("max"));
            	console.log($(this).next("span").text())
            	let productName = $(this).closest("li").prevAll("li").eq(2).text().substring(5)
            	console.log(productName)
            	$(this).next("span").addClass("visually-hidden")
            	let maxchoose = $(this).attr("max");
            	let obj = { 
            				'product_name': productName,	
            				'quantity': quantity	
            		};
            	let json = JSON.stringify(obj);
            	console.log(json)
            	let obj2 = { 
            				'product_name': productName,	
            				'quantity': maxchoose	
            		};
            	let json2 = JSON.stringify(obj2);
                if(parseInt($(this).val())>parseInt($(this).attr("max"))){
                	$(this).val(maxchoose);
                	$(this).next("span").removeClass("visually-hidden")
                	let xhr2 = new XMLHttpRequest();
                	xhr2.open('POST', "<c:url value='/orderDetail/updateNumber' />", true);
                    xhr2.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
                    xhr2.send(json2);
                    xhr2.onreadystatechange = function() {
                    	if (xhr2.readyState == 4 && xhr2.status == 200) {
                    		showshow.innerHTML = displayData(xhr2.responseText);
                    	}
                    }
                }else{
                	let xhr2 = new XMLHttpRequest();
                	xhr2.open('POST', "<c:url value='/orderDetail/updateNumber' />", true);
                    xhr2.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
                    xhr2.send(json);
                    xhr2.onreadystatechange = function() {
                    	if (xhr2.readyState == 4 && xhr2.status == 200) {
                    		console.log($(this));
                    		showshow.innerHTML = displayData(xhr2.responseText);
                    	}
                    }
                }
            })
//             $("input[type='number']").on("change  keyup", function () {
//             	let quantity = $(this).val()
//             	console.log(quantity);
//             	console.log($(this).attr("max"));
//             	console.log($(this).next("span").text())
//             	let productName = $(this).closest("li").prevAll("li").eq(2).text().substring(5)
//             	console.log(productName)
//             	$(this).next("span").addClass("visually-hidden")
//             	let maxchoose = $(this).attr("max");
//             	let obj = { 
//             				'product_name': productName,	
//             				'quantity': quantity	
//             		};
//             	let json = JSON.stringify(obj);
//             	console.log(json)
//             	let obj2 = { 
//             				'product_name': productName,	
//             				'quantity': maxchoose	
//             		};
//             	let json2 = JSON.stringify(obj2);
//                 if(parseInt($(this).val())>parseInt($(this).attr("max"))){
//                 	$(this).val(maxchoose);
//                 	$(this).next("span").removeClass("visually-hidden")
//                 	let xhr2 = new XMLHttpRequest();
//                 	xhr2.open('POST', "<c:url value='/orderDetail/updateNumber' />", true);
//                     xhr2.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
//                     xhr2.send(json2);
//                     xhr2.onreadystatechange = function() {
//                     	if (xhr2.readyState == 4 && xhr2.status == 200) {
//                     		showshow.innerHTML = displayData(xhr2.responseText);
//                     	}
//                     }
//                 }else{
//                 	let xhr2 = new XMLHttpRequest();
//                 	xhr2.open('POST', "<c:url value='/orderDetail/updateNumber' />", true);
//                     xhr2.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
//                     xhr2.send(json);
//                     xhr2.onreadystatechange = function() {
//                     	if (xhr2.readyState == 4 && xhr2.status == 200) {
//                     		console.log($(this));
//                     		showshow.innerHTML = displayData(xhr2.responseText);
//                     	}
//                     }
//                 }
//             })
            //刪除按鈕
            $(document).on("click",".deleteOrderDetail",function(){
            	console.log($(this).attr("id"));
            	console.log($(this).attr("id").substring(12));
            	var queryString = $(this).attr("id").substring(12);
            	Swal.fire({
                    title: "確定要刪除訂單嗎",
                    color: "#FF0000",
                    showCancelButton: true,
                    confirmButtonText: '確定',
                    confirmButtonColor: "#4EFEB3"
                }).then((result) => {
                    if (result.isConfirmed) {
                        Swal.fire('成功刪除', '', 'success')
                        let xhr3 = new XMLHttpRequest();
                        xhr3.open('GET', "<c:url value='/orderDetail/deleteOrderDetail/' />"+queryString , true);
                        xhr3.send();
                        xhr3.onreadystatechange = function () {
                        	if (xhr3.readyState == 4 && xhr3.status == 200) {
                        		showshow.innerHTML = displayData(xhr3.responseText);
                        	}
                        }   
                    } 
                })            	
            })
//             $(".deleteOrderDetail").click(function(){
//             	if (!confirm("確定要刪除嗎")) {
//                     return
//                 }
//             	console.log($(this).attr("id"));
//             	console.log($(this).attr("id").substring(12));
//             	var queryString = $(this).attr("id").substring(12);
//             	let xhr3 = new XMLHttpRequest();
//                 xhr3.open('GET', "<c:url value='/orderDetail/deleteOrderDetail/' />"+queryString , true);
//                 xhr3.send();
//                 xhr3.onreadystatechange = function () {
//                 	if (xhr3.readyState == 4 && xhr3.status == 200) {
//                 		console.log("成功")
//                 	}
//                 }
//             })
            $(document).on("click",'#checkoutButton',function(){
            	if(parseInt($("#totalPrice").text().substring(1))==0){
            		$("#surplusAmount").removeClass("invisible").css("color", "red").text("還沒有下單任何訂單")
            		return;
            	}
            	if(bonusCheck==2){
            		$("#surplusDividend").css("color", "red").text("紅利點數格式錯誤或點數不足");
            		return;
            	}else if(bonusCheck==3){
            		$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
            		return;
            	}else if(bonusCheck==4||bonusCheck==0){
            		if (!$(this).prop("checked") && $("#selectPayment :selected").val()==""){
            			$("#surplusAmount").removeClass("invisible").css("color", "red").text("請選擇使用付款方法")
            			return
            		}
            		var paidWallet = $("#paymentAmount").val();
            		var paidcreditCard = $("#paymentAmount").val();
            		var paidBonus;
            		if ($("#dividend").prop("checked")){
            			paidBonus = $("#dividendValue").val();
            		}else{
            			paidBonus = 0
            		}
            		if($("#paymentAmount").val()==0){
            			$("#sendBonus2").val(paidBonus);
            			$("#sendWallet2").val(0);
            			$("#sendCreditCard2").val(0)
                		checkout2();
            		}else if($("#selectPayment :selected").val() == 1){
            			$("#sendBonus").val(paidBonus);
            			$("#sendWallet").val(0);
            			$("#sendCreditCard").val(paidcreditCard)
                		checkout();
            		}else if($("#selectPayment :selected").val() == 2){
            			$("#sendBonus2").val(paidBonus);
            			$("#sendWallet2").val(paidWallet);
            			$("#sendCreditCard2").val(0)
                		checkout2();
            		}
            	}else{
            		$("#surplusAmount").removeClass("invisible").css("color", "red").text("紅利扣除完後尚有餘額請選擇付款方式")
            	}
            })
            
//             $("#checkoutButton").click(function(){
//             	if(bonusCheck==2){
//             		$("#surplusDividend").css("color", "red").text("紅利點數格式錯誤或點數不足");
//             		return;
//             	}else if(bonusCheck==3){
//             		$("#surplusAmount").removeClass("invisible").css("color", "red").text("儲值金不足請用信用卡或是調整訂單")
//             		return;
//             	}else{
//             		var paidWallet = $("#paymentAmount").val();
//             		var paidcreditCard = $("#paymentAmount").val();
//             		var paidBonus;
//             		if ($(this).prop("checked")){
//             			paidBonus = $("#dividendValue").val();
//             		}else{
//             			paidBonus = 0
//             		}
//             		if($("#selectPayment :selected").val() == 1){
//             			$("#sendBonus").val(paidBonus);
//             			$("#sendWallet").val(0);
//             			$("#sendCreditCard").val(paidcreditCard)
//                 		checkout();
//             		}else if($("#selectPayment :selected").val() == 2){
//             			$("#sendBonus").val(paidBonus);
//             			$("#sendWallet").val(paidWallet);
//             			$("#sendCreditCard").val(0)
//                 		checkout();
//             		}
//             	}
//             })
    	}
    }
}

function displayData(data) {
	var htmlSeg = "";
	var totalPrice = 0;
	if (data==null){
		htmlSeg += `<h1><font color="red">查無資料</h1>`
			return htmlSeg;
	}
    var order = JSON.parse(data);
    remainingBonus = order.remainingBonus;
    remainingWallet = order.remainingWallet;
    if (order != null) {
    	if(order.orders.order_detail.length ==0){
    		htmlSeg += `<div class="col-12 g-0 align-middle">`;
    		htmlSeg += `<img src="${contextRoot}/img2/58.png" class="rounded mx-auto d-block" style="width:450px;height:450px">`
    		htmlSeg +=	`</div>`;
    	}
    	for(var i in order.orders.order_detail){
    	htmlSeg += `<div class="row">`;
    	htmlSeg += `<div class="col-5 g-0">`;
    	htmlSeg += `<img src=`+"${pageContext.request.contextPath}/product/downloadImage/"+order.productList[i].id+` class="rounded mx-auto d-block me-0" style="height: 230px;width:230px;">`;
    	htmlSeg += `</div>`;
    	htmlSeg += `<div class="col-5 g-0 align-middle">`;
    	htmlSeg += `<ul class="list-group list-group-flush g-0 ">`;
    	htmlSeg += `<li class="list-group-item d-inline-block" style="line-height:2.2em;height:2.2em">商品名字:`+order.orders.order_detail[i].product_name+`</li>`;
    	htmlSeg += `<li class="list-group-item d-inline-block" style="line-height:2.2em;height:2.2em">商品內容:`+order.orders.order_detail[i].product_content+`</li>`;
    	htmlSeg += `<li class="list-group-item d-inline-block" style="line-height:2.2em;height:2.2em">商品單價:`+order.productList[i].price+`</li>`;
    	htmlSeg += `<li class="list-group-item d-inline-block" style="line-height:2.2em;height:2.2em">商品數量:`;
    	htmlSeg += `<input type="number" class="form-control number ms-0 pb-0 mb-0 g-0" style="width:80px;display: inline;border-style:none;background-color:transparent" min="1" max=`+(order.productList[i].quantity-order.productList[i].best_seller+order.orders.order_detail[i].quantity)+` value=`+order.orders.order_detail[i].quantity+`>`;
    	htmlSeg += `<span class="visually-hidden" style="color: red;">超過此商品庫存上限</span></li>`;
    	htmlSeg += `<li class="list-group-item d-inline-block" style="line-height:2.2em;height:2.2em">總共價格:`+order.orders.order_detail[i].total+`</li>`;
    	htmlSeg += `<li class="list-group-item d-inline-block" style="line-height:2.2em;height:2.2em"><a id=`+"deletebutton"+order.orders.order_detail[i].id+` class="btn btn-danger me-2 deleteOrderDetail">刪除商品</a></li>`;
    	htmlSeg += `</ul>`;
    	htmlSeg += `</div>`;
    	htmlSeg += `</div>`;
    	totalPrice += parseInt(order.orders.order_detail[i].total);
    	}
    }else{
		htmlSeg += `<h1><font color="red">查無資料</h1>`
	}
    htmlSeg += `<hr>`;
	htmlSeg += `<div class="row justify-content-center">`;
	htmlSeg += `<div class="col-3 d-flex justify-content-center">合計</div>`;
	htmlSeg += `<div class="col-3 d-flex justify-content-center" id="totalPrice">$`+totalPrice+`</div>`;
	htmlSeg += `</div>`;
	htmlSeg += `<div class="row justify-content-center mt-2">`;
	htmlSeg += `<div class="col-6 d-flex justify-content-start">付款方式</div>`;
	htmlSeg += `</div>`;
	htmlSeg += `<div class="row justify-content-center ">`;
	htmlSeg += `<div class="col-3 d-flex justify-content-start">`;
	htmlSeg += `<div class="input-group">`;
	htmlSeg += `<div class="input-group-text"><input class="form-check-input mt-0" type="checkbox" value="紅利" id="dividend" aria-label="Checkbox for following text input">紅利</div>`;
	htmlSeg += `<input type="text" class="form-control" id="dividendValue" aria-label="Text input with checkbox" disabled>`;
	htmlSeg += `</div></div>`;
	htmlSeg += `<div class="col-3 d-inline-flex justify-content-center align-items-center invisible" id="surplusDividend">紅利點數餘額:`+remainingBonus+`</div>`;
	htmlSeg += `</div>`;
	htmlSeg += `<div class="row justify-content-center mt-1">`;
	htmlSeg += `<div class="col-3 d-flex justify-content-center">`;
	htmlSeg += `<select class="form-select d-inline" id="selectPayment" aria-label="Default select example">
		          <option value="" style="display:none ;">請選擇付款方式</option>
                  <option value="1">信用卡</option>
                  <option value="2">儲值金</option>
                </select>`;
	htmlSeg += `<div class="input-group flex-nowrap">`;
	htmlSeg += `<input id="paymentAmount" type="text" class="form-control" placeholder="需付金額" aria-label="需付金額" aria-describedby="addon-wrapping" readonly value="" style="background-color: rgb(214, 212, 212);">`;
	htmlSeg += `</div></div>`;
	htmlSeg += `<div class="col-3 d-flex justify-content-center invisible" id="surplusAmount">儲值金餘額:`+remainingWallet+`</div>`;
	htmlSeg += `</div>`;
	htmlSeg += `<div class="row justify-content-center mt-4">`;
	htmlSeg += `<div class="col-6 d-flex justify-content-end"><a id="backButton" class="btn btn-info me-3" href="${contextRoot}/showProduct">返回</a><a id="checkoutButton" class="btn btn-success me-5">結帳</a></div>`;
	htmlSeg += `</div>`;
	htmlSeg += `<br>`;
	htmlSeg += `<br>`;
	htmlSeg += `<br>`;
    return htmlSeg;
}


function checkout(){
	Swal.fire({
        title: "確定要用信用卡嗎",
        color: "#FF0000",
        showCancelButton: true,
        confirmButtonText: '確定',
        confirmButtonColor: "#4EFEB3"
    }).then((result) => {
    	if (result.isConfirmed) {
    	$("#checkId").submit()
    	}
    })
}


function checkout2(){
	Swal.fire({
        title: "確定支付方法嗎",
        color: "#FF0000",
        showCancelButton: true,
        confirmButtonText: '確定',
        confirmButtonColor: "#4EFEB3"
    }).then((result) => {
    	if (result.isConfirmed) {
        	$("#checkId2").submit()
        	}
    })
}
</script>
</body>
</html>