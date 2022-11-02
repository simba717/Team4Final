package com.project.BonusPointExchangePlatform.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.dao.BankDao;
import com.project.BonusPointExchangePlatform.dao.WalletDao;
import com.project.BonusPointExchangePlatform.dto.MemberDto;
import com.project.BonusPointExchangePlatform.dto.WalletDto;
import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Bank;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Wallet;
import com.project.BonusPointExchangePlatform.service.MemberService;
import com.project.BonusPointExchangePlatform.service.WalletService;

@Controller
public class WalletController {
	
	@Autowired
	private WalletService wService; 
		
	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	@GetMapping("/MembergoBankAccount")
	public String newBankPage(HttpSession session) {
		
	Member member = (Member)session.getAttribute("member");
		
		if( member == null) {
			return "/frontend/entrance/login";
		}
		return "frontend/member/MemberBankAccount";
	}
	
	
	@ResponseBody
	@PostMapping(value="/frontend/wallet",produces = {"application/json;charset=UTF-8"})
	public WalletDto allBonus(@RequestBody WalletDto dto) {
		int id = dto.getAccount().getId();
		System.out.println(123);
		WalletDto all = new WalletDto();
		int allBonus = wService.allBonus(id);		
		if(allBonus>0) {
			all.setBonusTotal(allBonus);
		}else {
			all.setMessage("目前尚未擁有紅利點數");
		}
		return all;
		
	}
	
	@ResponseBody
	@PostMapping(value="/frontend/wallet1" , produces = {"application/json;charset=UTF-8"})
	public List<Wallet> showDate(@RequestParam(value="date1") String date1 ,
											@RequestParam(value="date2") String date2){ 
		
		System.out.println(date1);
		System.out.println(date2);
	
//		Map<String,String> map=new HashMap<String,String>();
//		
//		System.out.println(wService.findAllByDate(date1, date2));
//		map.put("wallet", wService.findAllByDate(date1, date2).toString());
		
		 List<Wallet> all=wService.findAllByDate(date1, date2);
		
		if(all!=null) {	

			return all;
		}else {
			return null;
		}
		
		
	}
	
	
	
	//*****查看銀行資訊*****
	@ResponseBody
	@PostMapping(value="/frontend/bank",produces = {"application/json;charset=UTF-8"})
	public Optional<Bank> bankDetail(@RequestBody WalletDto dto) {
		int id = dto.getAccount().getId();
		System.out.println(id);
		
		Optional<Bank> bankDetail = wService.bankDetail(id);
			
		if(bankDetail!=null) {	

			return bankDetail;
		}else {
			return null;
		}
	}
	
	
	
	//**********載入頁面後顯示儲值金兌換紀錄*********
	@ResponseBody
	@PostMapping(value="/frontend/bankList", produces = {"application/json;charset=UTF-8"})
	public List<WalletDto> showChangeList(@RequestBody WalletDto dto ) {
	System.out.println(dto);
	int id = dto.getAccount().getId();
//	int pagenumber = dto.getPagenumber();
	System.out.println(id);
	

	List<WalletDto> w1 = wService.findAllBySourceType(id);
		if(w1!=null) {	

			return w1;
		}else {
			return null;
		}
	}
	
	
	//**********兌換後顯示最新兌換紀錄*********
	@ResponseBody
	@PostMapping(value="/edit/changeAmount", produces = {"application/json;charset=UTF-8"})
	public List<WalletDto> changeAmount(@RequestBody WalletDto dto ) {
		
		
		int id = dto.getAccount().getId();
		int bank_amount = dto.getBank_amount();
		System.out.println(bank_amount);
		Optional<Bank> bank = wService.bankDetail(id);
		Integer amount = bank.get().getAmount();
		System.out.println(amount);
		List<WalletDto> dto1 = new 	ArrayList<WalletDto>();
		if(bank_amount!=0 && bank_amount<= amount && amount != 0 ) {
			int wallet_amount = bank_amount;
			int bonus = (bank_amount / 100);
			dto1 = wService.changeBankAccount(id, bank_amount, wallet_amount, bonus);
		}else {
			dto1.add(null);
		}
		return dto1;
	}
	
	//**********載入頁面後顯示紅利點數兌換紀錄*********
	@ResponseBody
	@PostMapping(value="/frontend/bonuslist", produces = {"application/json;charset=UTF-8"})
	public List<WalletDto> showBonusList(@RequestBody WalletDto dto ) {
		String date1 = dto.getDate1();
		String date2 = dto.getDate2();
		System.out.println(date1);
		System.out.println(date2);
	String selected = dto.getSelected();
	System.out.println(selected);
	String orderby = dto.getOrderby();
	System.out.println(orderby);
	int id = dto.getAccount().getId();
	System.out.println(id);
	List<WalletDto> w1 = new ArrayList<WalletDto>();
	if(date1=="" || date2=="") {
		w1 = wService.findAllBonusById(id,orderby,selected);
	}else {
		w1 = wService.findAllBonusByDate(id,orderby,selected,date1,date2);
	}
	System.out.println(w1);
		if(w1!=null) {	
			return w1;
		}else {
			return null;
		}
	}
	
	
	//**********紅利兌換模糊搜尋*********
//	@ResponseBody
//	@PostMapping(value="/backned/allBonusSearch", produces = {"application/json;charset=UTF-8"})
//	public List<MemberDto> showAllBonusbysearch(@RequestBody WalletDto dto ) {
		
//		System.out.println(member.getName());
//		
//		String orderby = member.getOrderby();
//	
//		List<MemberDto> m1 =mService.getAllMemberSearch(member.getName(),orderby);
//		
//		
//		
//
//			if(m1!=null) {	
//
//				return m1;
//			}else {
//				return null;
//			}
		
//	}
	
	


	
	
}
