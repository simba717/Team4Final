package com.project.BonusPointExchangePlatform.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.BonusPointExchangePlatform.dao.BankDao;
import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.dao.PaymentDao;
import com.project.BonusPointExchangePlatform.dao.WalletDao;
import com.project.BonusPointExchangePlatform.dto.WalletDto;
import com.project.BonusPointExchangePlatform.model.Bank;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.model.Payment;
import com.project.BonusPointExchangePlatform.model.Wallet;

@Service
public class WalletService {
	
	@Autowired
	private WalletDao wDao;
	
	@Autowired
	private BankDao bDao;
	
	@Autowired
	private PaymentDao paymentDao;
	
	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

	public Optional<Bank> bankDetail(Integer id) {

		bDao.findById(id);
		System.out.println(bDao.findById(id));

		return bDao.findById(id);
	}

	public int allBonus(Integer id) {

		wDao.allBonus(id);
		System.out.println(wDao.allBonus(id));

		if (wDao.allBonus(id) != 0) {
			return wDao.allBonus(id);
		} else
			return 0;
	}

	public List<Wallet> findAllByDate(String date1, String date2) {
		List<Wallet> all = wDao.findAllByDate(date1, date2);

		return all;

	}

	public List<WalletDto> findAllBySourceType(int id) {

		List<WalletDto> dto = new ArrayList<>();
		List<Wallet> all = wDao.findAllById(id);
		if (all != null) {
			for (Wallet w : all) {
				WalletDto dto1 = new WalletDto();
				dto1.setName(w.getMember().getName());
				dto1.setWallet_amount(w.getWallet_amount());
				dto1.setBonus(w.getBonus_point());
				dto1.setCreate_at(DateTimeFormat.format(w.getCreate_at()));
				dto.add(dto1);
			}
			return dto;

		} else
			return null;

	}

	public List<WalletDto> changeBankAccount(int id, int bank_amount, int wallet_amount, int bonus) {

		int amount = bDao.checkAmount(id);
		System.out.println(amount);

		int id2 = id;

		System.out.println(id2);

		int afteramount = (amount - bank_amount);

		System.out.println(afteramount);

		System.out.println(id);

		bDao.changeAmount(id, afteramount);

		System.out.println(bonus);
		bDao.insertNewChange(id, id2, wallet_amount, bonus);

		List<Wallet> all = wDao.findAllById(id);

		List<WalletDto> dto = new ArrayList<>();

		if (all != null) {
			for (Wallet w : all) {
				WalletDto dto1 = new WalletDto();
				dto1.setName(w.getMember().getName());
				dto1.setWallet_amount(w.getWallet_amount());
				dto1.setBonus(w.getBonus_point());
				dto1.setCreate_at(DateTimeFormat.format(w.getCreate_at()));
				dto.add(dto1);
			}
			return dto;

		} else
			return null;

	}

