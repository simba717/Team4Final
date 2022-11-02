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

		// 		****************頁面載入後會員的事件捕捉*************
		merberimage = document.getElementById("merberimage");
		merberimage.addEventListener('change', loadImageFileAsURL);
// 		send = document.getElementById("send");
// 		send.addEventListener('click', click);
		search = document.getElementById("search");
		document.getElementById("merbername").addEventListener("blur",
				checkName);

		document.getElementById("merberbirth").addEventListener("blur",
				checkBirth);

		document.getElementById("merberemail").addEventListener("blur",
				checkEmail);

		document.getElementById("merberphone").addEventListener("blur",
				checkPhone);
		
		$("#send").click(function() {
			if ($("#merbername").val() == "") {
				alert("您尚未填寫會員名稱");
				var merbername = document.getElementById("merbername");
				merbername.focus();
			} else if ($("#merberbirth").val() == "") {
				alert("您尚未填寫會員生日");
				var merberbirth = document.getElementById("merberbirth");
				merberbirth.focus();
			} else if ($("#merberemail").val() == "") {
				alert("您尚未填寫會員信箱");
				var merberemail = document.getElementById("merberemail");
				merberemail.focus();
			} else if ($("#merberphone").val() == "") {
				alert("您尚未填寫信箱");
				var merberphone = document.getElementById("merberphone");
				merberphone.focus();
			} else {
				click();
				window.location.reload();
				page();
			}

		})


		
		// 		**************會員排序方式事件捕捉**************
		$("input[name=flexRadioDefault]").change(function() {
			orderby = $("input:radio:checked[name='flexRadioDefault']").val();
			
			var value1 = document.getElementById("search").value
			var url = "<c:url value='/backned/allMemberSearch'/>"
			var obj = {
				'name' : value1,
				'orderby' : orderby
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
							rowTotal = data.length;
							pageTotal = Math.ceil(rowTotal
									/ pageSize);
							currentPage = 1;
							if (pageTotal == 1) {
								$("#page_ul").empty();
								$("#table tbody").empty();
								for (var i = 0; i < pageSize; i++) {
									if (data[i].account_type == 1) {
										$("#table tbody")
												.append(
														$("<tr><td>"
																+ (i + 1)
																+ "</td><td style='display:none'>"
																+ data[i].member.id
																+ "</td><td>"
																+ data[i].member.name
																+ "</td><td>"
																+ data[i].dateBirth
																+ "</td><td>"
																+ data[i].member.phone
																+ "</td><td>"
																+ data[i].member.email
																+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
         + data[i].member.image + "'></td><td>"
																+ data[i].dateCreate
																+ "</td><td>"
																+ data[i].dateUpdate
																+ "</td><td><input id='"
																+ data[i].member.id
																+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
																+ "</td></tr>"));

									} else {
										$("#table tbody")
												.append(
														$("<tr style='background:#D0D0D0;color:red;'><td>"
																+ (i + 1)
																+ "</td><td style='display:none'>"
																+ data[i].member.id
																+ "</td><td>"
																+ data[i].member.name
																+ "</td><td>"
																+ data[i].dateBirth
																+ "</td><td>"
																+ data[i].member.phone
																+ "</td><td>"
																+ data[i].member.email
																+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
	         + data[i].member.image + "'></td><td>"
																+ data[i].dateCreate
																+ "</td><td>"
																+ data[i].dateUpdate
																+ "</td><td><input id='"
																+ data[i].member.id

																+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
																+ "</td></tr>"));

									}

								}

							} else {
								$("#page_ul").empty();
								$("#table tbody").empty();
								for (var i = 0; i < pageSize; i++) {
									if (data[i].account_type == 1) {
										$("#table tbody")
												.append(
														$("<tr><td>"
																+ (i + 1)
																+ "</td><td style='display:none'>"
																+ data[i].member.id
																+ "</td><td>"
																+ data[i].member.name
																+ "</td><td>"
																+ data[i].dateBirth
																+ "</td><td>"
																+ data[i].member.phone
																+ "</td><td>"
																+ data[i].member.email
																+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
         + data[i].member.image + "'></td><td>"
																+ data[i].dateCreate
																+ "</td><td>"
																+ data[i].dateUpdate
																+ "</td><td><input id='"
																+ data[i].member.id
																+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
																+ "</td></tr>"));
									} else {
										$("#table tbody")
												.append(
														$("<tr style='background:#D0D0D0;color:red;'><td>"
																+ (i + 1)
																+ "</td><td style='display:none'>"
																+ data[i].member.id
																+ "</td><td>"
																+ data[i].member.name
																+ "</td><td>"
																+ data[i].dateBirth
																+ "</td><td>"
																+ data[i].member.phone
																+ "</td><td>"
																+ data[i].member.email
																+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
	         + data[i].member.image + "'></td><td>"
																+ data[i].dateCreate
																+ "</td><td>"
																+ data[i].dateUpdate
																+ "</td><td><input id='"
																+ data[i].member.id
																+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
																+ "</td></tr>"));

									}
								}
							
								for (var i = 1; i < pageTotal + 1; i++) {
									$("#page_ul")
											.append(
													$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"
															+ i
															+ "</span></button></li>"));

								}
								$("#page_ul li").click(
										function() {
											var pageNum = $(
													this)
													.text();
											gotoPage(pageNum);
										});
							}

						}

					})
		});

	

		// 		******會員的模糊搜尋*****
		search
				.addEventListener(
						'keyup',
						function(e) {
						
							var value1 = document.getElementById("search").value
							var url = "<c:url value='/backned/allMemberSearch'/>"
							var obj = {
								'name' : value1,
								'orderby' : orderby
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
											rowTotal = data.length;
											pageTotal = Math.ceil(rowTotal
													/ pageSize);
											currentPage = 1;
											if (pageTotal == 1) {
												$("#page_ul").empty();
												$("#table tbody").empty();
												for (var i = 0; i < pageSize; i++) {
													if (data[i].account_type == 1) {
														$("#table tbody")
																.append(
																		$("<tr><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].member.id
																				+ "</td><td>"
																				+ data[i].member.name
																				+ "</td><td>"
																				+ data[i].dateBirth
																				+ "</td><td>"
																				+ data[i].member.phone
																				+ "</td><td>"
																				+ data[i].member.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
				         + data[i].member.image + "'></td><td>"
																				+ data[i].dateCreate
																				+ "</td><td>"
																				+ data[i].dateUpdate
																				+ "</td><td><input id='"
																				+ data[i].member.id
																				+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
																				+ "</td></tr>"));

													} else {
														$("#table tbody")
																.append(
																		$("<tr style='background:#D0D0D0;color:red;'><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].member.id
																				+ "</td><td>"
																				+ data[i].member.name
																				+ "</td><td>"
																				+ data[i].dateBirth
																				+ "</td><td>"
																				+ data[i].member.phone
																				+ "</td><td>"
																				+ data[i].member.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
					         + data[i].member.image + "'></td><td>"
																				+ data[i].dateCreate
																				+ "</td><td>"
																				+ data[i].dateUpdate
																				+ "</td><td><input id='"
																				+ data[i].member.id

																				+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
																				+ "</td></tr>"));

													}

												}

											} else {
												$("#page_ul").empty();
												$("#table tbody").empty();
												for (var i = 0; i < pageSize; i++) {
													if (data[i].account_type == 1) {
														$("#table tbody")
																.append(
																		$("<tr><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].member.id
																				+ "</td><td>"
																				+ data[i].member.name
																				+ "</td><td>"
																				+ data[i].dateBirth
																				+ "</td><td>"
																				+ data[i].member.phone
																				+ "</td><td>"
																				+ data[i].member.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
				         + data[i].member.image + "'></td><td>"
																				+ data[i].dateCreate
																				+ "</td><td>"
																				+ data[i].dateUpdate
																				+ "</td><td><input id='"
																				+ data[i].member.id
																				+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
																				+ "</td></tr>"));
													} else {
														$("#table tbody")
																.append(
																		$("<tr style='background:#D0D0D0;color:red;'><td>"
																				+ (i + 1)
																				+ "</td><td style='display:none'>"
																				+ data[i].member.id
																				+ "</td><td>"
																				+ data[i].member.name
																				+ "</td><td>"
																				+ data[i].dateBirth
																				+ "</td><td>"
																				+ data[i].member.phone
																				+ "</td><td>"
																				+ data[i].member.email
																				+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
					         + data[i].member.image + "'></td><td>"
																				+ data[i].dateCreate
																				+ "</td><td>"
																				+ data[i].dateUpdate
																				+ "</td><td><input id='"
																				+ data[i].member.id
																				+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
																				+ "</td></tr>"));

													}
												}
											
												for (var i = 1; i < pageTotal + 1; i++) {
													$("#page_ul")
															.append(
																	$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"
																			+ i
																			+ "</span></button></li>"));

												}
												$("#page_ul li").click(
														function() {
															var pageNum = $(
																	this)
																	.text();
															gotoPage(pageNum);
														});
											}

										}

									})
						});

		

		// **********會員的windowload*********
		page();
		
		// 		**********會員的分頁按鈕*********
		$("#page_ul li").click(function() {
			var pageNum = $(this).text();
			gotoPage(pageNum);
		});

		$("#page_prev").click(function() {
			if (currentPage == 1) {
			} else {
				gotoPage(--currentPage);
			}
		});

		$("#page_next").click(function() {
			if (currentPage == pageTotal) {
			} else {
				gotoPage(++currentPage);
			}
		});

	}
	var imageurl = "data:image/jpeg;base64,"
	// 	*********會員的變數***********
	var orderby = null;
	var fileDataURL;
	var pageTotal = 0;
	var rowTotal = 0;
	var currentPage = 1;
	var startRow = 0;
	var endRow = 0;
	var pageSize = 5;
	var x = 0;
 	var index = 0;
