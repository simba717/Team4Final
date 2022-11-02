<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<main>
		<h1>會員註冊</h1>
		<form action="" method="post" enctype="multipart/form-data">
			<section>
				<label>帳號</label>
				<div class="input-area">
					<input type="text" name="account" placeholder="請輸入您的帳號" />
				</div>
			</section>

			<section>
				<label>密碼</label>
				<div>
					<input type="text" name="password" maxlength="16"
						placeholder="請輸入您的密碼" />
				</div>
			</section>

			<section>
				<label>姓名</label>
				<div>
					<input type="text" name="name" maxlength="16" placeholder="請輸入您的姓名" />
				</div>
			</section>


			<section>
				<label>生日</label>
				<div>
					<input type="date" name="birth" />
				</div>
			</section>

			<section>
				<label>手機</label>
				<div>
					<input type="text" name="phone" maxlength="16"
						placeholder="請輸入您的手機號碼" />
				</div>
			</section>

			<section>
				<label>信箱</label>
				<div>
					<input type="text" name="email" placeholder="請輸入您的信箱" />
				</div>
			</section>




			<section>
				<label>銀行帳號</label>
				<div>
					<input type="text" name="account_no" maxlength="16"
						placeholder="請輸入您的銀行帳號" />
				</div>
			</section>

			<section>
				<label>頭貼上傳</label>
				<div>
					<input type="file" id="file" accept="image/*"
						name="image"  />
				</div>
			</section>
			
			
			
<!-- 			<script type="text/javascript"> 
// 				function blobToDataURL(blob, cb) {
// 					let reader = new FileReader();
// 					reader.onload = function(evt) {
// 						var base64 = evt.target.result 
// 						cb(base64)
// 					};
// 					reader.readAsDataURL(blob);
// 				}

// 				var file = document.getElementById("file");
				
// 				function changeImg() {
// 					console.log("1234567")
// 					var img = file.files[0]
// 					if (img) {
// 						var url = URL.createObjectURL(img);
// 						var base64 = blobToDataURL(img, function(base64Url) {
// 							console.log(base64Url)
// 						})
// 					}
// 				}
<!-- 			</script>  -->


			<input type="Submit" value="提交">
		</form>
	</main>





</body>
</html>