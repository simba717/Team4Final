package com.project.BonusPointExchangePlatform.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;

@Repository
public interface GameDao extends JpaRepository<Game, Integer> {
	//HQL的:變數 要小心空白，不要跟雙引號黏在一起
	@Query(value = "select * from Member_Game mg "
			+ "join Member m on mg.member_id = m.id "
			+ "join Game g on mg.game_id = g.id "
			+ "where m.id = :id and g.game_type = :game_type "
			+"and convert(nvarchar,g.create_at,23) like :create_at ", nativeQuery = true)
	Game checkSignIn(@Param(value = "id") Integer id, @Param(value = "game_type") String game_type,@Param(value = "create_at") String create_at);
	
	@Query(value = "select * from Member_Game mg "
			+ "join Member m on mg.member_id = m.id "
			+ "join Game g on mg.game_id = g.id "
			+ "where m.id = :id and g.game_type = :game_type " , nativeQuery = true)
	List<Game> selectDate(@Param(value = "id") Integer id, @Param(value = "game_type") String game_type);
	
	@Modifying
	@Query(value = "insert into Game(game_type, check_status, game_score) "
			+ "values('簽到', 1, null) "
			+ "insert into Member_Game(member_id, game_id) "
			+ "values( :member_id, (select top 1.id from game where game_type='簽到' and update_at >:update_at "
			+ "order by update_at desc))" , nativeQuery = true)
	void insertLogin(@Param(value = "member_id") Member member_id,
			@Param(value = "update_at") Date update_at);
	
	
	@Query(value = "select * from Member_Game mg "
			+ "join Member m on mg.member_id = m.id "
			+ "join Game g on mg.game_id = g.id "
			+ "where m.id = :id and g.game_type = '生日禮' "
			+"and convert(nvarchar,g.create_at,23) like :create_at ", nativeQuery = true)
	Game checkBirthGift(@Param(value = "id") Integer id,@Param(value = "create_at") String create_at);
	
	@Modifying
	@Query(value = "insert into Game(game_type, check_status, game_score) "
			+ "values('生日禮', 1, null) "
			+ "insert into Member_Game(member_id, game_id) "
			+ "values( :member_id, (select top 1.id from game where game_type='生日禮' and update_at >:update_at "
			+ "order by update_at desc))" , nativeQuery = true)
	void insertBirth(@Param(value = "member_id") Member member_id,
			@Param(value = "update_at") Date update_at);

	
//////////////瑋煊的頭//////////////////
	
//前台會員查詢自已的遊戲紀錄:遊戲名稱 遊戲得分 遊戲時間 取得紅利
@Query(value = "select * from Member_Game mg "
	+ "	join Member m "
	+ "		on mg.member_id = m.id "
	+ "	join Game g "
	+ "		on mg.game_id = g.id "
	+ "	join Wallet w "
	+ "		on w.game_id = g.id "
	+ "where m.id = :id and g.game_type = '採集魔水晶' and g.game_score is not null", nativeQuery = true)
List<Game> findGameRecordsByMember(@Param(value = "id") Integer member_id);


//////////////瑋煊的腳/////////////////////



}
