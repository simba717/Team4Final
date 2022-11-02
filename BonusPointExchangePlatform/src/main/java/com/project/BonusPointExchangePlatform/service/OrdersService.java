package com.project.BonusPointExchangePlatform.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.BonusPointExchangePlatform.dao.OrdersDao;
import com.project.BonusPointExchangePlatform.dto.OrdersDto;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Orders;

@Service
public class OrdersService {
	
	@Autowired
	private OrdersDao ordersDao;
	
	/*查詢訂單(員工)*/
	public List<OrdersDto> findAllOrders(){
		List<Orders> orders = ordersDao.findAllOrders();
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Orders o : orders) {
			OrdersDto dto = new OrdersDto(o);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*查詢訂單(會員)*/
	public List<OrdersDto> findAllOrdersByMember(Member member){
		List<Orders> orders = ordersDao.findAllOrdersByMember(member);
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Orders o : orders) {
			OrdersDto dto = new OrdersDto(o);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*建立購物車訂單*/
	public void insertOrder(Member member) {
		Date getDate = new Date();
		Orders orders = new Orders();
		orders.setMember(member);
		orders.setOrder_status("待結帳");
		orders.setSub_total(0);
		orders.setCreate_at(getDate);
		orders.setUpdate_at(getDate);
		ordersDao.save(orders);
	}
	
	/*查詢待結帳訂單*/
	public Orders findUnPaidOrdersByMember(Member member) {
		return ordersDao.findUnPaidOrdersByMember(member);
	}

	/*員工查詢訂單號碼*/
	public List<OrdersDto> searchByOrder(String search){
		List<Orders> orders = ordersDao.searchByOrder("%" + search + "%");
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Orders o : orders) {
			OrdersDto dto = new OrdersDto(o);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*會員查詢訂單號碼*/
	public List<OrdersDto> memberSearchByOrder(Member member, String search){
		List<Orders> orders = ordersDao.memberSearchByOrder(member, "%" + search + "%");
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Orders o : orders) {
			OrdersDto dto = new OrdersDto(o);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*員工查詢會員訂單*/
	public List<OrdersDto> searchByMember(Member member){
		List<Orders> orders = ordersDao.findAllOrdersByMember(member);
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Orders o : orders) {
			OrdersDto dto = new OrdersDto(o);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*更新訂單狀態*/
	public void updateOrderStatus(Member member){
		ordersDao.updateOrderStatus(member);		
	}
	
	//顯浩
	public void updateOrdersTotal(Member member_id,Integer sub_total) {
		ordersDao.updateOrdersTotal(member_id, sub_total);
	}
}
