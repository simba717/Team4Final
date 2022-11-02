<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> --%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<!-- <title>商品編輯</title> -->
<!-- <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script> -->
<!-- <script> -->
// var mid = ${id};
// let inputFileToLoad = null;
// let fileDataURL = null;
// var result = null;
// /*
// window.addEventListener('load', function(){	
// 	inputFileToLoad = document.getElementById("inputFileToLoad");
// 	updateData = document.getElementById("updateData");
// 	inputFileToLoad.addEventListener('change', loadImageFileAsURL);
// 	updateData.addEventListener('click', updateData);
// });
// */
// window.onload = function() {
// 	document.getElementById("product_name").addEventListener("blur", checkProduct_Name);
// 	document.getElementById("product_content").addEventListener("blur", checkProduct_Content);
// 	document.getElementById("product_type").addEventListener("blur", checkProduct_Type);
// 	document.getElementById("price").addEventListener("blur", checkPrice);
// 	document.getElementById("quantity").addEventListener("blur", checkQuantity);
// 	inputFileToLoad = document.getElementById("inputFileToLoad");
// 	updateData = document.getElementById("updateData");
// 	inputFileToLoad.addEventListener('change', loadImageFileAsURL);
// 	updateData.addEventListener('click', updateData);
	
// 	var divResult = document.getElementById('resultMsg');
// 	var id = document.getElementById("id");
// 	var product_name = document.getElementById("product_name");
// 	var product_content = document.getElementById("product_content");
// 	var product_type = document.getElementById("product_type");
// 	var price = document.getElementById("price");
// 	var quantity = document.getElementById("quantity");
// 	var image = document.getElementById("preview_img");
// 	var best_seller = document.getElementById("best_seller");
	
// 	var xhr = new XMLHttpRequest();
// 	xhr.open("GET", "<c:url value='/product/' />" + mid , true);
// 	xhr.send();	
// 	xhr.onreadystatechange = function() {
// 	    // 伺服器請求完成
// 	    if (xhr.readyState == 4 && xhr.status == 200) {
// 		   var product = JSON.parse(xhr.responseText);
// 		   console.log(product);
// 		   id.value = product.id;
// 		   product_name.value = product.product_name;
// 		   product_content.value = product.product_content;
// 		   product_type.value = product.product_type;
// 		   price.value = product.price;
// 		   quantity.value = product.quantity;
// 		   image.src = "data:image/jpg;base64," + product.image;
// 	    }
//      }
	
// 	updateData.onclick = function() {
// 		// 讀取欄位資料	  
// 		var idValue = document.getElementById("id").value;
// 		var product_nameValue = document.getElementById("product_name").value;
// 		var product_contentValue = document.getElementById("product_content").value;
// 		var product_typeValue = document.getElementById("product_type").value;
// 		var priceValue = document.getElementById("price").value;
// 		var quantityValue = document.getElementById("quantity").value;
// 		let msg1 = document.getElementById("msg1");
// 		let msg2 = document.getElementById("msg2");
// 		let msg3 = document.getElementById("msg3");
// 		let msg4 = document.getElementById("msg4");
// 		let msg5 = document.getElementById("msg5");
// 		let v1 = document.querySelector('#product_name');
// 		let v2 = document.querySelector('#product_content');
// 		let v3 = document.querySelector('#product_type');
// 		let v4 = document.querySelector('#price');
// 		let v5 = document.querySelector('#quantity');
// 		let msg01 = document.querySelector('#msg1');
// 		let msg02 = document.querySelector('#msg2');
// 		let msg03 = document.querySelector('#msg3');
// 		let msg04 = document.querySelector('#msg4');
// 		let msg05 = document.querySelector('#msg5');
// 		let flag1 = true, flag2 = true, flag3 = true, flag4 = true, flag5 = true;
		
// 		if (product_nameValue == "") {
// 			v1.classList.remove('is-valid');
// 	    	v1.classList.add('is-invalid');
// 	    	msg01.classList.add('invalid-feedback');
// 			msg1.innerHTML = "(不可空白)";
// 			flag1 = false;
// 		} else {
// 			v1.classList.remove('is-invalid');
//         	v1.classList.add('is-valid');
// 		}
		
// 		if (product_contentValue == "") {
// 			v2.classList.remove('is-valid');
// 	    	v2.classList.add('is-invalid');
// 	    	msg02.classList.add('invalid-feedback');
// 			msg2.innerHTML = "(不可空白)";
// 			flag2 = false;
// 		} else {
// 			v2.classList.remove('is-invalid');
//         	v2.classList.add('is-valid');
// 		}
		
// 		if (product_typeValue == "") {
// 			v3.classList.remove('is-valid');
// 	    	v3.classList.add('is-invalid');
// 	    	msg03.classList.add('invalid-feedback');
// 			msg3.innerHTML = "(請選擇商品種類)";
// 			flag3 = false;
// 		} else {
// 			v3.classList.remove('is-invalid');
//         	v3.classList.add('is-valid');
// 		}
		
