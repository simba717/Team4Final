<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<title>商品管理</title>
<script>
var inputFileToLoad = null;
var fileDataURL = null;
var result = null;
var imageURL = "<c:url value='/getProductImage' />";
var controlURL = "<c:url value='/product/control' />";
var editURL = "<c:url value='/product/edit/' />";
var deleteURL = "<c:url value='/product/delete' />";
	window.onload = function() {
		var insertContent = function(xhrResponseText,page) {
			var products = JSON.parse(xhrResponseText).content;
 			console.log(products)
			var content = "<table id='idtable' class='table table-bordered'>";
			content += "<thead><tr style='background-color: lightblue'><th>#</th><th>照片</th><th>品名</th><th>內容物</th>" 
					+ "<th>類別</th><th>單價</th><th>庫存總數</th><th>熱銷數</th><th>商品狀態</th><th>編輯人</th>"
					+ "<th>建立時間</th><th>最後編輯時間</th><th>商品控制</th><th>編輯</th><th>刪除</th></tr></thead>";
					
			for (var i = 0; i < products.length; i++) {
				products[i].product = products[i];
			}
			
			for (var i = 0; i < products.length; i++) {					
				id = i + 1 + (5 * (page - 1));
				if(products[i].product.best_seller == products[i].product.quantity) {
					content += "<tbody><tr style='background-color:lightgray'><td align='center'>" + id + "</td>";
				} else {
					content += "<tbody><tr><td align='center'>" + id + "</td>";
				}					
				content += "<td align='center'><img width='40' height='48'" + " src='" + imageURL + "?id=" + products[i].product.id + "'></td>"
						+ "<td>" + products[i].product.product_name + "</td>"
						+ "<td>" + products[i].product.product_content + "</td>"
						+ "<td>" + products[i].product.product_type + "</td>" 
						+ "<td align='right'>"	+ products[i].product.price + "</td>" 
						+ "<td align='right'>" + products[i].product.quantity + "</td>"
						+ "<td align='right'>" + products[i].product.best_seller + "</td>";						
									
				if(products[i].product.button_switch == false) {						
					if(products[i].product.best_seller == products[i].product.quantity) {
						content += "<td style='font-weight: bold'>已完售</td>"
								+  "<td>" + products[i].employee.employee_no + "</td>"
								+  "<td>" + products[i].product.create_at + "</td>"
								+  "<td>" + products[i].product.updateDate + "</td>"
								+  "<td width='10.3%'><a style='visibility:hidden' class='btn btn-primary' role='button'>上架</a>"
								+  "<a style='visibility:hidden' class='btn btn-warning' role='button'>下架</a>"
								+  "<a class='btn btn-secondary' role='button' aria-disabled='true'>關閉</a></td>"
								+  "<td></td>"
								+  "<td></td></tr></tbody>";
					} else {
						content += "<td style='color: red; font-weight: bold'>已下架</td>"
								+  "<td>" + products[i].employee.employee_no + "</td>"
								+  "<td>" + products[i].product.create_at + "</td>"
								+  "<td>" + products[i].product.updateDate + "</td>"
								+  "<td width='10.3%'><a href='" + controlURL + "?id=" + products[i].product.id + "&button_switch=true' class='btn btn-primary' role='button'>上架</a>"
								+  "<a style='visibility:hidden' class='btn btn-warning' role='button'>下架</a></td>"									
								+  "<td><input id='" + products[i].product.id + "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-success' data-bs-toggle='modal' data-bs-target='#edit' data-bs-whatever='@getbootstrap'></button></td>"
								+  "<td><a onclick='confirm("+products[i].product.id+")' class='btn btn-danger' role='button'>刪除</a></td></tr></tbody>";
					}				
				} else {
					content += "<td style='color: green; font-weight: bold'>販售中</td>"
							+  "<td>" + products[i].employee.employee_no + "</td>"
							+  "<td>" + products[i].product.create_at + "</td>"
							+  "<td>" + products[i].product.updateDate + "</td>"
							+  "<td width='10.3%'><a style='visibility:hidden' class='btn btn-primary' role='button'>上架</a>"
							+  "<a href='" + controlURL + "?id=" + products[i].product.id + "&button_switch=false' class='btn btn-warning' role='button'>下架</a></td>"
							+  "<td></td>"
							+  "<td></td></tr></tbody>";																
				}							
			}
			content += "</table>";
			
			var divs = document.getElementById("somedivS");
			divs.innerHTML = content;
			
			var page = JSON.parse(xhrResponseText);
			var pageNum = document.getElementById("pagebtn");
			content = "<a data-id='1' class='btn btn-outline-dark'><<</a>";
			for(var i = 0; i < page.totalPages; i++) {
				content += "<a data-id='"+(i+1)+"' class='btn btn-outline-dark'>"+(i+1)+"</a>";
			}
			content += "<a data-id='"+page.totalPages+"' class='btn btn-outline-dark'>>></a>";
			pageNum.innerHTML = content;
		}
		
		var goPage = function(x) {
			var xhr = new XMLHttpRequest();
			xhr.open("GET", "<c:url value='/getAllProductsPages.json' />" + "?p=" + x, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					insertContent(xhr.responseText,x);
				}
			}
		}
		goPage(1);
		$("body").on("click","a.btn.btn-outline-dark",function() {
			goPage($(this).attr("data-id"));
		});	
	}
	
	function confirm(id){
		Swal.fire({
			icon: 'question',
			title:'請問是否要刪除？',
			color: "#7373b9",
			showCancelButton: true,
			cancelButtonText:"取消",
			cancelButtonColor: "#FF0000",
			confirmButtonText: '確定',
			confirmButtonColor: "#0000e3"
		}).then((result) => {
			if (result.isConfirmed) {				
				Swal.fire('刪除成功', '', 'success').then((result) => {
					window.location.href = deleteURL+"?id="+id;
				})
			}			
		})		
	}
	
	
	/*商品資料編輯*/
	function getindex(node) {
		index = $(node).attr('id');
		var url = "<c:url value='/product'/>";
		var obj = {
				'id' : index
			}
		var json = JSON.stringify(obj);
		var imageurl = "data:image/jpeg;base64,";
		
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
		   		$("#id").attr("value", data.id);
		    	$("#product_name").attr("value", data.product_name);
		    	$("#product_content").attr("value", data.product_content);
		    	$("#product_type option[value="+data.product_type+"]").attr('selected', 'selected');
		    	$("#price").attr("value", data.price);
		    	$("#quantity").attr("value", data.quantity);
		    	$("#preview_img").attr("src", "data:image/jpg;base64," + data.image);
		    	
		    	document.getElementById("product_name").addEventListener("blur", checkProduct_Name);
		    	document.getElementById("product_content").addEventListener("blur", checkProduct_Content);
		    	document.getElementById("product_type").addEventListener("blur", checkProduct_Type);
		    	document.getElementById("price").addEventListener("blur", checkPrice);
		    	document.getElementById("quantity").addEventListener("blur", checkQuantity);
		    	inputFileToLoad = document.getElementById("inputFileToLoad");
		    	inputFileToLoad.addEventListener('change', loadImageFileAsURL);
		    	updateData = document.getElementById("updateData");
		    	updateData.addEventListener('click', updateData);
		    	
		    	updateData.onclick = function() {
		    		// 讀取欄位資料	  
		    		var divResult = document.getElementById('resultMsg');
		    		var idValue = document.getElementById("id").value;
		    		var product_nameValue = document.getElementById("product_name").value;
		    		var product_contentValue = document.getElementById("product_content").value;
		    		var product_typeValue = document.getElementById("product_type").value;
		    		var priceValue = document.getElementById("price").value;
		    		var quantityValue = document.getElementById("quantity").value;
		    		let msg1 = document.getElementById("msg1");
		    		let msg2 = document.getElementById("msg2");
		    		let msg3 = document.getElementById("msg3");
		    		let msg4 = document.getElementById("msg4");
		    		let msg5 = document.getElementById("msg5");
		    		let v1 = document.querySelector('#product_name');
		    		let v2 = document.querySelector('#product_content');
		    		let v3 = document.querySelector('#product_type');
		    		let v4 = document.querySelector('#price');
		    		let v5 = document.querySelector('#quantity');
		    		let msg01 = document.querySelector('#msg1');
		    		let msg02 = document.querySelector('#msg2');
		    		let msg03 = document.querySelector('#msg3');
		    		let msg04 = document.querySelector('#msg4');
		    		let msg05 = document.querySelector('#msg5');
		    		let flag1 = true, flag2 = true, flag3 = true, flag4 = true, flag5 = true;
		    		
		    		if (product_nameValue == "") {
		    			v1.classList.remove('is-valid');
		    	    	v1.classList.add('is-invalid');
		    	    	msg01.classList.add('invalid-feedback');
		    			msg1.innerHTML = "(不可空白)";
		    			flag1 = false;
		    		} else {
		    			v1.classList.remove('is-invalid');
		            	v1.classList.add('is-valid');
		    		}
		    		
		    		if (product_contentValue == "") {
		    			v2.classList.remove('is-valid');
		    	    	v2.classList.add('is-invalid');
		    	    	msg02.classList.add('invalid-feedback');
		    			msg2.innerHTML = "(不可空白)";
		    			flag2 = false;
		    		} else {
		    			v2.classList.remove('is-invalid');
		            	v2.classList.add('is-valid');
		    		}
		    		
		    		if (product_typeValue == "") {
		    			v3.classList.remove('is-valid');
		    	    	v3.classList.add('is-invalid');
		    	    	msg03.classList.add('invalid-feedback');
		    			msg3.innerHTML = "(請選擇商品種類)";
		    			flag3 = false;
		    		} else {
		    			v3.classList.remove('is-invalid');
		            	v3.classList.add('is-valid');
		    		}
		    		
		    		if (priceValue == "") {
		    			v4.classList.remove('is-valid');
		    	    	v4.classList.add('is-invalid');
		    	    	msg04.classList.add('invalid-feedback');
		    			msg4.innerHTML = "(不可空白)";
		    			flag4 = false;
		    		} else if (priceValue <= 0) {
		    			v4.classList.remove('is-valid');
		    	    	v4.classList.add('is-invalid');
		    	    	msg04.classList.add('invalid-feedback');
		    			msg4.innerHTML = "(不可小於1)";
		    			flag4 = false;
		    		} else if (priceValue > 1000000000) {
		    			v4.classList.remove('is-valid');
		    	    	v4.classList.add('is-invalid');
		    	    	msg04.classList.add('invalid-feedback');
		    			msg4.innerHTML = "(超過上限1000000000)";
		    			flag4 = false;
		    		} else {
		    			v4.classList.remove('is-invalid');
		            	v4.classList.add('is-valid');
		    		}
		    		
		    		if (quantityValue == "") {
		    			v5.classList.remove('is-valid');
		    	    	v5.classList.add('is-invalid');
		    	    	msg05.classList.add('invalid-feedback');
		    			msg5.innerHTML = "(不可空白)";
		    			flag5 = false;
		    		} else if (quantityValue <= 0) {
		    			v5.classList.remove('is-valid');
		    	    	v5.classList.add('is-invalid');
		    	    	msg05.classList.add('invalid-feedback');
		    			msg5.innerHTML = "(不可小於1)";
		    			flag5 = false;
		    		} else if (quantityValue > 1000000000) {
		    			v5.classList.remove('is-valid');
		    	    	v5.classList.add('is-invalid');
		    	    	msg05.classList.add('invalid-feedback');
		    			msg5.innerHTML = "(超過上限1000000000)";
		    			flag5 = false;
		    		} else {
		    			v5.classList.remove('is-invalid');
		            	v5.classList.add('is-valid');
		    		}
		    		
		    		
		    		if (flag1 && flag2 && flag3 && flag4 && flag5) {
		    			Swal.fire({
		    				icon: 'success',
		    				title:'更新成功',
		    				color: "#7373b9",		    				
		    				confirmButtonText: '確定',
		    				confirmButtonColor: "#0000e3"
		    			}).then((result) => {
		    				window.location.href = "../product/findAll";
		    			})
		    			
		    			var xhr1 = new XMLHttpRequest();
		    			xhr1.open("PUT", "<c:url value='/products/' />" + data.id, true);
		    			var jsonProduct = {		
		    				'fileDataUrl': fileDataURL,
		    				'product':{
		    					'product_name': product_nameValue,	
		    					'product_content': product_contentValue,	
		    					'product_type': product_typeValue,
		    					'price': priceValue,
		    					'quantity': quantityValue
		    				}
		    			}
		    			xhr1.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		    			xhr1.send(JSON.stringify(jsonProduct));
		    			console.log(JSON.stringify(jsonProduct));
		    			console.log(fileDataURL);
		    			
		    			xhr1.onreadystatechange = function() {
		    				// 伺服器請求完成
		    				if (xhr1.readyState == 4 && (xhr1.status == 200 || xhr1.status == 201) ) {
		    		  			result = JSON.parse(xhr1.responseText);
		    		  			if (result.fail) {
		    			 			divResult.innerHTML = "<font color='red' >"	+ result.fail + "</font>";
		    		  			} else {
		    						divResult.innerHTML = "<font color='GREEN'>" + result.success + "</font>";
		    		  			}
		    				}
		    			}
		    		}			
		    	}
		    	
		    	function checkProduct_Name() {
		    		let v = document.querySelector('#product_name');
		    		let product_name = document.getElementById("product_name");
		    	    let product_nameValue = product_name.value;
		    	    let msg = document.querySelector('#msg1');
		    	    let msg1 = document.getElementById("msg1");    
		    	    let product_nameLen = product_nameValue.length;
		    	    let flag1 = false, flag2 = true;
		    	    if (product_nameLen == "") {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg1.innerHTML = "(不可空白)";
		    	    } else if (product_nameLen >= 1 && product_nameLen <= 20) {
		    	        for (let i = 0; i < product_nameLen; i++) {
		    	            let char = product_nameValue.charAt(i);
		    	            if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
		    	                flag1 = true;
		    	            } else {
		    	                flag2 = false;
		    	                break;
		    	            }
		    	        }
		    	        if (flag1 && flag2) {
		    	        	v.classList.remove('is-invalid');
		    	        	v.classList.add('is-valid');
		    	        	msg1.innerHTML = "";
		    	        	result = msg1.innerHTML;
		    	        } else {
		    	        	v.classList.remove('is-valid');
		    	        	v.classList.add('is-invalid');
		    	        	msg.classList.add('invalid-feedback');
		    	        	msg1.innerHTML = "(名稱必須為中文、英文、數字)";
		    	        }
		    	    } else {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg1.innerHTML = "(名稱字數限制20)";
		    	    }
		    	}

		    	function checkProduct_Content() {
		    		let v = document.querySelector('#product_content');
		    	    let product_content = document.getElementById("product_content");
		    	    let product_contentValue = product_content.value;
		    	    let msg = document.querySelector('#msg2');
		    	    let msg2 = document.getElementById("msg2");
		    	    let product_contentLen = product_contentValue.length;
		    	    let flag1 = false, flag2 = true;
		    	    if (product_contentLen == "") {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg2.innerHTML = "(不可空白)";
		    	    } else if (product_contentLen >= 1 && product_contentLen <= 50) {
		    	        for (let i = 0; i < product_contentLen; i++) {
		    	            let char = product_contentValue.charAt(i);
		    	            if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
		    	                flag1 = true;
		    	            } else {
		    	                flag2 = false;
		    	                break;
		    	            }
		    	        }
		    	        if (flag1 && flag2) {
		    	        	v.classList.remove('is-invalid');
		    	        	v.classList.add('is-valid');
		    	        	msg2.innerHTML = "";
		    	        } else {
		    	        	v.classList.remove('is-valid');
		    	        	v.classList.add('is-invalid');
		    	        	msg.classList.add('invalid-feedback');
		    	        	msg2.innerHTML = "(名稱必須為中文、英文、數字)";
		    	        }
		    	    } else {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg2.innerHTML = "(名稱字數限制50)";
		    	    }
		    	}

		    	function checkProduct_Type() {
		    		let v = document.querySelector('#product_type');
		    	    let product_type = document.getElementById("product_type");
		    	    let product_typeValue = product_type.value;
		    	    let msg = document.querySelector('#msg3');
		    	    let msg3 = document.getElementById("msg3")
		    	    
		    	    if (product_typeValue == "") {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg3.innerHTML = "(請選擇商品種類)";
		    	    } else {
		    	    	v.classList.remove('is-invalid');
		    	    	v.classList.add('is-valid');
		    	    	msg3.innerHTML = "";
		    	    }
		    	}

		    	function checkPrice() {
		    		let v = document.querySelector('#price');
		    	    let price = document.getElementById("price");
		    	    let priceValue = price.value;
		    	    let msg = document.querySelector('#msg4');
		    	    let msg4 = document.getElementById("msg4")
		    	    
		    	    if (priceValue == "") {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg4.innerHTML = "(不可空白)";
		    	    } else if (priceValue <= 0) {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg4.innerHTML = "(不可小於1)";
		    	    } else if (priceValue > 0 && priceValue <= 1000000000) {
		    	    	v.classList.remove('is-invalid');
		    	    	v.classList.add('is-valid');
		    	    	msg4.innerHTML = "";
		    	    } else {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg4.innerHTML = "(超過上限1000000000)";
		    	    }
		    	}

		    	function checkQuantity() {
		    		let v = document.querySelector('#quantity');
		    	    let quantity = document.getElementById("quantity");
		    	    let quantityValue = quantity.value;
		    	    let msg = document.querySelector('#msg5');
		    	    let msg5 = document.getElementById("msg5")
		    	    
		    	    if (quantityValue == "") {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg5.innerHTML = "(不可空白)";
		    	    } else if (quantityValue <= 0) {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg5.innerHTML = "(不可小於1)";
		    	    } else if (quantityValue > 0 && quantityValue <= 1000000000) {
		    	    	v.classList.remove('is-invalid');
		    	    	v.classList.add('is-valid');
		    	    	msg5.innerHTML = "";
		    	    } else {
		    	    	v.classList.remove('is-valid');
		    	    	v.classList.add('is-invalid');
		    	    	msg.classList.add('invalid-feedback');
		    	    	msg5.innerHTML = "(超過上限1000000000)";
		    	    }
		    	}
		    	
		    	function loadImageFileAsURL(){
		    	    let filesSelected = document.getElementById("inputFileToLoad").files;
		    	    if (filesSelected.length > 0)
		    	    {
		    	        let fileToLoad = filesSelected[0];		
		    	        let fileReader = new FileReader();
		    	        fileReader.onload = function(fileLoadedEvent) 
		    	        {
		    	        	fileDataURL = fileLoadedEvent.target.result;
		    	            console.log("product_name=" + fileLoadedEvent.product_name);
		    	            console.log("type=" + fileLoadedEvent.type );
		    	            console.log(fileDataURL);
		    	        };

		    	        fileReader.readAsDataURL(fileToLoad);
		    	    }
		    	}
		    	
		    }
	    })
    }