// 	var url = "<c:url value='/backned/allMember'/>"
// 	var object = {
// 		'id' : 1
// 	};
// 	var json = JSON.stringify(object);

	
	// 	*************windowload會員**************

	function page() {
		$("#page_ul").empty();
		var url = "<c:url value='/backned/allMember'/>"
		var object = {
			'id' : 1,
			'orderby' : orderby
		};
		var json = JSON.stringify(object);
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
						rowTotal = data.length;
						pageTotal = Math.ceil(rowTotal / pageSize);
						currentPage = 1;
						if (pageTotal == 1) {
							$("#table tbody").empty();
							for (var i = 0; i < pageSize; i++) {
								if (data[i].account_type == 1) {
									$("#table tbody")
											.append(
													$("<tr><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].member.id
															+ "</td><td>"
															+ data[i].member.name
															+ "</td><td>"
															+ data[i].dateBirth
															+ "</td><td>"
															+ data[i].member.phone
															+ "</td><td>"
															+ data[i].member.email
															+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
								         + data[i].member.image + "'></td><td>"
															+ data[i].dateCreate
															+ "</td><td>"
															+ data[i].dateUpdate
															+ "</td><td><input id='"
															+ data[i].member.id
															+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
															+ "</td></tr>"));
								} else {
									$("#table tbody")
											.append(
													$("<tr style='background:#D0D0D0;color:red;'><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].member.id
															+ "</td><td>"
															+ data[i].member.name
															+ "</td><td>"
															+ data[i].dateBirth
															+ "</td><td>"
															+ data[i].member.phone
															+ "</td><td>"
															+ data[i].member.email
															+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
									         + data[i].member.image + "'></td><td>"
															+ data[i].dateCreate
															+ "</td><td>"
															+ data[i].dateUpdate
															+ "</td><td><input id='"
															+ data[i].member.id
															+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
															+ "</td></tr>"));

								}

							}

						} else {
							$("#table tbody").empty();
							for (var i = 0; i < pageSize; i++) {
								if (data[i].account_type == 1) {
									$("#table tbody")
											.append(
													$("<tr><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].member.id
															+ "</td><td>"
															+ data[i].member.name
															+ "</td><td>"
															+ data[i].dateBirth
															+ "</td><td>"
															+ data[i].member.phone
															+ "</td><td>"
															+ data[i].member.email
															+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
								         + data[i].member.image + "'></td><td>"
															+ data[i].dateCreate
															+ "</td><td>"
															+ data[i].dateUpdate
															+ "</td><td><input id='"
															+ data[i].member.id
															+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
															+ "</td></tr>"));
								} else {
									$("#table tbody")
											.append(
													$("<tr style='background:#D0D0D0;color:red;'><td>"
															+ (i + 1)
															+ "</td><td style='display:none'>"
															+ data[i].member.id
															+ "</td><td>"
															+ data[i].member.name
															+ "</td><td>"
															+ data[i].dateBirth
															+ "</td><td>"
															+ data[i].member.phone
															+ "</td><td>"
															+ data[i].member.email
															+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
									         + data[i].member.image + "'></td><td>"
															+ data[i].dateCreate
															+ "</td><td>"
															+ data[i].dateUpdate
															+ "</td><td><input id='"
															+ data[i].member.id
															+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
															+ "</td></tr>"));

								}
							}
							
							for (var i = 1; i < pageTotal + 1; i++) {
								$("#page_ul")
										.append(
												$("<li class='page-item'><button class='arrow-number'><span style='vertical-align:middle;display:flex;text-align:right;margin-left:5px'>"
														+ i
														+ "</span></button></li>"));

							}
							$("#page_ul li").click(function() {
								var pageNum = $(this).text();
								gotoPage(pageNum);
							});

						}

					}
				})
	}

	// 	***********會員跳分頁***********

	function gotoPage(pageNum) {
		var url = "<c:url value='/backned/allMember'/>"
		var object = {
			'id' : 1,
			'orderby' : orderby
		};
		var json = JSON.stringify(object);
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
						currentPage = pageNum;
						console.log(currentPage)
						startRow = pageSize * (pageNum - 1);
						console.log(startRow)
						endRow = startRow + pageSize;
						console.log(endRow)
						endRow = (rowTotal > endRow) ? endRow : rowTotal;
						$("#table tbody").empty();
						for (var i = startRow; i < endRow; i++) {
							if (data[i].account_type == 1) {
								$("#table tbody")
										.append(
												$("<tr><td>"
														+ (i + 1)
														+ "</td><td style='display:none'>"
														+ data[i].member.id
														+ "</td><td>"
														+ data[i].member.name
														+ "</td><td>"
														+ data[i].dateBirth
														+ "</td><td>"
														+ data[i].member.phone
														+ "</td><td>"
														+ data[i].member.email
														+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
							         + data[i].member.image + "'></td><td>"
														+ data[i].dateCreate
														+ "</td><td>"
														+ data[i].dateUpdate
														+ "</td><td><input id='"
														+ data[i].member.id
														+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
														+ "</td></tr>"));
							} else {
								$("#table tbody")
										.append(
												$("<tr style='background:#D0D0D0;color:red;'><td>"
														+ (i + 1)
														+ "</td><td style='display:none'>"
														+ data[i].member.id
														+ "</td><td>"
														+ data[i].member.name
														+ "</td><td>"
														+ data[i].dateBirth
														+ "</td><td>"
														+ data[i].member.phone
														+ "</td><td>"
														+ data[i].member.email
														+ "</td><td align='center'><img width='40' height='48' src='"+imageurl
								         + data[i].member.image + "'></td><td>"
														+ data[i].dateCreate
														+ "</td><td>"
														+ data[i].dateUpdate
														+ "</td><td><input id='"
														+ data[i].member.id

														+ "' onclick='getindex(this)' type='button' value='編輯' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal' data-whatever='@getbootstrap'></button>"
														+ "</td></tr>"));

							}
						}
					}
				});
	}

	// 	******************會員編輯取值*****************

	function click() {

		var merbername = document.getElementById("merbername").value
		var merberbirth = document.getElementById("merberbirth").value;
		var merberphone = document.getElementById("merberphone").value;
		var merberemail = document.getElementById("merberemail").value;
		var memberid = document.getElementById("memberid").value;

		let obj = {
			'member' : {
				'id' : memberid
			},
			'name' : merbername,
			'birth' : merberbirth,
			'phone' : merberphone,
			'email' : merberemail,
			'image' : fileDataURL,
			'orderby' : orderby
		}
		let json = JSON.stringify(obj);
		var url = "<c:url value='/backned/edit/member'/>"
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
				gotoPage(currentPage);

			}
		})
	}

	
	// 	*************會員load照片**********

	function loadImageFileAsURL() {
		let filesSelected = document.getElementById("merberimage").files;
		if (filesSelected.length > 0) {
			let fileToLoad = filesSelected[0];

			let fileReader = new FileReader();

			fileReader.onload = function(fileLoadedEvent) {
				fileDataURL = fileLoadedEvent.target.result;

			};

			fileReader.readAsDataURL(fileToLoad);
		}
	}

	// 	*************取得會員按下單筆編輯的頁面***************

	function getindex(node) {
		index = $(node).attr('id');
		var url = "<c:url value='/backned/edit/memberbyid'/>"
		var obj = {
			'member' : {
				'id' : index
			},
			'orderby' : orderby
		}
		var json = JSON.stringify(obj);
		var imageurl = "data:image/jpeg;base64,"

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

 				var birth = data.dateBirth.substr(0, 10).split('/').join('-')
				$("#memberid").attr("value", data.member.id);
				$("#merbername").attr("value", data.member.name);
				$("#merberbirth").attr("value",birth);
				$("#merberphone").attr("value", data.member.phone);
				$("#merberemail").attr("value", data.member.email);
				$("#showphoto").attr("src", imageurl + data.member.image)

			}

		})
	}

	
	//************確認會員名稱*************
	function checkName() {
		let StrObj = document.getElementById("merbername");
		let checkName = document.getElementById("idsp1");
		let v = document.querySelector("#merbername");
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
		if ($("#merbername").val() == "" || $("#merberbirth").val() == ""
				|| $("#merberemail").val() == ""
				|| $("#merberphone").val() == "") {
			$("#send").prop("disabled", true)
		} else {
			$("#send").prop("disabled", false)
		}

	}

	//*********確認會員生日***********
	function checkBirth() {
		let StrObj = document.getElementById("merberbirth");
		let checkbirth = document.getElementById("idsp2");
		let v = document.querySelector("#merberbirth");
		StrObjname = StrObj.value;
		if (StrObjname.charAt(0) != "") {

			checkbirth.innerHTML = ("輸入正確");
			v.classList.remove("is-invalid");
			v.classList.add("is-valid");
			checkbirth.style = "color:green;font-size:14px";

		} else {
			checkbirth.innerHTML = ("不可輸入空值");
			v.classList.remove("is-valid");
			v.classList.add("is-invalid");
			checkbirth.style = "color:red;font-size:14px";

		}
		if ($("#merbername").val() == "" || $("#merberbirth").val() == ""
				|| $("#merberemail").val() == ""
				|| $("#merberphone").val() == "") {
			$("#send").prop("disabled", true)
		} else {
			$("#send").prop("disabled", false)
		}
	}

	//************確認會員電話*************
	function checkPhone() {
		let StrObj = document.getElementById("merberphone");
		let showphone = document.getElementById("idsp3");
		let v = document.querySelector("#merberphone");
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
		if ($("#merbername").val() == "" || $("#merberbirth").val() == ""
				|| $("#merberemail").val() == ""
				|| $("#merberphone").val() == "") {
			$("#send").prop("disabled", true)
		} else {
			$("#send").prop("disabled", false)
		}
	}

	//************確認會員信箱*************
	function checkEmail() {
		let StrObj = document.getElementById("merberemail");
		let showemail = document.getElementById("idsp4");
		let v = document.querySelector("#merberemail");
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
		if ($("#merbername").val() == "" || $("#merberbirth").val() == ""
				|| $("#merberemail").val() == ""
				|| $("#merberphone").val() == "") {
			$("#send").prop("disabled", true)
		} else {
			$("#send").prop("disabled", false)
		}
	}
	

