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
<link rel="stylesheet" href="${contextRoot}/css/style.css">
<!-- <link rel="stylesheet" href="css/responsive.css"> -->

<script type="text/javaScript">
	window.onload = function() {
		page()

		// 		<img width='40' height='48' src='"+imageurl
//         + data[i].member.image + "'>

	}

	function page() {
		var imageurl = "data:image/jpeg;base64,"
		var url = "<c:url value='/frontend/member/iconphoto'/>"
		var object = {
			'account' : {
				'id' : 5
			}
		};
		var json = JSON.stringify(object);

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
				$("#iconphoto").attr("src", imageurl + data.member.image)
			}

		})

	}
</script>
</head>

<body>
	<header>
		<div class="header-area ">
			<div id="sticky-header" class="main-header-area">
				<div class="container-fluid p-0">
					<div class="row align-items-center no-gutters">
						<div class="col-xl-5 col-lg-5">
							<div class="main-menu  d-none d-lg-block">
								<nav>
									<ul id="navigation">
										<li><a href="about.html">會員專區<i class="ti-angle-down"></i></a>
											<ul class="submenu">
												<li><a href="blog.html">個人資料</a></li>
												<li><a href="single-blog.html">查看帳戶</a></li>
												<li><a href="single-blog.html">紅利點數</a></li>
												<li><a href="single-blog.html">訂單查詢</a></li>
											</ul></li>
										<li><a href="about.html">最新活動<i class="ti-angle-down"></i></a>
											<ul class="submenu">
												<li><a href="blog.html">快速獲得紅利</a></li>
												<li><a href="single-blog.html">限時加碼活動</a></li>
											</ul></li>
										<li><a href="#">紅利商城<i class="ti-angle-down"></i></a>
											<ul class="submenu">
												<li><a href="${contextRoot}/product/create">商品新增</a></li>
												<li><a href="${contextRoot}/product/findAll">商品總覽</a></li>
												<li><a href="${contextRoot}/orders/findAll">員工訂單查詢</a></li>
												<li><a href="${contextRoot}/orders/findAllByMember">會員訂單查詢</a>
												</li>
												<li><a href="single-blog.html">購物車</a></li>
											</ul></li>
										<li><a href="#">與我聯繫<i class="ti-angle-down"></i></a>
											<ul class="submenu">
												<li><a href="blog.html">常見問題</a></li>
												<li><a href="single-blog.html">線上客服</a></li>
											</ul></li>
									</ul>
								</nav>
							</div>
						</div>
						<div class="col-xl-2 col-lg-2">
							<div class="logo-img">
								<a href="${contextRoot}"> <img
									src="${contextRoot}/img/logo.png" alt="">
								</a>
							</div>
						</div>
						<div class="col-xl-5 col-lg-5 d-none d-lg-block">
							<div class="book_room">
								<div class="socail_links">
									<ul>

										<li><a href="#"> <i class="fa fa-user"></i>
										</a></li>
										<li><a href="#"> <i class="fa-solid fa-cart-shopping"></i>
										</a></li>
										<li><a href="#"> <i class="fa fa-calendar-days"></i>
										</a></li>
									</ul>
									<div class="dropdown">
										<a class="btn btn-secondary dropdown-toggle" href="#"
											role="button" id="dropdownMenuLink" data-bs-toggle="dropdown"
											aria-expended="false">
											<ul class="dropdown-menu" aria-lableledby="dropdownMenuLink">

												<li><a class="dropdown-item" href="#" id="1">編輯個人資料</a></li>
												<li><a class="dropdown-item" href="#" id="2">個人帳戶查詢</a></li>
												<li><a class="dropdown-item" href="#" id="3">簽到活動管理</a></li>
												<li><a class="dropdown-item" href="#" id="4">遊戲紀錄查詢</a></li>
												<li><a class="dropdown-item" href="#" id="5">登出</a></li>
											</ul>
									</div>

								</div>
								<div class="book_btn d-none d-xl-block">
									<a class="#" href="${contextRoot}/login">登入 or 註冊</a> <a
										class="#" href="${contextRoot}/logout">登出</a>

								</div>
							</div>
						</div>
						<div class="col-12">
							<div class="mobile_menu d-block d-lg-none"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>

	<div class="slider_area">
		<div class="slider_active owl-carousel">
			<div
				class="single_slider  d-flex align-items-center slider_bg_1 overlay">
				<div class="container">
					<div class="row align-items-center justify-content-center">
						<div class="col-xl-9 col-md-9 col-md-12">
							<div class="slider_text text-center">
								<div class="deal_text">
									<span>Mall</span>
								</div>
								<h3>
									Burger <br> Bachelor
								</h3>
								<h4>Maxican</h4>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div
				class="single_slider  d-flex align-items-center slider_bg_2 overlay">
				<div class="container">
					<div class="row align-items-center justify-content-center">
						<div class="col-xl-9 col-md-9 col-md-12">
							<div class="slider_text text-center">
								<div class="deal_text">
									<span>Mall</span>
								</div>
								<h3>
									Burger <br> Bachelor
								</h3>
								<h4>Maxican</h4>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div
				class="single_slider  d-flex align-items-center slider_bg_3 overlay">
				<div class="container">
					<div class="row align-items-center justify-content-center">
						<div class="col-xl-9 col-md-9 col-md-12">
							<div class="slider_text text-center">
								<div class="deal_text">
									<span>Big Deal</span>
								</div>
								<h3>
									Burger <br> Bachelor
								</h3>
								<h4>Maxican</h4>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- JS here -->
	<script src="${contextRoot}/js/vendor/modernizr-3.5.0.min.js"></script>
	<script src="${contextRoot}/js/vendor/jquery-1.12.4.min.js"></script>
	<script src="${contextRoot}/js/popper.min.js"></script>
	<script src="${contextRoot}/js/bootstrap.min.js"></script>
	<script src="${contextRoot}/js/owl.carousel.min.js"></script>
	<script src="${contextRoot}/js/isotope.pkgd.min.js"></script>
	<script src="${contextRoot}/js/ajax-form.js"></script>
	<script src="${contextRoot}/js/waypoints.min.js"></script>
	<script src="${contextRoot}/js/jquery.counterup.min.js"></script>
	<script src="${contextRoot}/js/imagesloaded.pkgd.min.js"></script>
	<script src="${contextRoot}/js/scrollIt.js"></script>
	<script src="${contextRoot}/js/jquery.scrollUp.min.js"></script>
	<script src="${contextRoot}/js/wow.min.js"></script>
	<script src="${contextRoot}/js/nice-select.min.js"></script>
	<script src="${contextRoot}/js/jquery.slicknav.min.js"></script>
	<script src="${contextRoot}/js/jquery.magnific-popup.min.js"></script>
	<script src="${contextRoot}/js/plugins.js"></script>

	<!--contact js-->
	<script src="${contextRoot}/js/contact.js"></script>
	<script src="${contextRoot}/js/jquery.ajaxchimp.min.js"></script>
	<script src="${contextRoot}/js/jquery.form.js"></script>
	<script src="${contextRoot}/js/jquery.validate.min.js"></script>
	<script src="${contextRoot}/js/mail-script.js"></script>
	<script src="${contextRoot}/js/main.js"></script>
</body>

</html>