</script>
</head>
<body>
<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>
<div align='center'>
	商品搜尋：<input type="text" name="query" id='query' placeholder='品名、內容物、類別'>
	<input type='submit' id='queryData' value="查詢">	<br><br> 
	<div class='col-lg-12 grid-margin stretch-card'>
		<div class='card'>
			<div class='card-body'>				
   				<h2 class='card-title'>商品資料總覽</h2>
   				<div id='pagebtn'></div>
				<div style="margin-right: 2000px; margin-top: -50px; width: 200px">
					<button class='btn btn-info' style='font-size:15pt' data-bs-toggle='modal' data-bs-target='#create' data-bs-whatever='@getbootstrap'>+ 商品新增</button>					
				</div>   				
   				<div class='table-responsive pt-3'>
					<div id='somedivS'></div>
				</div>
 			</div>
		</div>
	</div>		
</div>

<div class="modal fade" id="create" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">商品資料新增</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form class="forms-sample" novalidate>
					<div class="form-group">
						<label for="exampleInputName1">商品名稱</label>
						<input type="text" class="form-control" id="product_name1" required>
						<span id="msg01"></span>					
					</div>
					<div class="form-group">
						<label for="exampleInputEmail3">商品內容</label>
						<input type="text" class="form-control" id="product_content1" required>
						<span id="msg02"></span>
					</div>
					<div class="form-group">
						<label for="exampleInputPassword4">商品類別</label>
						<select class="form-select" id="product_type1" required>
							<option selected disabled value="">請選擇</option>
				      		<option value="家庭用品">家庭用品</option>
				      		<option value="食品">食品</option>
				      		<option value="運動用品">運動用品</option>
				      		<option value="其他種類">其他種類</option>
				    	</select>
				    	<span id="msg03"></span>
					</div>			
					<div class="form-group">
						<label for="exampleInputCity1">單價</label>
						<input type="number" class="form-control" id="price1" value="0" required>
						<span id="msg04"></span>
					</div>
					<div class="form-group">
						<label for="exampleInputCity1">庫存數量</label>
						<input type="number" class="form-control" id="quantity1" value="0" required>
						<span id="msg05"></span>
					</div>					
					<div class="form-group">
						<label>商品照片</label><br>
						<input id="inputFileToLoad1" type="file" name="image1" class="form-control" accept="image/jpg,image/jpeg,image/png,image/gif" required>
						<span id="msg06"></span>					
					</div><br>
					<img id="preview_img1" src="/my-app/img/default.png" style="height: 300px; width: 300px;border-radius:60px 60px 60px 60px ;margin-left:50px">
				</form>
			</div>
			<div class="modal-footer">
				<button id="auto" class="btn btn-secondary" onclick="inputValue()" style="margin-left:20px">自動輸入</button>
				<input type="submit" id="submitdata" onclick="checkValue()" class="btn btn-primary me-2" style="margin-left:130px" value="新增" >
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="edit" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">商品資料編輯</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form class="forms-sample" novalidate>      
					<input type="hidden" name="id" id='id'>
					<div class="form-group">
						<label for="exampleInputName1">商品名稱</label>
						<input type="text" class="form-control" id="product_name" required>
						<span id="msg1"></span>					
					</div>
					<div class="form-group">
						<label for="exampleInputEmail3">商品內容</label>
						<input type="text" class="form-control" id="product_content" required>
						<span id="msg2"></span>
					</div>
					<div class="form-group">
						<label for="exampleInputPassword4">商品類別</label>
						<select class="form-select" id="product_type" required>
				      		<option value="家庭用品">家庭用品</option>
				      		<option value="食品">食品</option>
				      		<option value="運動用品">運動用品</option>
				      		<option value="其他種類">其他種類</option>
				    	</select>
				    	<span id="msg3"></span>
					</div>			
					<div class="form-group">
						<label for="exampleInputCity1">單價</label>
						<input type="number" class="form-control" id="price" value="0" required>
						<span id="msg4"></span>
					</div>
					<div class="form-group">
						<label for="exampleInputCity1">庫存數量</label>
						<input type="number" class="form-control" id="quantity" value="0" required>
						<span id="msg5"></span>
					</div>					
					<div class="form-group">
						<label>商品照片</label><br>
						<input id="inputFileToLoad" type="file" name="image" class="form-control" accept="image/jpg,image/jpeg,image/png,image/gif" required>
						<span id="msg6"></span>					
					</div><br>
					<img id="preview_img" src="#" style="height: 300px; width: 300px;border-radius:60px 60px 60px 60px ;margin-left:50px">
				</form>
			</div>
			<div class="modal-footer">
				<div id="resultMsg"></div>
				<a href="#"><input type="submit" id="updateData" class="btn btn-primary me-2" style="margin-left:130px" value="更新" ></a>
			</div>
		</div>
	</div>
