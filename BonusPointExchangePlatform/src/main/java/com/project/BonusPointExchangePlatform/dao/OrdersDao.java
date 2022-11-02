package com.project.BonusPointExchangePlatform.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Orders;

@Repository
public interface OrdersDao extends JpaRepository<Orders, Integer> {
	
	@Query(value = "select * from orders where order_status = '訂單完成' order by update_at desc", nativeQuery = true)
	List<Orders> findAllOrders();
	
	@Query(value = "select * from orders where member_id = :member_id and order_status = '訂單完成' order by update_at desc", nativeQuery = true)
	List<Orders> findAllOrdersByMember(@Param(value = "member_id") Member member_id);
	
	@Query(value = "select * from orders where member_id = :member_id and order_status = '待結帳'", nativeQuery = true)
	Orders findUnPaidOrdersByMember(@Param(value = "member_id") Member member_id);
	
	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update orders set sub_total = :sub_total, update_at = getdate() "
			+ "where member_id = :member_id and order_status = '待結帳'", nativeQuery = true)
	void updateOrdersTotal(			
			@Param(value = "member_id") Member member_id,
			@Param(value = "sub_total") Integer sub_total);
	
	@Query(value = "select * from orders "
			+ "where CONVERT(VARCHAR(8), update_at, 112)+replace(CONVERT(varchar(9), update_at, 114),':','') like :input "
			+ "and order_status = '訂單完成' order by update_at desc ", nativeQuery = true)
	List<Orders> searchByOrder(@Param(value = "input") String input);
	
	@Query(value = "select * from orders "
			+ "where CONVERT(VARCHAR(8), update_at, 112)+replace(CONVERT(varchar(9), update_at, 114),':','') like :input "
			+ "and order_status = '訂單完成' and member_id = :member_id order by update_at desc ", nativeQuery = true)
	List<Orders> memberSearchByOrder(
			@Param(value = "member_id") Member member_id,
			@Param(value = "input") String input);
	
	@Transactional
	@Modifying
	@Query(value = "update orders set order_status = '訂單完成', update_at = getdate() "
			+ "where order_status = '待結帳' and member_id = :member_id ", nativeQuery = true)
	void updateOrderStatus(@Param(value = "member_id") Member member_id);
	
}
