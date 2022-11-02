<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%> --%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<!-- <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script> -->
<!-- <title>商品管理</title> -->
<!-- </head> -->
<!-- <body> -->
<%-- <jsp:include page="../../layout/BackNavbar.jsp"></jsp:include> --%>

<!-- <div class="col-12 grid-margin stretch-card" style="height: 800px;width: 800px;margin-left:100px;float:left;"> -->
<!-- 	<div class="card" style="box-shadow: 10px 10px 5px gray;"> -->
<!-- 		<div class="card-body"> -->
<!-- 			<h3 class="card-title">商品資料新增</h3> -->
<!-- 			<form class="forms-sample" novalidate> -->
<!-- 				<div class="form-group"> -->
<!-- 					<label for="exampleInputName1">商品名稱</label> -->
<!-- 					<input type="text" class="form-control" id="product_name" autofocus required> -->
<!-- 					<span id="msg1"></span>					 -->
<!-- 				</div> -->
<!-- 				<div class="form-group"> -->
<!-- 					<label for="exampleInputEmail3">商品內容</label> -->
<!-- 					<input type="text" class="form-control" id="product_content" required> -->
<!-- 					<span id="msg2"></span> -->
<!-- 				</div> -->
<!-- 				<div class="form-group"> -->
<!-- 					<label for="exampleInputPassword4">商品類別</label> -->
<!-- 					<select class="form-select" id="product_type" required> -->
<!-- 						<option selected disabled value="">請選擇</option> -->
<!-- 			      		<option value="家庭用品">家庭用品</option> -->
<!-- 			      		<option value="食品">食品</option> -->
<!-- 			      		<option value="運動用品">運動用品</option> -->
<!-- 			      		<option value="其他種類">其他種類</option> -->
<!-- 			    	</select> -->
<!-- 			    	<span id="msg3"></span> -->
<!-- 				</div>			 -->
<!-- 				<div class="form-group"> -->
<!-- 					<label for="exampleInputCity1">單價</label> -->
<!-- 					<input type="number" class="form-control" id="price" value="0" required> -->
<!-- 					<span id="msg4"></span> -->
<!-- 				</div> -->
<!-- 				<div class="form-group"> -->
<!-- 					<label for="exampleInputCity1">庫存數量</label> -->
<!-- 					<input type="number" class="form-control" id="quantity" value="0" required> -->
<!-- 					<span id="msg5"></span> -->
<!-- 				</div>					 -->
<!-- 				<div class="form-group"> -->
<!-- 					<label>商品照片</label><br> -->
<!-- 					<input id="inputFileToLoad" type="file" name="photo" onchange="loadImageFileAsURL()" class="form-control" accept="image/jpg,image/jpeg,image/png,image/gif" required> -->
<!-- 					<span id="msg6"></span>					 -->
<!-- 				</div>				 -->
<!-- 			</form> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->
<!-- <img id="preview_img" src="/my-app/img/default.png" style="height: 300px; width: 300px;border-radius:60px 60px 60px 60px ;margin-left:50px"> -->
<!-- <br><br><br>	 -->
<!-- <a id="a" href="#"><input type="submit" id="submitdata" onclick="checkValue()" class="btn btn-primary me-2" style="margin-left:130px" value="新增"></a> -->
<!-- <a href="../backend"><button class="btn btn-light" style="margin-left:20px">取消</button></a> -->

<!-- <div id="div1" style="height: 100px; width: 100px"></div>	 -->

<!-- <script> -->
// var fileDataURL = null;
// document.getElementById("product_name").addEventListener("blur", checkProduct_Name);
// document.getElementById("product_content").addEventListener("blur", checkProduct_Content);
// document.getElementById("product_type").addEventListener("blur", checkProduct_Type);
// document.getElementById("price").addEventListener("blur", checkPrice);
// document.getElementById("quantity").addEventListener("blur", checkQuantity);
// document.getElementById("inputFileToLoad").addEventListener("change", loadImageFileAsURL);

