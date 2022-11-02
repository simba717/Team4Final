package com.project.BonusPointExchangePlatform.model;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "game")
public class Game implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	
	@Column(name = "game_type")
	private String game_type;
	
	@Column(name = "check_status")
	private boolean check_status;	
	
	@Column(name = "game_score")
	private Integer game_score;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Column(name = "create_at")
	private Date create_at;	
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Column(name = "update_at")
	private Date update_at;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "game")
	private Set<Member> member = new HashSet<Member>();
	
	@JsonIgnore
	@OneToOne(mappedBy = "game")
	private Wallet wallet;
	
	
	
	public Game(String game_type, boolean check_status, Integer game_score, Date create_at, Date update_at,
			Set<Member> member) {
		super();
		this.game_type = game_type;
		this.check_status = check_status;
		this.game_score = game_score;
		this.create_at = create_at;
		this.update_at = update_at;
		this.member = member;
	}

	public Game() {
	}

	public Wallet getWallet() {
		return wallet;
	}

	public void setWallet(Wallet wallet) {
		this.wallet = wallet;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getGame_type() {
		return game_type;
	}

	public void setGame_type(String game_type) {
		this.game_type = game_type;
	}

	public boolean getCheck_status() {
		return check_status;
	}

	public void setCheck_status(boolean check_status) {
		this.check_status = check_status;
	}
	

	public Integer getGame_score() {
		return game_score;
	}

	public void setGame_score(Integer game_score) {
		this.game_score = game_score;
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

	public Set<Member> getMember() {
		return member;
	}

	public void setMember(Set<Member> member) {
		this.member = member;
	}

}
