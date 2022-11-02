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
<title></title>
<style>
.arrow-left {
	background-color: white;
	border-right: 1px 0px 1px 0px solid black;
	font-color: black;
	vertial-align: middle;
	display: inline-block;
	display: flex;
	content: "";
	margin-top: 5px;
}

.arrow-right {
	background-color: white;
	border-left: 1px 0px 1px 0px solid black;
	font-color: black;
	vertial-align: middle;
	display: inline-block;
	display: flex;
	content: "";
	margin-top: 5px;
}

.arrow-number {
	background-color: white;
	font-color: black;
	vertial-align: middle;
	display: inline-block;
	align: center;
	display: flex;
	content: "";
	margin-top: 5px;
	width: 35px;
}
</style>
<script type="text/javaScript">
	//*************載入頁面後立刻觸發功能**********
	window.onload = function() {

		// 		****************頁面載入後員工的事件捕捉*************
		employeeimage1 = document.getElementById("employeeimage1");
		employeeimage1.addEventListener('change', loadImageFileAsURL1);
		send1 = document.getElementById("send1");
		send1.addEventListener('click', click1);
		search1 = document.getElementById("search1");

		document.getElementById("employeename1").addEventListener("blur",
				checkName);

		document.getElementById("employeeno1")
				.addEventListener("blur", checkNo);

		document.getElementById("employeearrived1").addEventListener("blur",
				checkArrived);

		document.getElementById("employeephone1").addEventListener("blur",
				checkPhone);

		document.getElementById("employeeemail1").addEventListener("blur",
				checkEmail);

		$("#send1").click(
				function() {

					if ($("#employeename1").val() == "") {
						alert("您尚未填寫員工名稱");
						var employeename1 = document
								.getElementById("employeename1");
						employeename1.focus();

					} else if ($("#employeeno1").val() == "") {
						alert("您尚未填寫員工編號");
						var employeeno1 = document
								.getElementById("employeeno1");
						employeeno1.focus();

					} else if ($("#employeearrived1").val() == "") {
						alert("您尚未填寫員工到職日");
						var employeearrived1 = document
								.getElementById("employeearrived1");
						employeearrived1.focus();

					} else if ($("#employeephone1").val() == "") {
						alert("您尚未填寫員工電話");
						var employeephone1 = document
								.getElementById("employeephone1");
						employeephone1.focus();
					} else if ($("#employeeemail1").val() == "") {
						alert("您尚未填寫員工信箱");
						var employeeemail1 = document
								.getElementById("employeeemail1");
						employeeemail1.focus();
					} else {
						click1();
						window.location.reload();
						page1();
					}

				})

		// 		**************員工排序方式事件捕捉**************
		$("input[name=flexRadioDefault1]")
				.change(
						function() {

							orderby1 = $(
									"input:radio:checked[name='flexRadioDefault1']")
									.val();

							var value2 = document.getElementById("search1").value
							var url1 = "<c:url value='/backned/allEmployeeSearch'/>"
							var obj1 = {
								'name' : value2,
								'orderby' : orderby1
							}
							var json1 = JSON.stringify(obj1);
							var imageurl = "data:image/jpeg;base64,"
							console.log(json1)
							$
									.ajax({
										url : url1,
										method : 'post',
										data : json1,
										contentType : 'application/json;charset=UTF-8',
										dataType : 'json',
										error : function() {
											alert("ajax error")
										},
										success : function(data) {
											console.log(data)
											rowTotal1 = data.length;
											pageTotal1 = Math.ceil(rowTotal1
													/ pageSize1);
											currentPage1 = 1;
											if (pageTotal1 == 1) {
												$("#page_ul1").empty();
												$("#table1 tbody").empty();
												for (var i = 0; i < pageSize1; i++) {
													if (data[i].account_type == 2) {
														$("#table1 tbody")
																.append(
																		$("<tr><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].employee.id
																				+ "</td><td>"
																				+ data[i].employee.name
																				+ "</td><td>"
																				+ data[i].employee.employee_no
																				+ "</td><td>"
																				+ data[i].arrived_date
																				+ "</td><td>"
																				+ data[i].employee.phone
																				+ "</td><td>"
																				+ data[i].employee.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
									         + data[i].employee.image + "'></td><td>"
																				+ data[i].create_date
																				+ "</td><td>"
																				+ data[i].update_date
																				+ "</td><td><input id='"
																				+ data[i].employee.id
																				+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
																				+ "</td><td><input type='button' class='btn btn-danger' id='"
																				+ data[i].employee.id
																				+ "' name='"
																				+ data[i].account_type
																				+ "'onclick='check(this)' value='停權'/></td></tr>"));
													} else {
														$("#table1 tbody")
																.append(
																		$("<tr style='background:#D0D0D0;color:red;'><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].employee.id
																				+ "</td><td>"
																				+ data[i].employee.name
																				+ "</td><td>"
																				+ data[i].employee.employee_no
																				+ "</td><td>"
																				+ data[i].arrived_date
																				+ "</td><td>"
																				+ data[i].employee.phone
																				+ "</td><td>"
																				+ data[i].employee.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
										         + data[i].employee.image + "'></td><td>"
																				+ data[i].create_date
																				+ "</td><td>"
																				+ data[i].update_date
																				+ "</td><td><input id='"
																				+ data[i].employee.id
																				+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
																				+ "</td><td><input type='button' class='btn btn-success' id='"
																				+ data[i].employee.id
																				+ "' name='"
																				+ data[i].account_type
																				+ "'onclick='check(this)' value='復權'/></td></tr>"));

													}

												}

											} else {
												$("#page_ul1").empty();
												$("#table1 tbody").empty();
												for (var i = 0; i < pageSize1; i++) {
													if (data[i].account_type == 2) {
														$("#table1 tbody")
																.append(
																		$("<tr><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].employee.id
																				+ "</td><td>"
																				+ data[i].employee.name
																				+ "</td><td>"
																				+ data[i].employee.employee_no
																				+ "</td><td>"
																				+ data[i].arrived_date
																				+ "</td><td>"
																				+ data[i].employee.phone
																				+ "</td><td>"
																				+ data[i].employee.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
									         + data[i].employee.image + "'></td><td>"
																				+ data[i].create_date
																				+ "</td><td>"
																				+ data[i].update_date
																				+ "</td><td><input id='"
																				+ data[i].employee.id
																				+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
																				+ "</td><td><input type='button' class='btn btn-danger' id='"
																				+ data[i].employee.id
																				+ "' name='"
																				+ data[i].account_type
																				+ "'onclick='check(this)' value='停權'/></td></tr>"));
													} else {
														$("#table1 tbody")
																.append(
																		$("<tr style='background:#D0D0D0;color:red;'><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].employee.id
																				+ "</td><td>"
																				+ data[i].employee.name
																				+ "</td><td>"
																				+ data[i].employee.employee_no
																				+ "</td><td>"
																				+ data[i].arrived_date
																				+ "</td><td>"
																				+ data[i].employee.phone
																				+ "</td><td>"
																				+ data[i].employee.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
										         + data[i].employee.image + "'></td><td>"
																				+ data[i].create_date
																				+ "</td><td>"
																				+ data[i].update_date
																				+ "</td><td><input id='"
																				+ data[i].employee.id
																				+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
																				+ "</td><td><input type='button' class='btn btn-success' id='"
																				+ data[i].employee.id
																				+ "' name='"
																				+ data[i].account_type
																				+ "'onclick='check(this)' value='復權'/></td></tr>"));

													}
												}
												for (var i = 1; i < pageTotal1 + 1; i++) {
													$("#page_ul1")
															.append(
																	$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"
																			+ i
																			+ "</span></button></li>"));

												}
												$("#page_ul1 li")
														.click(
																function() {
																	var pageNum1 = $(
																			this)
																			.text();
																	gotoPage1(pageNum1);
																});

											}

										}

									})

						});

		// 		******員工的模糊搜尋*****
		search1
				.addEventListener(
						'keyup',
						function(e) {

							var value2 = document.getElementById("search1").value
							var url1 = "<c:url value='/backned/allEmployeeSearch'/>"
							var obj1 = {
								'name' : value2,
								'orderby' : orderby1
							}
							var json1 = JSON.stringify(obj1);
							var imageurl = "data:image/jpeg;base64,"
							console.log(json1)
							$
									.ajax({
										url : url1,
										method : 'post',
										data : json1,
										contentType : 'application/json;charset=UTF-8',
										dataType : 'json',
										error : function() {
											alert("ajax error")
										},
										success : function(data) {
											pageTotal1 = 0;
											$("#page_ul1").empty();
											console.log(data)
											rowTotal1 = data.length;
											pageTotal1 = Math.ceil(rowTotal1
													/ pageSize1);
											currentPage1 = 1;
											if (pageTotal1 == 1) {
												$("#page_ul1").empty();
												$("#table1 tbody").empty();
												for (var i = 0; i < pageSize1; i++) {
													if (data[i].account_type == 2) {
														$("#table1 tbody")
																.append(
																		$("<tr><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].employee.id
																				+ "</td><td>"
																				+ data[i].employee.name
																				+ "</td><td>"
																				+ data[i].employee.employee_no
																				+ "</td><td>"
																				+ data[i].arrived_date
																				+ "</td><td>"
																				+ data[i].employee.phone
																				+ "</td><td>"
																				+ data[i].employee.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
											         + data[i].employee.image + "'></td><td>"
																				+ data[i].create_date
																				+ "</td><td>"
																				+ data[i].update_date
																				+ "</td><td><input id='"
																				+ data[i].employee.id
																				+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
																				+ "</td><td><input type='button' class='btn btn-danger' id='"
																				+ data[i].employee.id
																				+ "' name='"
																				+ data[i].account_type
																				+ "'onclick='check(this)' value='停權'/></td></tr>"));
													} else {
														$("#table1 tbody")
																.append(
																		$("<tr style='background:#D0D0D0;color:red;'><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].employee.id
																				+ "</td><td>"
																				+ data[i].employee.name
																				+ "</td><td>"
																				+ data[i].employee.employee_no
																				+ "</td><td>"
																				+ data[i].arrived_date
																				+ "</td><td>"
																				+ data[i].employee.phone
																				+ "</td><td>"
																				+ data[i].employee.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
												         + data[i].employee.image + "'></td><td>"
																				+ data[i].create_date
																				+ "</td><td>"
																				+ data[i].update_date
																				+ "</td><td><input id='"
																				+ data[i].employee.id
																				+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
																				+ "</td><td><input type='button' class='btn btn-success' id='"
																				+ data[i].employee.id
																				+ "' name='"
																				+ data[i].account_type
																				+ "'onclick='check(this)' value='復權'/></td></tr>"));

													}

												}

											} else {
												$("#page_ul1").empty();
												$("#table1 tbody").empty();
												for (var i = 0; i < pageSize1; i++) {
													if (data[i].account_type == 2) {
														$("#table1 tbody")
																.append(
																		$("<tr><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].employee.id
																				+ "</td><td>"
																				+ data[i].employee.name
																				+ "</td><td>"
																				+ data[i].employee.employee_no
																				+ "</td><td>"
																				+ data[i].arrived_date
																				+ "</td><td>"
																				+ data[i].employee.phone
																				+ "</td><td>"
																				+ data[i].employee.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
											         + data[i].employee.image + "'></td><td>"
																				+ data[i].create_date
																				+ "</td><td>"
																				+ data[i].update_date
																				+ "</td><td><input id='"
																				+ data[i].employee.id
																				+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
																				+ "</td><td><input type='button' class='btn btn-danger' id='"
																				+ data[i].employee.id
																				+ "' name='"
																				+ data[i].account_type
																				+ "'onclick='check(this)' value='停權'/></td></tr>"));
													} else {
														$("#table1 tbody")
																.append(
																		$("<tr style='background:#D0D0D0;color:red;'><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].employee.id
																				+ "</td><td>"
																				+ data[i].employee.name
																				+ "</td><td>"
																				+ data[i].employee.employee_no
																				+ "</td><td>"
																				+ data[i].arrived_date
																				+ "</td><td>"
																				+ data[i].employee.phone
																				+ "</td><td>"
																				+ data[i].employee.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
												         + data[i].employee.image + "'></td><td>"
																				+ data[i].create_date
																				+ "</td><td>"
																				+ data[i].update_date
																				+ "</td><td><input id='"
																				+ data[i].employee.id
																				+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
																				+ "</td><td><input type='button' class='btn btn-success' id='"
																				+ data[i].employee.id
																				+ "' name='"
																				+ data[i].account_type
																				+ "'onclick='check(this)' value='復權'/></td></tr>"));

													}
												}
												for (var i = 1; i < pageTotal1 + 1; i++) {
													$("#page_ul1")
															.append(
																	$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"
																			+ i
																			+ "</span></button></li>"));

												}
												$("#page_ul1 li")
														.click(
																function() {
																	var pageNum1 = $(
																			this)
																			.text();
																	gotoPage1(pageNum1);
																});

											}

										}

									})
						});

		// **********員工的windowload*********
		page1();

		// 		**********員工的分頁按鈕*********

		$("#page_ul1 li").click(function() {
			var pageNum1 = $(this).text();
			gotoPage1(pageNum1);
		});

		$("#page_prev1").click(function() {
			if (currentPage1 == 1) {
			} else {
				gotoPage1(--currentPage1);
			}
		});

		$("#page_next1").click(function() {
			if (currentPage1 == pageTotal1) {
			} else {
				gotoPage1(++currentPage1);
			}
		});

	}
	var imageurl = "data:image/jpeg;base64,"

	// 	*********員工的變數***********
	var orderby1 = null;
	var fileDataURL1;
	var pageTotal1 = 0;
	var rowTotal1 = 0;
	var currentPage1 = 1;
	var startRow1 = 0;
	var endRow1 = 0;
	var pageSize1 = 5;
	var x1 = 0;
	var index1 = 0;
	// 	var url1 = "<c:url value='/backned/allEmployee'/>"
	// 	var object1 = {
	// 		'id' : 1
	// 	};
	// 	var json1 = JSON.stringify(object1);

	// 	*************windowload員工**************

	function page1() {
		console.log(orderby1)
		var object1 = {
			'employee' : {
				'id' : 1
			},
			'orderby' : orderby1
		};
		var json1 = JSON.stringify(object1);
		console.log(json1)
		var url1 = "<c:url value='/backned/allEmployee'/>"
		$
				.ajax({

					url : url1,
					method : 'post',
					data : json1,
					contentType : 'application/json;charset=UTF-8',
					dataType : 'json',
					error : function() {
						alert("ajax error")
					},

					success : function(data) {
						console.log(data)
						rowTotal1 = data.length;
						pageTotal1 = Math.ceil(rowTotal1 / pageSize1);
						currentPage1 = 1;
						if (pageTotal1 == 1) {
							$("#table1 tbody").empty();
							for (var i = 0; i < pageSize1; i++) {
								if (data[i].account_type == 2) {
									$("#table1 tbody")
											.append(
													$("<tr><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].employee.id
															+ "</td><td>"
															+ data[i].employee.name
															+ "</td><td>"
															+ data[i].employee.employee_no
															+ "</td><td>"
															+ data[i].arrived_date
															+ "</td><td>"
															+ data[i].employee.phone
															+ "</td><td>"
															+ data[i].employee.email
															+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
								         + data[i].employee.image + "'></td><td>"
															+ data[i].create_date
															+ "</td><td>"
															+ data[i].update_date
															+ "</td><td><input id='"
															+ data[i].employee.id
															+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
															+ "</td><td><input type='button' class='btn btn-danger' id='"
															+ data[i].employee.id
															+ "' name='"
															+ data[i].account_type
															+ "'onclick='check(this)' value='停權'/></td></tr>"));
								} else {
									$("#table1 tbody")
											.append(
													$("<tr style='background:#D0D0D0;color:red;'><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].employee.id
															+ "</td><td>"
															+ data[i].employee.name
															+ "</td><td>"
															+ data[i].employee.employee_no
															+ "</td><td>"
															+ data[i].arrived_date
															+ "</td><td>"
															+ data[i].employee.phone
															+ "</td><td>"
															+ data[i].employee.email
															+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
									         + data[i].employee.image + "'></td><td>"
															+ data[i].create_date
															+ "</td><td>"
															+ data[i].update_date
															+ "</td><td><input id='"
															+ data[i].employee.id
															+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
															+ "</td><td><input type='button' class='btn btn-success' id='"
															+ data[i].employee.id
															+ "' name='"
															+ data[i].account_type
															+ "'onclick='check(this)' value='復權'/></td></tr>"));

								}

							}

						} else {
							$("#table1 tbody").empty();
							for (var i = 0; i < pageSize1; i++) {
								if (data[i].account_type == 2) {
									$("#table1 tbody")
											.append(
													$("<tr><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].employee.id
															+ "</td><td>"
															+ data[i].employee.name
															+ "</td><td>"
															+ data[i].employee.employee_no
															+ "</td><td>"
															+ data[i].arrived_date
															+ "</td><td>"
															+ data[i].employee.phone
															+ "</td><td>"
															+ data[i].employee.email
															+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
								         + data[i].employee.image + "'></td><td>"
															+ data[i].create_date
															+ "</td><td>"
															+ data[i].update_date
															+ "</td><td><input id='"
															+ data[i].employee.id
															+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
															+ "</td><td><input type='button' class='btn btn-danger' id='"
															+ data[i].employee.id
															+ "' name='"
															+ data[i].account_type
															+ "'onclick='check(this)' value='停權'/></td></tr>"));
								} else {
									$("#table1 tbody")
											.append(
													$("<tr style='background:#D0D0D0;color:red;'><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].employee.id
															+ "</td><td>"
															+ data[i].employee.name
															+ "</td><td>"
															+ data[i].employee.employee_no
															+ "</td><td>"
															+ data[i].arrived_date
															+ "</td><td>"
															+ data[i].employee.phone
															+ "</td><td>"
															+ data[i].employee.email
															+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
									         + data[i].employee.image + "'></td><td>"
															+ data[i].create_date
															+ "</td><td>"
															+ data[i].update_date
															+ "</td><td><input id='"
															+ data[i].employee.id
															+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
															+ "</td><td><input type='button' class='btn btn-success' id='"
															+ data[i].employee.id
															+ "' name='"
															+ data[i].account_type
															+ "'onclick='check(this)' value='復權'/></td></tr>"));

								}
							}

							for (var i = 1; i < pageTotal1 + 1; i++) {
								$("#page_ul1")
										.append(
												$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"
														+ i
														+ "</span></button></li>"));

							}
							$("#page_ul1 li").click(function() {
								var pageNum1 = $(this).text();
								gotoPage1(pageNum1);
							});

						}

					}
				})
	}

	// 	***************員工跳分頁***********

	function gotoPage1(pageNum1) {
		var object1 = {
			'employee' : {
				'id' : 1
			},
			'orderby' : orderby1
		};
		var json1 = JSON.stringify(object1);
		var url1 = "<c:url value='/backned/allEmployee'/>"
		console.log(json1)
		$
				.ajax({
					url : url1,
					method : 'post',
					data : json1,
					contentType : 'application/json;charset=UTF-8',
					dataType : 'json',
					error : function() {
						alert("ajax error")
					},
					success : function(data) {
						currentPage1 = pageNum1;
						console.log(currentPage1)
						startRow1 = pageSize1 * (pageNum1 - 1);
						console.log(startRow1)
						endRow1 = startRow1 + pageSize1;
						console.log(endRow1)
						endRow1 = (rowTotal1 > endRow1) ? endRow1 : rowTotal1;
						$("#table1 tbody").empty();
						for (var i = startRow1; i < endRow1; i++) {
							if (data[i].account_type == 2) {
								$("#table1 tbody")
										.append(
												$("<tr><td>"
														+ (i + 1)
														+ "</td><td style='display:none'>"
														+ data[i].employee.id
														+ "</td><td>"
														+ data[i].employee.name
														+ "</td><td>"
														+ data[i].employee.employee_no
														+ "</td><td>"
														+ data[i].arrived_date
														+ "</td><td>"
														+ data[i].employee.phone
														+ "</td><td>"
														+ data[i].employee.email
														+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
							         + data[i].employee.image + "'></td><td>"
														+ data[i].create_date
														+ "</td><td>"
														+ data[i].update_date
														+ "</td><td><input id='"
														+ data[i].employee.id
														+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
														+ "</td><td><input type='button' class='btn btn-danger' id='"
														+ data[i].employee.id
														+ "' name='"
														+ data[i].account_type
														+ "'onclick='check(this)' value='停權'/></td></tr>"));
							} else {
								$("#table1 tbody")
										.append(
												$("<tr style='background:#D0D0D0;color:red;'><td>"
														+ (i + 1)
														+ "</td><td style='display:none'>"
														+ data[i].employee.id
														+ "</td><td>"
														+ data[i].employee.name
														+ "</td><td>"
														+ data[i].employee.employee_no
														+ "</td><td>"
														+ data[i].arrived_date
														+ "</td><td>"
														+ data[i].employee.phone
														+ "</td><td>"
														+ data[i].employee.email
														+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
								         + data[i].employee.image + "'></td><td>"
														+ data[i].create_date
														+ "</td><td>"
														+ data[i].update_date
														+ "</td><td><input id='"
														+ data[i].employee.id
														+ "' onclick='getindex1(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal1' data-whatever='@getbootstrap'></button>"
														+ "</td><td><input type='button' class='btn btn-success' id='"
														+ data[i].employee.id
														+ "' name='"
														+ data[i].account_type
														+ "'onclick='check(this)' value='復權'/></td></tr>"));

							}

						}
					}
				});
	}

	// 	******************員工編輯取值**************

	function click1() {
		console.log(orderby1)

		var employeeid1 = document.getElementById("employeeid1").value
		var employeename1 = document.getElementById("employeename1").value
		var employeeno1 = document.getElementById("employeeno1").value;
		var employeearrived1 = document.getElementById("employeearrived1").value;
		var employeephone1 = document.getElementById("employeephone1").value;
		var employeeemail1 = document.getElementById("employeeemail1").value;

		let obj1 = {
			'arrived_date' : employeearrived1,
			'employee' : {
				'phone' : employeephone1,
				'email' : employeeemail1,
				'id' : employeeid1,
				'name' : employeename1,
				'employee_no' : employeeno1
			},
			'image' : fileDataURL1,
			'orderby' : orderby1
		}
		let json1 = JSON.stringify(obj1);
		console.log(json1)
		var url1 = "<c:url value='/backned/edit/employee'/>"
		$.ajax({
			url : url1,
			method : 'post',
			data : json1,
			contentType : 'application/json;charset=UTF-8',
			dataType : 'json',
			error : function() {
				alert("ajax error")
			},

			success : function(data) {
				gotoPage1(currentPage1);

			}
		})
	}

	// 		*************員工load照片**********

	function loadImageFileAsURL1() {
		let filesSelected = document.getElementById("employeeimage1").files;
		if (filesSelected.length > 0) {
			let fileToLoad = filesSelected[0];

			let fileReader = new FileReader();

			fileReader.onload = function(fileLoadedEvent1) {
				fileDataURL1 = fileLoadedEvent1.target.result;

			};

			fileReader.readAsDataURL(fileToLoad);
		}
	}

	// 	*************取得員工按下單筆編輯的頁面***************

	function getindex1(node) {
		console.log(orderby1)
		index1 = $(node).attr('id');
		var url1 = "<c:url value='/backned/edit/employeebyid'/>"
		var obj1 = {
			'employee' : {
				'id' : index1
			},
			'orderby' : orderby1
		}
		var json1 = JSON.stringify(obj1);
		var imageurl = "data:image/jpeg;base64,"

		$.ajax({
			url : url1,
			method : 'post',
			data : json1,
			contentType : 'application/json;charset=UTF-8',
			dataType : 'json',
			error : function() {
				alert("ajax error")
			},
			success : function(data) {
				console.log(data)

				var Arrived_date = data.arrived_date.substr(0, 10).split('/')
						.join('-')
				$("#employeeid1").attr("value", data.employee.id);
				$("#employeename1").attr("value", data.employee.name);
				$("#employeeno1").attr("value", data.employee.employee_no);
				$("#employeearrived1").attr("value", Arrived_date);
				$("#employeephone1").attr("value", data.employee.phone);
				$("#employeeemail1").attr("value", data.employee.email);
				$("#showphoto1").attr("src", imageurl + data.employee.image)

			}

		})
	}

	//**********停權前做確認***********
	function check(node) {
		var value = $(node).attr('value');
		if (value=="停權") {
			var check = confirm("確定要停權此員工的權限嗎?");
			if (check == true) {
				restore1(node)
			} else {
				return false;
			}
		}else{
			var check1 = confirm("確定要復權此員工的權限嗎?");

			if (check1 == true) {
				restore1(node)
			} else {
				return false;
			}
		}

	}

	// 	*************取得員工按下單筆停權的頁面***************

	function restore1(node) {
		var index1 = $(node).attr('id');
		var type1 = $(node).attr('name');
		var value1 = $(node).attr('value');
		console.log(index1)
		console.log(type1)
		console.log(value1)
		var url1 = "<c:url value='/backned/employee/edit/restorepermission'/>"
		var obj1 = {
			'account_type' : type1,
			'employee' : {
				'id' : index1
			},
			'orderby' : orderby1
		}
		var json1 = JSON.stringify(obj1);
		var imageurl = "data:image/jpeg;base64,"

		$.ajax({
			url : url1,
			method : 'post',
			data : json1,
			contentType : 'application/json;charset=UTF-8',
			dataType : 'json',
			error : function() {
				alert("ajax error")
			},
			success : function(data) {
				window.location.reload()
			}

		})
	}

	//************確認員工名稱*************
	function checkName() {
		let StrObj = document.getElementById("employeename1");
		let checkName = document.getElementById("idsp1");
		let v = document.querySelector("#employeename1");
		StrObjname = StrObj.value;
		if (StrObjname.charAt(0) != "") {
			if (StrObjname.charAt(1) != "") {
				for (let i = 0; i < StrObjname.length; i++) {
					let ch = StrObjname.charCodeAt(i);
					if (ch >= 0x4e00 && ch <= 0x9fff) {
						v.classList.remove("is-invalid");
						v.classList.add("is-valid");
						checkName.innerHTML = ("輸入正確")
						checkName.style = "color:green;font-size:14px";
					} else {
						v.classList.remove("is-valid");
						v.classList.add("is-invalid");
						checkName.innerHTML = ("建議輸入中文")
						checkName.style = "color:red;font-size:14px";
						break;
					}
				}
			} else {
				checkName.innerHTML = ("至少兩個字以上");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				checkName.style = "color:red;font-size:14px";

			}
		} else {
			checkName.innerHTML = ("不可輸入空值");
			v.classList.remove("is-valid");
			v.classList.add("is-invalid");
			checkName.style = "color:red;font-size:14px";

		}
		if ($("#employeename1").val() == "" || $("#employeeno1").val() == ""
				|| $("#employeearrived1").val() == ""
				|| $("#employeephone1").val() == ""
				|| $("#employeeemail1").val() == "") {
			$("#send1").prop("disabled", true)
		} else {
			$("#send1").prop("disabled", false)
		}

	}

	//*********確認員工編號***********
	function checkNo() {
		let StrObj = document.getElementById("employeeno1");
		let checkNo = document.getElementById("idsp2");
		let v = document.querySelector("#employeeno1");
		StrObjname = StrObj.value;
		if (StrObjname.charAt(0) != "") {

			checkNo.innerHTML = ("輸入正確");
			v.classList.remove("is-invalid");
			v.classList.add("is-valid");
			checkNo.style = "color:green;font-size:14px";

		} else {
			checkNo.innerHTML = ("不可輸入空值");
			v.classList.remove("is-valid");
			v.classList.add("is-invalid");
			checkNo.style = "color:red;font-size:14px";

		}
		if ($("#employeename1").val() == "" || $("#employeeno1").val() == ""
				|| $("#employeearrived1").val() == ""
				|| $("#employeephone1").val() == ""
				|| $("#employeeemail1").val() == "") {
			$("#send1").prop("disabled", true)
		} else {
			$("#send1").prop("disabled", false)
		}
	}

	//************確認員工到職日*************
	function checkArrived() {
		let StrObj = document.getElementById("employeearrived1");
		let checkArrived = document.getElementById("idsp3");
		let v = document.querySelector("#employeearrived1");
		StrObjname = StrObj.value;
		if (StrObjname.charAt(0) != "") {

			checkArrived.innerHTML = ("輸入正確");
			v.classList.remove("is-invalid");
			v.classList.add("is-valid");
			checkArrived.style = "color:green;font-size:14px";

		} else {
			checkArrived.innerHTML = ("不可輸入空值");
			v.classList.remove("is-valid");
			v.classList.add("is-invalid");
			checkArrived.style = "color:red;font-size:14px";

		}
		if ($("#employeename1").val() == "" || $("#employeeno1").val() == ""
				|| $("#employeearrived1").val() == ""
				|| $("#employeephone1").val() == ""
				|| $("#employeeemail1").val() == "") {
			$("#send1").prop("disabled", true)
		} else {
			$("#send1").prop("disabled", false)
		}

	}

	//************確認員工電話*************
	function checkPhone() {
		let StrObj = document.getElementById("employeephone1");
		let showPhone = document.getElementById("idsp4");
		let v = document.querySelector("#employeephone1");
		StrObjname = StrObj.value;
		if (StrObjname.charAt(0) != "") {

			showPhone.innerHTML = ("輸入正確");
			v.classList.remove("is-invalid");
			v.classList.add("is-valid");
			showPhone.style = "color:green;font-size:14px";

		} else {
			showPhone.innerHTML = ("不可輸入空值");
			v.classList.remove("is-valid");
			v.classList.add("is-invalid");
			showPhone.style = "color:red;font-size:14px";

		}
		if ($("#employeename1").val() == "" || $("#employeeno1").val() == ""
				|| $("#employeearrived1").val() == ""
				|| $("#employeephone1").val() == ""
				|| $("#employeeemail1").val() == "") {
			$("#send1").prop("disabled", true)
		} else {
			$("#send1").prop("disabled", false)
		}
	}

	//************確認員工信箱*************
	function checkEmail() {
		let StrObj = document.getElementById("employeeemail1");
		let showemail = document.getElementById("idsp4");
		let v = document.querySelector("#employeeemail1");
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
		if ($("#employeename1").val() == "" || $("#employeeno1").val() == ""
				|| $("#employeearrived1").val() == ""
				|| $("#employeephone1").val() == ""
				|| $("#employeeemail1").val() == "") {
			$("#send1").prop("disabled", true)
		} else {
			$("#send1").prop("disabled", false)
		}
	}
