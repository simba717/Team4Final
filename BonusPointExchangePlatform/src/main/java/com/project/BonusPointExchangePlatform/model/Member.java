package com.project.BonusPointExchangePlatform.model;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "member")
public class Member implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	
	@Column(name = "name")
	private String name;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	@Column(name = "birth")
	private Date birth;
	
	@Column(name = "phone")
	private String phone;
	
	@Column(name = "email")
	private String email;
	
	@Lob
	@Column(name = "image")
	private byte[] image;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Column(name = "create_at")
	private Date create_at;	
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Column(name = "update_at")
	private Date update_at;	
	
	
	@JsonIgnore
	@OneToOne
	@JoinColumn(name = "bank_id")
	private Bank bank;
	
	@JsonIgnore	
	@ManyToMany(fetch =FetchType.EAGER)
	@JoinTable(name = "member_game", 
	joinColumns = {@JoinColumn(name = "member_id", referencedColumnName = "id")},
	inverseJoinColumns = {@JoinColumn(name = "game_id", referencedColumnName = "id")}
	)
	private Set<Game> game = new HashSet<Game>();
	
//	@OneToOne(mappedBy = "member")
//	private Account account;
	
	@JsonIgnore	
	@ManyToMany
	@JoinTable(name = "member_campaign", 
	joinColumns = {@JoinColumn(name = "member_id", referencedColumnName = "id")},
	inverseJoinColumns = {@JoinColumn(name = "campaign_id", referencedColumnName = "id")}
	)
	private Set<Campaign> campaign = new HashSet<Campaign>();
	

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member")
	private Set<Wallet> wallet = new LinkedHashSet<Wallet>();
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member")
	private Set<Orders> orders = new LinkedHashSet<Orders>();	

	public Member() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public Set<Game> getGame() {
		return game;
	}

	public void setGame(Set<Game> game) {
		this.game = game;
	}

	public Bank getBank() {
		return bank;
	}

	public void setBank(Bank bank) {
		this.bank = bank;
	}

//	public Account getAccount() {
//		return account;
//	}
//
//	public void setAccount(Account account) {
//		this.account = account;
//	}

	public Set<Campaign> getCampaign() {
		return campaign;
	}

	public void setCampaign(Set<Campaign> campaign) {
		this.campaign = campaign;
	}

	public Set<Wallet> getWallet() {
		return wallet;
	}

	public void setWallet(Set<Wallet> wallet) {
		this.wallet = wallet;
	}

	public Set<Orders> getOrders() {
		return orders;
	}

	public void setOrders(Set<Orders> orders) {
		this.orders = orders;
	}	

}
