package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;

import com.project.BonusPointExchangePlatform.dao.WalletDao;
import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Wallet;

public class WalletDto implements Serializable{
	private static final long serialVersionUID=1L;
	
	private int bonusTotal ;
	
	private int wallet_amount;
	
	private int bank_amount;
	
	private int bonus;
	
	private String create_at ;
	
	private String name;
	
	private Account account;

	private int pagenumber;
	
	private Double totalpagenumber;
	
	private String orderby;
	
	private Wallet wallet;
	
	private String gameName; 
	
	private int usecardamount;
	
	private String selected;
	
	private String message;
	
	private String date1;
	
	private String date2;

	public String getDate1() {
		return date1;
	}

	public void setDate1(String date1) {
		this.date1 = date1;
	}

	public String getDate2() {
		return date2;
	}

	public void setDate2(String date2) {
		this.date2 = date2;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSelected() {
		return selected;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}

	public int getUsecardamount() {
		return usecardamount;
	}

	public void setUsecardamount(int usecardamount) {
		this.usecardamount = usecardamount;
	}

	public String getGameName() {
		return gameName;
	}

	public void setGameName(String gameName) {
		this.gameName = gameName;
	}

	public Wallet getWallet() {
		return wallet;
	}

	public void setWallet(Wallet wallet) {
		this.wallet = wallet;
	}

	public String getOrderby() {
		return orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}

	public Double getTotalpagenumber() {
		return totalpagenumber;
	}

	public void setTotalpagenumber(Double totalpagenumber) {
		this.totalpagenumber = totalpagenumber;
	}

	public int getPagenumber() {
		return pagenumber;
	}

	public void setPagenumber(int pagenumber) {
		this.pagenumber = pagenumber;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	

	public String getCreate_at() {
		return create_at;
	}

	public void setCreate_at(String create_at) {
		this.create_at = create_at;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getBonus() {
		return bonus;
	}

	public void setBonus(int bonus) {
		this.bonus = bonus;
	}

	public WalletDto() {
	}

	public int getBonusTotal() {
		return bonusTotal;
	}

	public int getWallet_amount() {
		return wallet_amount;
	}

	public void setWallet_amount(int wallet_amount) {
		this.wallet_amount = wallet_amount;
	}

	public int getBank_amount() {
		return bank_amount;
	}

	public void setBank_amount(int bank_amount) {
		this.bank_amount = bank_amount;
	}

	public void setBonusTotal(int bonusTotal) {
		this.bonusTotal = bonusTotal;
	}
	
	
}
