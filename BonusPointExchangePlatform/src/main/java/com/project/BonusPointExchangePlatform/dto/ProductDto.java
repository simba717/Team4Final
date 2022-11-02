package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;
import java.util.Base64;

import com.project.BonusPointExchangePlatform.model.Product;

public class ProductDto implements Serializable {
	
	private static final long serialVersionUID = 1L;	
	
	private String fileDataUrl;
	
	private Product product;
	
	private String employee_name;
	
	public ProductDto() {
	}

	public ProductDto(Product product) {
		this.product = product;
		this.employee_name = product.getEmployee().getName();
	}	

	public String getFileDataUrl() {
		return fileDataUrl;
	}

	public void setFileDataUrl(String fileDataUrl) {
		this.fileDataUrl = fileDataUrl;
	}

	public String getEmployee_name() {
		return employee_name;
	}

	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public void convertImage() {
		String base64 = fileDataUrl.substring(fileDataUrl.indexOf(",") + 1);
	    byte[] a = Base64.getMimeDecoder().decode(base64);
	    product.setImage(a);	    
	}

	
	
}
