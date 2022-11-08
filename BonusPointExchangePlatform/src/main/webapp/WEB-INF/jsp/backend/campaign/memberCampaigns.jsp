<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
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
<title>會員活動管理</title>
<script>
var campaignPhoto1 = null;
var fileDataURL = null;
var result = null;

//插入圖片功能
var imageURL = "<c:url value='/getCampaignImage' />";
//上下架按鈕功能
var controlURL = "<c:url value='/campaign/control' />";
//編輯功能
var editURL = "<c:url value='/campaign/edit/' />";
//刪除功能
var deleteURL = "<c:url value='/campaign/delete' />";

window.onload = function() {
	var xhr = new XMLHttpRequest();
	xhr.open("GET",
			"<c:url value='/backend/campaign/getCampaigns' />",
			true);
	xhr.send();
	xhr.onload = function() {
		if (xhr.status == 200) {
		var content = "<table id='idtable' class='table table-bordered'>";
			content += "<thead><tr style='background-color: coral'>"
				+ "<th>活動名稱</th>"
				+ "<th>活動用圖</th>" 
				+ "<th>活動內容</th>" 
				+ "<th>開始時間</th>" 
				+ "<th>結束時間</th>" 
				+ "<th>員工編號</th>" 
				+ "<th>建立時間</th>" 
				+ "<th>最後編輯時間</th>" 
				+ "<th>上下架</th>" 
				+ "<th>編輯</th>" 
				+ "<th>刪除</th>" 
				+ "</tr></thead>";
	
		var campaigns = JSON.parse(xhr.responseText);
		let imageURL = "data:image/jpg;base64,";
		for (var i = 0; i < campaigns.length; i++) {
			content += "<tbody><tr>" 
					+ "<td>" + campaigns[i].campaignName + "</td>"
					+ "<td width='100'><img width='100' height='60'" + " src='" + imageURL + campaigns[i].campaignPhoto + "'></td>"
					+ "<td>" + campaigns[i].campaignContent + "</td>"
					+ "<td width='100'>" + campaigns[i].campaignStart_at + "</td>"
					+ "<td width='100'>" + campaigns[i].campaignEnd_at + "</td>"
					+ "<td width='90'>" + campaigns[i].employeeNo + "</td>" 
					+ "<td width='160'>" + campaigns[i].campaignCreat_at + "</td>"
					+ "<td width='160'>" + campaigns[i].campaignUpdate_at + "</td>"					
			if (campaigns[i].campaignStatus == true){
				content += "<td width='80'><a href='" + controlURL + "?id=" + campaigns[i].campaignId + "&button_switch=false' class='btn btn-warning' role='button'>下架</a>"
				  		+ "<a style='visibility:hidden' class='btn btn-warning' role='button'>上架</a></td>"						
						+ "<td width='80'><input id='" + campaigns[i].campaignId + "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-success' data-bs-toggle='modal' data-bs-target='#edit' data-bs-whatever='@getbootstrap'></button></td>"
						+ "<td width='80'><a onclick='return confirm(`確定刪除嗎?`)' href='" + deleteURL + "?id=" + campaigns[i].campaignId + "' class='btn btn-danger' role='button'>刪除</a></td>";
						+ "</tr></tbody>";
						
			} else {
				content += "<td width='80'><a style='visibility:hidden' class='btn btn-warning' role='button'>下架</a>"
						+ "<a href='" + controlURL + "?id=" + campaigns[i].campaignId + "&button_switch=true' class='btn btn-primary' role='button'>上架</a></td>"
						+ "<td width='80'><input id='" + campaigns[i].campaignId + "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-success' data-bs-toggle='modal' data-bs-target='#edit' data-bs-whatever='@getbootstrap'></button></td>"
						+ "<td width='80'><a onclick='return confirm(`確定刪除嗎?`)' href='" + deleteURL + "?id=" + campaigns[i].campaignId + "' class='btn btn-danger' role='button'>刪除</a></td>";
						+ "</tr></tbody>";
			}
		}
		content += "</table>";

		var divs = document.getElementById("content");
		divs.innerHTML = content;
			
		}
	}
}

/*用表單編輯活動內容Update*/


