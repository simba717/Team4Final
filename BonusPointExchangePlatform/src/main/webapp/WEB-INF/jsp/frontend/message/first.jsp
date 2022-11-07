<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>常見Q&A</title>
</head>
<body>
	<jsp:include page="../../layout/Navbar.jsp"></jsp:include>

	<div class="row">
		<div class="col-4">
			<nav id="navbar-example3"
				class="h-100 flex-column align-items-stretch pe-4 border-end">
				<nav class="nav nav-pills flex-column">
				
					<a class="nav-link" href="#item-1">訂購問題</a>
					<nav class="nav nav-pills flex-column">
						<a class="nav-link ms-3 my-1" href="#item-1-1">訂購需要先入會員嗎？</a> 
						<a class="nav-link ms-3 my-1" href="#item-1-2">如何查詢我的訂單資料呢？</a> 
						<a class="nav-link ms-3 my-1" href="#item-1-3">如何取消訂單？訂單數量有誤如何更改？</a>
						<a class="nav-link ms-3 my-1" href="#item-1-4">訂購時忘了加購商品，請問可以再追加嗎？</a>
						<a class="nav-link ms-3 my-1" href="#item-1-5">商品訂錯或不滿意，可以直接換購其他商品嗎？</a>
						<a class="nav-link ms-3 my-1" href="#item-1-6">訂購當時至付款網頁後一片空白，請問是否訂購成功？</a>
						<a class="nav-link ms-3 my-1" href="#item-1-7">為什麼要訂購的商品，卻無法進入訂購頁面？</a>
						<a class="nav-link ms-3 my-1" href="#item-1-8">今天訂購資訊商品可以明天到貨嗎？</a>
						<a class="nav-link ms-3 my-1" href="#item-1-9">可以寄送海外或離島嗎？</a> 
						<a class="nav-link ms-3 my-1" href="#item-1-10">貴站商品頁上的價格是否含稅免運費開發票的價格？</a>
					</nav>
					
					<a class="nav-link" href="#item-3">付款問題</a>
					<nav class="nav nav-pills flex-column">
						<a class="nav-link ms-3 my-1" href="#item-3-1">請問付款方式有哪些？有匯款、貨到付款、支票和現金嗎？</a> 
						<a class="nav-link ms-3 my-1" href="#item-3-2">付款多久可以查到？</a>
						<a class="nav-link ms-3 my-1" href="#item-3-3">我刷卡失敗，持卡行告知請貴公司打電話去確認？</a>
						<a class="nav-link ms-3 my-1" href="#item-3-4">查詢訂單狀態為授權失敗，銀行會請款嗎？</a>
						<a class="nav-link ms-3 my-1" href="#item-3-5">商品未送達，信用卡帳單來了怎辦？需先繳款嗎？</a>
						<a class="nav-link ms-3 my-1" href="#item-3-6">為什麼其它區不開放超商取貨付款呢？</a>
					</nav>
					
					<a class="nav-link" href="#item-4">其它問題</a>
					<nav class="nav nav-pills flex-column">
						<a class="nav-link ms-3 my-1" href="#item-4-1">請問退款的方式有哪些？</a> 
						<a class="nav-link ms-3 my-1" href="#item-4-2">如何與顧客中心聯絡？</a>
						<a class="nav-link ms-3 my-1" href="#item-4-3">為何未提供商品諮詢？</a>
						<a class="nav-link ms-3 my-1" href="#item-4-4">網頁圖片有很多顏色，為什麼商品規格只有一個顏色可選？</a>
					</nav>
					
				</nav>
			</nav>
		</div>

		<div class="col-8">
			<div data-bs-spy="scroll" data-bs-target="#navbar-example3"
				data-bs-smooth-scroll="true" class="scrollspy-example-2"
				tabindex="0">
				<div id="item-1"><br>
					<h2>訂購問題</h2>
					<br>
				</div>
				<div id="item-1-1">
					<h5>Q1: 訂購需要先入會員嗎？</h5>
					<p>若您未曾在PChome平台消費購物，請先註冊成為會員，會員帳號可透過2種方式進行註冊：手機號碼或Email，過程中免填詳細資料，您也可透過第三方帳號快速登入(例：Facebook、Google帳號)，登入時輸入第三方帳號密碼，系統會產生一組全新的流水號辨識碼，完成後即可快速登入並選購商品。</p>
				</div>
				<div id="item-1-2">
					<h5>Q2: 如何查詢我的訂單資料呢？</h5>
					<p>請至本站「顧客中心」的「查訂單」功能，查詢購物資料。</p>
				</div>
				<div id="item-1-3">
					<h5>Q3: 如何取消訂單？訂單數量有誤如何更改？</h5>
					<p>由於受限營運、認證中心和銀行規範，無法變更訂單付款方式、內容、金額或是退補差額方式換購其它商品，因此尚無法提供線上網路直接由顧客取消訂單或修改，如有需要變更，我們建議最晚於貨到７日內至本站「顧客中心」申請退訂再重訂。</p>
				</div>
				<div id="item-1-4">
					<h5>Q4: 訂購時忘了加購商品，請問可以再追加嗎？</h5>
					<p>未完成付款者，請重新訂購即可。但已付款者，因受限銀行系統及作業規定，請恕無法再行追加，此時請至專館另行添購</p>
				</div>
				<div id="item-1-5">
					<h4>Q5: 商品訂錯或不滿意，可以直接換購其他商品嗎？</h4>
					<p>目前受限營運機制，尚無法直接以退補差額方式來換購其它商品，若有需求欲退回情形，請至遲於貨到7日內先至本站「顧客中心」的「查訂單」功能申請退訂。</p>
				</div>
				<div id="item-1-6">
					<h4>Q6: 訂購當時至付款網頁後一片空白，請問是否訂購成功？</h4>
					<p>不一定成功，請至本站「顧客中心」的「查訂單」功能，再確認購物資料，或是來信「訂單確認客服信箱」提供訂購姓名和E-mail再確認一下。</p>
				</div>
				<div id="item-1-7">
					<h4>Q7: 為什麼要訂購的商品，卻無法進入訂購頁面？</h4>
					<p>當您訂購時，卻發現無法進入訂購頁面，或頁面顯示本館的首頁畫面，即表示該項商品因廠商促銷活動已結束，商品不再提供訂購了，建議您可以重新整理瀏覽器確認一下或是考量選購其它商品！</p>
				</div>
				<div id="item-1-8">
					<h4>Q8: 今天訂購資訊商品可以明天到貨嗎？</h4>
					<p>一般商品尚無法完全指定隔天送達。本站與供貨商簽定約須1-3個工作天的訂單作業時間安排寄送，由於配合供貨商整裝的流程，大致寄送時間請詳見各商品網頁說明。</p>
				</div>
				<div id="item-1-9">
					<h4>Q9: 可以寄送海外或離島嗎？</h4>
					<p>配送範圍限台灣本島、離島地區(不含海外)。</p>
				</div>
				<div id="item-1-10">
					<h4>Q10: 貴站商品頁上的價格是否含稅免運費開發票的價格？</h4>
					<p>除網頁另有標示外，一般是不需另外支付運費或是其它費用。</p>
				</div><br>
				
				<div id="item-3">
					<h2>付款問題</h2>
					<br>
				</div>
				<div id="item-3-1">
					<h5>Q1: 請問付款方式有哪些？有匯款、貨到付款、支票和現金嗎？</h5>
					<p>本站付款方式為「信用卡」、「ATM轉帳」、「本行帳戶儲值」。目前尚無臨櫃匯款、支票和現金等方式。
					</p>
				</div>
				<div id="item-3-2">
					<h5>Q2: 付款多久可以查到？</h5>
					<p>完成訂購後即可至「顧客中心」中查詢。</p>
				</div>
				<div id="item-3-3">
					<h5>Q3: 我刷卡失敗，持卡行告知請貴公司打電話去確認？</h5>
					<p>銀行是一般實體商店的作法，客戶正好在刷卡機旁邊，店家可以直接打電話並請客戶與銀行確認身份，可是本站是網路訂購方式非上述情況，請客戶向持卡行要求放寬「網路單筆消費額度」，或是直接在網路訂購時選擇ATM轉帳的方式。</p>
				</div>
				<div id="item-3-4">
					<h5>Q4: 查詢訂單狀態為授權失敗，銀行會請款嗎？</h5>
					<p>如確認訂單為授權失敗，原因可能為網路壅塞或是系統機制..等等不明因素，導致未接獲此筆訂單授權碼，而我們現行電子商務與銀行端無人工授權，故無法向您的發卡銀行辦理請款事宜，因此訂單如為失效亦不會做請款作業。
					   在此，請您與發卡行確認提供授權碼，我們可以協助透過銀行與銀行間取消此筆授權金額，盡快歸還您的信用額度，以利您再消費使用，如您尚需此商品，請網站上重新下訂單即可，如有不便之處，尚祈見諒！</p>
				</div>
				<div id="item-3-5">
					<h5>Q5: 商品未送達，信用卡帳單來了怎辦？需先繳款嗎？</h5>
					<p>本站受限銀行請款時效，因此需要先請款，訂單方能完整成立，若待商品送達再請款則時效不及，訂單將會失效。因此本站統一作業，訂購者均需先完成付款，故訂購者若已收到帳單是需要先行繳款。</p>
				</div>
				<div id="item-3-6">
					<h5>Q6: 為什麼其它區不開放超商取貨付款呢？</h5>
					<p>目前由於超商取貨有營運上的限制，暫無法提供全面性的取貨付款服務，不便之處，敬請見諒！</p><br>
				</div>
				
				<div id="item-4">
					<h2>其它問題</h2>
					<br>
				</div>
				<div id="item-4-1">
					<h5>Q1: 請問退款的方式有哪些？</h5>
					<p>一般而言，我們退款方式因應每位消費者訂單付款方式不同而有所差異(信用卡刷退/退回行動支付帳戶/銀行帳戶退款..等)，若您於辦理退貨時，系統請您填寫退款帳號資料，請您務必填寫正確，以利為您儘速完成退款。當退款完成時，我們會發送退款完成通知信通知您。</p>
				</div>
				<div id="item-4-2">
					<h5>Q2: 如何與客服聯絡？</h5>
					<p>訂單如有訂購、付款、發票、運送、商品等問題，在常見問題Q&A中仍無法為您解答，請依發票上的客服專線連絡我們或是至本站「與我們聯繫」的「線上客服」功能留言，我們將在1-2個工作天內 (不含週六日)確認結果後，儘速回覆在帳戶中「問答紀錄」，並隨後寄發一封Email或是電話通知。</p>
				</div>
				<div id="item-4-3">
					<h5>Q3: 為何未提供商品諮詢？</h5>
					<p>目前所有商品價格、規格、數量、顏色等均已依照特約廠商提供標示在網頁上，由於各網友詢問問題差異太大，多半無法回覆，為避免網友們無限期等待，現階段暫無提供未訂購前的商品諮詢，敬請見諒。</p>
				</div>
				<div id="item-4-4">
					<h5>Q4: 網頁圖片有很多顏色，為什麼商品規格只有一個顏色可選？</h5>
					<p>商品規格可選的顏色為現貨供應，因此圖片顏色與商品規格顏色非等同，若無現貨供應，我們將暫停提供訂購。</p>
				</div>
				
			</div>
		</div>
	</div>
<jsp:include page="../../layout/footer.jsp"></jsp:include>
</body>
</html>