// 		if (priceValue == "") {
// 			v4.classList.remove('is-valid');
// 	    	v4.classList.add('is-invalid');
// 	    	msg04.classList.add('invalid-feedback');
// 			msg4.innerHTML = "(不可空白)";
// 			flag4 = false;
// 		} else if (priceValue <= 0) {
// 			v4.classList.remove('is-valid');
// 	    	v4.classList.add('is-invalid');
// 	    	msg04.classList.add('invalid-feedback');
// 			msg4.innerHTML = "(不可小於1)";
// 			flag4 = false;
// 		} else if (priceValue > 1000000000) {
// 			v4.classList.remove('is-valid');
// 	    	v4.classList.add('is-invalid');
// 	    	msg04.classList.add('invalid-feedback');
// 			msg4.innerHTML = "(超過上限1000000000)";
// 			flag4 = false;
// 		} else {
// 			v4.classList.remove('is-invalid');
//         	v4.classList.add('is-valid');
// 		}
		
// 		if (quantityValue == "") {
// 			v5.classList.remove('is-valid');
// 	    	v5.classList.add('is-invalid');
// 	    	msg05.classList.add('invalid-feedback');
// 			msg5.innerHTML = "(不可空白)";
// 			flag5 = false;
// 		} else if (quantityValue <= 0) {
// 			v5.classList.remove('is-valid');
// 	    	v5.classList.add('is-invalid');
// 	    	msg05.classList.add('invalid-feedback');
// 			msg5.innerHTML = "(不可小於1)";
// 			flag5 = false;
// 		} else if (quantityValue > 1000000000) {
// 			v5.classList.remove('is-valid');
// 	    	v5.classList.add('is-invalid');
// 	    	msg05.classList.add('invalid-feedback');
// 			msg5.innerHTML = "(超過上限1000000000)";
// 			flag5 = false;
// 		} else {
// 			v5.classList.remove('is-invalid');
//         	v5.classList.add('is-valid');
// 		}
		
// 		if (flag1 && flag2 && flag3 && flag4 && flag5) {
// 			var xhr1 = new XMLHttpRequest();
// 			xhr1.open("PUT", "<c:url value='/products/' />" + mid, true);
// 			var jsonProduct = {		
// 				'fileDataUrl': fileDataURL,
// 				'product':{
// 					'product_name': product_nameValue,	
// 					'product_content': product_contentValue,	
// 					'product_type': product_typeValue,
// 					'price': priceValue,
// 					'quantity': quantityValue
// 				}
// 			}
// 			xhr1.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
// 			xhr1.send(JSON.stringify(jsonProduct));
// 			console.log(JSON.stringify(jsonProduct));
// 			console.log(fileDataURL);
			
// 			xhr1.onreadystatechange = function() {
// 				// 伺服器請求完成
// 				if (xhr1.readyState == 4 && (xhr1.status == 200 || xhr1.status == 201) ) {
// 		  			result = JSON.parse(xhr1.responseText);
// 		  			if (result.fail) {
// 			 			divResult.innerHTML = "<font color='red' >"	+ result.fail + "</font>";
// 		  			} else {
// 						divResult.innerHTML = "<font color='GREEN'>" + result.success + "</font>";
// 		  			}
// 				}
// 			}
// 		}			
// 	}
// }

// function checkProduct_Name() {
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

// function loadImageFileAsURL(){
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
//     }
// }

<!-- </script> -->
<!-- </head> -->
 
<!-- <body> -->
<%-- <jsp:include page="../../layout/BackNavbar.jsp"></jsp:include> --%>

<!-- <div class="col-12 grid-margin stretch-card" style="height: 800px;width: 800px;margin-left:100px;float:left;"> -->
<!-- 	<div class="card" style="box-shadow: 10px 10px 5px gray;"> -->
<!-- 		<div class="card-body"> -->
<!-- 			<h3 class="card-title">商品資料新增</h3> -->
<!-- 			<form class="forms-sample" novalidate> -->
<!-- 				<input type="hidden" name="id" id='id'> -->
<!-- 				<div class="form-group"> -->
<!-- 					<label for="exampleInputName1">商品名稱</label> -->
<!-- 					<input type="text" class="form-control" id="product_name" required> -->
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
<!-- 					<input id="inputFileToLoad" type="file" name="image" onchange="loadImageFileAsURL()" class="form-control" accept="image/jpg,image/jpeg,image/png,image/gif" required> -->
<!-- 					<span id="msg6"></span>					 -->
<!-- 				</div>				 -->
<!-- 			</form> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->
<!-- <img id="preview_img" src="#" style="height: 300px; width: 300px;border-radius:60px 60px 60px 60px ;margin-left:50px"> -->
<!-- <br><br><br>	 -->
<!-- <input type="submit" id="updateData" class="btn btn-primary me-2" style="margin-left:130px" value="更新" > -->
<!-- <a href="../findAll"><button class="btn btn-light" style="margin-left:20px">返回</button></a> -->
<!-- <div id="resultMsg"></div> -->

<!-- <script> -->
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