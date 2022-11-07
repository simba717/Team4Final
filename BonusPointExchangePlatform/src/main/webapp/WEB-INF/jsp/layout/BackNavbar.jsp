<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="chrome=1">
<title>紅利商城平台</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- <link rel="manifest" href="site.webmanifest"> -->
<link rel="shortcut icon" type="image/x-icon"
	href="${contextRoot}/img/favicon.png">
<!-- Place favicon.ico in the root directory -->
<script src="https://code.jquery.com/jquery-3.6.1.js"
	integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI="
	crossorigin="anonymous"></script>
<!-- CSS here -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">
<link rel="stylesheet" href="${contextRoot}/css/owl.carousel.min.css">
<link rel="stylesheet" href="${contextRoot}/css/magnific-popup.css">
<link rel="stylesheet" href="${contextRoot}/css/font-awesome.min.css">
<link rel="stylesheet" href="${contextRoot}/css/themify-icons.css">
<link rel="stylesheet" href="${contextRoot}/css/nice-select.css">
<link rel="stylesheet" href="${contextRoot}/css/flaticon.css">
<link rel="stylesheet" href="${contextRoot}/css/animate.css">
<link rel="stylesheet" href="${contextRoot}/css/slicknav.css">
<link rel="stylesheet" href="${contextRoot}/css/style1.css">
<!-- <link rel="stylesheet" href="css/responsive.css"> -->
<script>

				$(function () {

					if (${ account.account_type } == 3) {
					$("#highclass").css('visibility', 'visible');
				}else {
					$("#highclass").css('visibility', 'hidden');
				}


				loadpage();
    })




				function loadpage() {
					var imageurl = "data:image/jpeg;base64,"
					var url = "<c:url value='/frontend/employee/iconphoto'/>"
					var object = {
						'account': {
							'id': ${ employee.id }

				}
						};
				var json = JSON.stringify(object);

				$.ajax({

					url: url,
					method: 'post',
					data: json,
					contentType: 'application/json;charset=UTF-8',
					dataType: 'json',
					error: function () {
						alert("ajax error")
					},

					success: function (data) {
						console.log(data)
							if (data.image) {
								$("#personphoto").attr("src", imageurl + data.image)
							}
							else{
								$("#personphoto").attr("src", "${contextRoot}/img2/nopicture.jpg")
							}
					}

				})

				}

			</script>
</head>

