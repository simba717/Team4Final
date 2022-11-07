<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>紅利小活動</title>
<style>
<style>
        * {
            margin: 0;
            padding: 0
        }
        
        h1{
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
            background:#FFDC35;
            color: #fff;
        }

        #calendar .dateList .sun {
            color: #f00;
        }
        
        #calendar .dateList .sign {
            background-image: url("${contextRoot}/img2/correct.png");
            background-repeat: no-repeat;
            background-position: center;
            color: black;
        }
</style>
</head>
<body>
	<jsp:include page="../../layout/Navbar.jsp"></jsp:include>
	<br>
	<br>
	<div class="container">
		<div class="row justify-content-between">
			<div class="col-12 col-md-3">
				<div class="item">
					<a id="gameSign"><img src="${contextRoot}/img2/Campaign1.png" class="w-100"></a>
					<div class="accordion" id="gameOne">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseOne"
							aria-expanded="false" aria-controls="collapseOne">簽到活動</button>
						<div id="collapseOne" class="accordion-collapse collapse"
							aria-labelledby="headingOne" data-bs-parent="#gameOne">
							<div class="accordion-body">
								<p>每天登入獲得500紅利點，單月無上限，登入越多領取越多!想參加活動直接點及圖片就可參加，還沒簽到的會員們還不馬上點擊。</p>
								<button id="btn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#dateModal" style="margin-left:60px">查詢簽到日期</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-3">
				<div class="item">
					<a id="gameBirthGift"><img src="${contextRoot}/img2/Campaign2.png" class="w-100"></a>
					<div class="accordion" id="gameTwo">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseTwo"
							aria-expanded="false" aria-controls="collapseTwo">生日禮活動
						</button>
						<div id="collapseTwo" class="accordion-collapse collapse"
							aria-labelledby="headingTwo" data-bs-parent="#gameTwo">
							<div class="accordion-body">
								<p>一年一度生日大禮只要生日當天點擊圖片，即可獲得紅利一萬點，你今天生日了嗎?</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-3">
				<div class="item">
					<a id="gameCrystalGift"><img src="${contextRoot}/img2/Campaign3.png"
						class="w-100"></a>
					<div class="accordion" id="gameThree">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseThree"
							aria-expanded="false" aria-controls="collapseThree">
							本月遊戲</button>
						<div id="collapseThree" class="accordion-collapse collapse"
							aria-labelledby="headingThree" data-bs-parent="#gameThree">
							<div class="accordion-body">
								<p>本月的小遊戲採集魔水晶，驚險刺激的遊玩看你能採到幾個黃水晶，每日一次只要遊玩就能獲得500紅利點數，還不快點擊圖片去體驗遊戲。</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- modal -->
<div class="modal fade" id="dateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel" style="margin-left:180px">簽到日期查詢</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body mx-auto" id='dataArea'>
                    <div id="calendar">
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
                </div>

            </div>
        </div>
 </div>

<div id="membercheck" class="visually-hidden">${member}</div>
	
	<script>
	//hover
	$(".item a").hover(function () {
        $(this).next("div").children("button").click()
    }, function () {
        $(this).next("div").children("button").click()
    });
	
	window.onload = function() {  
		btn.onclick = function() {
			if($("#membercheck").text()==""){
				window.location.href="${contextRoot}/login";
				return ;
			}
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
			if($("#membercheck").text()==""){
				window.location.href="${contextRoot}/login";
				return ;
			}
			let xhr2 = new XMLHttpRequest();
			xhr2.open('GET', "<c:url value="/checkSignIn" />", true);
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					let signAlert = JSON.parse(xhr2.responseText);
					if(signAlert.game_type=="已完成簽到"){
						Swal.fire("成功!",signAlert.game_type, "success")
					}else{
						Swal.fire("失敗!",signAlert.game_type, "error")
					}
				}
			}	
		}
		$("#gameBirthGift").click(function(){
			if($("#membercheck").text()==""){
				window.location.href="${contextRoot}/login";
				return ;
			}
			let xhr3 = new XMLHttpRequest();
			xhr3.open('GET', "<c:url value="/checkBirth" />", true);
			xhr3.send();
			xhr3.onreadystatechange = function() {
				if (xhr3.readyState == 4 && xhr3.status == 200) {
					let signAlert2 = JSON.parse(xhr3.responseText);
					if(signAlert2.game_type=="恭喜獲得生日禮"){
						Swal.fire("成功!",signAlert2.game_type, "success")
					}else if(signAlert2.game_type=="您今天已經領過生日禮囉"){
						Swal.fire("失敗!",signAlert2.game_type, "error")
					}else{
						Swal.fire("失敗!",signAlert2.game_type, "error")
					}
				}
			}
		})
		$("#gameCrystalGift").click(function(){
			if($("#membercheck").text()==""){
				window.location.href="${contextRoot}/login";
				return ;
			}
			let xhr4 = new XMLHttpRequest();
			xhr4.open('GET', "<c:url value="/checkCrystal" />", true);
			xhr4.send();
			xhr4.onreadystatechange = function() {
				if (xhr4.readyState == 4 && xhr4.status == 200) {
					let signAlert3 = JSON.parse(xhr4.responseText);
					if(signAlert3.game_type=="已完成魔水晶遊戲活動"){
						Swal.fire("成功!",signAlert3.game_type, "success")
					}else{
						Swal.fire("失敗!",signAlert3.game_type, "error")
					}
				}
			}	
		})
	}
	
	</script>
</body>
</html>