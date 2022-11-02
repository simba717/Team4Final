package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;

import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Product;

public class FrontendOrdersListDto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer orderNumber;

	private Product product;

	public FrontendOrdersListDto() {
	}

	public Integer getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(Integer orderNumber) {
		this.orderNumber = orderNumber;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}	

	public void saveOrderImage(byte[] image) {
		product.setImage(image);
	}
	
}