<body>
	<header>
		<div class="header-area">
			<div id="sticky-header" class="main-header-area">
				<div class="container-fluid p-0">
					<div class="row align-items-center no-gutters">
						<div class="col-xl-5 col-lg-5">
							<div class="main-menu  d-none d-lg-block">
								<nav>
									<ul id="navigation">
										<li><a href="#">個人資料系統<i class="ti-angle-down1"></i></a>
											<ul class="submenu">
												<li><a
													href="${contextRoot}/backend/EditEmployeeByEmployee">編輯個人資料</a>
												</li>
												<li><a href="${contextRoot}/EditByRoot">編輯會員資料</a></li>
												<li id="highclass" style="visibility: hidden"><a
													href="${contextRoot}/EditByRoot1">編輯員工資料</a></li>
											</ul></li>
										<li><a href="#">活動管理系統<i class="ti-angle-down"></i></a>
											<ul class="submenu">
												<li><a href="${contextRoot}/campaign/findAll">會員活動管理</a></li>
												<li><a href="${contextRoot}/game/GameBonus">會員遊戲紅利</a></li>
											</ul></li>

										<li><a href="#">商城管理系統<i class="ti-angle-down"></i></a>
											<ul class="submenu">
												<li><a href="${contextRoot}/product/findAll">商品管理</a></li>
												<li><a href="${contextRoot}/orders/findAll">訂單管理</a></li>
											</ul></li>

										<li><a href="#">數據圖表系統<i class="ti-angle-down"></i></a>
											<ul class="submenu">
												<li><a href="${contextRoot}/mainsearch">報表管理</a></li>
											</ul></li>
									</ul>
								</nav>
							</div>
						</div>
						<div class="col-xl-2 col-lg-2">
							<div class="logo-img">
								<a href="${contextRoot}/mainsearch"> <img
									src="${contextRoot}/img/logo2.jpg" alt="">
								</a>
							</div>
						</div>

						<div class="col-xl-5 col-lg-5 d-none d-lg-block">
							<div class="book_room">
								<div class="dropdown" style="margin-right: 5px; display:none;"
									id="memberdiv">
									<a class="dropdown-toggle" href="#"
										style="background-color: transparent" role="button"
										id="dropdownMenuLink" data-bs-toggle="dropdown"
										aria-expended="false"><img id="personphoto"
										src="${contextRoot}/img2/nopicture.jpg"
										style="object-fit: cover; height: 40px; width: 40px; border-radius: 190px 190px 190px 190px;"></a>
									<ul class="dropdown-menu dropdown-menu-dark"
										aria-lableledby="dropdownMenuLink">
										<li><a class="dropdown-item"
											href="${contextRoot}/backend/EditEmployeeByEmployee" id="1">編輯個人資料</a></li>
										<li><a class="dropdown-item" href="#" id="2">登出</a></li>
									</ul>
								</div>
								<div class="socail_links">
									<ul>

										<li style="margin-right: 5px;"><a href="#"> <i
												class="fa-regular fa-envelope" style="font-size: 40px"></i>
										</a></li>
										<li style="margin-right: 5px;"><a
											href="${contextRoot}/toFront"><i
												class="fa fa-right-from-bracket" style="font-size: 40px"></i>

										</a></li>
									</ul>
								</div>

								<div class="book_btn d-none d-xl-block">
									<a class="#" href="${contextRoot}/loginEmp" id="loginbtn">登入</a>
									<a class="#" href="${contextRoot}/logoutEmp" id="logoutbtn"
										style="display: none">登出</a>
								</div>

							</div>
							<!--          <input type="button" value="切換至前台會員頁面" -->
							<%-- onclick="location.href='${contextRoot}/toFront'" --%>
							<!--           style="width:180px;height:40px;"> -->

						</div>



						<div class="col-12">
							<div class="mobile_menu d-block d-lg-none"></div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</header>






	<!-- JS here -->
	<script src="${contextRoot}/js/vendor/modernizr-3.5.0.min.js"></script>
	<script src="${contextRoot}/js/jquery-3.6.1.min.js"></script>
	<script src="${contextRoot}/js/popper.min.js"></script>
	<script src="${contextRoot}/js/bootstrap.bundle.js"></script>
	<script src="${contextRoot}/js/owl.carousel.min.js"></script>
	<script src="${contextRoot}/js/isotope.pkgd.min.js"></script>
	<script src="${contextRoot}/js/ajax-form.js"></script>
	<script src="${contextRoot}/js/jquery.waypoints.min.js"></script>
	<script src="${contextRoot}/js/jquery.counterup.min.js"></script>
	<script src="${contextRoot}/js/imagesloaded.pkgd.min.js"></script>
	<script src="${contextRoot}/js/scrollIt.js"></script>
	<script src="${contextRoot}/js/jquery.scrollUp.min.js"></script>
	<script src="${contextRoot}/js/wow.min.js"></script>
	<script src="${contextRoot}/js/nice-select.min.js"></script>
	<script src="${contextRoot}/js/jquery.slicknav.min.js"></script>
	<script src="${contextRoot}/js/jquery.magnific-popup.min.js"></script>
	<script src="${contextRoot}/js/plugins.js"></script>
	<script src="${contextRoot}/js/sweetalert2.all.min.js"></script>

	<!--contact js-->
	<script src="${contextRoot}/js/contact.js"></script>
	<script src="${contextRoot}/js/jquery.ajaxchimp.min.js"></script>
	<script src="${contextRoot}/js/jquery.form.js"></script>
	<script src="${contextRoot}/js/jquery.validate.min.js"></script>
	<script src="${contextRoot}/js/mail-script.js"></script>
	<script src="${contextRoot}/js/main1.js"></script>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<script>
				function loginback() {
					var loginstatus = ${ employee.id };

					console.log(loginstatus);

					if (loginstatus == "") {
						logoutbtn.style.display = 'none';
						loginbtn.style.display = 'block';
						memberdiv.style.display='none';

					} else {

						logoutbtn.style.display = 'block';
						loginbtn.style.display = 'none';
						memberdiv.style.display='block';


					}
				}
				loginback();

			</script>

</body>

</html>