</div>

<script>
document.getElementById("queryData").addEventListener('click', query);

function clear(products) {
	$("#pagebtn").empty();
	var pageNum = document.getElementById("pagebtn");
	var page = Math.ceil(products.length / 5);
	content = "<a data-id='1' class='btn btn-outline-dark'><<</a>";
	for(var i = 0; i < page; i++) {
		content += "<a data-id='"+(i+1)+"' class='btn btn-outline-dark'>"+(i+1)+"</a>";
	}
	content += "<a data-id='"+page+"' class='btn btn-outline-dark'>>></a>";
	pageNum.innerHTML = content;

}

function goPage(x) {
	
}


$("body").on("click","a.btn.btn-outline-dark",function() {
	goPage($(this).attr("data-id"));
});

function query() {	
	search = document.getElementById("query").value;
	var xhr1 = new XMLHttpRequest();
	xhr1.open("Get", "<c:url value='/products/search=' />" + search , true);
	xhr1.send();
	
	xhr1.onreadystatechange = function() {
		var imageURL = "<c:url value='/getProductImage' />";
		var controlURL = "<c:url value='/product/control' />";
		var editURL = "<c:url value='/product/edit/' />";
		var deleteURL = "<c:url value='/product/delete' />";
		
		if (xhr1.readyState == 4 && xhr1.status == 200) {
			var content = "<table id='idtable' class='table table-bordered'>";
				content += "<thead><tr style='background-color: lightblue'><th>#</th><th>照片</th><th>品名</th><th>內容物</th>" 
						+ "<th>類別</th><th>單價</th><th>庫存總數</th><th>熱銷數</th><th>商品狀態</th><th>編輯人</th>"
						+ "<th>建立時間</th><th>最後編輯時間</th><th>商品控制</th><th>編輯</th><th>刪除</th></tr></thead>";
			var products = JSON.parse(xhr1.responseText);	
			console.log(products)
			clear(products);			
			if(products.length == 0) {
				content += "<tbody><tr><td id='tbody' align='center'style='color:red' colspan='15'></td></tr></tbody>";				
			}
			for (var i = 0; i < products.length; i++) {				
				id = i + 1;
				if(products[i].product.best_seller == products[i].product.quantity) {
					content += "<tbody><tr style='background-color:lightgray'><td align='center'>" + id + "</td>";
				} else {
					content += "<tbody><tr><td align='center'>" + id + "</td>";
				}
				content += "<td align='center'><img width='40' height='48'" + " src='" + imageURL + "?id=" + products[i].product.id + "'></td>"
						+ "<td>" + products[i].product.product_name + "</td>"
						+ "<td>" + products[i].product.product_content + "</td>"
						+ "<td>" + products[i].product.product_type + "</td>" 
						+ "<td align='right'>"	+ products[i].product.price + "</td>" 
						+ "<td align='right'>" + products[i].product.quantity + "</td>"
						+ "<td align='right'>" + products[i].product.best_seller + "</td>";				

				if(products[i].product.button_switch == false) {						
					if(products[i].product.best_seller == products[i].product.quantity) {
						
						content += "<td style='font-weight: bold'>已完售</td>"
								+  "<td>" + products[i].product.employee.employee_no + "</td>"
								+  "<td>" + products[i].product.create_at + "</td>"
								+  "<td>" + products[i].product.updateDate + "</td>"
								+  "<td width='10.3%'><a style='visibility:hidden' class='btn btn-primary' role='button'>上架</a>"
								+  "<a style='visibility:hidden' class='btn btn-warning' role='button'>下架</a>"
								+  "<a class='btn btn-secondary' role='button' aria-disabled='true'>關閉</a></td>"
								+  "<td></td>"
								+  "<td></td></tr></tbody>";
					} else {	
						content += "<td style='color: red; font-weight: bold'>已下架</td>"
								+  "<td>" + products[i].product.employee.employee_no + "</td>"
								+  "<td>" + products[i].product.create_at + "</td>"
								+  "<td>" + products[i].product.updateDate + "</td>"
								+  "<td width='10.3%'><a href='" + controlURL + "?id=" + products[i].product.id + "&button_switch=true' class='btn btn-primary' role='button'>上架</a>"
								+  "<a style='visibility:hidden' class='btn btn-warning' role='button'>下架</a></td>"
								+  "<td><input id='" + products[i].product.id + "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-success' data-bs-toggle='modal' data-bs-target='#edit' data-bs-whatever='@getbootstrap'></button></td>"
								+  "<td><a onclick='confirm("+products[i].product.id+")' class='btn btn-danger' role='button'>刪除</a></td></tr></tbody>";						
					}
				} else {					
					content += "<td style='color: green; font-weight: bold'>販售中</td>"
						+  "<td>" + products[i].product.employee.employee_no + "</td>"
						+  "<td>" + products[i].product.create_at + "</td>"
						+  "<td>" + products[i].product.updateDate + "</td>"
						+  "<td width='10.3%'><a style='visibility:hidden' class='btn btn-primary' role='button'>上架</a>"
						+  "<a href='" + controlURL + "?id=" + products[i].product.id + "&button_switch=false' class='btn btn-warning' role='button'>下架</a></td>"
						+  "<td></td>"
						+  "<td></td></tr></tbody>";				
				}	
			}
			
			content += "</table>";
			
			var divs = document.getElementById("somedivS");
			divs.innerHTML = content;
			if(products.length == 0) {
				document.getElementById("tbody").innerHTML="查無資料";
			}
		}
	}
	
}