</script>
</head>
<body>
	<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>

	<div class='col-lg-12 grid-margin stretch-card' Style="height: 600px">

		<div class="card" style="text-align: center">



			<div class='card-body' style="text-align: center">

				<h1 class='card-title'>會員資料總覽</h1>
				<div style="display: flex; justify-content: center;">

					<nav aria-label="Page navigation example"
						style="display: flex; justify-content: center;">
						<ul class="pagination navbar-center" style="margin: auto">
							<li class="page-item" id="page_prev"><button
									class="arrow-left">
									<span><<</span>
								</button></li>

							<li class="pagination" id="page_ul"></li>


							<li class="page-item" id="page_next"><button
									class="arrow-right">
									<span>>></span>
								</button></li>
						</ul>
					</nav>
				</div>
				<div style="margin-left: 1000px; margin-top: -90px; width: 200px">
					<div style="margin: 0 auto; width: 200px">
						搜尋會員:依會員名稱<input type='text' id='search'>
					</div>
					<div class="form-check" style="margin: 0 auto; width: 200px">
						<input style="text-align: right" class="form-check-input"
							type="radio" name="flexRadioDefault" id="flexRadioDefault1"
							value="DESC" checked> <label style="text-align: right"
							class="form-check-label" for="flexRadioDefault1">依最後編輯時間排序:
							新往舊</label>
					</div>

					<div class="form-check" style="margin: 0 auto; width: 200px">
						<input style="text-align: right" class="form-check-input"
							type="radio" name="flexRadioDefault" id="flexRadioDefault2"
							value="ASC"> <label style="text-align: right"
							class="form-check-label" for="flexRadioDefault2">依最後編輯時間排序:
							舊往新</label>
					</div>
				</div>

				<div class='table-responsive pt-3'>
					<table id="table" class='table table-bordered'>
						<thead>
							<tr>
								<th>#</th>
								<th>會員名稱</th>
								<th>會員生日</th>
								<th>連絡電話</th>
								<th>電子郵件</th>
								<th>會員照片</th>
								<th>會員資料建立時間</th>
								<th>資料最後編輯時間</th>
								<th>編輯</th>
