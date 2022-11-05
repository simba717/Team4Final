package com.project.BonusPointExchangePlatform.controller;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Bank;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.service.BankService;
import com.project.BonusPointExchangePlatform.service.CipherUtilsService;
import com.project.BonusPointExchangePlatform.service.LoginService;
import com.project.BonusPointExchangePlatform.service.MemberService;

@Controller
public class RegisterController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private BankService bankService;

	@Autowired
	private LoginService loginService;

	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

	/* 註冊頁面 */
	@GetMapping("/register")
	public String registerAction() {
		return "/frontend/entrance/newregister";
	}

	/* 註冊頁面 */
	@GetMapping("/registertest")
	public String registerActiontest() {
		return "/frontend/entrance/newregister";
	}

	@PostMapping("/registerAccount")
	public String registerAccount(@RequestParam("account") String account, @RequestParam("password") String password,
			@RequestParam("name") String name, @RequestParam("birth") String birth, @RequestParam("phone") String phone,
			@RequestParam("email") String email, @RequestParam("account_no") String account_no,
			@RequestParam("image") MultipartFile image) throws ParseException, IOException, InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException {
		System.out.println(account + " " + password + " " + name + " " + phone + " " + email + " " + account_no + " "
				+ birth + " " + image);
 
		/* 抓到的birth是String,需轉型成Date */
		Date newbirth = DateFormat.parse(birth);

		/* new 一個member和account來裝資料 */
		Member member = new Member();
		Account account2 = new Account();

		/* 透過輸入的銀行帳號找銀行的ID並填進member裡的銀行ID */
		Bank bankId = bankService.findIdByAccountNo(account_no);

		/* new一個getDate塞進member及account裡的createdate和updatedate */
		Date newcreatedate = new Date();

		member.setName(name);
		member.setBirth(newbirth);
		member.setPhone(phone);
		member.setEmail(email);
		member.setBank(bankId);
		member.setCreate_at(newcreatedate);
		member.setUpdate_at(newcreatedate);

		/* 如果註冊時無上傳照片 會預設頭貼塞入頭貼欄位 */
		if (image != null) {
			member.setImage(image.getBytes());
		} else {

			member.setImage(null);
		}
		;

		/* 把塞進資料的member儲存好 */
		memberService.insertMember(member);

		/* 根據member裡的email找到剛剛新增member自動產生的memberId塞進account裡的memberId */
		Member newmemberId = memberService.findIdByEmail(email);

		/*加密*/
		String key = "kittymickysnoopy"; // 對稱式金鑰
		byte[] iv = new byte[128 / 8]; // 初始向量
		SecureRandom srnd = new SecureRandom();
		srnd.nextBytes(iv);
		
		String newpassword = CipherUtilsService.encryptString(key, password, iv);

		
		account2.setIv(iv);
		account2.setMember(newmemberId);
		account2.setAccount(account);
		account2.setPassword(newpassword);
		account2.setAccount_type(1);
		account2.setCheck_code(null);
		account2.setEmployee(null);
		account2.setCreate_at(newcreatedate);
		account2.setUpdate_at(newcreatedate);
		/* 把塞進資料的account儲存好 */
		loginService.insertAccount(account2);

		return "/frontend/entrance/registersuccess";
	}

	// 當新增會員資料時, 檢查帳號是否可用
	@PostMapping(value = "/CheckAccountRepeat", produces = { "application/json" })
	public @ResponseBody Map<String, String> checkMemberId(@RequestParam("account") String account) {
		Map<String, String> map = new HashMap<>();

		Account checkAccount = loginService.getBeanByAcc(account);
		if (checkAccount != null) {
			map.put("account", checkAccount.getAccount());
		} else {
			map.put("account", "");
		}

		return map;
	}

	// 當新增會員資料時, 檢查信箱是否可用
	@PostMapping(value = "/CheckMailRepeat", produces = { "application/json" })
	public @ResponseBody Map<String, String> checkMail(@RequestParam("email") String email) {
		Map<String, String> map = new HashMap<>();

		Member checkEmail = memberService.getBeanByEmail(email);
		if (checkEmail != null) {
			map.put("email", checkEmail.getEmail());
		} else {
			map.put("email", "");
		}

		return map;
	}

	// 當新增會員資料時, 檢查銀行帳號是否可用
	@PostMapping(value = "/CheckBankRepeat", produces = { "application/json" })
	@ResponseBody
	public boolean checkBank(@RequestParam("account_no") String account_no) {
		boolean repeatRs = bankService.checkRepeatByAccountNo(account_no);
		return repeatRs;
	}
	
	
	
	//加鹽
//		 public static void main(String[] args) {
//		  String key = "kittymickysnoopy"; // 對稱式金鑰
//		  byte[] iv = new byte[128 / 8]; // 初始向量
//		  SecureRandom srnd = new SecureRandom();
//		  srnd.nextBytes(iv);
//		  String plainText = "美國總統(川普)的老婆拍過裸照";
//		  String cipherText = "";
//		  String decryptedString = "";
//		  try {
//		   // encryptString(key, plainText, iv) : 將明文轉換為密文
//		   cipherText = CipherUtils.encryptString(key, plainText, iv);
//		   // decryptString(key, cipherText, iv) : 將密文還原為明文
//		   decryptedString = CipherUtils.decryptString(key, cipherText, iv);
//		  } catch (Exception e) {
//		   e.printStackTrace();
//		  }
//		  System.out.println("原始字串: " + plainText);
//		  System.out.println("加密字串: " + cipherText);
//		  System.out.println("解密字串: " + decryptedString);
//		 }
		
	
}