$("h1").css("color","blue")
$("#inputFileToLoad").change(function(){
	readURL1(this);
})

function readURL1(input){
	if(input.files&&input.files[0]){
	var reader = new FileReader();
	reader.onload = function(e){
		$("#preview_img").attr("src",e.target.result);		
	}
	reader.readAsDataURL(input.files[0]);		
	}
}

/*商品新增*/
var fileDataURL1 = null;
document.getElementById("product_name1").addEventListener("blur", checkProduct_Name);
document.getElementById("product_content1").addEventListener("blur", checkProduct_Content);
document.getElementById("product_type1").addEventListener("blur", checkProduct_Type);
document.getElementById("price1").addEventListener("blur", checkPrice);
document.getElementById("quantity1").addEventListener("blur", checkQuantity);
document.getElementById("inputFileToLoad1").addEventListener("change", loadImageFileAsURL);

function inputValue() {
	document.getElementById("product_name1").value = "沙發";
	document.getElementById("product_content1").value = "牛皮製";
	document.getElementById("price1").value = 10000;
	document.getElementById("quantity1").value = 20;	
}
function checkProduct_Name() {
	let button = document.querySelector('#submitdata');
	let v = document.querySelector('#product_name1');
	let product_name = document.getElementById("product_name1");
    let product_nameValue = product_name.value;
    let msg = document.querySelector('#msg01');
    let msg1 = document.getElementById("msg01");    
    let product_nameLen = product_nameValue.length;
    let flag1 = false, flag2 = true;
    if (product_nameLen == "") {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg1.innerHTML = "(不可空白)";
    } else if (product_nameLen >= 1 && product_nameLen <= 20) {
        for (let i = 0; i < product_nameLen; i++) {
            let char = product_nameValue.charAt(i);
            if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
                flag1 = true;
            } else {
                flag2 = false;
                break;
            }
        }
        if (flag1 && flag2) {
        	v.classList.remove('is-invalid');
        	v.classList.add('is-valid');
        	msg1.innerHTML = "";
        	result = msg1.innerHTML;
        } else {
        	v.classList.remove('is-valid');
        	v.classList.add('is-invalid');
        	msg.classList.add('invalid-feedback');
        	msg1.innerHTML = "(名稱必須為中文、英文、數字)";
        }
    } else {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg1.innerHTML = "(名稱字數限制20)";
    }
}

