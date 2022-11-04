<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
			<link rel="shortcut icon" type="image/x-icon" href="${contextRoot}/img/favicon.png">
			<!-- Place favicon.ico in the root directory -->

			<!-- CSS here -->
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
			<%-- <link rel="stylesheet" href="${contextRoot}/css/all.min.css"> --%>
				<link rel="stylesheet" href="${contextRoot}/css/bootstrap-icons.css">
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
				<link rel="stylesheet" href="${contextRoot}/css/burgerstyle.css">
				<!-- <link rel="stylesheet" href="css/responsive.css"> -->
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
												<li><a href="#">會員專區<i class="ti-angle-down"></i></a>
													<ul class="submenu">
														<li><a
																href="${contextRoot}/frontend/EditMemberByMember">編輯個人資料</a>
														</li>
														<li><a href="${contextRoot}/MembergoBankAccount">查看帳戶資訊</a></li>
														<li><a href="${contextRoot}/orders/findAllByMember">訂單查詢</a>
														</li>
														<li><a href="${contextRoot}/campaign">簽到</a></li>
														<li><a href="${contextRoot}/campaign/gameRecord">遊戲紀錄</a></li>
													</ul>
												</li>
												<li><a href="#">最新活動<i class="ti-angle-down"></i></a>
													<ul class="submenu">
														<li><a href="${contextRoot}/campaign/game">商城小遊戲</a></li>
														<li><a href="${contextRoot}/campaign/double11">雙十一購物紅利加倍送</a>
														</li>
													</ul>
												</li>
												
												<li><a href="#">與我聯繫<i class="ti-angle-down"></i></a>
													<ul class="submenu">
														<li><a href="${contextRoot}/message">常見問題</a></li>
														<li><a href="#"
																onclick="window.open('http://localhost:8080/my-app/chatroom.html', 'WebSocket', config='height=1000,width=500');">線上客服</a>
														</li>
														<li><a href="${contextRoot}/mail">客服信箱</a></li>
													</ul>
												</li>
											</ul>
										</nav>
									</div>
								</div>
								<div class="col-xl-2 col-lg-2">
									<div class="logo-img">
										<a href="${contextRoot}/showProduct"> <img src="${contextRoot}/img/logo2.jpg"
												alt="">
										</a>
									</div>
								</div>
								<div class="col-xl-5 col-lg-5 d-none d-lg-block">
									<div class="book_room">
										<div class="dropdown" style="margin-right:5px">
										<a class="dropdown-toggle" href="#" style="background-color:transparent"
											role="button" id="dropdownMenuLink" data-bs-toggle="dropdown"
											aria-expended="false"><img id="personphoto" src="img2/nopicture.jpg" style="object-fit:cover;height: 40px; width: 40px; border-radius: 190px 190px 190px 190px;" ></a>
											<ul class="dropdown-menu dropdown-menu-dark" aria-lableledby="dropdownMenuLink">
												<li><a class="dropdown-item" href="#" id="1">編輯個人資料</a></li>
												<li><a class="dropdown-item" href="#" id="2">個人帳戶查詢</a></li>
												<li><a class="dropdown-item" href="#" id="3">簽到活動管理</a></li>
												<li><a class="dropdown-item" href="#" id="4">遊戲紀錄查詢</a></li>
												<li><a class="dropdown-item" href="#" id="5">登出</a></li>
											</ul>
										</div>
										
										<div class="socail_links">
											<ul>
									