function getindex(node) {
	//取得活動ID
	index = $(node).attr('id');
	var url = "<c:url value='/campaigns'/>";
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
	    	$("#campaignName1").attr("value", data.campaignName);
	    	$("#campaignContent1").attr("value", data.campaignContent);
	    	$("#campaignStart_at1").attr("value", data.campaignStart_at);
	    	$("#campaignEnd_at1").attr("value", data.campaignStart_at);
	    	$("#preview_img1").attr("src", "data:image/jpg;base64," + data.campaignPhoto);
	  		
	    	
	    	document.getElementById("campaignName1").addEventListener("blur", checkCampaignName);
	    	document.getElementById("campaignContent1").addEventListener("blur", checkCampaignContent);
	    	document.getElementById("campaignStart_at1").addEventListener("blur", checkStartTime);
	    	document.getElementById("campaignEnd_at1").addEventListener("blur", checkEndTime);
	    	
	    	campaignPhoto1 = document.getElementById("campaignPhoto1");
	    	campaignPhoto1.addEventListener('change', loadImageFileAsURL);
	    	
	    	
	    	//按下送出編輯表單
	    	var updateData = document.getElementById("updateData");
	    	updateData.addEventListener('click', updateData);
	    	
	    	updateData.onclick = function() {
	    		var divResult = document.getElementById('resultMsg');
	    		var idValue = index;
	    		console.log(idValue)
	    		// 取得欄位id
	    		var campaignName1 = document.getElementById("campaignName1");
	    		var campaignContent1 = document.getElementById("campaignContent1");
	    		var campaignStart_at1 = document.getElementById("campaignStart_at1");
	    		var campaignEnd_at1 = document.getElementById("campaignEnd_at1");
	    		
	    		// 取得欄位id值	
	    		let campaignNameValue1 = campaignName1.value;
	    		let campaignContentValue1 = campaignContent1.value;
	    		let campaignStart_atValue1 = campaignStart_at1.value;
	    		let campaignEnd_atValue1 = campaignEnd_at1.value;
	    		
	    		//取得顯示訊息欄位的id
	    		let campaignName1_msg = document.getElementById("campaignName1_msg");
	    		let campaignContent1_msg = document.getElementById("campaignContent1_msg");
	    		let campaignStart_at1_msg = document.getElementById("campaignStart_at1_msg");
	    		let campaignEnd_at1_msg = document.getElementById("campaignEnd_at1_msg");
	    		let campaignPhoto1_msg = document.getElementById("campaignPhoto1_msg");
	    		
	    		//切換顯示訊息的邏輯
	    		let flag1 = true, flag2 = true, flag3 = true, flag4 = true;
	    		
	    		//確認是否輸入活動名稱
	    		if (campaignNameValue1 == "") {
	    			campaignName1.classList.remove('is-valid');
	    			campaignName1.classList.add('is-invalid');
	    			campaignName1_msg.classList.add('invalid-feedback');
	    			campaignName1_msg.innerHTML = "(不可空白)";
	    			flag1 = false;
	    		} else {
	    			campaignName1.classList.remove('is-invalid');
	    			campaignName1.classList.add('is-valid');
	    		}
	    		
	    		//確認是否輸入活動內容
	    		if (campaignContentValue1 == "") {
	    			campaignContent1.classList.remove('is-valid');
	    			campaignContent1.classList.add('is-invalid');
	    			campaignContent1_msg.classList.add('invalid-feedback');
	    			campaignContent1_msg.innerHTML = "(不可空白)";
	    			flag2 = false;
	    		} else {
	    			campaignContent1.classList.remove('is-invalid');
	    			campaignContent1.classList.add('is-valid');
	    		}
	    		
	    		
	    		//確認開始日期是否正確
	    		if (campaignStart_atValue1 > campaignEnd_atValue1) {
	    			campaignStart_at1.classList.remove('is-valid');
	    			campaignStart_at1.classList.add('is-invalid');
	    			campaignStart_at1_msg.classList.add('invalid-feedback');
	    			campaignStart_at1_msg.innerHTML = "(開始日期不得大於結束日期)";
	    			flag3 = false;
	    		} else {
	    			campaignStart_at1.classList.remove('is-invalid');
	    			campaignStart_at1.classList.add('is-valid');
	    		}

	    		//確認結束日期是否正確
	    		if (campaignStart_atValue1 > campaignEnd_atValue1) {
	    			campaignEnd_at1.classList.remove('is-valid');
	    			campaignEnd_at1.classList.add('is-invalid');
	    			campaignEnd_at1_msg.classList.add('invalid-feedback');
	    			campaignEnd_at1_msg.innerHTML = "(結束日期不得小於開始日期)";
	    			flag4 = false;
	    		} else {
	    			campaignEnd_at1.classList.remove('is-invalid');
	    			campaignEnd_at1.classList.add('is-valid');
	    		}
	    		
	    		//如果輸入內容都正確
	    		if (flag1 && flag2 && flag3 && flag4) {
	    			var xhr1 = new XMLHttpRequest();
	    			xhr1.open("PUT", "<c:url value='/campaigns/' />" + idValue, true);

	    			
	    			var jsonCampaign = {		
	    				'fileDataUrl': fileDataURL,
	    				'campaignName': campaignNameValue1,	
	    				'campaignContent': campaignContentValue1,	
	    				'campaignStart_at': campaignStart_atValue1,	    		    		
	    				'campaignEnd_at': campaignEnd_atValue1
	    			}
	    			xhr1.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	    			xhr1.send(JSON.stringify(jsonCampaign));
	    			console.log(JSON.stringify(jsonCampaign));
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
	    	//檢查活動名稱
	    	function checkCampaignName() {
	    		var campaignName1 = document.getElementById("campaignName1");
	    		let campaignNameValue1 = campaignName1.value;
	    		let campaignName1_msg = document.getElementById("campaignName1_msg");
	    		
	    		let campaignName1Len = campaignNameValue1.length;
	    	    let flag1 = false, flag2 = true;
	    	    
	    	    if (campaignName1Len == "") {
	    	    	campaignName1.classList.remove('is-valid');
	    	    	campaignName1.classList.add('is-invalid');
	    	    	campaignName1_msg.classList.add('invalid-feedback');
	    	    	campaignName1_msg.innerHTML = "(不可空白)";
	    	    } else if (campaignName1Len >= 1 && campaignName1Len <= 20) {
	    	        for (let i = 0; i < campaignName1Len; i++) {
	    	            let char = campaignNameValue1.charAt(i);
	    	            if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
	    	                flag1 = true;
	    	            } else {
	    	                flag2 = false;
	    	                break;
	    	            }
	    	        }
	    	        if (flag1 && flag2) {
	    	        	campaignName1.classList.remove('is-invalid');
	    	        	campaignName1.classList.add('is-valid');
	    	        	campaignName1_msg.innerHTML = "";
	    	        	result = campaignName1_msg.innerHTML;
	    	        } else {
	    	        	campaignName1.classList.remove('is-valid');
	    	        	campaignName1.classList.add('is-invalid');
	    	        	campaignName1_msg.classList.add('invalid-feedback');
	    	        	campaignName1_msg.innerHTML = "(活動名稱必須為中文、英文或數字)";
	    	        }
	    	    } else {
	    	    	campaignName1.classList.remove('is-valid');
	    	    	campaignName1.classList.add('is-invalid');
	    	    	campaignName1_msg.classList.add('invalid-feedback');
	    	    	campaignName1_msg.innerHTML = "(活動名稱字數限制20字內)";
	    	    }
	    	}
	    	
	    	//檢查活動內容
	    	function checkCampaignContent() {
	    		var campaignContent1 = document.getElementById("campaignContent1");
	    		let campaignContentValue1 = campaignContent1.value;
	    		let campaignContent1_msg = document.getElementById("campaignContent1_msg");

	    		let campaignContent1Len = campaignContentValue1.length;
	    		
	    	    let flag1 = false, flag2 = true;
	    	    
	    	    if (campaignContent1Len == "") {
	    	    	campaignContent1.classList.remove('is-valid');
	    	    	campaignContent1.classList.add('is-invalid');
	    	    	campaignContent1_msg.classList.add('invalid-feedback');
	    	    	campaignContent1_msg.innerHTML = "(不可空白)";
	    	    } else if (campaignContent1Len >= 1 && campaignContent1Len <= 50) {
	    	        for (let i = 0; i < campaignContent1Len; i++) {
	    	            let char = campaignContentValue1.charAt(i);
	    	            if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
	    	                flag1 = true;
	    	            } else {
	    	                flag2 = false;
	    	                break;
	    	            }
	    	        }
	    	        if (flag1 && flag2) {
	    	        	campaignContent1.classList.remove('is-invalid');
	    	        	campaignContent1.classList.add('is-valid');
	    	        	campaignContent1_msg.innerHTML = "";
	    	        } else {
	    	        	campaignContent1.classList.remove('is-valid');
	    	        	campaignContent1.classList.add('is-invalid');
	    	        	campaignContent1_msg.classList.add('invalid-feedback');
	    	        	campaignContent1_msg.innerHTML = "(活動內容必須為中文、英文或數字)";
	    	        }
	    	    } else {
	    	    	campaignContent1.classList.remove('is-valid');
	    	    	campaignContent1.classList.add('is-invalid');
	    	    	campaignContent1_msg.classList.add('invalid-feedback');
	    	    	campaignContent1_msg.innerHTML = "(活動內容字數限制50字內)";
	    	    }
	    	}
	    	
	    	//檢查開始和結束時間
	    	function checkStartTime(){
	    		let JStoday = new Date();
	    		let JStoday2 = null;
	    		if(JStoday.getDate() < 10){
	    			JStoday2 = JStoday.getFullYear() + "-" + (JStoday.getMonth()+1) + "-0" + JStoday.getDate();
	    		} else {
	    			JStoday2 = JStoday.getFullYear() + "-" + (JStoday.getMonth()+1) + "-" + JStoday.getDate();
	    		}
	    		
	    		let campaignStart_at1 = document.getElementById("campaignStart_at1");
	    		let campaignStart_atValue = campaignStart_at.value;
	    		let campaignStart_at_msg = document.getElementById("campaignStart_at_msg");
	    		
	    		let campaignEnd_at = document.getElementById("campaignEnd_at");
	    		let campaignEnd_atValue = campaignEnd_at.value;
	    		
	    		console.log("開始msg" + campaignStart_at_msg);
	    		
	    		//取得表單選取日期的時間戳
	    		let ST = Date.parse(campaignStart_atValue);
	    		//取得當天的時間戳
	    		let Today = Date.parse(JStoday2);
	    		if(campaignStart_atValue != ""){
	    			if (ST < Today) {
	    				campaignStart_at.classList.remove('is-valid');
	    				campaignStart_at.classList.add('is-invalid');
	    				campaignStart_at_msg.classList.add('invalid-feedback');
	    				campaignStart_at_msg.innerHTML = "(開始日期不得小於今天)";
	    				
	    			} else {
	    				campaignStart_at.classList.remove('is-invalid');
	    				campaignStart_at.classList.add('is-valid');
	    			}
	    		} else{
	    			
	    			campaignStart_at.classList.remove('is-valid');
	    			campaignStart_at.classList.add('is-invalid');
	    			campaignStart_at_msg.classList.add('invalid-feedback');
	    			campaignStart_at_msg.innerHTML = "(請選取開始時間)";
	    		}
	    	}

	    	function checkEndTime(){
	    		let JStoday = new Date();
	    		let JStoday2 = null;
	    		if(JStoday.getDate() < 10){
	    			JStoday2 = JStoday.getFullYear() + "-" + (JStoday.getMonth()+1) + "-0" + JStoday.getDate();
	    		} else {
	    			JStoday2 = JStoday.getFullYear() + "-" + (JStoday.getMonth()+1) + "-" + JStoday.getDate();
	    		}
	    		
	    		let campaignStart_at = document.getElementById("campaignStart_at");
	    		let campaignStart_atValue = campaignStart_at.value;
	    		
	    		let campaignEnd_at = document.getElementById("campaignEnd_at");
	    		let campaignEnd_atValue = campaignEnd_at.value;
	    		let campaignEnd_at_msg = document.getElementById("campaignEnd_at_msg");
	    		console.log("9+++++++++++++++++++++++++++" + campaignEnd_at_msg);
	    		//取得表單選取日期的時間戳
	    		let ET = Date.parse(campaignEnd_atValue);
	    		
	    		//取得當天的時間戳
	    		let Today = Date.parse(JStoday2);
	    		if(campaignEnd_atValue != ""){
	    			if (ET < Today) {
	    				console.log("1+++++++++++++++++++++++++++");
	    				campaignEnd_at.classList.remove('is-valid');
	    				campaignEnd_at.classList.add('is-invalid');
	    				campaignEnd_at_msg.classList.add('invalid-feedback');
	    				campaignEnd_at_msg.innerHTML = "(結束日期不得小於今天)";
	    			console.log("結束msg" + campaignEnd_at_msg);
	    			
	    			
	    				
	    			} else if (campaignStart_atValue > campaignEnd_atValue) {
	    				console.log("2+++++++++++++++++++++++++++");
	    				campaignEnd_at.classList.remove('is-valid');
	    				campaignEnd_at.classList.add('is-invalid');
	    				campaignEnd_at_msg.classList.add('invalid-feedback');
	    				campaignEnd_at_msg.innerHTML = "(結束日期不得小於開始日期)";
	    				console.log("結束msg1" + campaignEnd_at_msg);

	    				
	    			} else {
	    				campaignEnd_at.classList.remove('is-invalid');
	    				campaignEnd_at.classList.add('is-valid');
	    				console.log("結束msg2" + campaignEnd_at_msg);
	    			}
	    		} else{
	    			campaignEnd_at.classList.remove('is-valid');
	    			campaignEnd_at.classList.add('is-invalid');
	    			campaignEnd_at_msg.classList.add('invalid-feedback');
	    			campaignEnd_at_msg.innerHTML = "(請選取結束日期)";
	    		}
	    		
	    	}
	    	
	    	
	    	//顯示上載圖片
	    	function loadImageFileAsURL(){
	    	    let filesSelected = document.getElementById("campaignPhoto1").files;
	    	    if (filesSelected.length > 0)
	    	    {
	    	        let fileToLoad = filesSelected[0];		
	    	        let fileReader = new FileReader();
	    	        fileReader.onload = function(fileLoadedEvent) 
	    	        {
	    	        	fileDataURL = fileLoadedEvent.target.result;
	    	        	
	    	            console.log("campaignName1=" + fileLoadedEvent.campaignName1);
	    	            console.log("type=" + fileLoadedEvent.type );
	    	            console.log(fileDataURL);
	    	        };

	    	        fileReader.readAsDataURL(fileToLoad);
	    	    }
	    	}
	    	
	    	$("h1").css("color","blue")
	    	$("#campaignPhoto1").change(function(){
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
	    }
    })
}


	    	
</script>
</head>
<body>
	<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>
	<div id='wrapper' align='center'>
		<div id="header">
			<h1>會員活動管理</h1>
			<hr>
		<br><br><br>
		</div>
		<div id="container" align="right">
			<div style="margin-right: 2000px; margin-top: -50px; width: 200px">
				<button class='btn btn-info' style='font-size:15pt' data-bs-toggle='modal' data-bs-target='#create' data-bs-whatever='@getbootstrap'>+ 活動新增</button>					
			</div>
			<br>   	
			<div id="content"></div>
		</div>
	</div>