function checkProduct_Content() {
	let v = document.querySelector('#product_content1');
    let product_content = document.getElementById("product_content1");
    let product_contentValue = product_content.value;
    let msg = document.querySelector('#msg02');
    let msg2 = document.getElementById("msg02");
    let product_contentLen = product_contentValue.length;
    let flag1 = false, flag2 = true;
    if (product_contentLen == "") {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg2.innerHTML = "(不可空白)";
    } else if (product_contentLen >= 1 && product_contentLen <= 50) {
        for (let i = 0; i < product_contentLen; i++) {
            let char = product_contentValue.charAt(i);
            if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
                flag1 = true;
            } else {
                flag2 = false;
                break;
            }
        }
        if (flag1 && flag2) {
        	v.classList.remove('is-invalid');
        	v.classList.add('is-valid');
        	msg2.innerHTML = "";
        } else {
        	v.classList.remove('is-valid');
        	v.classList.add('is-invalid');
        	msg.classList.add('invalid-feedback');
        	msg2.innerHTML = "(名稱必須為中文、英文、數字)";
        }
    } else {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg2.innerHTML = "(名稱字數限制50)";
    }
}

function checkProduct_Type() {
	let v = document.querySelector('#product_type1');
    let product_type = document.getElementById("product_type1");
    let product_typeValue = product_type.value;
    let msg = document.querySelector('#msg03');
    let msg3 = document.getElementById("msg03")
    
    if (product_typeValue == "") {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg3.innerHTML = "(請選擇商品種類)";
    } else {
    	v.classList.remove('is-invalid');
    	v.classList.add('is-valid');
    	msg3.innerHTML = "";
    }
}

