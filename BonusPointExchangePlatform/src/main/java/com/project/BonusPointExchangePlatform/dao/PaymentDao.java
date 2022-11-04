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
import com.project.BonusPointExchangePlatform.model.Payment;

@Repository
public interface PaymentDao extends JpaRepository<Payment, Integer> {
	
	@Query(value = "select p.* from orders o "
			+ "join payment p on p.orders_id = o.id ", nativeQuery = true)
	List<Payment> findAllPayment();
	
	@Query(value = "select p.* from orders o "
			+ "join payment p on p.orders_id = o.id "
			+ "where o.member_id = :member_id ", nativeQuery = true)
	List<Payment> findAllPaymentByMember(@Param(value = "member_id") Member member_id);

	@Query(value = "select p.* from orders o "
			+ "join payment p on p.orders_id = o.id "
			+ "where CONVERT(VARCHAR(8), o.update_at, 112)+replace(CONVERT(varchar(9), o.update_at, 114),':','') like :input "
			+ "and o.order_status = '訂單完成' order by o.update_at desc ", nativeQuery = true)
	List<Payment> searchByOrder(@Param(value = "input") String input);
	
	@Query(value = "select p.* from orders o "
			+ "join payment p on p.orders_id = o.id "
			+ "where CONVERT(VARCHAR(8), o.update_at, 112)+replace(CONVERT(varchar(9), o.update_at, 114),':','') like :input "
			+ "and o.order_status = '訂單完成' and o.member_id = :member_id order by o.update_at desc ", nativeQuery = true)
	List<Payment> memberSearchByOrder(
			@Param(value = "member_id") Member member_id, 
			@Param(value = "input") String input);
	
	@Query(value = "select p.* from orders o "
			+ "join payment p on p.orders_id = o.id "
			+ "where o.member_id = :member_id and o.order_status = '訂單完成' order by o.update_at desc ", nativeQuery = true)
	List<Payment> searchByMember(@Param(value = "member_id") Member member_id);
	
	//才蔚
	@Transactional
	@Modifying
	@Query(value = "insert into payment(payment, orders_id, wallet_id) "
			+ "values(:payment, :orders_id, (select top 1.id from Wallet "
			+ "where member_id = :member_id and source_type = '交易' "
			+ "order by create_at desc))" , nativeQuery = true)
	void insertPayment(
			@Param(value = "member_id") Member member,
			@Param(value = "orders_id") Orders orders,
			@Param(value = "payment") String payment);
		
}