<!-- //*******呼叫互動式視窗********* -->



<!-- //***********跳出互動式視窗*********** -->

<!--會員活動新增 -->
<div class="modal fade" id="create" tabindex="-1" aria-labelledby="exampleModalLabel" 
	aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">會員活動新增</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form class="forms-sample" novalidate>      
					<input type="hidden" name="id" id='id'>
					<div class="form-group">
						<label for="campaignName">活動名稱</label>
						<input type="text" class="form-control" id="campaignName" name="campaignName" required>
						<span id="campaignName_msg"></span>					
					</div>
					<div class="form-group">
						<label for="campaignContent">活動內容</label>
						<input type="text" class="form-control" id="campaignContent" name="campaignContent" required>
						<span id="campaignContent_msg"></span>
					</div>
					<div class="form-group">
						<label for="campaignStart_at">開始時間</label>
						<input type="date" class="form-control" id="campaignStart_at" name="campaignStart_at" required>
						<span id="campaignStart_at_msg"></span>
					</div>
					<div class="form-group">
						<label for="campaignEnd_at">結束時間</label>
						<input type="date" class="form-control" id="campaignEnd_at" name="campaignEnd_at" required>
						<span id="campaignEnd_at_msg"></span>
					</div>
					<div class="form-group">
						<label for="campaignPhoto">活動用圖</label><br>
						<input id="campaignPhoto" type="file" name="campaignPhoto" class="form-control" 
							accept="image/jpg,image/jpeg,image/png,image/gif" required>
						<span id="campaignPhoto_msg"></span>					
					</div><br>
					<img id="preview_img" src="#" style="height: 300px; width: 300px;
						border-radius:60px 60px 60px 60px ;margin-left:50px">
				</form>
			</div>
			<div class="modal-footer">
				<button id="autoInput" class="btn btn-secondary">自動輸入</button>
				<a id="a" href="${contextRoot}/campaign/insert"><input type="submit" id="submitdata" onclick="checkValue()" class="btn btn-primary me-2" style="margin-left:130px" value="新增" ></a>
				<a href=""><button class="btn btn-secondary" style="margin-left:20px">返回</button></a>
			</div>
		</div>
	</div>
