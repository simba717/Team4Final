package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;
import java.util.List;

import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.model.Payment;
import com.project.BonusPointExchangePlatform.model.Product;

public class OrdersDto implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Orders orders;
	
	private Order_Detail order_detail;
	
	private Payment payment;
	
	private List<Product> productList;
	
	private Integer remainingBonus;
	
	private Integer remainingWallet;

	public Integer getRemainingBonus() {
		return remainingBonus;
	}

	public void setRemainingBonus(Integer remainingBonus) {
		this.remainingBonus = remainingBonus;
	}

	public Integer getRemainingWallet() {
		return remainingWallet;
	}

	public void setRemainingWallet(Integer remainingWallet) {
		this.remainingWallet = remainingWallet;
	}

	public List<Product> getProductList() {
		return productList;
	}

	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}

	public OrdersDto() {
	}

	public OrdersDto(Orders orders) {
		this.orders = orders;
	}

	public OrdersDto(Order_Detail order_detail) {
		this.order_detail = order_detail;
	}

	public OrdersDto(Payment payment) {
		this.payment = payment;
	}

	public Orders getOrders() {
		return orders;
	}

	public void setOrders(Orders orders) {
		this.orders = orders;
	}

	public Order_Detail getOrder_Detail() {
		return order_detail;
	}

	public void setOrder_Detail(Order_Detail order_detail) {
		this.order_detail = order_detail;
	}

	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}

}
