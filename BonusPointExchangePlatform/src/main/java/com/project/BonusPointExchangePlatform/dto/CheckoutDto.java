package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;
import java.util.LinkedHashSet;
import java.util.Set;

import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Orders;

public class CheckoutDto implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Orders orders;
	
	private Integer bonus;
	
	private Integer wallet;
	
	private Integer creditCard;
	private Set<Order_Detail> order_detail;
	public CheckoutDto() {
	}

	public Orders getOrders() {
		return orders;
	}

	public void setOrders(Orders orders) {
		this.orders = orders;
	}

	public Integer getBonus() {
		return bonus;
	}

	public void setBonus(Integer bonus) {
		this.bonus = bonus;
	}

	public Integer getWallet() {
		return wallet;
	}

	public void setWallet(Integer wallet) {
		this.wallet = wallet;
	}

	public Integer getCreditCard() {
		return creditCard;
	}

	public void setCreditCard(Integer creditCard) {
		this.creditCard = creditCard;
	}
	
	public Set<Order_Detail> getOrder_detail() {
		return order_detail;
	}

	public void setOrder_detail(Set<Order_Detail> order_detail) {
		this.order_detail = new LinkedHashSet<>();
		for(Order_Detail o : order_detail) {
			this.order_detail.add(o);
		}
		
		
	}
	
}