</div>

<!--會員活動編輯 -->
<div class="modal fade" id="edit" tabindex="-1" aria-labelledby="exampleModalLabel" 
	aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">會員活動編輯</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form class="forms-sample" novalidate>      
					<input type="hidden" name="id" id='id'>
					<div class="form-group">
						<label for="campaignName1">活動名稱</label>
						<input type="text" class="form-control" id="campaignName1" name="campaignName1" required>
						<span id="campaignName1_msg"></span>					
					</div>
					<div class="form-group">
						<label for="campaignContent1">活動內容</label>
						<input type="text" class="form-control" id="campaignContent1" name="campaignContent1" required>
						<span id="campaignContent1_msg"></span>
					</div>
					<div class="form-group">
						<label for="campaignStart_at1">開始時間</label>
						<input type="date" class="form-control" id="campaignStart_at1" name="campaignStart_at1" required>
						<span id="campaignStart_at1_msg"></span>
					</div>
					<div class="form-group">
						<label for="campaignEnd_at1">結束時間</label>
						<input type="date" class="form-control" id="campaignEnd_at1" name="campaignEnd_at1" required>
						<span id="campaignEnd_at1_msg"></span>
					</div>
					<div class="form-group">
						<label for="campaignPhoto1">活動用圖</label><br>
						<input id="campaignPhoto1" type="file" name="campaignPhoto1" class="form-control" 
							accept="image/jpg,image/jpeg,image/png,image/gif" required>
						<span id="campaignPhoto1_msg"></span>					
					</div><br>
					<img id="preview_img1" src="#" style="height: 300px; width: 300px;
						border-radius:60px 60px 60px 60px ;margin-left:50px">
				</form>
			</div>
			<div class="modal-footer">
				<div id="resultMsg"></div>
				<a href="#"><input type="submit" id="updateData" class="btn btn-primary me-2" 
					style="margin-left:130px" value="更新" ></a>
				<a href=""><button class="btn btn-secondary" style="margin-left:20px">返回</button></a>
			</div>
		</div>
	</div>
