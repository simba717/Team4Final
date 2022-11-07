package com.project.BonusPointExchangePlatform.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.BonusPointExchangePlatform.dto.CheckoutDto;
import com.project.BonusPointExchangePlatform.dto.FrontendOrdersListDto;
import com.project.BonusPointExchangePlatform.dto.OrdersDto;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.model.Payment;
import com.project.BonusPointExchangePlatform.model.Product;
import com.project.BonusPointExchangePlatform.model.Wallet;
import com.project.BonusPointExchangePlatform.service.MemberService;
import com.project.BonusPointExchangePlatform.service.Order_DetailService;
import com.project.BonusPointExchangePlatform.service.OrdersService;
import com.project.BonusPointExchangePlatform.service.PaymentService;
import com.project.BonusPointExchangePlatform.service.ProductService;
import com.project.BonusPointExchangePlatform.service.WalletService;

@Controller
public class OrdersController {
	
	@Autowired
	private OrdersService ordersService;
	
	@Autowired
	private Order_DetailService order_DetailService;
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private WalletService walletService;
	
	@Autowired
	private MemberService memberService;
	
	/*SELECT*/
	/*後臺訂單*/
	@GetMapping(value = "/getAllOrders.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, Object> getAllProducts() {
		Map<String, Object> map = new HashMap<>();
		List<OrdersDto> orders = ordersService.findAllOrders();
		List<OrdersDto> orderDetail = order_DetailService.findOrderDetail();
		List<OrdersDto> payment = paymentService.findPayment(); 
		
		map.put("orders", orders);
		map.put("orderDetail", orderDetail);
		map.put("payment", payment);
		
		return map;
	}
	
	/*前臺訂單*/
	@GetMapping(value = "/getAllOrdersByMember.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, Object> getAllOrdersByMember(HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		Member member = (Member) session.getAttribute("member");		
		System.out.println(member.getName());
		List<OrdersDto> orders = ordersService.findAllOrdersByMember(member);
		List<OrdersDto> orderDetail = order_DetailService.findOrderDetailByMember(member);
		List<OrdersDto> payment = paymentService.findPaymentByMember(member);
		
		map.put("orders", orders);
		map.put("orderDetail", orderDetail);
		map.put("payment", payment);
		
		return map;
	}
	
