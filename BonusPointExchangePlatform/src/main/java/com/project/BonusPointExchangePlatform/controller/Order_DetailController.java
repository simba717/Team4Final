package com.project.BonusPointExchangePlatform.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.dto.FrontendOrdersListDto;
import com.project.BonusPointExchangePlatform.dto.OrdersDto;
import com.project.BonusPointExchangePlatform.dto.ShoppingCartDto;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.model.Product;
import com.project.BonusPointExchangePlatform.service.Order_DetailService;
import com.project.BonusPointExchangePlatform.service.OrdersService;
import com.project.BonusPointExchangePlatform.service.ProductService;

@Controller
public class Order_DetailController {

	@Autowired
	private OrdersService ordersService;

	@Autowired
	private ProductService productService;

	@Autowired
	private Order_DetailService order_DetailService;

	// 顯浩
	@ResponseBody
	@PostMapping(path = "/orderDetail/updateNumber", produces = { "application/json; charset=UTF-8" })
	public OrdersDto shoppingCartList(@RequestBody Order_Detail order_Detail, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		Integer tmpOrderDetailTotal = 0;
		Integer bestSellerTotal = 0;
		Product product = productService.findByProductName(order_Detail.getProduct_name());
		Orders orders = ordersService.findUnPaidOrdersByMember(member);
		String productName = order_Detail.getProduct_name();
		//得到目前此商品訂購總數
		List<Order_Detail> findAllByOrderDetailName = order_DetailService.findAllByOrderDetailName(productName);
		for(Order_Detail findOneByOrderDetailName:findAllByOrderDetailName) {
			bestSellerTotal += findOneByOrderDetailName.getQuantity();
		}
		
		Order_Detail findByIdOrderDetail = order_DetailService.findOneByOrderDetailIdProductName(orders, productName);
		Integer checkTotal= bestSellerTotal-findByIdOrderDetail.getQuantity()+order_Detail.getQuantity();
		
		
		//判斷商品訂購總數有沒有大於庫存
		if (checkTotal > product.getQuantity()) {
			System.out.println("有問題");
			return null;
		} else {
			//熱銷數修改&訂單detail更新
			Integer price = product.getPrice();
			tmpOrderDetailTotal += price * order_Detail.getQuantity();
			order_DetailService.updateBestSellerAndOrderDetail(productName, checkTotal, order_Detail.getQuantity(), tmpOrderDetailTotal, orders);
			
			//未結帳訂單總共價格更新
			order_DetailService.updateOrdersTotal(member, orders);
				
			//回傳Dto
			OrdersDto ordersDto = order_DetailService.getShoppingCartDto(member);
			return ordersDto;
		}
	}

	@ResponseBody
	@GetMapping(path = "/orderDetail/deleteOrderDetail/{id}")
	public OrdersDto deleteOrderDetail(@PathVariable Integer id,HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		Integer bestSellerTotal = 0;
		Order_Detail order_Detail = order_DetailService.findById(id);
		String productName = order_Detail.getProduct_name();
		Integer orderDetailTotal = order_Detail.getTotal();
		Orders orders = order_Detail.getOrders();
		//得到目前此商品訂購總數
		List<Order_Detail> findAllByOrderDetailName = order_DetailService.findAllByOrderDetailName(productName);
		for(Order_Detail findOneByOrderDetailName:findAllByOrderDetailName) {
			bestSellerTotal += findOneByOrderDetailName.getQuantity();
		}
		Integer checkTotal = bestSellerTotal-order_Detail.getQuantity();
		
		order_DetailService.deleteOrderDetail(id,checkTotal,productName,orderDetailTotal,orders,member);
		
		//回傳Dto
		OrdersDto ordersDto = order_DetailService.getShoppingCartDto(member);
		return ordersDto;
	}
	

}