// function checkProduct_Name() {
// 	let button = document.querySelector('#submitdata');
// 	let v = document.querySelector('#product_name');
// 	let product_name = document.getElementById("product_name");
//     let product_nameValue = product_name.value;
//     let msg = document.querySelector('#msg1');
//     let msg1 = document.getElementById("msg1");    
//     let product_nameLen = product_nameValue.length;
//     let flag1 = false, flag2 = true;
//     if (product_nameLen == "") {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg1.innerHTML = "(不可空白)";
//     } else if (product_nameLen >= 1 && product_nameLen <= 20) {
//         for (let i = 0; i < product_nameLen; i++) {
//             let char = product_nameValue.charAt(i);
//             if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
//                 flag1 = true;
//             } else {
//                 flag2 = false;
//                 break;
//             }
//         }
//         if (flag1 && flag2) {
//         	v.classList.remove('is-invalid');
//         	v.classList.add('is-valid');
//         	msg1.innerHTML = "";
//         	result = msg1.innerHTML;
//         } else {
//         	v.classList.remove('is-valid');
//         	v.classList.add('is-invalid');
//         	msg.classList.add('invalid-feedback');
//         	msg1.innerHTML = "(名稱必須為中文、英文、數字)";
//         }
//     } else {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg1.innerHTML = "(名稱字數限制20)";
//     }
// }

// function checkProduct_Content() {
// 	let v = document.querySelector('#product_content');
//     let product_content = document.getElementById("product_content");
//     let product_contentValue = product_content.value;
//     let msg = document.querySelector('#msg2');
//     let msg2 = document.getElementById("msg2");
//     let product_contentLen = product_contentValue.length;
//     let flag1 = false, flag2 = true;
//     if (product_contentLen == "") {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg2.innerHTML = "(不可空白)";
//     } else if (product_contentLen >= 1 && product_contentLen <= 50) {
//         for (let i = 0; i < product_contentLen; i++) {
//             let char = product_contentValue.charAt(i);
//             if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
//                 flag1 = true;
//             } else {
//                 flag2 = false;
//                 break;
//             }
//         }
//         if (flag1 && flag2) {
//         	v.classList.remove('is-invalid');
//         	v.classList.add('is-valid');
//         	msg2.innerHTML = "";
//         } else {
//         	v.classList.remove('is-valid');
//         	v.classList.add('is-invalid');
//         	msg.classList.add('invalid-feedback');
//         	msg2.innerHTML = "(名稱必須為中文、英文、數字)";
//         }
//     } else {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg2.innerHTML = "(名稱字數限制50)";
//     }
// }

// function checkProduct_Type() {
// 	let v = document.querySelector('#product_type');
//     let product_type = document.getElementById("product_type");
//     let product_typeValue = product_type.value;
//     let msg = document.querySelector('#msg3');
//     let msg3 = document.getElementById("msg3")
    
//     if (product_typeValue == "") {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg3.innerHTML = "(請選擇商品種類)";
//     } else {
//     	v.classList.remove('is-invalid');
//     	v.classList.add('is-valid');
//     	msg3.innerHTML = "";
//     }
// }

// function checkPrice() {
// 	let v = document.querySelector('#price');
//     let price = document.getElementById("price");
//     let priceValue = price.value;
//     let msg = document.querySelector('#msg4');
//     let msg4 = document.getElementById("msg4")
    
//     if (priceValue == "") {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg4.innerHTML = "(不可空白)";
//     } else if (priceValue <= 0) {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg4.innerHTML = "(不可小於1)";
//     } else if (priceValue > 0 && priceValue <= 1000000000) {
//     	v.classList.remove('is-invalid');
//     	v.classList.add('is-valid');
//     	msg4.innerHTML = "";
//     } else {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg4.innerHTML = "(超過上限1000000000)";
//     }
// }

// function checkQuantity() {
// 	let v = document.querySelector('#quantity');
//     let quantity = document.getElementById("quantity");
//     let quantityValue = quantity.value;
//     let msg = document.querySelector('#msg5');
//     let msg5 = document.getElementById("msg5")
    