	public List<WalletDto> findAllBonusById(int id, String orderby, String selected) {

		List<Wallet> type;
		String value;
		if (selected == null) {
			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(123);
				type = wDao.findAllBonusByIdOrderByAsc(id);
			} else {
				System.out.println(456);
				type = wDao.findAllBonusByIdOrderByDesc(id);
			}
		} else if (selected.equals("儲值金兌換")) {
			value = "兌換";
			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(123);
				type = wDao.findAllBonusByIdOrderByAsc1(id, value);
			} else {
				System.out.println(456);
				type = wDao.findAllBonusByIdOrderByDesc1(id, value);
			}
		} else if (selected.equals("活動獎勵")) {
			value = "活動獎勵";
			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(123);
				type = wDao.findAllBonusByIdOrderByAsc1(id, value);
			} else {
				System.out.println(456);
				type = wDao.findAllBonusByIdOrderByDesc1(id, value);
			}
		} else if (selected.equals("信用卡回饋")) {
			value = "回饋";
			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(123);
				type = wDao.findAllBonusByIdOrderByAsc1(id, value);
			} else {
				System.out.println(456);
				type = wDao.findAllBonusByIdOrderByDesc1(id, value);
			}
		} else {
			value = "交易";

			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(123);
				type = wDao.findAllBonusByIdOrderByAsc1(id, value);
			} else {
				System.out.println(456);
				type = wDao.findAllBonusByIdOrderByDesc1(id, value);
			}
		}

		List<WalletDto> WalletDto = new ArrayList<WalletDto>();
		if (type != null) {
			for (Wallet X : type) {
				WalletDto wallet = new WalletDto();
				wallet.setWallet(X);
				if (X.getCredit_card_amount() != null) {
					wallet.setUsecardamount(X.getCredit_card_amount());
				} else {
					wallet.setUsecardamount(0);
				}
				wallet.setCreate_at(DateTimeFormat.format(X.getCreate_at()));
				wallet.setName(X.getMember().getName());
				if (X.getGame() != null) {
					wallet.setGameName(X.getGame().getGame_type());
				} else {
					wallet.setGameName("無相關紀錄");
				}
				WalletDto.add(wallet);
			}

			return WalletDto;

		} else
			return null;

	}

	public List<WalletDto> findAllBonusByDate(int id, String orderby, String selected, String date1, String date2) {

		List<Wallet> type;
		String value;
		if (selected == null) {
			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(123);
				type = wDao.findAllBonusByIdOrderByAsc3(id, date1,date2);
			} else {
				System.out.println(456);
				type = wDao.findAllBonusByIdOrderByDesc3(id, date1,date2);
			}
		} else if (selected.equals("儲值金兌換")) {
			value = "兌換";
			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(000);
				type = wDao.findAllBonusByIdOrderByAsc4(id, value,  date1,date2);
			} else {
				System.out.println(999);
				type = wDao.findAllBonusByIdOrderByDesc4(id, value,  date1,date2);
			}
		} else if (selected.equals("活動獎勵")) {
			value = "活動獎勵";
			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(123);
				type = wDao.findAllBonusByIdOrderByAsc4(id, value,  date1,date2);
			} else {
				System.out.println(456);
				type = wDao.findAllBonusByIdOrderByDesc4(id, value,  date1,date2);
			}
		} else if (selected.equals("信用卡回饋")) {
			value = "回饋";
			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(123);
				type = wDao.findAllBonusByIdOrderByAsc4(id, value, date1,date2);
			} else {
				System.out.println(456);
				type = wDao.findAllBonusByIdOrderByDesc4(id, value,  date1,date2);
			}
		} else {
			value = "交易";

			if (orderby != null && orderby.equals("ASC")) {
				System.out.println(123);
				type = wDao.findAllBonusByIdOrderByAsc4(id, value,  date1,date2);
			} else {
				System.out.println(456);
				type = wDao.findAllBonusByIdOrderByDesc4(id, value,  date1,date2);
			}
		}

		List<WalletDto> WalletDto = new ArrayList<WalletDto>();
		if (type != null) {
			for (Wallet X : type) {
				WalletDto wallet = new WalletDto();
				wallet.setWallet(X);
				if (X.getCredit_card_amount() != null) {
					wallet.setUsecardamount(X.getCredit_card_amount());
				} else {
					wallet.setUsecardamount(0);
				}
				wallet.setCreate_at(DateTimeFormat.format(X.getCreate_at()));
				wallet.setName(X.getMember().getName());
				if (X.getGame() != null) {
					wallet.setGameName(X.getGame().getGame_type());
				} else {
					wallet.setGameName("無相關紀錄");
				}
				WalletDto.add(wallet);
			}

			return WalletDto;

		} else
			return null;

	}
	
	
	
	//顯浩
	public List<Wallet> findMemberWalletAmount(Member member){
		return wDao.findMemberWalletAmount(member);
	}
	
	public List<Wallet> findMemberBonusAmount(Member member){
		return wDao.findMemberBonusAmount(member);
	}
	
	//才蔚
	/*建立訂單支付*/
	public void insertWalletByBonus(Member member, Orders orders, Integer bonus_point) {
		Date getDate = new Date();		
		Wallet w = new Wallet();
		w.setSource_type("交易");
		w.setMember(member);
		w.setGame(null);
		w.setCreate_at(getDate);
		w.setBonus_point(-bonus_point);
		w.setCredit_card_amount(0);
		w.setBank(null);
		w.setWallet_amount(0);
		wDao.save(w);
	}
	
	public void insertByCreditCardAndWallet(Member member, Orders orders, Bank bank, Integer credit_card_amount, Integer wallet_amount) {
		Date getDate = new Date();		
		Wallet w = new Wallet();
		w.setSource_type("交易");
		w.setMember(member);
		w.setGame(null);
		w.setCreate_at(getDate);
		w.setBonus_point(0);
		if(bank != null) {			
			w.setCredit_card_amount(-credit_card_amount);
			w.setBank(bank);
			w.setWallet_amount(0);
		} else {
			w.setCredit_card_amount(0);
			w.setBank(null);
			w.setWallet_amount(-wallet_amount);
		}
		wDao.save(w);	
	}
	
	public void insertWalletByFeedback(Member member, Bank bank, Integer credit_card_amount, Integer wallet_amount) {
		Date getDate = new Date();
		Wallet feedbackw = new Wallet();
		
		if(credit_card_amount != 0 && wallet_amount == 0) {
			int checkWallet = (int)Math.floor(credit_card_amount/3000);
			if(checkWallet > 0) {
				feedbackw.setSource_type("回饋");
				feedbackw.setBonus_point(checkWallet * 30000);
				feedbackw.setBank(bank);
				feedbackw.setCreate_at(getDate);
				feedbackw.setCredit_card_amount(-credit_card_amount);
				feedbackw.setGame(null);
				feedbackw.setMember(member);
				feedbackw.setPayment(null);
				feedbackw.setWallet_amount(0);
				wDao.save(feedbackw);
			}
		} else {
			int checkWallet = (int)Math.floor(wallet_amount/3000);
			if(checkWallet > 0) {
				feedbackw.setSource_type("回饋");
				feedbackw.setBonus_point(checkWallet * 60000);
				feedbackw.setBank(null);
				feedbackw.setCreate_at(getDate);
				feedbackw.setCredit_card_amount(0);
				feedbackw.setGame(null);
				feedbackw.setMember(member);
				feedbackw.setPayment(null);
				feedbackw.setWallet_amount(-wallet_amount);
				wDao.save(feedbackw);
			}
		}				
	}
	
