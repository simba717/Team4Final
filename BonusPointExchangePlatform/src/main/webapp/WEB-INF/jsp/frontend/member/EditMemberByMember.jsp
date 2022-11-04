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
<title>Check and Edit Member</title>
<style>
ul {
	list-style: none;
	height: 25px;
	overflow: hidden;
}
</style>
</head>
<body>
	<jsp:include page="../../layout/Navbar.jsp"></jsp:include>
	<script type="text/javaScript">
		var fileDataURL = null;
		var inputFileToLoad = null;
		var submit = null
		var div1 = null

		window.onload = function() {

			// 			submit.addEventListener('click', click);
			div1 = document.getElementById("div1");
			inputFileToLoad = document.getElementById("inputFileToLoad");
			inputFileToLoad.addEventListener('change', loadImageFileAsURL);

			document.getElementById("password").addEventListener("blur",
					checkPassword);

			document.getElementById("username").addEventListener("blur",
					checkName);

			document.getElementById("birth").addEventListener("blur",
					checkBirth);

			document.getElementById("email").addEventListener("blur",
					checkEmail);

			document.getElementById("phone").addEventListener("blur",
					checkPhone);

			getindex()

			setInterval(function() {
				$("#news li:first-child").slideUp(function() {
					$(this).appendTo($('#news')).slideDown()
				})
			}, 3000)

			$("#edit").click(function() {
				if ($("#password").val() == "") {
					alert("您尚未填寫密碼");
					var password = document.getElementById("password");
					password.focus();
				} else if ($("#username").val() == "") {
					alert("您尚未填寫姓名");
					var username = document.getElementById("username");
					username.focus();
				} else if ($("#birth").val() == "") {
					alert("您尚未填寫生日");
					var birth = document.getElementById("birth");
					birth.focus();
				} else if ($("#email").val() == "") {
					alert("您尚未填寫信箱");
					var email = document.getElementById("email");
					email.focus();
				} else if ($("#phone").val() == "") {
					alert("您尚未填寫電話");
					var phone = document.getElementById("phone");
					phone.focus();
				} else {
					edit();
					getindex();
				}

			})

		}

		function getindex() {
			var url = "<c:url value='/frontned/edit/MemberByMember'/>"
			var obj = {
				'account' : {
					'id' : 2
				}
			}
			var json = JSON.stringify(obj);
			var imageurl = "data:image/jpeg;base64,"

			$
					.ajax({
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

							var birth = data.account.member.birth.substr(0, 10)
									.split('/').join('-')
							$("#exampleInputName1").attr("value",
									data.account.account);
							$("#password").attr("value", data.account.password);
							$("#username").attr("value",
									data.account.member.name);
							$("#birth").attr("value", birth);
							$("#email")
									.attr("value", data.account.member.email);
							$("#phone")
									.attr("value", data.account.member.phone);
							if( data.account.member.image != null){
							$("#preview_img").attr("src",
									imageurl +  data.account.member.image);
							}
							$("#welcome").text(data.account.member.name);
							
							
						}

					})
		}

		function edit() {
			var password = document.getElementById("password").value
			var username = document.getElementById("username").value;
			var birth = document.getElementById("birth").value;
			var email = document.getElementById("email").value;
			var phone = document.getElementById("phone").value;

			var url = "<c:url value='/edit/member' />"
			var object = {
				'account' : {
					'password' : password
				},
				'image' : fileDataURL,
				'name' : username,
				'birth' : birth,
				'email' : email,
				'phone' : phone
			};
			var json = JSON.stringify(object);
			$.ajax({
				url : url,
				method : 'post',
				data : json,
				contentType : 'application/json;charset=UTF-8',
				dataType : 'json',
				error : function() {
					alert("編輯失敗,請重新輸入")
				},
				success : function(data) {
					alert("編輯成功")
					window.location.reload();
				}
			});

		}

		//************照片載入***************
		function loadImageFileAsURL() {
			let filesSelected = document.getElementById("inputFileToLoad").files;
			if (filesSelected.length > 0) {
				let fileToLoad = filesSelected[0];

				let fileReader = new FileReader();

				fileReader.onload = function(fileLoadedEvent) {
					fileDataURL = fileLoadedEvent.target.result;

				};

				fileReader.readAsDataURL(fileToLoad);
			}
		}

		//************確認密碼*************
		function checkPassword() {
			let StrObj = document.getElementById("password");
			let showpassword = document.getElementById("idsp1");
			let v = document.querySelector("#password");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {

				showpassword.innerHTML = ("輸入正確");
				v.classList.remove("is-invalid");
				v.classList.add("is-valid");
				showpassword.style = "color:green;font-size:14px";

			} else {
				showpassword.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showpassword.style = "color:red;font-size:14px";

			}
			
			if ($("#password").val() == "" || $("#username").val() == "" || $("#birth").val() == ""
				|| $("#email").val() == ""
				|| $("#phone").val() == "" ) {
			$("#edit").prop("disabled", true)
		} else {
			$("#edit").prop("disabled", false)
		}
		}

		//*********確認名字***********
		function checkName() {
			let StrObj = document.getElementById("username");
			let showname = document.getElementById("idsp2");
			let v = document.querySelector("#username");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {
				if (StrObjname.charAt(1) != "") {
					for (let i = 0; i < StrObjname.length; i++) {
						let ch = StrObjname.charCodeAt(i);
						if (ch >= 0x4e00 && ch <= 0x9fff) {
							v.classList.remove("is-invalid");
							v.classList.add("is-valid");
							showname.innerHTML = ("輸入正確")
							showname.style = "color:green;font-size:14px";
						} else {
							v.classList.remove("is-valid");
							v.classList.add("is-invalid");
							showname.innerHTML = ("建議輸入中文")
							showname.style = "color:red;font-size:14px";
							break;
						}
					}
				} else {
					showname.innerHTML = ("至少兩個字以上");
					v.classList.remove("is-valid");
					v.classList.add("is-invalid");
					showname.style = "color:red;font-size:14px";

				}
			} else {
				showname.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showname.style = "color:red;font-size:14px";

			}
			
			if ($("#password").val() == "" || $("#username").val() == "" || $("#birth").val() == ""
				|| $("#email").val() == ""
				|| $("#phone").val() == "" ) {
			$("#edit").prop("disabled", true)
		} else {
			$("#edit").prop("disabled", false)
		}
		}

		//************確認生日*************
		function checkBirth() {
			let StrObj = document.getElementById("birth");
			let showbirth = document.getElementById("idsp3");
			let v = document.querySelector("#birth");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {

				showbirth.innerHTML = ("輸入正確");
				v.classList.remove("is-invalid");
				v.classList.add("is-valid");
				showbirth.style = "color:green;font-size:14px";

			} else {
				showbirth.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showbirth.style = "color:red;font-size:14px";

			}
			
			if ($("#password").val() == "" || $("#username").val() == "" || $("#birth").val() == ""
				|| $("#email").val() == ""
				|| $("#phone").val() == "" ) {
			$("#edit").prop("disabled", true)
		} else {
			$("#edit").prop("disabled", false)
		}
		}

		//************確認信箱*************
		function checkEmail() {
			let StrObj = document.getElementById("email");
			let showemail = document.getElementById("idsp4");
			let v = document.querySelector("#email");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {

				showemail.innerHTML = ("輸入正確");
				v.classList.remove("is-invalid");
				v.classList.add("is-valid");
				showemail.style = "color:green;font-size:14px";

			} else {
				showemail.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showemail.style = "color:red;font-size:14px";

			}
			
			if ($("#password").val() == "" || $("#username").val() == "" || $("#birth").val() == ""
				|| $("#email").val() == ""
				|| $("#phone").val() == "" ) {
			$("#edit").prop("disabled", true)
		} else {
			$("#edit").prop("disabled", false)
		}
		}

		//************確認電話*************
		function checkPhone() {
			let StrObj = document.getElementById("phone");
			let showphone = document.getElementById("idsp5");
			let v = document.querySelector("#phone");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {

				showphone.innerHTML = ("輸入正確");
				v.classList.remove("is-invalid");
				v.classList.add("is-valid");
				showphone.style = "color:green;font-size:14px";

			} else {
				showphone.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showphone.style = "color:red;font-size:14px";

			}
			
			if ($("#password").val() == "" || $("#username").val() == "" || $("#birth").val() == ""
				|| $("#email").val() == ""
				|| $("#phone").val() == "" ) {
			$("#edit").prop("disabled", true)
		} else {
			$("#edit").prop("disabled", false)
		}
		}
	</script>

	<br>
	<br>
	<br>
	<br>



	<div
		class="col-12 grid-margin stretch-card shadow p-3 mb-5 bg-body rounded"
		style="height: 700px; width: 600px; margin-left: 250px; float: left;">
		<div class="card" style="border-radius: 30px 30px 30px 30px;">
			<div class="card-body" style="height: 600px; margin-top: 40px">
				<h3 class="card-title">會員個人資料編輯</h3>

				<form class="forms-sample" id="form">
					<div class="form-group">
						<label for="exampleInputName1">Account</label> <input type="text"
							class="form-control"
							style="color: #7b7b7b; background-color: #f0f0f0"
							id="exampleInputName1" placeholder="Name" value="" readonly
							style="backround-color:grey">
					</div>
					<div class="form-group">

						<label for="exampleInputEmail3">Password</label><div
							style="text-align: right; margin-right: 12px; margin-bottom: -30px";>
							<i class="show_pass fa-solid fa-eye-slash" id="icon"></i>
						</div><input
							type="password" class="form-control" id="password"
							placeholder="password" value="" />
						<div id="idsp1" style="font-size: 20px"></div>
						

					</div>
					<div class="form-group">
						<label for="exampleInputPassword4">Name</label> <input type="text"
							class="form-control" id="username" name="username"
							placeholder="username" value="">
						<div id="idsp2" style="font-size: 20px"></div>
					</div>

					<div class="form-group">
						<label for="exampleInputCity1">Birth</label> <input type="date"
							class="form-control" id="birth" placeholder="birth" value="">
						<div id="idsp3" style="font-size: 20px"></div>
					</div>


					<div class="form-group">
						<label for="exampleInputCity1">Email</label> <input type="email"
							class="form-control" id="email" placeholder="email" value="">
						<div id="idsp4" style="font-size: 20px"></div>
					</div>

					<div class="form-group">
						<label for="exampleInputCity1">Phone</label> <input type="text"
							class="form-control" id="phone" placeholder="phone" value="">
						<div id="idsp5" style="font-size: 20px"></div>
					</div>

					<div class="form-group" style="margin-top: 20px">
						<label>Please select a photo</label><br> <input
							id="inputFileToLoad" type="file" name="photo"
							onchange="loadImageFileAsURL()" class="file-upload-default">


					</div>

				</form>
			</div>
		</div>
	</div>
	<div style="text-align: center">
		<img id="preview_img" src="../img2/nophoto.png"
			style="height: 400px; width: 400px; border-radius: 190px 190px 190px 190px;">

		<br> <br> <br>
		<h2>
			歡迎您登入編輯頁面 : <span id="welcome"></span>
		</h2>
		<br>
		<ul id="news">
			<li style="color: red">小編貼心提醒您~~~</li>
			<li style="color: red">現在參加簽到活動免費贈送紅利點數</li>
			<li style="color: red">還不趕快透過上方連結簽到 ?</li>
		</ul>

		<br> <br>
		<div style="justify-content: center;">
			<input type="button" id="edit" class="btn btn-primary me-2"
				value="確認送出" display="none">
			<button class="btn btn-danger" style="margin-left: 20px"
				onclick="window.location.reload()">取消編輯</button>
		</div>



		<!-- 							<button id="edit" type="button">Submit</button>  -->
		<!-- <div> -->
		<!-- 		<table> -->

		<!-- 			<tr height='36'> -->
		<!-- 				<td width='120' align='right'>會員密碼：</td> -->
		<!-- 				<td><input id='password' type="text" name="password" size="10"></td> -->
		<!-- 			</tr> -->
		<!-- 			<tr height='36'> -->
		<!-- 				<td width='120' align='right'>會員姓名：</td> -->
		<!-- 				<td><input id='username' type="text" name="username" size="20"></td> -->
		<!-- 			</tr> -->
		<!-- 			<tr height='36'> -->
		<!-- 				<td width='120' align='right'>會員生日：</td> -->
		<!-- 				<td><input id='birth' type="text" name="birth" size="20"></td> -->
		<!-- 			</tr> -->
		<!-- 			<tr height='36'> -->
		<!-- 				<td width='120' align='right'>會員郵件：</td> -->
		<!-- 				<td><input id='email' type="text" name="email" size="20"></td> -->
		<!-- 			</tr> -->
		<!-- 			<tr height='36'> -->
		<!-- 				<td width='120' align='right'>會員電話：</td> -->
		<!-- 				<td><input id='phone' type="text" name="phone" size="20"></td> -->
		<!-- 			</tr> -->
		<!-- 			<tr height='36'> -->
		<!-- 				<td width='120' align='right'>圖片名稱：</td> -->
		<!-- 				<td><input id='photoName' type="text" name="photoName" -->
		<!-- 					size="20"></td> -->
		<!-- 				<td><input id="inputFileToLoad" type="file" name="file" -->
		<!-- 					onchange="loadImageFileAsURL()" /> <img id="preview_img2" -->
		<!-- 					src="#" style="height: 100px; width: 100px"></td> -->
		<!-- 			</tr> -->

		<!-- 		</table> -->
		<!-- 		<input type="button" id="edit" value="編輯會員"> -->
		<!-- 	</div> -->



		<!-- <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script> -->
		<script>
			$("#icon").click(
					function() {
						let pass_type = $("#password").attr("type");
						console.log(pass_type)

						if (pass_type === "password") {
							$("#password").attr("type", "type");
							$("#icon").removeClass("fa-solid fa-eye-slash")
									.addClass("fa-solid fa-eye")
						} else {
							$("#password").attr("type", "password");
							$("#icon").removeClass("fa-solid fa-eye").addClass(
									"fa-solid fa-eye-slash")
						}
					})

			$("#inputFileToLoad").change(function() {
				readURL(this);
			})

			function readURL(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$("#preview_img").attr("src", e.target.result);

					}
					reader.readAsDataURL(input.files[0]);

				}
			}
		</script>
</body>

</html>