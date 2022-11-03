package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Wallet;

public class FrontendGameRecoedDto implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
//	private Game game;
//	
//	private Wallet wallet;
	
	private int gameId;
	
	private String gameName;
	
	private int gameScore;
	
	private  Date playTime;
	
	private int bonusPoint;
	

	public FrontendGameRecoedDto() {
	}
	
	
	public int getGameId() {
		return gameId;
	}

	public void setGameId(int gameId) {
		this.gameId = gameId;
	}

//	public Game getGame() {
//		return game;
//	}
//
//	public void setGame(Game game) {
//		this.game = game;
//	}
//
//	public Wallet getWallet() {
//		return wallet;
//	}
//
//	public void setWallet(Wallet wallet) {
//		this.wallet = wallet;
//	}


	public String getGameName() {
		return gameName;
	}


	public void setGameName(String gameName) {
		this.gameName = gameName;
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