</div>
<script>
//用表單新增活動內容Insert
var fileDataURL = null;
document.getElementById("campaignName").addEventListener("blur", checkCampaignName);
document.getElementById("campaignContent").addEventListener("blur", checkCampaignContent);
document.getElementById("campaignStart_at").addEventListener("blur", checkStartTime);
document.getElementById("campaignEnd_at").addEventListener("blur", checkEndTime);
document.getElementById("campaignPhoto").addEventListener("change", loadImageFileAsURL);
document.getElementById("autoInput").addEventListener("click", autoInput);

function autoInput() {
	document.getElementById("campaignName").value = "蛋特賣會";
	document.getElementById("campaignContent").value = "蛋大特價先搶先贏只有前50組";
	document.getElementById("campaignStart_at").value = "2022-11-09";
	document.getElementById("campaignEnd_at").value = "2022-11-20";
}


//檢查活動名稱
function checkCampaignName() {
	let campaignName = document.getElementById("campaignName");
	let campaignNameValue = campaignName.value;
	let campaignNameLen = campaignNameValue.length;
	let campaignName_msg = document.getElementById("campaignName_msg");
 	let flag1 = false, flag2 = true;
  
  if (campaignNameLen == "") {
  	campaignName.classList.remove('is-valid');
  	campaignName.classList.add('is-invalid');
  	campaignName_msg.classList.add('invalid-feedback');
  	campaignName_msg.innerHTML = "(不可空白)";
  } else if (campaignNameLen >= 1 && campaignNameLen <= 20) {
      for (let i = 0; i < campaignNameLen; i++) {
          let char = campaignNameValue.charAt(i);
          if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
              flag1 = true;
          } else {
              flag2 = false;
              break;
          }
      }
      if (flag1 && flag2) {
      	campaignName.classList.remove('is-invalid');
      	campaignName.classList.add('is-valid');
      	campaignName_msg.innerHTML = "";
      	result = campaignName_msg.innerHTML;
      } else {
      	campaignName.classList.remove('is-valid');
      	campaignName.classList.add('is-invalid');
      	campaignName_msg.classList.add('invalid-feedback');
      	campaignName_msg.innerHTML = "(活動名稱必須為中文、英文或數字)";
      }
  } else {
  	campaignName.classList.remove('is-valid');
  	campaignName.classList.add('is-invalid');
  	campaignName_msg.classList.add('invalid-feedback');
  	campaignName_msg.innerHTML = "(活動名稱字數限制20字內)";
  }
}