function checkPrice() {
	let v = document.querySelector('#price1');
    let price = document.getElementById("price1");
    let priceValue = price.value;
    let msg = document.querySelector('#msg04');
    let msg4 = document.getElementById("msg04")
    
    if (priceValue == "") {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg4.innerHTML = "(不可空白)";
    } else if (priceValue <= 0) {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg4.innerHTML = "(不可小於1)";
    } else if (priceValue > 0 && priceValue <= 1000000000) {
    	v.classList.remove('is-invalid');
    	v.classList.add('is-valid');
    	msg4.innerHTML = "";
    } else {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg4.innerHTML = "(超過上限1000000000)";
    }
}

function checkQuantity() {
	let v = document.querySelector('#quantity1');
    let quantity = document.getElementById("quantity1");
    let quantityValue = quantity.value;
    let msg = document.querySelector('#msg05');
    let msg5 = document.getElementById("msg05")
    
    if (quantityValue == "") {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg5.innerHTML = "(不可空白)";
    } else if (quantityValue <= 0) {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg5.innerHTML = "(不可小於1)";
    } else if (quantityValue > 0 && quantityValue <= 1000000000) {
    	v.classList.remove('is-invalid');
    	v.classList.add('is-valid');
    	msg5.innerHTML = "";
    } else {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg5.innerHTML = "(超過上限1000000000)";
    }
}

