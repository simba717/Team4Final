package com.project.BonusPointExchangePlatform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.BonusPointExchangePlatform.dao.AccountDao;
import com.project.BonusPointExchangePlatform.dao.BankDao;
import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Bank;
import com.project.BonusPointExchangePlatform.model.Member;

@Service
@Transactional
public class BankService {
	@Autowired
	private BankDao bankDao;
	
	@Autowired
	private AccountDao accountDao;
	
	@Autowired
	private MemberDao memberDao;
	
	/*根據銀行帳號找ID*/
	public Bank findIdByAccountNo(String account_no) {
		return bankDao.findIdByAccountNo(account_no);
	}
	
	/*根據銀行帳號找ID*/
	public boolean checkRepeatByAccountNo(String account_no) {
		Bank bankBean = bankDao.checkRepeatByAccountNo(account_no);
		if(bankBean!=null){
			Member checkBankRepeat = memberDao.checkReapeatByBankId(bankBean.getId());
			if(checkBankRepeat !=null) {
				return false;
				
			}else
				return true;
		}else
			return false;
	
	}
	

}
