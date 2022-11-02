package com.project.BonusPointExchangePlatform.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Wallet;

@Repository
public interface WalletDao extends JpaRepository<Wallet, Integer> {
	
	//才蔚
	@Query(value = "select top 1* from Wallet "
			+ "where member_id = :member_id and source_type = :source_type "
			+ "order by create_at desc " , nativeQuery = true)
	Wallet findBySourceTypeAndMember(
			@Param(value = "member_id") Member member,
			@Param(value = "source_type") String source_type);
	
	//庭偉
	@Query(value = "select sum(bonus_point) from Wallet where member_id =:id" , nativeQuery = true)
	Integer allBonus(@Param(value="id")Integer id); 
	
	@Query(value = "select * from Wallet where create_at between :date1 and :date2 ",nativeQuery = true)
	List<Wallet> findAllByDate(@Param(value="date1") String date1 , @Param(value="date2") String date2);
	
	
	@Query(value = "select * from Wallet \r\n"
			+ "  where member_id=:id and source_type in('兌換') \r\n"
			+ "  order by create_at desc offset :offsetpage rows fetch next 5 rows only",nativeQuery = true)
	List<Wallet> findAllBySourceType(@Param(value="id") int id,@Param(value="offsetpage") int offsetpage);
	
	@Query(value = "select * from Wallet where member_id=:id order by create_at desc",nativeQuery = true)
	List<Wallet> findAllById(@Param(value="id") int id);
	
	@Query(value = "select * from Wallet where member_id=:id order by create_at Desc",nativeQuery = true)
	List<Wallet> findAllBonusByIdOrderByDesc(@Param(value="id") int id);
	
	@Query(value = "select * from Wallet where member_id=:id order by create_at Asc",nativeQuery = true)
	List<Wallet> findAllBonusByIdOrderByAsc(@Param(value="id") int id);
	
	@Query(value = "select * from Wallet where member_id=:id and source_type in(:value) order by create_at Desc",nativeQuery = true)
	List<Wallet> findAllBonusByIdOrderByDesc1(@Param(value="id") int id,@Param(value="value") String value );
	
	@Query(value = "select * from Wallet where member_id=:id and source_type in(:value) order by create_at Asc",nativeQuery = true)
	List<Wallet> findAllBonusByIdOrderByAsc1(@Param(value="id") int id,@Param(value="value") String value );
	
	@Query(value = "select * from Wallet where member_id=:id and create_at between :date1 and :date2 order by create_at Desc",nativeQuery = true)
	List<Wallet> findAllBonusByIdOrderByDesc3(@Param(value="id") int id , @Param(value="date1") String date1 , @Param(value="date2") String date2);
	
	@Query(value = "select * from Wallet where member_id=:id and create_at between :date1 and :date2 order by create_at Asc",nativeQuery = true)
	List<Wallet> findAllBonusByIdOrderByAsc3(@Param(value="id") int id , @Param(value="date1") String date1 , @Param(value="date2") String date2);
	
	@Query(value = "select * from Wallet where member_id=:id and source_type in(:value) and create_at between :date1 and :date2 order by create_at Desc",nativeQuery = true)
	List<Wallet> findAllBonusByIdOrderByDesc4(@Param(value="id") int id,@Param(value="value") String value , @Param(value="date1") String date1 , @Param(value="date2") String date2);
	
	@Query(value = "select * from Wallet where member_id=:id and source_type in(:value) and create_at between :date1 and :date2 order by create_at Asc",nativeQuery = true)
	List<Wallet> findAllBonusByIdOrderByAsc4(@Param(value="id") int id,@Param(value="value") String value , @Param(value="date1") String date1 , @Param(value="date2") String date2 );
	
	
	
	
	//顯浩
	@Query(value = "select * from Wallet where member_id=:member_id and source_type!='回饋' ",nativeQuery = true)
	List<Wallet> findMemberWalletAmount(@Param(value="member_id") Member member_id);
	
	@Query(value = "select * from Wallet where member_id=:member_id and source_type!='回饋' ",nativeQuery = true)
	List<Wallet> findMemberBonusAmount(@Param(value="member_id") Member member_id);
}
