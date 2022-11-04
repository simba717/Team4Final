<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<title>showProduct</title>
</head>
<body>
<jsp:include page="../../layout/Navbar.jsp"></jsp:include>


<!-- 商品 -->
<section class="food_section layout_padding-bottom">
        <div class="container">
            <div class="heading_container heading_center">
                <h2>
                    商城
                </h2>
            </div>

            <ul class="filters_menu">
                <li class="active" data-filter="*">全部</li>
                <li data-filter=".houseitem">家庭用品</li>
                <li data-filter=".fooditem">食品</li>
                <li data-filter=".sportitem">運動用品</li>
                <li data-filter=".other">其他種類</li>
            </ul>

            <div class="filters-content">
                <div class="row grid" id='dataArea'>
                &nbsp;
                </div>
            </div>
            <div class="btn-box">
                <a href="https://tw.yahoo.com/">
                    YAYAYAYAYAYA
                </a>
            </div>
        </div>
    </section>


<!-- modal -->
<div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">商品資料</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id='dataArea2'>
                    &nbsp;
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal" id="orderList">下訂單子</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">關閉</button>
                </div>
            </div>
        </div>
 </div>
 
 <!-- toast -->
 <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <img src="${contextRoot}/img2/2.jpg" style="height: 50px;width: 50px;" class="rounded me-2">
                <strong class="me-auto">通知</strong>
                <small>1秒前</small>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                你已下訂了一筆單子
            </div>
        </div>
    </div>
    <div id="membercheck" class="visually-hidden">${member}</div>
    
<script>

 
window.onload = function(){	
	let xhr = new XMLHttpRequest();
    xhr.open('GET', "<c:url value='/product/findAllFrontend' />", true);
    xhr.send();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            dataArea.innerHTML = displayData(xhr.responseText);
//          isotope用法用class分類
            $('.filters_menu li').click(function () {
                $('.filters_menu li').removeClass('active');
                $(this).addClass('active');
                var data = $(this).attr('data-filter');
                $grid.isotope({
                    filter: data
                })
            });
//          isotope用法
            var $grid = $(".grid").isotope({
                itemSelector: ".all",
                percentPosition: false,
                masonry: {
                    columnWidth: ".all"
                }
            })
            $("#dataArea a").click(function(){
            	let xhr2 = new XMLHttpRequest();
            	var queryString = $(this).attr("name")
                xhr2.open('GET', "<c:url value='/product/findOne/' />"+queryString, true);
                xhr2.send();
                xhr2.onreadystatechange = function () {
                    if (xhr2.readyState == 4 && xhr2.status == 200) {
                        dataArea2.innerHTML = displayData2(xhr2.responseText); 
                    }
                }
            })
        }
    }
}

function displayData(data) {
    var htmlSeg = "";
    var list = JSON.parse(data);
    if (list.length > 0) {
        for (var i in list) {
        	if(list[i].product_type=="houseitem"){
        		htmlSeg += `<div class="col-sm-6 col-lg-3 all houseitem">`
        	}else if(list[i].product_type=="fooditem"){
        		htmlSeg += `<div class="col-sm-6 col-lg-3 all fooditem">`
        	}else if(list[i].product_type=="sportitem"){
        		htmlSeg += `<div class="col-sm-6 col-lg-3 all sportitem">`
        	}else{
        		htmlSeg += `<div class="col-sm-6 col-lg-3 all other">`
        	}
        	
            htmlSeg +=
        `<div class="box">
            <div>
                <div class="img-box">`+
                `<a name=`+list[i].id+` data-bs-toggle="modal" data-bs-target="#productModal" ><img src=`+"${pageContext.request.contextPath}/product/downloadImage/"+list[i].id+" />" +"</a>"
                +`</div>
                <div class="detail-box">
                    <h5 style="color: blue;">`+
                    list[i].product_name
                    +`</h5>
                    <p style="color: red;">`+
                    list[i].product_content
                    +`</p>
                    <div class="options">
                        <h6>`+
                        "$"+list[i].price
                        +`</h6>
                        <a name=`+list[i].id+` data-bs-toggle="modal" data-bs-target="#productModal">
                            <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg"
                                xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029"
                                style="enable-background:new 0 0 456.029 456.029;" xml:space="preserve">
                                <g>
                                    <g>
                                        <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
             c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                                    </g>
                                </g>
                                <g>
                                    <g>
                                        <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
             C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
             c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
             C457.728,97.71,450.56,86.958,439.296,84.91z" />
                                    </g>
                                </g>
                                <g>
                                    <g>
                                        <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
             c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                                    </g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                                <g>
                                </g>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>`
        }
    } else {
        htmlSeg += `<p style="color: red;">查無資料</p>`
    }
    
    return htmlSeg;
}