//檢查活動內容
function checkCampaignContent() {
	let campaignContent = document.getElementById("campaignContent");
	let campaignContentValue = campaignContent.value;
	let campaignContentLen = campaignContentValue.length;
	let campaignContent_msg = document.getElementById("campaignContent_msg");
  	let flag1 = false, flag2 = true;
  
  	if (campaignContentLen == "") {
  	campaignContent.classList.remove('is-valid');
  	campaignContent.classList.add('is-invalid');
  	campaignContent_msg.classList.add('invalid-feedback');
  	campaignContent_msg.innerHTML = "(不可空白)";
 	} else if (campaignContentLen >= 1 && campaignContentLen <= 50) {
      for (let i = 0; i < campaignContentLen; i++) {
          let char = campaignContentValue.charAt(i);
          if (char >= "\u4e00" && char <= "\u9fff" || char >= "0" && char <= "9" || char >= "A" && char <= "Z" || char >= "a" && char <= "z") {
              flag1 = true;
          } else {
              flag2 = false;
              break;
          }
      }
      if (flag1 && flag2) {
      	campaignContent.classList.remove('is-invalid');
      	campaignContent.classList.add('is-valid');
      	campaignContent_msg.innerHTML = "";
      } else {
      	campaignContent.classList.remove('is-valid');
      	campaignContent.classList.add('is-invalid');
      	campaignContent_msg.classList.add('invalid-feedback');
      	campaignContent_msg.innerHTML = "(活動內容必須為中文、英文或數字)";
      }
  	} else {
  	campaignContent.classList.remove('is-valid');
  	campaignContent.classList.add('is-invalid');
  	campaignContent_msg.classList.add('invalid-feedback');
  	campaignContent_msg.innerHTML = "(活動內容字數限制20字內)";
  	}
}