	/*後臺查詢訂單編號*/
	@GetMapping(path = "/orders/searchOrder={search}", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, Object> searchOrder(@PathVariable String search) {
		Map<String, Object> map = new HashMap<>();
		List<OrdersDto> orders = ordersService.searchByOrder(search);
		List<OrdersDto> orderDetail = order_DetailService.searchByOrder(search);
		List<OrdersDto> payment = paymentService.searchByOrder(search);		
				
		map.put("orders", orders);
		map.put("orderDetail", orderDetail);
		map.put("payment", payment);
		return map;
	}
	
	/*前臺查詢訂單編號*/
	@GetMapping(path = "/orders/memberSearchOrder={search}", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, Object> memberSearchOrder(@PathVariable String search, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		Map<String, Object> map = new HashMap<>();		
		List<OrdersDto> orders = ordersService.memberSearchByOrder(member, search);
		List<OrdersDto> orderDetail = order_DetailService.memberSearchByOrder(member, search);
		List<OrdersDto> payment = paymentService.memberSearchByOrder(member, search);
				
		map.put("orders", orders);
		map.put("orderDetail", orderDetail);
		map.put("payment", payment);
				
		return map;
	}
	
	/*後臺查詢會員訂單*/
	@GetMapping(path = "/orders/searchMember={search}", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, Object> searchMember(@PathVariable String search) {
		Map<String, Object> map = new HashMap<>();
		List<Member> member = memberService.findIdByName(search);				
		for(Member m : member) {
			List<OrdersDto> orders = ordersService.searchByMember(m);
			List<OrdersDto> orderDetail = order_DetailService.searchByMember(m);			
			List<OrdersDto> payment = paymentService.searchByMember(m);
			
			map.put("orders", orders);
			map.put("orderDetail", orderDetail);
			map.put("payment", payment);
		}		
		return map;
	}
	
	//顯浩
	@ResponseBody
	@GetMapping(path = "/product/FrontendOrderDetailList")
	public OrdersDto shoppingCartList(HttpSession session){
		Member member = (Member) session.getAttribute("member");
		Orders order = ordersService.findUnPaidOrdersByMember(member);
		//排序ID
		Set<Order_Detail> order_detailListOld = order.getOrder_detail();
		Set<Order_Detail> sortSet = new TreeSet<Order_Detail>((o1,o2)->(o1.getId()-o2.getId()));
		sortSet.addAll(order_detailListOld);
		order.setOrder_detail(sortSet);
		OrdersDto ordersDto = new OrdersDto();
		ordersDto.setOrders(order);
		Set<Order_Detail> order_details = sortSet;

		List<Product> detailList = new ArrayList<Product>();
		for(Order_Detail order_detail:order_details) {
			Product product = productService.findByProductName(order_detail.getProduct_name());
			detailList.add(product);
		}
		ordersDto.setProductList(detailList);
		
		//紅利金跟儲蓄金計算
		Integer remainingBonus = 0;
		Integer remainingWallet = 0;
		List<Wallet> walletList = walletService.findMemberWalletAmount(member);
		for(Wallet wallet:walletList) {
			remainingWallet += wallet.getWallet_amount();
		}
		
		List<Wallet> bonusList = walletService.findMemberBonusAmount(member);
		for(Wallet bonus:bonusList) {
			remainingBonus += bonus.getBonus_point();
		}
		ordersDto.setRemainingBonus(remainingBonus);
		ordersDto.setRemainingWallet(remainingWallet);
		
		return ordersDto;
	}
	
	
	
	@GetMapping(path = "/shoppingCart")
	public String processMainAction(HttpSession session) {
		
		Member member = (Member)session.getAttribute("member");
		
		if( member == null) {
		return "/frontend/entrance/newlogin";
		}else {
			return "frontend/order/shoppingCart";
		}

	}
	
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping(path = "/product/FrontendOrdersListDto" , produces = { "application/json; charset=UTF-8" })
	public List<FrontendOrdersListDto> orderList(@RequestBody FrontendOrdersListDto frontendOrdersListDto, HttpSession session) {
		byte[] orderImage = productService.findById(frontendOrdersListDto.getProduct().getId()).getImage();
		frontendOrdersListDto.saveOrderImage(orderImage);
		Member member = (Member) session.getAttribute("member");
		Orders orders = ordersService.findUnPaidOrdersByMember(member);
		if(orders == null) {
			ordersService.insertOrder(member);
		}		
		order_DetailService.insertOrderDetail(ordersService.findUnPaidOrdersByMember(member), frontendOrdersListDto.getProduct(), frontendOrdersListDto.getOrderNumber(), member);
		
		List<FrontendOrdersListDto> list = (List<FrontendOrdersListDto>)session.getAttribute("ordersListContent");
		if(list==null) {
			List<FrontendOrdersListDto> newList = new ArrayList<FrontendOrdersListDto>();
			list = newList;
			list.add(frontendOrdersListDto);
		}else {
			list.add(frontendOrdersListDto);
		}
		session.setAttribute("ordersListContent", list);
		return list;
	}
	
	
	//結帳訂單
	@PostMapping(path = "/orders/checkoutWallet" , produces = { "application/json; charset=UTF-8" })
	public String ordersCheckoutWallet(@RequestParam("sendBonus2") Integer sendBonus2,@RequestParam("sendWallet2") Integer sendWallet2,@RequestParam("sendCreditCard2") Integer sendCreditCard2,HttpSession session,Model m) {
		Member member = (Member) session.getAttribute("member");
		Orders order = ordersService.findUnPaidOrdersByMember(member);
		CheckoutDto checkoutWallet = new CheckoutDto();
		checkoutWallet.setOrders(order);
		checkoutWallet.setBonus(sendBonus2);
		checkoutWallet.setWallet(sendWallet2);
		checkoutWallet.setCreditCard(sendCreditCard2);
		
		/*紅利&儲值金*/
		if(sendBonus2 != 0 && sendWallet2 != 0 && sendCreditCard2 == 0) {
			walletService.insertWalletByBonus(member, order, sendBonus2);
			paymentService.insertPayment(member, order, "紅利點數");
			walletService.insertByCreditCardAndWallet(member, order, null, sendCreditCard2, sendWallet2);
			paymentService.insertPayment(member, order, "儲值金");
			walletService.insertWalletByFeedback(member, null, sendCreditCard2, sendWallet2);
			ordersService.updateOrderStatus(member);
		/*儲值金*/	
		} else if(sendBonus2 == 0 && sendWallet2 != 0 && sendCreditCard2 == 0) {
			walletService.insertByCreditCardAndWallet(member, order, null, sendCreditCard2, sendWallet2);
			paymentService.insertPayment(member, order, "儲值金");
			walletService.insertWalletByFeedback(member, null, sendCreditCard2, sendWallet2);
			ordersService.updateOrderStatus(member);
		/*紅利*/
		} else if(sendBonus2 != 0 && sendWallet2 == 0 && sendCreditCard2 == 0) {
			walletService.insertWalletByBonus(member, order, sendBonus2);
			paymentService.insertPayment(member, order, "紅利點數");
			ordersService.updateOrderStatus(member);
		} else {
			System.out.println("ERROR");
		}
		m.addAttribute("checkout",checkoutWallet);
		
		return "redirect:/";
	}
	
	
	@PostMapping(path = "/orders/checkoutCreditCard" , produces = { "application/json; charset=UTF-8" })
	public String orderscheckoutCreditCard(@RequestParam("sendBonus") Integer sendBonus,@RequestParam("sendWallet") Integer sendWallet,@RequestParam("sendCreditCard") Integer sendCreditCard, HttpSession session,RedirectAttributes redirectAttrs) {
		Member member = (Member) session.getAttribute("member");
		Orders order = ordersService.findUnPaidOrdersByMember(member);
		CheckoutDto checkoutCreditCard = new CheckoutDto();
		checkoutCreditCard.setOrders(order);
		checkoutCreditCard.setBonus(sendBonus);
		checkoutCreditCard.setWallet(sendWallet);
		checkoutCreditCard.setCreditCard(sendCreditCard);
		Set<Order_Detail> order_detail = order.getOrder_detail();
		checkoutCreditCard.setOrder_detail(order_detail);
		
		/*紅利&信用卡*/
		if(sendBonus != 0 && sendWallet == 0 && sendCreditCard != 0) {
			walletService.insertWalletByBonus(member, order, sendBonus);
			paymentService.insertPayment(member, order, "紅利點數");
			walletService.insertByCreditCardAndWallet(member, order, member.getBank(), sendCreditCard, sendWallet);
			paymentService.insertPayment(member, order, "信用卡");
			walletService.insertWalletByFeedback(member, member.getBank(), sendCreditCard, sendWallet);
			ordersService.updateOrderStatus(member);
		/*信用卡*/	
		} else if(sendBonus == 0 && sendWallet == 0 && sendCreditCard != 0) {
			walletService.insertByCreditCardAndWallet(member, order, member.getBank(), sendCreditCard, sendWallet);
			paymentService.insertPayment(member, order, "信用卡");
			walletService.insertWalletByFeedback(member, member.getBank(), sendCreditCard, sendWallet);
			ordersService.updateOrderStatus(member);
		} else {
			System.out.println("ERROR");
		}
		redirectAttrs.addFlashAttribute("checkout",checkoutCreditCard);//Controller傳Controller值
		return "redirect:/public/ecpay";
	}
}
