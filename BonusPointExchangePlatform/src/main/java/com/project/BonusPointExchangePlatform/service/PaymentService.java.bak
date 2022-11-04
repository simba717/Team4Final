package com.project.BonusPointExchangePlatform.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.dao.PaymentDao;
import com.project.BonusPointExchangePlatform.dao.WalletDao;
import com.project.BonusPointExchangePlatform.dto.OrdersDto;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.model.Payment;
import com.project.BonusPointExchangePlatform.model.Wallet;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private WalletDao walletDao;
	
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
	
	/*建立訂單支付*/
	public void insertPayment(Member member, Orders orders, List<Payment> payment, List<Wallet> wallet) {
		Date getDate = new Date();
		
		for(int i = 0; i < payment.size(); i++) {
			Wallet w = new Wallet();
			Wallet feedbackw = new Wallet();
			w.setSource_type("交易");
			w.setMember(member);
			w.setGame(null);
			w.setCreate_at(getDate);
			
			switch(payment.get(i).getPayment()) {
			case "紅利點數":
				w.setBonus_point(-wallet.get(i).getBonus_point());
				w.setCredit_card_amount(0);
				w.setBank(null);
				w.setWallet_amount(0);
				break;
			case "信用卡":
				w.setCredit_card_amount(-wallet.get(i).getCredit_card_amount());
				w.setBank(member.getBank());
				w.setWallet_amount(0);
				w.setBonus_point(0);
				
				int checkCredit = (int)Math.floor(wallet.get(i).getCredit_card_amount()/3000);
				if(checkCredit > 0) {
					feedbackw.setSource_type("回饋");
					feedbackw.setBonus_point(checkCredit * 30000);
					feedbackw.setBank(member.getBank());
					feedbackw.setCreate_at(getDate);
					feedbackw.setCredit_card_amount(wallet.get(i).getCredit_card_amount());
					feedbackw.setGame(null);
					feedbackw.setMember(member);
					feedbackw.setPayment(null);
					feedbackw.setWallet_amount(0);
				}				
				break;
			case "儲值金":
				w.setWallet_amount(-wallet.get(i).getWallet_amount());
				w.setBonus_point(0);
				w.setCredit_card_amount(0);
				w.setBank(null);
				
				int checkWallet = (int)Math.floor(wallet.get(i).getWallet_amount()/3000);
				if(checkWallet > 0) {
					feedbackw.setSource_type("回饋");
					feedbackw.setBonus_point(checkWallet * 60000);
					feedbackw.setBank(null);
					feedbackw.setCreate_at(getDate);
					feedbackw.setCredit_card_amount(0);
					feedbackw.setGame(null);
					feedbackw.setMember(member);
					feedbackw.setPayment(null);
					feedbackw.setWallet_amount(wallet.get(i).getWallet_amount());
				}
				break;		
			}	
			walletDao.save(w);
			Wallet indexWallet = walletDao.findBySourceTypeAndMember(member, w.getSource_type());
			
			Payment p = new Payment();
			p.setCreate_at(getDate);
			p.setOrders(orders);
			p.setPayment(payment.get(i).getPayment());
			p.setWallet(indexWallet);
			paymentDao.save(p);
			walletDao.save(feedbackw);			
		}		
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
	

}