//檢查開始和結束時間
function checkStartTime(){
	let JStoday = new Date();
	let JStoday2 = null;
	if(JStoday.getDate() < 10){
		JStoday2 = JStoday.getFullYear() + "-" + (JStoday.getMonth()+1) + "-0" + JStoday.getDate();
	} else {
		JStoday2 = JStoday.getFullYear() + "-" + (JStoday.getMonth()+1) + "-" + JStoday.getDate();
	}
	
	let campaignStart_at = document.getElementById("campaignStart_at");
	let campaignStart_atValue = campaignStart_at.value;
	let campaignStart_at_msg = document.getElementById("campaignStart_at_msg");
	
	let campaignEnd_at = document.getElementById("campaignEnd_at");
	let campaignEnd_atValue = campaignEnd_at.value;
	
	console.log("開始msg" + campaignStart_at_msg);
	
	//取得表單選取日期的時間戳
	let ST = Date.parse(campaignStart_atValue);
	//取得當天的時間戳
	let Today = Date.parse(JStoday2);
	if(campaignStart_atValue != ""){
		if (ST < Today) {
			campaignStart_at.classList.remove('is-valid');
			campaignStart_at.classList.add('is-invalid');
			campaignStart_at_msg.classList.add('invalid-feedback');
			campaignStart_at_msg.innerHTML = "(開始日期不得小於今天)";
			
		} else {
			campaignStart_at.classList.remove('is-invalid');
			campaignStart_at.classList.add('is-valid');
		}
	} else{
		
		campaignStart_at.classList.remove('is-valid');
		campaignStart_at.classList.add('is-invalid');
		campaignStart_at_msg.classList.add('invalid-feedback');
		campaignStart_at_msg.innerHTML = "(請選取開始時間)";
	}
}

function checkEndTime(){
	let JStoday = new Date();
	let JStoday2 = null;
	if(JStoday.getDate() < 10){
		JStoday2 = JStoday.getFullYear() + "-" + (JStoday.getMonth()+1) + "-0" + JStoday.getDate();
	} else {
		JStoday2 = JStoday.getFullYear() + "-" + (JStoday.getMonth()+1) + "-" + JStoday.getDate();
	}
	
	let campaignStart_at = document.getElementById("campaignStart_at");
	let campaignStart_atValue = campaignStart_at.value;
	
	let campaignEnd_at = document.getElementById("campaignEnd_at");
	let campaignEnd_atValue = campaignEnd_at.value;
	let campaignEnd_at_msg = document.getElementById("campaignEnd_at_msg");
	console.log("9+++++++++++++++++++++++++++" + campaignEnd_at_msg);
	//取得表單選取日期的時間戳
	let ET = Date.parse(campaignEnd_atValue);
	
	//取得當天的時間戳
	let Today = Date.parse(JStoday2);
	if(campaignEnd_atValue != ""){
		if (ET < Today) {
			console.log("1+++++++++++++++++++++++++++");
			campaignEnd_at.classList.remove('is-valid');
			campaignEnd_at.classList.add('is-invalid');
			campaignEnd_at_msg.classList.add('invalid-feedback');
			campaignEnd_at_msg.innerHTML = "(結束日期不得小於今天)";
		console.log("結束msg" + campaignEnd_at_msg);
		
		
			
		} else if (campaignStart_atValue > campaignEnd_atValue) {
			console.log("2+++++++++++++++++++++++++++");
			campaignEnd_at.classList.remove('is-valid');
			campaignEnd_at.classList.add('is-invalid');
			campaignEnd_at_msg.classList.add('invalid-feedback');
			campaignEnd_at_msg.innerHTML = "(結束日期不得小於開始日期)";
			console.log("結束msg1" + campaignEnd_at_msg);

			
		} else {
			campaignEnd_at.classList.remove('is-invalid');
			campaignEnd_at.classList.add('is-valid');
			console.log("結束msg2" + campaignEnd_at_msg);
		}
	} else{
		campaignEnd_at.classList.remove('is-valid');
		campaignEnd_at.classList.add('is-invalid');
		campaignEnd_at_msg.classList.add('invalid-feedback');
		campaignEnd_at_msg.innerHTML = "(請選取結束日期)";
	}
	
}

//顯示選取圖片

function loadImageFileAsURL(){
	let campaignPhoto = document.getElementById("campaignPhoto");
	let campaignPhoto_msg = document.getElementById("campaignPhoto_msg");
    let filesSelected = campaignPhoto.files;
    
    if (filesSelected.length > 0)
    {
        let fileToLoad = filesSelected[0];		
        let fileReader = new FileReader();
        fileReader.onload = function(fileLoadedEvent) 
        {
        	fileDataURL = fileLoadedEvent.target.result;
        	
            console.log("campaignName=" + fileLoadedEvent.campaignName);
            console.log("type=" + fileLoadedEvent.type );
            console.log(fileDataURL);
        };

        fileReader.readAsDataURL(fileToLoad);
        campaignPhoto.classList.remove('is-invalid');
        campaignPhoto.classList.add('is-valid');
        campaignPhoto_msg.innerHTML = "";
        
    } else {
    	campaignPhoto.classList.remove('is-valid');
    	campaignPhoto.classList.add('is-invalid');
    	campaignPhoto_msg.classList.add('invalid-feedback');
    	campaignPhoto_msg.innerHTML = "(請選擇照片)";
    }
}