<!-- 								<th>停權</th> -->
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>



	<div class="modal fade" id="exampleModal" data-backdrop="static"
		data-keyboard="false" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">會員資料編輯</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group" style='display: none'>
							<label for="message-text" class="col-form-label">會員ID:</label> <input
								type="text" class="form-control" id="memberid" value="">
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">會員名稱:</label>
							<input type="text" class="form-control" id="merbername" value="">
							<div id="idsp1" style="font-size: 20px"></div>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">會員生日:</label> <input
								type="date" class="form-control" id="merberbirth" value="">
								<div id="idsp2" style="font-size: 20px"></div>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">連絡電話:</label> <input
								type="text" class="form-control" id="merberphone" value="">
								<div id="idsp3" style="font-size: 20px"></div>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">電子郵件:</label> <input
								type="text" class="form-control" id="merberemail" value="">
								<div id="idsp4" style="font-size: 20px"></div>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">會員照片:</label> <input
								type="file" class="form-control" id="merberimage"> <br>

							<img id="showphoto" src="#"
								style="width: 250px; height: 200px; border: 1px solid black">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" onclick="window.location.reload()">取消編輯</button>
					<button type="button" class="btn btn-primary" id="send"
						>完成送出</button>
				</div>
			</div>
		</div>
	</div>


	<script>
		// 	*************會員照片預覽***************
		$("#merberimage").change(function() {
			readURL(this);
		})

	
		// 	*************會員照片預覽***************
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$("#showphoto").attr("src", e.target.result);

				}
				reader.readAsDataURL(input.files[0]);

			}
		}
	
	</script>

</body>
</html>