function displayData2(data) {
    var htmlSeg = "";  
    if (data!=null) {
    	var one = JSON.parse(data);
            htmlSeg += `<img width="100px" src=`+"${pageContext.request.contextPath}/product/downloadImage/"+one.id+` class="rounded mx-auto d-block"/>`
            htmlSeg += `<ul class="list-group list-group-flush">`
            htmlSeg += `<li class="list-group-item visually-hidden">商品編號: <span>`+one.id+`</span></li>`
            htmlSeg += `<li class="list-group-item">商品名字: <span>`+one.product_name+`</span></li>`
            htmlSeg += `<li class="list-group-item">商品內容: <span>`+one.product_content+`</span></li>`
            htmlSeg += `<li class="list-group-item">商品種類: <span>`+one.product_type+`</span></li>`
            htmlSeg += `<li class="list-group-item">商品價格: <span>`+one.price+`</span></li>`
            htmlSeg += `<li class="list-group-item">商品庫存: <span>`+(one.quantity-one.best_seller)+`</span></li>`
            htmlSeg += `<li class="list-group-item">下訂數量: <select class="form-select form-select-sm"
                        style="width:auto;height:auto;display: inline;" aria-label=".form-select-sm example">`
            for(let j = 0;j < (one.quantity-one.best_seller);j++){
            	htmlSeg += `<option value=`+(j+1)+">"+(j+1)+`</option>`	
            }
            htmlSeg += `</select></li></ul>`
    } else {
        htmlSeg += `<p style="color: red;">查無資料</p>`
    }
    return htmlSeg;
}

//取得下單值，並且按下下單鍵做購物車Ajax
$("#orderList").click(function(){
	if($("#membercheck").text()==""){
		window.location.href="${contextRoot}/login";
		return ;
	}
	
	console.log($(":selected").eq(0).val());
	console.log($("#dataArea2 li>span").eq(0).text())
	var orderId = $("#dataArea2 li>span").eq(0).text();
	var orderName = $("#dataArea2 li>span").eq(1).text();
	var orderContent = $("#dataArea2 li>span").eq(2).text();
	var orderType = $("#dataArea2 li>span").eq(3).text();
	var orderPrice = $("#dataArea2 li>span").eq(4).text();
	var orderQuantity = $("#dataArea2 li>span").eq(5).text();
	var orderNumber = $(":selected").eq(0).val();
	let obj = {
			'orderNumber': orderNumber,
			'product':{
				'id': orderId,
				'product_name': orderName,	
				'product_content': orderContent,	
				'product_type': orderType,
				'price': orderPrice,
				'quantity': orderQuantity
			}		
		};
	let json = JSON.stringify(obj);
	let xhr3 = new XMLHttpRequest();
    xhr3.open('POST', "<c:url value='/product/FrontendOrdersListDto' />", true);
    xhr3.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr3.send(json);
    xhr3.onreadystatechange = function() {
    	if (xhr3.readyState == 4 && xhr3.status == 200) {
    		orderListContent.innerHTML = displayData3(xhr3.responseText);
    	}
    }
    
    
    var obj2= "";
    
    if($(".rounded-pill").text()==""){
    	obj2 = 1;
    }else{
    	let inform = parseInt($(".rounded-pill").text());
    	obj2 = inform+1;
    }
    
    console.log(obj2);
    let json2 = JSON.stringify(obj2);
    
    let xhr4 = new XMLHttpRequest();
    xhr4.open('POST', "<c:url value="/product/pillSession" />", true);
	xhr4.send(json2);
	xhr4.onreadystatechange = function() {
		if (xhr4.readyState == 4 && xhr4.status == 200) {
			if($(".rounded-pill").text()==""){
		 		$(".rounded-pill").text("1");
		 	}else{
		 		let inform = parseInt($(".rounded-pill").text());
		 		$(".rounded-pill").text(inform+1);
		 	}
		}
	}
})

function displayData3(data) {
	var htmlSeg = "";
	var listorder = JSON.parse(data);
    if (listorder.length > 0) {
    	for (var k in listorder){
    		htmlSeg += `<div class="container p-0 m-0">`
    		htmlSeg += `<a href=`+"${pageContext.request.contextPath}/product/pillSessionClear"+` class="list-group-item list-group-item-action m-0 p-0">`;
    		htmlSeg += `<img src=`+"${pageContext.request.contextPath}/product/downloadImage/"+listorder[k].product.id+` style="width:100px;height: 124px;" class=" rounded mx-auto pt-4">`;
    		htmlSeg += `<ul class="list-group list-group-flush float-end pt-4 fst-italic" style="width: 250px;">`;
    		htmlSeg += `<li class="list-group-item">商品名字: <span>`+listorder[k].product.product_name+`</span></li>`;
    		htmlSeg += `<li class="list-group-item">訂購數量: <span>`+listorder[k].orderNumber+`</span></li>`;
    		htmlSeg += `</ul>`;
    		htmlSeg += `</a></div>`;
    		htmlSeg += `<div class="dropdown-divider p-0 m-0"></div>`;
    	}
    }else{
		htmlSeg += `<div><img src="${contextRoot}/img2/54.png" style="width:200px;height:200px;" class="rounded mx-auto d-block"></div>`;
		htmlSeg += `<div class="dropdown-divider"></div>`;
		htmlSeg += `<p class="fst-italic text-center align-middle fs-4">無商品訂購</p>`;
	}
    return htmlSeg;
}


// toast
var toastTrigger = document.getElementById('orderList')
var toastLiveExample = document.getElementById('liveToast')
if (toastTrigger) {
    toastTrigger.addEventListener('click', function () {
        var toast = new bootstrap.Toast(toastLiveExample)

        toast.show()
    })
}

</script>
</body>
</html>