function checkValue() {
	
	let campaignName = document.getElementById("campaignName");
	let campaignNameValue = campaignName.value;
	let campaignName_msg = document.getElementById("campaignName_msg");
	
	let campaignContent = document.getElementById("campaignContent");
	let campaignContentValue = campaignContent.value;
	let campaignContent_msg = document.getElementById("campaignContent_msg");
	
	let campaignStart_at = document.getElementById("campaignStart_at");
	let campaignStart_atValue = campaignStart_at.value;
	let campaignStart_at_msg = document.getElementById("campaignStart_at_msg");
	
	let campaignEnd_at = document.getElementById("campaignEnd_at");
	let campaignEnd_atValue = campaignEnd_at.value;
	let campaignEnd_at_msg = document.getElementById("campaignEnd_at_msg");

	let campaignPhoto = document.getElementById("campaignPhoto");
	let campaignPhotoValue = document.getElementById("campaignPhoto").value;
	let campaignPhoto_msg = document.getElementById("campaignPhoto_msg");
	
	let flag1 = true, flag2 = true, flag3 = false, flag4 = false;
	
	if (campaignNameValue == "") {
		campaignName.classList.remove('is-valid');
		campaignName.classList.add('is-invalid');
		campaignName_msg.classList.add('invalid-feedback');
		campaignName_msg.innerHTML = "(不可空白)";
		flag1 = false;
	}
	
	if (campaignContentValue == "") {
		campaignContent.classList.remove('is-valid');
		campaignContent.classList.add('is-invalid');
		campaignContent_msg.classList.add('invalid-feedback');
		campaignContent_msg.innerHTML = "(不可空白)";
		flag2 = false;
	}
	
	//檢查開始時間是否小於結束時間
	if(campaignStart_atValue > campaignEnd_atValue){
		campaignStart_at.classList.remove('is-valid');
		campaignStart_at.classList.add('is-invalid');
		campaignStart_at_msg.classList.add('invalid-feedback');
		campaignStart_at_msg.innerHTML = "(開始日期不得大於結束日期)";
		flag3 = false;
			
	} else {
		campaignStart_at.classList.remove('is-invalid');
		campaignStart_at.classList.add('is-valid');
		flag3 = true;
			
	}
		
	if (campaignPhotoValue == "") {
		campaignPhoto.classList.remove('is-valid');
		campaignPhoto.classList.add('is-invalid');
		campaignPhoto_msg.classList.add('invalid-feedback');
		campaignPhoto_msg.innerHTML = "(請選擇照片)";
		flag4 = false;
		
	} else {
		campaignPhoto.classList.remove('is-invalid');
		campaignPhoto.classList.add('is-valid');
		campaignPhoto_msg.classList.add('valid-feedback');
		campaignPhoto_msg.innerHTML = "";
		flag4 = true;
	}
	
	if (flag1 && flag2 && flag3 && flag4) {		
		let checkAndSendData = () => {
			let campaignNameValue = document.getElementById("campaignName").value;
			let campaignContentValue = document.getElementById("campaignContent").value;
			let campaignStart_atValue = document.getElementById("campaignStart_at").value;
			let campaignEnd_atValue = document.getElementById("campaignEnd_at").value;
			
			let obj = {
					'fileDataUrl': fileDataURL,
    				'campaignName': campaignNameValue,	
    				'campaignContent': campaignContentValue,	
    				'campaignStart_at': campaignStart_atValue,	    		    		
    				'campaignEnd_at': campaignEnd_atValue
					
			};
			
			let campaignJson = JSON.stringify(obj);
			let xhr = new XMLHttpRequest();	
			xhr.open('POST', "<c:url value='/campaign/insert' />" , true);
			xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xhr.send(campaignJson);
			
			console.log("campaignName=" + campaignNameValue + ", campaignContent=" + campaignContentValue  
				+ ", campaignStart_at=" + campaignStart_atValue  + ", campaignEnd_at=" + campaignEnd_atValue);
			console.log("campaignPhoto=" + fileDataURL);
			console.log("json=" + campaignJson);
		}
		checkAndSendData();
		document.getElementById("a").href = "../campaign/findAll";
	}	
}

$("h1").css("color","blue")
$("#campaignPhoto").change(function(){
	readURL(this);
})

function readURL(input){
	if(input.files&&input.files[0]){
	var reader = new FileReader();
	reader.onload = function(e){
		$("#preview_img").attr("src",e.target.result);
		
	}
	reader.readAsDataURL(input.files[0]);
		
	}
}

</script>
</body>
</html>