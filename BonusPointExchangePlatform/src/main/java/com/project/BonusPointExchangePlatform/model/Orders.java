package com.project.BonusPointExchangePlatform.model;

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "orders")
public class Orders implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")	
	private Integer id;
	
	@Column(name = "sub_total")
	private Integer sub_total;
	
	@Column(name = "order_token")
	@GeneratedValue(generator = "paymentableGenerator")     
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid") 
	private String order_token;
	
	@Column(name = "order_status")
	private String order_status;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy/MM/dd HH:mm:ss", timezone = "GMT+8")
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Column(name = "create_at")
	private Date create_at;	
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy/MM/dd HH:mm:ss", timezone = "GMT+8")
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Column(name = "update_at")
	private Date update_at;
		
	@ManyToOne
	@JoinColumn(name = "member_id")
	private Member member;	
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "orders")
	private Set<Order_Detail> order_detail = new LinkedHashSet<Order_Detail>();	
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "orders")
	private Set<Payment> payment = new LinkedHashSet<Payment>();
	
	@PrePersist
	public void onCreate() {
		if(order_token == null) {
			order_token = UUID.randomUUID().toString();
		}
	}

	public Orders() {
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSub_total() {
		return sub_total;
	}

	public void setSub_total(Integer sub_total) {
		this.sub_total = sub_total;
	}

	public String getOrder_token() {
		String result = StringUtils.replace(getUpdate_at().toString().substring(0, 19), "-", "");
			   result = StringUtils.replace(result, ":", "");
			   result = StringUtils.replace(result, " ", "") + id;
		return result;
	}

	public void setOrder_token(String order_token) {
		this.order_token = order_token;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
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

	public Set<Order_Detail> getOrder_detail() {
		return order_detail;
	}

	public void setOrder_detail(Set<Order_Detail> order_detail) {
		this.order_detail = order_detail;
	}

	public Set<Payment> getPayment() {
		return payment;
	}

	public void setPayment(Set<Payment> payment) {
		this.payment = payment;
	}

}
