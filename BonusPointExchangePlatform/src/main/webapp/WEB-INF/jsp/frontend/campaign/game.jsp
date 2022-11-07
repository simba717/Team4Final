<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>遊戲</title>
</head>
<body>
	<jsp:include page="../../layout/Navbar.jsp"></jsp:include>
	<h1>本月遊戲: 採集魔水晶</h1>
	<hr>
	<h3>遊戲規則:</h3>
	<ul>
		<li>遊戲方式: 控制人物移動, 觸碰隨機出現的黃水晶; 前進:W鍵, 後退:S鍵 (也可使用上下鍵), 右轉:D鍵, 左轉:A鍵 (也可使用左右鍵)</li>
		<li>遊戲時間: 每天可以玩1次, 每次30秒</li>
		<li>得分方式: 每採集1個黃水晶, 可獲得100分；倒數10秒時會出現幸運星, 碰到幸運星可獲得300分</li>
		<li>遊戲結束: 觸碰到紫水晶3次(每次扣生命點數1點)；時間歸零。</li>
	</ul>
	<div id="game3">
		<iframe src="https://syuan0902.github.io/" width=960 height=600></iframe>
	</div>



<jsp:include page="../../layout/footer.jsp"></jsp:include>
</body>
</html>