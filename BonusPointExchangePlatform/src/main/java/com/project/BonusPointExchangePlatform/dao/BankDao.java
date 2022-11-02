package com.project.BonusPointExchangePlatform.dao;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Bank;

@Repository
public interface BankDao extends JpaRepository<Bank, Integer> {
		
	@Query(value = "select amount from bank where id=:id",nativeQuery = true)
	int checkAmount(@Param(value="id")int id);
	
	
	@Modifying
	@Transactional
	@Query(value = "update Bank set amount= :afteramount,update_at=getdate() where id =:id ",nativeQuery = true)
	void changeAmount(@Param(value="id")int id,@Param(value="afteramount") int afteramount);

	@Modifying
	@Transactional
	@Query(value = "insert into wallet(source_type,wallet_amount,bonus_point,credit_card_amount,member_id,bank_id,game_id,create_at)\r\n"
			+ "values('兌換',:wallet_amount,:bonus,0,:id,:id2,null,getdate())",nativeQuery = true)
	void insertNewChange(@Param(value="id") int id,@Param(value="id2") int id2,@Param(value="wallet_amount") int wallet_amount,@Param(value="bonus") int bonus);
	

	@Query(value="select * from bank "
			+"where account_no =:account_no",nativeQuery = true)
	Bank findIdByAccountNo(@Param(value = "account_no")String account_no);

	@Query(value="select * from bank "
			+"where account_no =:account_no",nativeQuery = true)
	Bank checkRepeatByAccountNo(@Param(value = "account_no")String account_no);
}