//     if (quantityValue == "") {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg5.innerHTML = "(不可空白)";
//     } else if (quantityValue <= 0) {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg5.innerHTML = "(不可小於1)";
//     } else if (quantityValue > 0 && quantityValue <= 1000000000) {
//     	v.classList.remove('is-invalid');
//     	v.classList.add('is-valid');
//     	msg5.innerHTML = "";
//     } else {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg5.innerHTML = "(超過上限1000000000)";
//     }
// }

// function loadImageFileAsURL() {
// 	let v = document.querySelector('#inputFileToLoad');
// 	let msg = document.querySelector('#msg6');
// 	let msg6 = document.getElementById("msg6")
//     let filesSelected = document.getElementById("inputFileToLoad").files;
//     if (filesSelected.length > 0)
//     {
//         let fileToLoad = filesSelected[0];		
//         let fileReader = new FileReader();
//         fileReader.onload = function(fileLoadedEvent) 
//         {
//         	fileDataURL = fileLoadedEvent.target.result;
//             console.log("product_name=" + fileLoadedEvent.product_name);
//             console.log("type=" + fileLoadedEvent.type );
//             console.log(fileDataURL);
//         };
//         fileReader.readAsDataURL(fileToLoad);
//         v.classList.remove('is-invalid');
//     	v.classList.add('is-valid');
//     	msg6.innerHTML = "";
//     } else {
//     	v.classList.remove('is-valid');
//     	v.classList.add('is-invalid');
//     	msg.classList.add('invalid-feedback');
//     	msg6.innerHTML = "(請選擇照片)";
//     }
// }

// function checkValue() {
// 	let product_name = document.getElementById("product_name").value;
// 	let product_content = document.getElementById("product_content").value;
// 	let product_type = document.getElementById("product_type").value;
// 	let price = document.getElementById("price").value;
// 	let quantity = document.getElementById("quantity").value;
// 	let image = document.getElementById("inputFileToLoad").value;
// 	let msg1 = document.getElementById("msg1");
// 	let msg2 = document.getElementById("msg2");
// 	let msg3 = document.getElementById("msg3");
// 	let msg4 = document.getElementById("msg4");
// 	let msg5 = document.getElementById("msg5");
// 	let msg6 = document.getElementById("msg6");
// 	let v1 = document.querySelector('#product_name');
// 	let v2 = document.querySelector('#product_content');
// 	let v3 = document.querySelector('#product_type');
// 	let v4 = document.querySelector('#price');
// 	let v5 = document.querySelector('#quantity');
// 	let v6 = document.querySelector('#inputFileToLoad');
// 	let msg01 = document.querySelector('#msg1');
// 	let msg02 = document.querySelector('#msg2');
// 	let msg03 = document.querySelector('#msg3');
// 	let msg04 = document.querySelector('#msg4');
// 	let msg05 = document.querySelector('#msg5');
// 	let msg06 = document.querySelector('#msg6');
// 	let flag1 = true, flag2 = true, flag3 = true, flag4 = true, flag5 = true, flag6 = true;
	
// 	if (product_name == "") {
// 		v1.classList.remove('is-valid');
//     	v1.classList.add('is-invalid');
//     	msg01.classList.add('invalid-feedback');
// 		msg1.innerHTML = "(不可空白)";
// 		flag1 = false;
// 	}
	
// 	if (product_content == "") {
// 		v2.classList.remove('is-valid');
//     	v2.classList.add('is-invalid');
//     	msg02.classList.add('invalid-feedback');
// 		msg2.innerHTML = "(不可空白)";
// 		flag2 = false;
// 	}
	
// 	if (product_type == "") {
// 		v3.classList.remove('is-valid');
//     	v3.classList.add('is-invalid');
//     	msg03.classList.add('invalid-feedback');
// 		msg3.innerHTML = "(請選擇商品種類)";
// 		flag3 = false;
// 	}
	
