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
import com.project.BonusPointExchangePlatform.dto.FrontendGameRecoedDto;
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
		
//		return gameDao.save(game);
	}
	
	public Game checkSignIn(Integer id,String game_type,String create_at) {
		return gameDao.checkSignIn(id, game_type, create_at);
	}
	
	public List<Game> selectDate(Integer id,String game_type){
		return gameDao.selectDate(id, game_type);
	}
	
	
//////////////瑋煊的頭//////////////////

//將會員遊戲紀錄塞進Dto
public List<FrontendGameRecoedDto> findGameRecordsByMember(int member_id) {

List<Game> gameRecords = gameDao.findGameRecordsByMember(member_id);

List<FrontendGameRecoedDto> gameRecordsDto = new ArrayList<>();
//
for(Game gameRecord : gameRecords) {
	FrontendGameRecoedDto gameRecordDto = new FrontendGameRecoedDto();
	gameRecordDto.setGameId(gameRecord.getId());
	gameRecordDto.setGameName(gameRecord.getGame_type());
	gameRecordDto.setGameScore(gameRecord.getGame_score());
	gameRecordDto.setPlayTime(gameRecord.getCreate_at());
	gameRecordDto.setBonusPoint(gameRecord.getWallet().getBonus_point());
	
//	gameRecordDto.setGame(gameRecord);
//	gameRecordDto.setWallet(gameRecord.getWallet());
	gameRecordsDto.add(gameRecordDto);
}	

return gameRecordsDto;
}

//將會員經遊戲取得的紅利塞進Dto
public List<BackendLookGameBonusOfMemberDto> findGameBonusOfAllMember() {

List<Wallet> allMemberGameBonus = walletDao.findGameBonusOfAllMember();
List<BackendLookGameBonusOfMemberDto> allMemberGameBonusDto = new ArrayList<>();

for(Wallet memberGameBonus : allMemberGameBonus) {
	BackendLookGameBonusOfMemberDto memberGameBonusDto = new BackendLookGameBonusOfMemberDto();
	memberGameBonusDto.setMemberId(memberGameBonus.getMember().getId());
	memberGameBonusDto.setGameBonus(memberGameBonus.getBonus_point());
	allMemberGameBonusDto.add(memberGameBonusDto);
}	

return allMemberGameBonusDto;
}


//////////////瑋煊的腳//////////////////
	
	
	
	
	
	
	
	
}
