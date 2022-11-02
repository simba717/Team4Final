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
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "employee")
public class Employee implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	
	@Column(name = "name")
	private String name;
	
	@Column(name = "employee_no")
	private Integer employee_no;	
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	@Column(name = "arrived_at")
	private Date arrived_at;	
	
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
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "employee")
	private Set<Message> message = new LinkedHashSet<Message>();
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "employee")
	private Set<Quest> quest = new LinkedHashSet<Quest>();
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "employee")
	private Set<Campaign> campaign = new LinkedHashSet<Campaign>();
	
//	@OneToOne(mappedBy = "employee")
//	private Account account;
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "employee")
	private Set<Product> product = new LinkedHashSet<Product>();	

	public Employee() {
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
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

	public Integer getEmployee_no() {
		return employee_no;
	}

	public void setEmployee_no(Integer employee_no) {
		this.employee_no = employee_no;
	}

	public Date getArrived_at() {
		return arrived_at;
	}

	public void setArrived_at(Date arrived_at) {
		this.arrived_at = arrived_at;
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

	public Set<Message> getMessage() {
		return message;
	}

	public void setMessage(Set<Message> message) {
		this.message = message;
	}

	public Set<Quest> getQuest() {
		return quest;
	}

	public void setQuest(Set<Quest> quest) {
		this.quest = quest;
	}

	public Set<Campaign> getCampaign() {
		return campaign;
	}

	public void setCampaign(Set<Campaign> campaign) {
		this.campaign = campaign;
	}

//	public Account getAccount() {
//		return account;
//	}
//
//	public void setAccount(Account account) {
//		this.account = account;
//	}

	public Set<Product> getProduct() {
		return product;
	}

	public void setProduct(Set<Product> product) {
		this.product = product;
	}

}
