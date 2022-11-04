package com.project.BonusPointExchangePlatform.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.dao.PaymentDao;
import com.project.BonusPointExchangePlatform.dto.OrdersDto;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.model.Payment;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	
	/*查詢訂單支付(員工)*/
	public List<OrdersDto> findPayment(){
		List<Payment> payment = paymentDao.findAllPayment();
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Payment p : payment) {
			OrdersDto dto = new OrdersDto(p);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*查詢訂單支付(會員)*/
	public List<OrdersDto> findPaymentByMember(Member member){
		Optional<Member> optional = memberDao.findById(member.getId());
		List<Payment> payment = paymentDao.findAllPaymentByMember(optional.get());
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Payment p : payment) {
			OrdersDto dto = new OrdersDto(p);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	
	/*員工查詢訂單編號*/
	public List<OrdersDto> searchByOrder(String search){
		List<Payment> payment = paymentDao.searchByOrder("%" + search + "%");
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Payment p : payment) {
			OrdersDto dto = new OrdersDto(p);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*會員查詢訂單編號*/
	public List<OrdersDto> memberSearchByOrder(Member member, String search){
		List<Payment> payment = paymentDao.memberSearchByOrder(member, "%" + search + "%");
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Payment p : payment) {
			OrdersDto dto = new OrdersDto(p);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*員工查詢會員訂單*/
	public List<OrdersDto> searchByMember(Member member){
		List<Payment> payment = paymentDao.searchByMember(member);
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Payment p : payment) {
			OrdersDto dto = new OrdersDto(p);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	/*建立訂單支付*/
	public void insertPayment(Member member, Orders orders, String payment) {
		paymentDao.insertPayment(member, orders, payment);
	}
	
}
