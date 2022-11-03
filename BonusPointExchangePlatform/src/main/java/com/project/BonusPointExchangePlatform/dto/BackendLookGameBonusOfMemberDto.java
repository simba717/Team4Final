package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;

public class BackendLookGameBonusOfMemberDto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int memberId;
	
	private String gameType; 
	
	private int gameBonus;

	public BackendLookGameBonusOfMemberDto() {
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	
	public String getGameType() {
		return gameType;
	}

	public void setGameType(String gameType) {
		this.gameType = gameType;
	}

	public int getGameBonus() {
		return gameBonus;
	}

	public void setGameBonus(int gameBonus) {
		this.gameBonus = gameBonus;
	}
	
}
