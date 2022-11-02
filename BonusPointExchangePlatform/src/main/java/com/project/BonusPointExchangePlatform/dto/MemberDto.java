package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;
import java.util.Base64;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Bank;
import com.project.BonusPointExchangePlatform.model.Member;

public class MemberDto implements Serializable{
	
	private static final long serialVersionUID=1L;
	
	private Account account;
	
	private Member member;
	

	private Bank bank;
	
	private String dateBirth;
	
	private String dateUpdate;
	
	private String name;
	
	private String birth;
	
	private String dateCreate;


	private String email;
	
	private String phone;
	
	private String image;
	
	private int account_type;
	
	private String orderby;
	
	
	
	

	public String getOrderby() {
		return orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}

	public int getAccount_type() {
		return account_type;
	}

	public void setAccount_type(int account_type) {
		this.account_type = account_type;
	}

	public Member getMember() {
		return member;
	}
	
	public void setMember(Member member) {
		this.member = member;
	}
	
	public String getDateCreate() {
		return dateCreate;
	}
	
	public void setDateCreate(String dateCreate) {
		this.dateCreate = dateCreate;
	}
	
	public Bank getBank() {
		return bank;
	}

	public void setBank(Bank bank) {
		this.bank = bank;
	}
	
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public MemberDto() {
	
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public String getDateBirth() {
		return dateBirth;
	}

	public void setDateBirth(String dateBirth) {
		this.dateBirth = dateBirth;
	}

	public String getDateUpdate() {
		return dateUpdate;
	}

	public void setDateUpdate(String dateUpdate) {
		this.dateUpdate = dateUpdate;
	}
	
	public byte[] convertImage() {
		String base64 = image.substring(image.indexOf(",")+1);
		byte[] a = Base64.getMimeDecoder().decode(base64);
		return a;
	}

}