</script>
</head>
<body>
	<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>


	<!-- ******************************************員工資料****************************************	 -->

	<div class='col-lg-12 grid-margin stretch-card' Style="height: 600px">

		<div class="card" style="text-align: center">



			<div class='card-body' style="text-align: center">

				<h1 class='card-title'>員工資料總覽</h1>
				<div style="display: flex; justify-content: center;">
					<nav aria-label="Page navigation example"
						style="display: flex; justify-content: center;">
						<ul class="pagination navbar-center" style="margin: auto">
							<li class="page-item" id="page_prev1"><button
									class="arrow-left">
									<span><<</span>
								</button></li>

							<li class="pagination" id="page_ul1"></li>


							<li class="page-item" id="page_next1"><button
									class="arrow-right">
									<span>>></span>
								</button></li>
						</ul>
					</nav>
				</div>
				<div style="margin-left: 1000px; margin-top: -90px; width: 200px">
					<div style="margin: 0 auto; width: 200px">
						搜尋員工:依員工名稱<input type='text' id='search1'>
					</div>
					<div class="form-check" style="margin: 0 auto; width: 200px">
						<input style="text-align: right" class="form-check-input"
							type="radio" name="flexRadioDefault1" id="flexRadioDefault1"
							value="DESC" checked> <label style="text-align: right"
							class="form-check-label" for="flexRadioDefault1">依最後編輯時間排序:
							新往舊</label>
					</div>

					<div class="form-check" style="margin: 0 auto; width: 200px">
						<input style="text-align: right" class="form-check-input"
							type="radio" name="flexRadioDefault1" id="flexRadioDefault2"
							value="ASC"> <label style="text-align: right"
							class="form-check-label" for="flexRadioDefault2">依最後編輯時間排序:
							舊往新</label>
					</div>
				</div>

				<div class='table-responsive pt-3'>
					<table id="table1" class='table table-bordered'>
						<thead>
							<tr>
								<th>#</th>
								<th>員工名稱</th>
								<th>員工編號</th>
								<th>員工到職日</th>
								<th>連絡電話</th>
								<th>電子郵件</th>
								<th>員工照片</th>
								<th>員工資料建立時間</th>
								<th>資料最後編輯時間</th>
								<th>編輯</th>
								<th>停權</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>



	<div class="modal fade" id="exampleModal1" data-backdrop="static"
		data-keyboard="false" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel1">員工資料編輯</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group" style='display: none'>
							<label for="message-text" class="col-form-label">員工ID:</label> <input
								type="text" class="form-control" id="employeeid1" value="">
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">員工名稱:</label>
							<input type="text" class="form-control" id="employeename1"
								value="">
							<div id="idsp1" style="font-size: 20px"></div>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">員工編號:</label>
							<input type="text" class="form-control" id="employeeno1" value="">
							<div id="idsp2" style="font-size: 20px"></div>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">員工到職日:</label>
							<input type="date" class="form-control" id="employeearrived1"
								value="">
							<div id="idsp3" style="font-size: 20px"></div>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">連絡電話:</label> <input
								type="text" class="form-control" id="employeephone1" value="">
							<div id="idsp4" style="font-size: 20px"></div>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">電子郵件:</label> <input
								type="text" class="form-control" id="employeeemail1" value="">
							<div id="idsp5" style="font-size: 20px"></div>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">員工照片:</label> <input
								type="file" class="form-control" id="employeeimage1"> <br>

							<img id="showphoto1" src="#"
								style="width: 250px; height: 200px; border: 1px solid black">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" onclick="window.location.reload()">取消編輯</button>
					<button type="button" class="btn btn-primary" id="send1">完成送出</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		// 	*************員工照片預覽***************

		$("#employeeimage1").change(function() {
			readURL1(this);
		})

		//	 	*************員工照片預覽***************
		function readURL1(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$("#showphoto1").attr("src", e.target.result);

				}
				reader.readAsDataURL(input.files[0]);

			}
		}
	</script>


</body>
</html>