function loadImageFileAsURL() {
	let v = document.querySelector('#inputFileToLoad1');
	let msg = document.querySelector('#msg06');
	let msg6 = document.getElementById("msg06")
    let filesSelected = document.getElementById("inputFileToLoad1").files;
    if (filesSelected.length > 0)
    {
        let fileToLoad = filesSelected[0];		
        let fileReader = new FileReader();
        fileReader.onload = function(fileLoadedEvent) 
        {
        	fileDataURL1 = fileLoadedEvent.target.result;
            console.log("product_name=" + fileLoadedEvent.product_name);
            console.log("type=" + fileLoadedEvent.type );
            console.log(fileDataURL1);
        };
        fileReader.readAsDataURL(fileToLoad);
        v.classList.remove('is-invalid');
    	v.classList.add('is-valid');
    	msg6.innerHTML = "";
    } else {
    	v.classList.remove('is-valid');
    	v.classList.add('is-invalid');
    	msg.classList.add('invalid-feedback');
    	msg6.innerHTML = "(請選擇照片)";
    }
}

function checkValue() {
	let product_name = document.getElementById("product_name1").value;
	let product_content = document.getElementById("product_content1").value;
	let product_type = document.getElementById("product_type1").value;
	let price = document.getElementById("price1").value;
	let quantity = document.getElementById("quantity1").value;
	let image = document.getElementById("inputFileToLoad1").value;
	let msg1 = document.getElementById("msg01");
	let msg2 = document.getElementById("msg02");
	let msg3 = document.getElementById("msg03");
	let msg4 = document.getElementById("msg04");
	let msg5 = document.getElementById("msg05");
	let msg6 = document.getElementById("msg06");
	let v1 = document.querySelector('#product_name1');
	let v2 = document.querySelector('#product_content1');
	let v3 = document.querySelector('#product_type1');
	let v4 = document.querySelector('#price1');
	let v5 = document.querySelector('#quantity1');
	let v6 = document.querySelector('#inputFileToLoad1');
	let msg01 = document.querySelector('#msg01');
	let msg02 = document.querySelector('#msg02');
	let msg03 = document.querySelector('#msg03');
	let msg04 = document.querySelector('#msg04');
	let msg05 = document.querySelector('#msg05');
	let msg06 = document.querySelector('#msg06');
	let flag1 = true, flag2 = true, flag3 = true, flag4 = true, flag5 = true, flag6 = true;
	
	if (product_name == "") {
		v1.classList.remove('is-valid');
    	v1.classList.add('is-invalid');
    	msg01.classList.add('invalid-feedback');
		msg1.innerHTML = "(不可空白)";
		flag1 = false;
	}
	
	if (product_content == "") {
		v2.classList.remove('is-valid');
    	v2.classList.add('is-invalid');
    	msg02.classList.add('invalid-feedback');
		msg2.innerHTML = "(不可空白)";
		flag2 = false;
	}
	
	if (product_type == "") {
		v3.classList.remove('is-valid');
    	v3.classList.add('is-invalid');
    	msg03.classList.add('invalid-feedback');
		msg3.innerHTML = "(請選擇商品種類)";
		flag3 = false;
	}
	
	if (price == "") {
		v4.classList.remove('is-valid');
    	v4.classList.add('is-invalid');
    	msg04.classList.add('invalid-feedback');
		msg4.innerHTML = "(不可空白)";
		flag4 = false;
	} else if (price <= 0) {
		v4.classList.remove('is-valid');
    	v4.classList.add('is-invalid');
    	msg04.classList.add('invalid-feedback');
		msg4.innerHTML = "(不可小於1)";
		flag4 = false;
	} else if (price > 1000000000) {
		v4.classList.remove('is-valid');
    	v4.classList.add('is-invalid');
    	msg04.classList.add('invalid-feedback');
		msg4.innerHTML = "(超過上限1000000000)";
		flag4 = false;
	}
	
	if (quantity == "") {
		v5.classList.remove('is-valid');
    	v5.classList.add('is-invalid');
    	msg05.classList.add('invalid-feedback');
		msg5.innerHTML = "(不可空白)";
		flag5 = false;
	} else if (quantity <= 0) {
		v5.classList.remove('is-valid');
    	v5.classList.add('is-invalid');
    	msg05.classList.add('invalid-feedback');
		msg5.innerHTML = "(不可小於1)";
		flag5 = false;
	} else if (quantity > 1000000000) {
		v5.classList.remove('is-valid');
    	v5.classList.add('is-invalid');
    	msg05.classList.add('invalid-feedback');
		msg5.innerHTML = "(超過上限1000000000)";
		flag5 = false;
	}
	
	if (image == "") {
		v6.classList.remove('is-valid');
    	v6.classList.add('is-invalid');
    	msg06.classList.add('invalid-feedback');
		msg6.innerHTML = "(請選擇照片)";
		flag6 = false;
	} else {
		v6.classList.remove('is-invalid');
    	v6.classList.add('is-valid');
    	msg06.classList.add('valid-feedback');
		msg6.innerHTML = "";
		flag6 = true;
	}
	
	if (flag1 && flag2 && flag3 && flag4 && flag5 && flag6) {		
		let checkAndSendData = () => {			
			product_name1 = document.getElementById("product_name1").value;			
			product_content1 = document.getElementById("product_content1").value;
			product_type1 = document.getElementById("product_type1").value;
			price1 = document.getElementById("price1").value;
			quantity1 = document.getElementById("quantity1").value;
			let obj = {
				'fileDataUrl': fileDataURL1,
				'product':{
					'product_name': product_name1,	
					'product_content': product_content1,	
					'product_type': product_type1,
					'price': price1,
					'quantity': quantity1
				}		
			};
			let json = JSON.stringify(obj);
			let xhr = new XMLHttpRequest();	
			xhr.open('POST', "<c:url value='/product/insert' />" , true);
			xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");	
			xhr.send(json);
			
			console.log("product_name=" + product_name1 + ", product_content=" + product_content1  + ", product_type=" + product_type1  + ", price=" + price1  + ", quantity=" + quantity1);
			console.log("image=" + fileDataURL1);
			console.log("json=" + json);
		}
		
		checkAndSendData();
		Swal.fire({
			icon: 'success',
			title:'新增成功',
			color: "#7373b9",		    				
			confirmButtonText: '確定',
			confirmButtonColor: "#0000e3"
		}).then((result) => {
			window.location.href = "../product/findAll";
		})
	}	
}

$("h1").css("color","blue")
$("#inputFileToLoad1").change(function(){
	readURL(this);
})

function readURL(input){
	if(input.files&&input.files[0]){
	var reader = new FileReader();
	reader.onload = function(e){
		$("#preview_img1").attr("src",e.target.result);
		
	}
	reader.readAsDataURL(input.files[0]);
		
	}
}

</script>
</body>
</html>