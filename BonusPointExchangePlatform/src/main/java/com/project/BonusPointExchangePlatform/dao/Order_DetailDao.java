package com.project.BonusPointExchangePlatform.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Orders;

@Repository
public interface Order_DetailDao extends JpaRepository<Order_Detail, Integer> {
	
	@Query(value = "select d.* from orders o "
			+ "join order_detail d on d.orders_id = o.id ", nativeQuery = true)
	List<Order_Detail> findAllOrder_Detail();
	
	@Query(value = "select d.* from orders o "
			+ "join order_detail d on d.orders_id = o.id "
			+ "where o.member_id = :member_id ", nativeQuery = true)
	List<Order_Detail> findAllOrder_DetailByMember(@Param(value = "member_id") Member member_id);
	
	@Query(value = "select d.* from orders o "
			+ "join order_detail d on d.orders_id = o.id "
			+ "where o.member_id = :member_id and o.order_status = '待結帳' order by d.id", nativeQuery = true)
	List<Order_Detail> findAllUnPaidOrder_DetailByMember(@Param(value = "member_id") Member member_id);
	
	@Transactional
	@Modifying
	@Query(value = "update order_detail set quantity = :quantity, total = :total, update_at = getdate() "
			+ "where product_name = :product_name ", nativeQuery = true)
	void updateOrderDetail(			
			@Param(value = "quantity") Integer quantity,
			@Param(value = "total") Integer total,
			@Param(value = "product_name") String product_name);
	
	@Query(value = "select d.* from orders o "
			+ "join order_detail d on d.orders_id = o.id "
			+ "where CONVERT(VARCHAR(8), o.update_at, 112)+replace(CONVERT(varchar(9), o.update_at, 114),':','') like :input "
			+ "and o.order_status = '訂單完成' order by o.update_at desc ", nativeQuery = true)
	List<Order_Detail> searchByOrder(@Param(value = "input") String input);
	
	@Query(value = "select d.* from orders o "
			+ "join order_detail d on d.orders_id = o.id "
			+ "where CONVERT(VARCHAR(8), o.update_at, 112)+replace(CONVERT(varchar(9), o.update_at, 114),':','') like :input "
			+ "and o.order_status = '訂單完成' and o.member_id = :member_id order by o.update_at desc ", nativeQuery = true)
	List<Order_Detail> memberSearchByOrder(
			@Param(value = "member_id") Member member_id, 
			@Param(value = "input") String input);
	
	@Query(value = "select d.* from orders o "
			+ "join order_detail d on d.orders_id = o.id "
			+ "where o.member_id = :member_id and o.order_status = '訂單完成' order by o.update_at desc ", nativeQuery = true)
	List<Order_Detail> searchByMember(@Param(value = "member_id") Member member_id);

	//顯浩
	@Transactional
	@Modifying(clearAutomatically = true)//update清除暫存資料可以查詢更新後的資訊
	@Query(value = "update order_detail set quantity = :quantity, total = :total, update_at = getdate() "
			+ "where product_name = :product_name and orders_id = :orders_id ", nativeQuery = true)
	void updateOrderDetailByOrderId(	
			@Param(value = "orders_id") Orders orders,
			@Param(value = "quantity") Integer quantity,
			@Param(value = "total") Integer total,
			@Param(value = "product_name") String product_name);
	
	
	
	@Query(value = "select * from order_detail where orders_id = :orders_id ", nativeQuery = true)
	List<Order_Detail> findAllByOrderDetailId(@Param(value = "orders_id") Orders orders);

	@Query(value = "select * from order_detail where product_name = :product_name ", nativeQuery = true)
	List<Order_Detail> findAllByOrderDetailName(@Param(value = "product_name") String product_name);
	
	
	@Query(value = "select * from order_detail where orders_id = :orders_id and product_name = :product_name", nativeQuery = true)
	Order_Detail findOneByOrderDetailIdProductName(@Param(value = "orders_id") Orders orders ,@Param(value = "product_name") String product_name);
	
}
