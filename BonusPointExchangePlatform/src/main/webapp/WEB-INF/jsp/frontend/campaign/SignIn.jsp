<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>SignIn</title>
<style>
        * {
            margin: 0;
            padding: 0
        }
        
        h1{
        margin-left: 10px ;
        }
        
        #btn,#gameSign{
            margin-left: 10px ;
        }

        #calendar {
            width: 270px;
            margin-left: 10px ;
            overflow: hidden;
            border: 1px solid #000;
            padding: 20px;
            position: relative;
            font-family: Arial, Helvetica, sans-serif;
        }

        #calendar h4 {
            text-align: center;
            margin-bottom: 10px
        }

        #calendar .a1 {
            position: absolute;
            top: 20px;
            left: 20px;
        }

        #calendar .a2 {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        #calendar .week {
            height: 30px;
            line-height: 20px;
            border-bottom: 1px solid #000;
            margin-bottom: 10px
        }

        #calendar .week li {
            float: left;
            width: 30px;
            height: 30px;
            text-align: center;
            list-style: none;
        }

        #calendar .dateList {
            overflow: hidden;
            clear: both
        }

        #calendar .dateList li {
            float: left;
            width: 30px;
            height: 30px;
            text-align: center;
            line-height: 30px;
            list-style: none;
        }

        #calendar .dateList .ccc {
            color: #ccc;
        }

        #calendar .dateList .red {
            background: #F90;
            color: #fff;
        }

        #calendar .dateList .sun {
            color: #f00;
        }
        
        #calendar .dateList .sign {
            background-image: url("img2/2.jpg");
            background-repeat: no-repeat;
            background-position: center;
            color: black;
        }
        
        
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script>
        window.onload = function() {  
			btn.onclick = function() {
				let xhr = new XMLHttpRequest();
				xhr.open('GET', "<c:url value="/selectDate" />", true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						document.getElementById("calendar").removeAttribute("hidden");
						$(function () {

				            //必要的資料
				            //今天的年 月 日 ；本月的總天數；本月第一天是周幾？？？
				            var iNow = 0;

				            function run(n) {

				                var oDate = new Date(); //定義時間
				                oDate.setMonth(oDate.getMonth() + n);//設定月份
				                var year = oDate.getFullYear(); //年
				                var month = oDate.getMonth(); //月
				                var today = oDate.getDate(); //日

				                //計算本月有多少天
				                var allDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];

				                //判斷閏年
				                if (month == 1) {
				                    if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
				                        allDay = 29;
				                    }
				                }

				                //判斷本月第一天是星期幾
				                oDate.setDate(1); //時間調整到本月第一天
				                var week = oDate.getDay(); //讀取本月第一天是星期幾

				                //console.log(week);
				                $(".dateList").empty();//每次清空
				                //插入空白

				                for (var i = 0; i < week; i++) {
				                    $(".dateList").append("<li></li>");
				                }

				                //日期插入到dateList
				                for (var i = 1; i <= allDay; i++) {
				                    $(".dateList").append("<li>" + i + "</li>")
				                }
				                //標記顏色=====================
				                $(".dateList li").each(function (i, elm) {
				                    //console.log(index,elm);
				                    var val = $(this).text();
				                    //console.log(val);
				                    if (n == 0) {
				                        if (val < today) {
				                            if (i % 7 == 0 || i % 7 == 6) {
				                                $(this).addClass('sun')
				                            }
				                            // $(this).addClass('ccc')
				                        } else if (val == today) {
				                            $(this).addClass('red')
				                        } else if (i % 7 == 0 || i % 7 == 6) {
				                            $(this).addClass('sun')
				                        }
				                    } else if (n < 0) {
				                        if (i % 7 == 0 || i % 7 == 6) {
				                            $(this).addClass('sun')
				                        }
				                        // $(this).addClass('ccc')
				                    } else if (i % 7 == 0 || i % 7 == 6) {
				                        $(this).addClass('sun')
				                    }
				                    var list = JSON.parse(xhr.responseText);
									if (list.length > 0) {
										for ( var i in list) {
											var str = list[i]
											var y = parseInt(str.substring(0, 4));
								            var m = parseInt(str.substring(5, 7)) - 1;
								            var d = parseInt(str.substring(8, 10));
								            if (year == y && month == m && val == d) {
						                        $(this).addClass('sign')
						                    }
										}
									}
				                });

				                //定義標題日期
				                $("#calendar h4").text(year + "年" + (month + 1) + "月");
				            };
				            run(0);

				            $(".a1").click(function () {
				                iNow--;
				                run(iNow);
				            });

				            $(".a2").click(function () {
				                iNow++;
				                run(iNow);
				            })
				        });
					}
				}
			}
			
			var gameSign = document.getElementById("gameSign")
				gameSign.onclick = function() {
				let xhr = new XMLHttpRequest();
				xhr.open('GET', "<c:url value="/checkSignIn" />", true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var signAlert = JSON.parse(xhr.responseText);
						alert(signAlert.game_type);
					}
				}	
			}	
		}
    </script>
</head>
<body>
<jsp:include page="../../layout/Navbar.jsp"></jsp:include>
	<h1>簽到</h1>
	<button id="gameSign" class="btn btn-danger">簽到</button>
	<button id="btn" class="btn btn-primary">查詢日期</button>
	<br>
	<div id="dataArea">&nbsp;</div>
	<div id="calendar" hidden>
        <h4 style="font-family: Arial, Helvetica, sans-serif;">年月</h4>
        <a href="##"  class="a1">&lt;&lt;</a>
        <a href="##"  class="a2">&gt;&gt;</a>
        <ul class="week">
            <li>日</li>
            <li>一</li>
            <li>二</li>
            <li>三</li>
            <li>四</li>
            <li>五</li>
            <li>六</li>

        </ul>
        <ul class="dateList"></ul>
    </div>
</body>
</html>