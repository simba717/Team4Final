package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Wallet;

public class GameDto implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int memberId;
	
	private String memberName;
	
	private int gameId;
	
	private String gameType;
	
	private int gameScore;
	
	private  Date playTime;
	
	private int bonusPoint;
	

	public GameDto() {
	}
	
	
	
	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	

	public String getMemberName() {
		return memberName;
	}



	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}



	public int getGameId() {
		return gameId;
	}

	public void setGameId(int gameId) {
		this.gameId = gameId;
	}

	
	public String getGameType() {
		return gameType;
	}

	public void setGameType(String gameType) {
		this.gameType = gameType;
	}

	public int getGameScore() {
		return gameScore;
	}


	public void setGameScore(int gameScore) {
		this.gameScore = gameScore;
	}

	public Date getPlayTime() {
		return playTime;
	}


	public void setPlayTime(Date playTime) {
		this.playTime = playTime;
	}


	public int getBonusPoint() {
		return bonusPoint;
	}


	public void setBonusPoint(int bonusPoint) {
		this.bonusPoint = bonusPoint;
	}

}
