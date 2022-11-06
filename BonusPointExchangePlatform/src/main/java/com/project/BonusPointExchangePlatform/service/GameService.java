package com.project.BonusPointExchangePlatform.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.BonusPointExchangePlatform.dao.GameDao;
import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.dao.WalletDao;

import com.project.BonusPointExchangePlatform.dto.BackendLookGameBonusOfMemberDto;

import com.project.BonusPointExchangePlatform.dto.GameDto;
import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Wallet;

@Service
@Transactional
public class GameService {

	@Autowired
	private GameDao gameDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private WalletDao walletDao;
	
	
	public Member getMemberById(Integer id) {
		Optional<Member> query = memberDao.findById(id);
		if(query.isPresent()) {
			return query.get();
		}
		
		return null;
	}
	
	public void insertGame(Member member, Date update_at) {
		gameDao.insertLogin(member, update_at);
	}
	
	public Game checkSignIn(Integer id,String game_type,String create_at) {
		return gameDao.checkSignIn(id, game_type, create_at);
	}
	
	public List<Game> selectDate(Integer id,String game_type){
		return gameDao.selectDate(id, game_type);
	}
	

	public Member checkBirth(String birh,Integer merber_id) {
		return memberDao.checkBirth(birh, merber_id);
	}
	
	public Game checkBirthGift(Integer id,String create_at) {
		return gameDao.checkBirthGift(id, create_at);
	}
	
	public void insertBirth(Member member_id,Date update_at) {
		gameDao.insertBirth(member_id, update_at);;
	}
	
	public Game checkCrystalGift(Integer id,String create_at) {
		return gameDao.checkCrystalGift(id, create_at);
	}
	
	public void insertCrystal(Member member_id,Date update_at) {
		gameDao.insertCrystal(member_id, update_at);;
	}
	
	public void insertSignWallet(Member member_id,Date update_at) {
		walletDao.insertSignWallet(member_id, update_at);
	}
	
	public void insertBirthWallet(Member member_id,Date update_at) {
		walletDao.insertBirthWallet(member_id, update_at);
	}

	public void insertCrystalWallet(Member member_id,Date update_at) {
		walletDao.insertCrystalWallet(member_id, update_at);
	}
	
//////////////瑋煊的頭//////////////////

//前台將會員遊戲紀錄塞進Dto
public List<GameDto> findGameRecordsByMember(int member_id) {

List<Game> gameRecords = gameDao.findGameRecordsByMember(member_id);

List<GameDto> gameDto = new ArrayList<>();
//
for(Game gameRecord : gameRecords) {
	GameDto gameRecordDto = new GameDto();
	gameRecordDto.setGameId(gameRecord.getId());
	gameRecordDto.setGameType(gameRecord.getGame_type());
	gameRecordDto.setGameScore(gameRecord.getGame_score());
	gameRecordDto.setPlayTime(gameRecord.getCreate_at());
	gameRecordDto.setBonusPoint(gameRecord.getWallet().getBonus_point());
	
//	gameRecordDto.setGame(gameRecord);
//	gameRecordDto.setWallet(gameRecord.getWallet());
	gameDto.add(gameRecordDto);
}	

return gameDto;
}

//後台將所有會員經遊戲取得的紅利塞進Dto
public List<GameDto> findGameBonusOfAllMember() {

List<Wallet> allMemberGameBonus = walletDao.findGameBonusOfAllMember();
List<GameDto> allMemberGameBonusDto = new ArrayList<>();

for(Wallet memberGameBonus : allMemberGameBonus) {
	GameDto memberGameBonusDto = new GameDto();
	memberGameBonusDto.setMemberId(memberGameBonus.getMember().getId());
	memberGameBonusDto.setMemberName(memberGameBonus.getMember().getName());
	memberGameBonusDto.setGameType(memberGameBonus.getGame().getGame_type());
	memberGameBonusDto.setBonusPoint(memberGameBonus.getBonus_point());
	allMemberGameBonusDto.add(memberGameBonusDto);
}	

return allMemberGameBonusDto;
}

//後台將單一會員經遊戲取得的紅利塞進Dto
public List<GameDto> findGameBonusOfOneMember(int member_id) {

List<Wallet> oneMemberGameBonus = walletDao.findGameBonusOfOneMember(member_id);
List<GameDto> oneMemberGameBonusDto = new ArrayList<>();

for(Wallet GameBonus : oneMemberGameBonus) {
	GameDto GameBonusDto = new GameDto();
	GameBonusDto.setMemberId(GameBonus.getMember().getId());
	GameBonusDto.setMemberName(GameBonus.getMember().getName());
	GameBonusDto.setGameType(GameBonus.getGame().getGame_type());
	GameBonusDto.setBonusPoint(GameBonus.getBonus_point());
	oneMemberGameBonusDto.add(GameBonusDto);
}	

return oneMemberGameBonusDto;
}

//////////////瑋煊的腳//////////////////
	
	
	
	
	
	
	
	
}
