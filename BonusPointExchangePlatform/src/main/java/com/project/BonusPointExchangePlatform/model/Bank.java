package com.project.BonusPointExchangePlatform.model;

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "bank")
public class Bank implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	
	@Column(name = "name")
	private String name;
	
	@Column(name = "bank_code")
	private Integer bank_code;
	
	@Column(name = "account_no")
	private String account_no;
	
	@Column(name = "amount")
	private Integer amount;	
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Column(name = "create_at")
	private Date create_at;	
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Column(name = "update_at")
	private Date update_at;	
	
	@JsonIgnore
	@OneToOne(mappedBy = "bank")
	private Member member;
	

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "bank")
	private Set<Wallet> wallet = new LinkedHashSet<Wallet>();
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "bank")
	private Set<Credit_Card> credit_card = new LinkedHashSet<Credit_Card>();

	public Bank() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getBank_code() {
		return bank_code;
	}

	public void setBank_code(Integer bank_code) {
		this.bank_code = bank_code;
	}

	public String getAccount_no() {
		return account_no;
	}

	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Date getCreate_at() {
		return create_at;
	}

	public void setCreate_at(Date create_at) {
		this.create_at = create_at;
	}

	public Date getUpdate_at() {
		return update_at;
	}

	public void setUpdate_at(Date update_at) {
		this.update_at = update_at;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Set<Wallet> getWallet() {
		return wallet;
	}

	public void setWallet(Set<Wallet> wallet) {
		this.wallet = wallet;
	}

	public Set<Credit_Card> getCredit_card() {
		return credit_card;
	}

	public void setCredit_card(Set<Credit_Card> credit_card) {
		this.credit_card = credit_card;
	}

}
