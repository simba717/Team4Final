package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;

public class BackendLookGameBonusOfMemberDto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int memberId;
	
	private int gameBonus;

	public BackendLookGameBonusOfMemberDto() {
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getGameBonus() {
		return gameBonus;
	}

	public void setGameBonus(int gameBonus) {
		this.gameBonus = gameBonus;
	}
	
}