//	public void insertWallet(Member member, Orders orders, Integer bonus_point, Integer wallet_amount, Integer credit_card_amount) {
//		Date getDate = new Date();		
//		Wallet w;
//		Payment p;
//		Wallet feedbackw = new Wallet();
//		/*紅利&儲值金*/
//		if(bonus_point != 0 && wallet_amount != 0 && credit_card_amount == 0) {			
//			/*紅利交易*/
//			w = new Wallet();
//			w.setSource_type("交易");
//			w.setMember(member);
//			w.setGame(null);
//			w.setCreate_at(getDate);
//			w.setBonus_point(-bonus_point);
//			w.setCredit_card_amount(0);
//			w.setBank(null);
//			w.setWallet_amount(0);
//			wDao.save(w);			
//			p = new Payment();
//			p.setCreate_at(getDate);
//			p.setOrders(orders);
//			p.setPayment("紅利點數");
//			p.setWallet(wDao.findBySourceTypeAndMember(member, w.getSource_type()));
//			paymentDao.save(p);
//			
//			/*儲值金交易*/
//			w = new Wallet();
//			w.setSource_type("交易");
//			w.setMember(member);
//			w.setGame(null);
//			w.setCreate_at(getDate);
//			w.setBonus_point(0);
//			w.setCredit_card_amount(0);
//			w.setBank(null);
//			w.setWallet_amount(-wallet_amount);
//			wDao.save(w);
//			p = new Payment();
//			p.setCreate_at(getDate);
//			p.setOrders(orders);
//			p.setPayment("儲值金");
//			p.setWallet(wDao.findBySourceTypeAndMember(member, w.getSource_type()));
//			paymentDao.save(p);
//			
//			/*儲值金回饋*/
//			int checkWallet = (int)Math.floor(wallet_amount/3000);
//			if(checkWallet > 0) {
//				feedbackw.setSource_type("回饋");
//				feedbackw.setBonus_point(checkWallet * 60000);
//				feedbackw.setBank(null);
//				feedbackw.setCreate_at(getDate);
//				feedbackw.setCredit_card_amount(0);
//				feedbackw.setGame(null);
//				feedbackw.setMember(member);
//				feedbackw.setPayment(null);
//				feedbackw.setWallet_amount(wallet_amount);
//				wDao.save(feedbackw);
//			}
//			
//		/*紅利&信用卡*/
//		} else if(bonus_point != 0 && wallet_amount == 0 && credit_card_amount != 0) {
//			/*紅利交易*/
//			w = new Wallet();
//			w.setSource_type("交易");
//			w.setMember(member);
//			w.setGame(null);
//			w.setCreate_at(getDate);
//			w.setBonus_point(-bonus_point);
//			w.setCredit_card_amount(0);
//			w.setBank(null);
//			w.setWallet_amount(0);
//			wDao.save(w);			
//			p = new Payment();
//			p.setCreate_at(getDate);
//			p.setOrders(orders);
//			p.setPayment("紅利點數");
//			p.setWallet(wDao.findBySourceTypeAndMember(member, w.getSource_type()));
//			paymentDao.save(p);
//			
//			/*信用卡交易*/
//			w = new Wallet();
//			w.setSource_type("交易");
//			w.setMember(member);
//			w.setGame(null);
//			w.setCreate_at(getDate);
//			w.setBonus_point(0);
//			w.setCredit_card_amount(-credit_card_amount);
//			w.setBank(null);
//			w.setWallet_amount(0);
//			wDao.save(w);
//			p = new Payment();
//			p.setCreate_at(getDate);
//			p.setOrders(orders);
//			p.setPayment("信用卡");
//			p.setWallet(wDao.findBySourceTypeAndMember(member, w.getSource_type()));
//			paymentDao.save(p);
//			
//			/*信用卡回饋*/
//			int checkCredit = (int)Math.floor(credit_card_amount/3000);
//			if(checkCredit > 0) {
//				feedbackw.setSource_type("回饋");
//				feedbackw.setBonus_point(checkCredit * 30000);
//				feedbackw.setBank(member.getBank());
//				feedbackw.setCreate_at(getDate);
//				feedbackw.setCredit_card_amount(credit_card_amount);
//				feedbackw.setGame(null);
//				feedbackw.setMember(member);
//				feedbackw.setPayment(null);
//				feedbackw.setWallet_amount(0);
//				wDao.save(feedbackw);
//			}
//			
//		/*紅利*/
//		} else if(bonus_point != 0 && wallet_amount == 0 && credit_card_amount == 0) {
//			/*紅利交易*/
//			w = new Wallet();
//			w.setSource_type("交易");
//			w.setMember(member);
//			w.setGame(null);
//			w.setCreate_at(getDate);
//			w.setBonus_point(-bonus_point);
//			w.setCredit_card_amount(0);
//			w.setBank(null);
//			w.setWallet_amount(0);
//			wDao.save(w);			
//			p = new Payment();
//			p.setCreate_at(getDate);
//			p.setOrders(orders);
//			p.setPayment("紅利點數");
//			p.setWallet(wDao.findBySourceTypeAndMember(member, w.getSource_type()));
//			paymentDao.save(p);
//			
//		/*儲值金*/
//		} else if(bonus_point == 0 && wallet_amount != 0 && credit_card_amount == 0) {
//			/*儲值金交易*/
//			w = new Wallet();
//			w.setSource_type("交易");
//			w.setMember(member);
//			w.setGame(null);
//			w.setCreate_at(getDate);
//			w.setBonus_point(0);
//			w.setCredit_card_amount(0);
//			w.setBank(null);
//			w.setWallet_amount(-wallet_amount);
//			wDao.save(w);
//			p = new Payment();
//			p.setCreate_at(getDate);
//			p.setOrders(orders);
//			p.setPayment("儲值金");
//			p.setWallet(wDao.findBySourceTypeAndMember(member, w.getSource_type()));
//			paymentDao.save(p);
//			
//			/*儲值金回饋*/
//			int checkWallet = (int)Math.floor(wallet_amount/3000);
//			if(checkWallet > 0) {
//				feedbackw.setSource_type("回饋");
//				feedbackw.setBonus_point(checkWallet * 60000);
//				feedbackw.setBank(null);
//				feedbackw.setCreate_at(getDate);
//				feedbackw.setCredit_card_amount(0);
//				feedbackw.setGame(null);
//				feedbackw.setMember(member);
//				feedbackw.setPayment(null);
//				feedbackw.setWallet_amount(wallet_amount);
//				wDao.save(feedbackw);
//			}
//			
//		/*信用卡*/	
//		} else if(bonus_point == 0 && wallet_amount == 0 && credit_card_amount != 0) {
//			/*信用卡交易*/
//			w = new Wallet();
//			w.setSource_type("交易");
//			w.setMember(member);
//			w.setGame(null);
//			w.setCreate_at(getDate);
//			w.setBonus_point(0);
//			w.setCredit_card_amount(-credit_card_amount);
//			w.setBank(null);
//			w.setWallet_amount(0);
//			wDao.save(w);
//			p = new Payment();
//			p.setCreate_at(getDate);
//			p.setOrders(orders);
//			p.setPayment("信用卡");
//			p.setWallet(wDao.findBySourceTypeAndMember(member, w.getSource_type()));
//			paymentDao.save(p);
//			
//			/*信用卡回饋*/
//			int checkCredit = (int)Math.floor(credit_card_amount/3000);
//			if(checkCredit > 0) {
//				feedbackw.setSource_type("回饋");
//				feedbackw.setBonus_point(checkCredit * 30000);
//				feedbackw.setBank(member.getBank());
//				feedbackw.setCreate_at(getDate);
//				feedbackw.setCredit_card_amount(credit_card_amount);
//				feedbackw.setGame(null);
//				feedbackw.setMember(member);
//				feedbackw.setPayment(null);
//				feedbackw.setWallet_amount(0);
//				wDao.save(feedbackw);
//			}
//		} else {
//			System.out.println("ERROR");
//		}
//	}	
	
	
	
	
}
