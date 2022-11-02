package com.project.BonusPointExchangePlatform.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name="photo")
public class goodphoto {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "photo_name")
	private String photo_name;

	@Lob
	@Column(name = "photo_file")
	private byte[] photo_file;

	public goodphoto() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPhoto_name() {
		return photo_name;
	}

	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}

	public byte[] getPhoto_file() {
		return photo_file;
	}

	public void setPhoto_file(byte[] photo_file) {
		this.photo_file = photo_file;
	}

}
