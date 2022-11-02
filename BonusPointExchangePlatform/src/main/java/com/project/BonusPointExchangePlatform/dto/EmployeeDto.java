package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;
import java.util.Base64;

import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Employee;

public class EmployeeDto implements Serializable {

	private static final long serialVersionUID = 1L;

	private Account account;
	
	private Employee employee;

	private String Arrived_date;

	private String Create_date;

	private String Update_date;
	
	private String orderby;
	
	private int account_type;
	
	private String name;
	
	private String image;
	
	
	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}
	
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAccount_type() {
		return account_type;
	}

	public void setAccount_type(int account_type) {
		this.account_type = account_type;
	}

	public String getOrderby() {
		return orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}

	public String getCreate_date() {
		return Create_date;
	}

	public void setCreate_date(String create_date) {
		Create_date = create_date;
	}

	public String getUpdate_date() {
		return Update_date;
	}

	public void setUpdate_date(String update_date) {
		Update_date = update_date;
	}

	public EmployeeDto() {
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getArrived_date() {
		return Arrived_date;
	}

	public void setArrived_date(String arrived_date) {
		Arrived_date = arrived_date;
	}
	
	public byte[] convertImage() {
		String base64 = image.substring(image.indexOf(",")+1);
		byte[] a = Base64.getMimeDecoder().decode(base64);
		return a;
	}

}