<!-- 												<li><a href="#"> <i class="fa fa-user"></i> -->
<!-- 													</a></li> -->
													<li><a href="${contextRoot}/shoppingCart"><i class="fa fa-cart-shopping" style="font-size:45px"></i>
													</a></li>	
												<li><a href="#" id="dropdownorderLink" data-bs-toggle="dropdown"
														data-bs-auto-close="false" aria-expanded="false">
														<i class="fa-solid fa-bell position-relative" style="font-size:40px">
															<span style="font-size: 0.3em;"
																class="position-absolute top-100 start-100 translate-middle badge rounded-pill bg-danger"></span></i>
													</a>
													<!-- 	購物車內容		     -->
													<div id="orderListContent" class="dropdown-menu p-0 overflow-auto"
														style="max-height:800px;">
														<div>
															<img src="${contextRoot}/img2/54.png"
																style="width:200px;height:200px;"
																class="rounded mx-auto d-block">
														</div>
														<div class="dropdown-divider"></div>
														<p class="fst-italic text-center align-middle fs-4">無商品訂購</p>
													</div>
													<!-- 	購物車內容		     -->
												</li>
												<li><a id="signIn"> <i class="fa fa-calendar-days" style="font-size:40px"></i>
													</a></li>
												<li><a href="#"><i class="fa fa-right-to-bracket" style="font-size:42px"></i>
													</a></li>	
												
											</ul>
										</div>
									
										<div class="book_btn d-none d-xl-block">
											<a class="#" href="${contextRoot}/login" id="loginbtn"
												style="background-color: white;color: orange">登入/註冊</a> <a class="#"
												href="${contextRoot}/logout" id="logoutbtn"
												style="background-color: white;color: orange;display: none">登出</a>
										</div>
										<div style="display: none" id="histatus">
											<a style="color:white">Hi ${member.name}</a>
										</div>
									</div>
									<input type="button" value="切換至後台管理頁面"
										onclick="location.href='${contextRoot}/toBack'"
										style="width:180px;height:40px;">


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
					<div class="single_slider  d-flex align-items-center slider_bg_1 overlay">
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
					<div class="single_slider  d-flex align-items-center slider_bg_2 overlay">
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

					<div class="single_slider  d-flex align-items-center slider_bg_3 overlay">
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
			<%-- <script src="${contextRoot}/js/all.min.js">
				</script> --%>

				<!--contact js-->
				<script src="${contextRoot}/js/contact.js"></script>
				<script src="${contextRoot}/js/jquery.ajaxchimp.min.js"></script>
				<script src="${contextRoot}/js/jquery.form.js"></script>
				<script src="${contextRoot}/js/jquery.validate.min.js"></script>
				<script src="${contextRoot}/js/mail-script.js"></script>
				<script src="${contextRoot}/js/main.js"></script>


				<script>
					// 	簽到禮
					var signIn = document.getElementById("signIn")
					signIn.onclick = function () {
						let xhr = new XMLHttpRequest();
						xhr.open('GET', "<c:url value=" / checkSignIn" />", true);
						xhr.send();
						xhr.onreadystatechange = function () {
							if (xhr.readyState == 4 && xhr.status == 200) {
								let signAlert = JSON.parse(xhr.responseText);
								if (signAlert.game_type == "已完成簽到") {
									Swal.fire("成功!", signAlert.game_type, "success")
								} else {
									Swal.fire("失敗!", signAlert.game_type, "error")
								}
							}
						}
					}
					// 		pill
					function pill() {
						let xhr2 = new XMLHttpRequest();
						xhr2.open('GET', "<c:url value=" / product / pill" />", true);
						xhr2.send();
						xhr2.onreadystatechange = function () {
							if (xhr2.readyState == 4 && xhr2.status == 200) {
								var pillNumber = xhr2.responseText
								if (pillNumber == "") {
									$(".rounded-pill").text("");
								} else {
									let inform = parseInt(pillNumber);
									$(".rounded-pill").text(inform);
								}
							}
						}
					}
					pill();
					// 		show出訂單
					$("#dropdownorderLink").hover(function () {
						let xhr3 = new XMLHttpRequest();
						xhr3.open('GET', "<c:url value=" / product / navbarOrderList" />", true);
						xhr3.send();
						xhr3.onreadystatechange = function () {
							if (xhr3.readyState == 4 && xhr3.status == 200) {
								orderListContent.innerHTML = displayOrder(xhr3.responseText);
							}
						}
					})
					function displayOrder(data) {
						var htmlSeg = "";
						if (data != "") {
							var listorder = JSON.parse(data);
							if (listorder.length > 0) {
								for (var k in listorder) {
									htmlSeg += `<div class="container p-0 m-0">`
									htmlSeg += `<a href=` + "${pageContext.request.contextPath}/product/pillSessionClear" + ` class="list-group-item list-group-item-action m-0 p-0">`;
									htmlSeg += `<img src=` + "${pageContext.request.contextPath}/product/downloadImage/" + listorder[k].product.id + ` style="width:100px;height: 124px;" class=" rounded mx-auto pt-4">`;
									htmlSeg += `<ul class="list-group list-group-flush float-end pt-4 fst-italic" style="width: 250px;">`;
									htmlSeg += `<li class="list-group-item">商品名字: <span>` + listorder[k].product.product_name + `</span></li>`;
									htmlSeg += `<li class="list-group-item">訂購數量: <span>` + listorder[k].orderNumber + `</span></li>`;
									htmlSeg += `</ul>`;
									htmlSeg += `</a></div>`;
									htmlSeg += `<div class="dropdown-divider p-0 m-0"></div>`;
								}
							}
						} else {
							htmlSeg += `<div><img src="${contextRoot}/img2/54.png" style="width:200px;height:200px;" class="rounded mx-auto d-block"></div>`;
							htmlSeg += `<div class="dropdown-divider"></div>`;
							htmlSeg += `<p class="fst-italic text-center align-middle fs-4">無商品訂購</p>`;
						}
						return htmlSeg;
					}
					//登入登出
					function login() {
						var loginstatus = ${ member.id };

						console.log(loginstatus);

						if (loginstatus == "") {
							logoutbtn.style.display = 'none';
							loginbtn.style.display = 'block';
							histatus.style.display = 'none';

						} else {

							logoutbtn.style.display = 'block';
							loginbtn.style.display = 'none';
							histatus.style.display = 'block';

						}
					}
					login();

				</script>

		</body>

		</html>