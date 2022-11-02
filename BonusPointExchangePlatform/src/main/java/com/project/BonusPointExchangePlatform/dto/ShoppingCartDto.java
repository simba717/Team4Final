package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;

import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Product;

public class ShoppingCartDto implements Serializable {

	private static final long serialVersionUID = 1L;

	private Order_Detail order_Detail;
	
	private Product product;
	
	public Order_Detail getOrder_Detail() {
		return order_Detail;
	}

	public void setOrder_Detail(Order_Detail order_Detail) {
		this.order_Detail = order_Detail;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public ShoppingCartDto() {
	}

}
