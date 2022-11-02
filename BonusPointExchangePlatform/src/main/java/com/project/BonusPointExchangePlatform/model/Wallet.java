package com.project.BonusPointExchangePlatform.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "wallet")
public class Wallet implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")	
	private Integer id;
	
	@Column(name = "source_type")	
	private String source_type;
	
	@Column(name = "wallet_amount")	
	private Integer wallet_amount;
	
	@Column(name = "bonus_point")	
	private Integer bonus_point;
	
	@Column(name = "credit_card_amount")	
	private Integer credit_card_amount;	
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Column(name = "create_at")
	private Date create_at;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "member_id")
	private Member member;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "bank_id")
	private Bank bank;
	
	@JsonIgnore
	@OneToOne
	@JoinColumn(name = "game_id")
	private Game game;
	
	@JsonIgnore
	@OneToOne(mappedBy = "wallet")
	private Payment payment;	

	public Wallet() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSource_type() {
		return source_type;
	}

	public void setSource_type(String source_type) {
		this.source_type = source_type;
	}

	public Integer getWallet_amount() {
		return wallet_amount;
	}

	public void setWallet_amount(Integer wallet_amount) {
		this.wallet_amount = wallet_amount;
	}

	public Integer getBonus_point() {
		return bonus_point;
	}

	public void setBonus_point(Integer bonus_point) {
		this.bonus_point = bonus_point;
	}

	public Integer getCredit_card_amount() {
		return credit_card_amount;
	}

	public void setCredit_card_amount(Integer credit_card_amount) {
		this.credit_card_amount = credit_card_amount;
	}

	public Date getCreate_at() {
		return create_at;
	}

	public void setCreate_at(Date create_at) {
		this.create_at = create_at;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Bank getBank() {
		return bank;
	}

	public void setBank(Bank bank) {
		this.bank = bank;
	}

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
	}

	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}

}
