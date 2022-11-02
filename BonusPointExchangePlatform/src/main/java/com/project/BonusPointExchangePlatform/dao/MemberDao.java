package com.project.BonusPointExchangePlatform.dao;

import java.time.LocalDate;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Member;

@Repository
public interface MemberDao extends JpaRepository<Member, Integer>{

	@Query(value ="select a.*  from Member m "
			+ "join account a on m.id = a.member_id "
			+ "where a.id= :id " , nativeQuery = true)
	Account showMemberById(@Param(value="id") Integer id);	
	
	@Modifying
	@Transactional
	@Query(value="update Member set name = :name, birth= :birth , email= :email, phone=:phone , update_at = getdate(),image=:image where id = :id ",nativeQuery = true)
	void editMemberDetail(@Param(value="name")String name, @Param(value="birth")LocalDate birth,@Param(value="email")String email,@Param(value="phone")String phone,@Param(value="image")byte[] image,@Param(value="id")Integer id );
	
	@Query(value ="select m.* from Member m "
			+ "join Bank b on m.bank_id = b.id "
			+ "where m.bank_id= :id " , nativeQuery = true)
	Member showMemberBankById(@Param(value="id") Integer id); 
	
	@Modifying
	@Transactional
	@Query(value="update Member set name = :name, birth= :birth , email= :email, phone=:phone , update_at = getdate(),image=:image where id = :id ",nativeQuery = true)
	void editBacknedMemberDetail(@Param(value="name")String name, @Param(value="birth")LocalDate birth,@Param(value="email")String email,@Param(value="phone")String phone,@Param(value="image")byte[] image2,@Param(value="id")Integer id);
	
	@Query(value="select * from Member where id = :id ",nativeQuery = true)
	Member findOnebyId(@Param(value="id")int id);
	
	/*根據email找memberid*/
	@Query(value = "select * from member m "
			+ "where m.email = :email", nativeQuery = true)
	Member findIdByEmail(@Param(value = "email") String email);
	
	@Query(value = "select * from member where name like :name", nativeQuery = true)
	List<Member> findByName(@Param(value = "name") String name);
	
	@Query(value = "select * from Member "
			+ "where bank_id= :bank_id", nativeQuery = true)
	Member checkReapeatByBankId(@Param(value = "bank_id") Integer bank_id);
}