// 	if (price == "") {
// 		v4.classList.remove('is-valid');
//     	v4.classList.add('is-invalid');
//     	msg04.classList.add('invalid-feedback');
// 		msg4.innerHTML = "(不可空白)";
// 		flag4 = false;
// 	} else if (price <= 0) {
// 		v4.classList.remove('is-valid');
//     	v4.classList.add('is-invalid');
//     	msg04.classList.add('invalid-feedback');
// 		msg4.innerHTML = "(不可小於1)";
// 		flag4 = false;
// 	} else if (price > 1000000000) {
// 		v4.classList.remove('is-valid');
//     	v4.classList.add('is-invalid');
//     	msg04.classList.add('invalid-feedback');
// 		msg4.innerHTML = "(超過上限1000000000)";
// 		flag4 = false;
// 	}
	
// 	if (quantity == "") {
// 		v5.classList.remove('is-valid');
//     	v5.classList.add('is-invalid');
//     	msg05.classList.add('invalid-feedback');
// 		msg5.innerHTML = "(不可空白)";
// 		flag5 = false;
// 	} else if (quantity <= 0) {
// 		v5.classList.remove('is-valid');
//     	v5.classList.add('is-invalid');
//     	msg05.classList.add('invalid-feedback');
// 		msg5.innerHTML = "(不可小於1)";
// 		flag5 = false;
// 	} else if (quantity > 1000000000) {
// 		v5.classList.remove('is-valid');
//     	v5.classList.add('is-invalid');
//     	msg05.classList.add('invalid-feedback');
// 		msg5.innerHTML = "(超過上限1000000000)";
// 		flag5 = false;
// 	}
	
// 	if (image == "") {
// 		v6.classList.remove('is-valid');
//     	v6.classList.add('is-invalid');
//     	msg06.classList.add('invalid-feedback');
// 		msg6.innerHTML = "(請選擇照片)";
// 		flag6 = false;
// 	} else {
// 		v6.classList.remove('is-invalid');
//     	v6.classList.add('is-valid');
//     	msg06.classList.add('valid-feedback');
// 		msg6.innerHTML = "";
// 		flag6 = true;
// 	}
	
// 	if (flag1 && flag2 && flag3 && flag4 && flag5 && flag6) {		
// 		let checkAndSendData = () => {
// 			product_name = document.getElementById("product_name").value;			
// 			product_content = document.getElementById("product_content").value;
// 			product_type = document.getElementById("product_type").value;
// 			price = document.getElementById("price").value;
// 			quantity = document.getElementById("quantity").value;
// 			let obj = {
// 				'fileDataUrl': fileDataURL,
// 				'product':{
// 					'product_name': product_name,	
// 					'product_content': product_content,	
// 					'product_type': product_type,
// 					'price': price,
// 					'quantity': quantity
// 				}		
// 			};
// 			let json = JSON.stringify(obj);
// 			let xhr = new XMLHttpRequest();	
// 			xhr.open('POST', "<c:url value='/product/insert' />" , true);
// 			xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
// 			xhr.send(json);
			
// 			console.log("product_name=" + product_name + ", product_content=" + product_content  + ", product_type=" + product_type  + ", price=" + price  + ", quantity=" + quantity);
// 			console.log("image=" + fileDataURL);
// 			console.log("json=" + json);
// 		}
// 		checkAndSendData();
// 		document.getElementById("a").href = "../product/findAll";
// 	}	
// }

// $("h1").css("color","blue")
// $("#inputFileToLoad").change(function(){
// 	readURL(this);
// })

// function readURL(input){
// 	if(input.files&&input.files[0]){
// 	var reader = new FileReader();
// 	reader.onload = function(e){
// 		$("#preview_img").attr("src",e.target.result);
		
// 	}
// 	reader.readAsDataURL(input.files[0]);
		
// 	}
// }

<!-- </script> -->
<!-- </body> -->
<!-- </html> -->