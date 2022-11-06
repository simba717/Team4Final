package com.project.BonusPointExchangePlatform.service;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.BonusPointExchangePlatform.dao.AccountDao;
import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Member;

@Service
public class LoginService {

	@Autowired
	private AccountDao accountDao;
	
	@Autowired
	private CipherUtilsService cipherUtilsService;
	
	
	/* 確認帳密 */
	public boolean checkAccount(String account, String password) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException {

		Account checkAccount = accountDao.checkPwdByAcc(account);

		if (checkAccount != null) {
			String key = "kittymickysnoopy";
			String oldPassword = cipherUtilsService.decryptString(key, checkAccount.getPassword(), checkAccount.getIv());

			if (oldPassword.equals(password)) {
				return true;
			}else {
				return false;
			}
			
		}
		return false;

	}

	/* 確認員工帳密 */
	public boolean checkAccountEmp(String account, String password) {
		Account checkAccount = accountDao.checkAccountEmp(account, password);

		if (checkAccount != null) {
			return true;
		}
		return false;
	}

	/* 根據帳密得到Account Bean */
	public Account getBeanByAccPwd(String account, String password) {
		Account checkAccount = accountDao.checkAccount(account, password);
		return checkAccount;
	}
	

	
	
	/* 根據帳號得到Account Bean 確認註冊帳號是否重複 */
	public Account getBeanByAcc(String account) {
		Account checkAccount = accountDao.checkAccountByAcc(account);
		return checkAccount;
	}
	
	
	/* 註冊儲存account */
	public void insertAccount(Account account) {
		accountDao.save(account);
	}

	/* 檢查email是否正確並更新驗證碼 */
	public Account checkEmailUpdateCheckCode(String account, String email) {
		Account checkAccountByemail = accountDao.checkAccountByemail(account, email);
		if (checkAccountByemail != null) {
			return checkAccountByemail;
		} else {
			return null;
		}
	}

	/* 檢查員工email是否正確並更新驗證碼 */
	public Account checkEmailUpdateCheckCodeEmp(String account, String email) {
		Account checkAccountByemail = accountDao.checkAccountByemailEmp(account, email);
		if (checkAccountByemail != null) {
			return checkAccountByemail;
		} else {
			return null;
		}
	}

	/* 亂數生成驗證碼 */
	public String getRandomPassword() {
		int z;
		StringBuilder sb = new StringBuilder();
		int i;
		for (i = 0; i < 8; i++) {
			z = (int) ((Math.random() * 7) % 3);

			if (z == 1) { // 放數字
				sb.append((int) ((Math.random() * 10) + 48));
			} else if (z == 2) { // 放大寫英文
				sb.append((char) (((Math.random() * 26) + 65)));
			} else {// 放小寫英文
				sb.append(((char) ((Math.random() * 26) + 97)));
			}
		}
		String checkcode = sb.toString();
		return checkcode;
	}

	public void updatePwdByCheckcode(String checkcode, String password) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException {
		Account checkAccount = accountDao.checkCheckCode(checkcode);
		String key = "kittymickysnoopy";
		String newpassword = cipherUtilsService.encryptString(key, password, checkAccount.getIv());

		accountDao.updatePwdByCheckcode(checkcode, newpassword);

	}

	
	public void updatePwdByCheckcodeEmp(String checkcode, String password)  {
		accountDao.updatePwdByCheckcode(checkcode, password);

	}
	
	
}
