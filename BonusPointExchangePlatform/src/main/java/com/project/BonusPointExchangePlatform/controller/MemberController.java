package com.project.BonusPointExchangePlatform.controller;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.project.BonusPointExchangePlatform.dao.AccountDao;
import com.project.BonusPointExchangePlatform.dto.EmployeeDto;
import com.project.BonusPointExchangePlatform.dto.MemberDto;
import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.model.goodphoto;
import com.project.BonusPointExchangePlatform.service.EmployeeService;
import com.project.BonusPointExchangePlatform.service.LoginService;
import com.project.BonusPointExchangePlatform.service.MailService;
import com.project.BonusPointExchangePlatform.service.MemberService;
import com.project.BonusPointExchangePlatform.service.OrdersService;

@Controller
@SessionAttributes(names = "member")
public class MemberController {
	
	@Autowired
	private AccountDao aDao;
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private LoginService loginService;

	@Autowired
	private MailService mailService;
	
	@Autowired
	private OrdersService ordersService; 
	
	
	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	//*******前台會員編輯會員資料**********
		@GetMapping("/frontend/EditMemberByMember")
		public String newMemberPage(HttpSession session) {
			Member member = (Member)session.getAttribute("member");
			
			if( member == null) {
			return "/frontend/entrance/newlogin";
			
			}else
			return "frontend/member/EditMemberByMember";
		}

		
		
		
	//
//		@GetMapping("/goMemberdetail")
//		public String newMemberdetail() {
//			return "layout/Navbar2";
//		}
		
		@ResponseBody
		@GetMapping(value="/frontend/member", produces = {"application/json;charset=UTF-8"})
		public MemberDto showMemberById(@RequestParam(value="id") Integer id) {
			System.out.println(id);
			MemberDto dto = new MemberDto();
			Account newa1 =aDao.showMemberById(id);
			dto.setAccount(newa1);
			dto.setDateBirth(DateFormat.format(newa1.getMember().getBirth()));
			dto.setDateUpdate(DateTimeFormat.format(newa1.getMember().getUpdate_at()));
			return dto;
		}
		
	

		

		//**********後台載入頁面顯示所有會員***********
		@ResponseBody
		@PostMapping(value="/backned/allMember", produces = {"application/json;charset=UTF-8"})
		public List<MemberDto> showAllMember(@RequestBody MemberDto member) {
		
			String orderby = member.getOrderby();
			List<MemberDto> m1 =mService.getAllMember(orderby);
		System.out.println(123);

				if(m1!=null) {	

					return m1;
				}else {
					return null;
				}
			
		}
		

		//**********後台模糊搜尋以及排序所有會員***********
		@ResponseBody
		@PostMapping(value="/backned/allMemberSearch", produces = {"application/json;charset=UTF-8"})
		public List<MemberDto> showAllbysearch(@RequestBody MemberDto member ) {
			
			System.out.println(member.getName());
			
			String orderby = member.getOrderby();
		
			List<MemberDto> m1 =mService.getAllMemberSearch(member.getName(),orderby);
			
			
			

				if(m1!=null) {	

					return m1;
				}else {
					return null;
				}
			
		}
		
		//**********後台針對單筆會員做修改***********
		@ResponseBody
		@PostMapping(path="/backned/edit/member", produces = {"application/json;charset=UTF-8"})
		public List<MemberDto> editBacknedMemberById(@RequestBody MemberDto dto ) {
			String orderby = dto.getOrderby();
			int id = dto.getMember().getId();
			System.out.println(id);
			String name = dto.getName();
			LocalDate birth = LocalDate.parse(dto.getBirth());
			String email = dto.getEmail();
			String phone = dto.getPhone();
			byte[] image2=null;
			if(dto.getImage()==null) {
				MemberDto m1 = mService.findOnebyId(id);
				image2 = m1.getMember().getImage();
				mService.editBacknedMemberDetail(name, birth, email,phone,image2,id);
			}else
				mService.editBacknedMemberDetail(name, birth, email,phone,dto.convertImage(),id);
			 
			List<MemberDto> all = mService.getAllMember(orderby);

			return all;
		
		}

		
		//**********後台針對單筆會員按下修改後顯示舊資料***********
		@ResponseBody
		@PostMapping(path = "/backned/edit/memberbyid", produces = {"application/json;charset=UTF-8"})
		public MemberDto findoneById(@RequestBody MemberDto dto ) {
			String orderby = dto.getOrderby();
			int id  = dto.getMember().getId();
			MemberDto dto1 = mService.findOnebyId(id);
			
			return dto1;	
		}
		
		
		//**********後台針對單筆會員停權復權***********
		@ResponseBody
		@PostMapping(path = "/backned/member/edit/restorepermission", produces = {"application/json;charset=UTF-8"})
		public List<MemberDto> restorepermission(@RequestBody  MemberDto dto ) {
			
			int id  = dto.getMember().getId();
			String orderby = dto.getOrderby();
			int type = dto.getAccount_type();
			int newtype;
			if(type==1) {
				newtype=0;
			}else {
				newtype=1;
			}
			System.out.println(newtype);
			List<MemberDto> dto1= mService.restorepermission(id,newtype,orderby);
			return dto1;
				
		}
		
		
		@ResponseBody
		@PostMapping(path="/frontend/member/iconphoto", produces = {"application/json;charset=UTF-8"})
		public Member geticonphoto(@RequestBody MemberDto dto ) {
			
			Integer id1 = dto.getAccount().getId();
			System.out.println(id1);
			if(id1!=null) {
			Member member = mService.geticonphoto(id1);
			return member;
			}else
			return null;
		}
		
		
		//***********前台會員個人編輯載入後頁面*********
		@ResponseBody
		@PostMapping(path = "/frontned/edit/MemberByMember", produces = {"application/json;charset=UTF-8"})
		public MemberDto editMemberByMember(@RequestBody MemberDto dto, HttpSession session ) {
			
			Member member = (Member)session.getAttribute("member");
			Integer id = member.getId();
//			int id  = dto.getAccount().getId();
			
			MemberDto dto1 =new MemberDto();
					
			dto1.setAccount(mService.showMemberById(id));
			
			return dto1;	
		}
		
		
		//***********前台會員完成個人編輯*********
		@ResponseBody
		@PostMapping(path="/edit/member", produces = {"application/json;charset=UTF-8"})
		public MemberDto editMemberById(@RequestBody MemberDto dto,HttpSession session ) {
			
			Member member = (Member)session.getAttribute("member");
			Integer id = member.getId();
			
			String password = dto.getAccount().getPassword();
//		    System.out.println(dto.convertImage()); 
			String name = dto.getName();
			LocalDate birth = LocalDate.parse(dto.getBirth());
			String email = dto.getEmail();
			String phone = dto.getPhone();
			
			if(dto.getImage()==null) {
			MemberDto m1 = mService.findOnebyId(id);
			byte[] image2 = m1.getMember().getImage();
			mService.editMemberDetail(name, birth, email, phone, password,image2, id);
			}else {
			byte[] image = dto.convertImage();
			mService.editMemberDetail(name, birth, email, phone, password,image, id);
			}
			MemberDto dto1 =new MemberDto();
			dto1.setAccount(mService.showMemberById(id));
			
			return dto1;
			
		}
	
	
	
	
	
	

	
	
//	/*會員資料*/
//	@ResponseBody
//	@GetMapping(path = "/query/findMemberByAccountId")
//	public void findMemberByAccountId(Integer id) throws ParseException {
//		Optional<Account> optional = aDao.findById(id);		
//		Member member = optional.get().getMember();
//				
//        String birth = DateFormat.format(member.getBirth());        
//        String create_date = DateTimeFormat.format(member.getCreate_at());
//        String update_date = DateTimeFormat.format(member.getUpdate_at());
//		
//		System.out.println(member.getId() + " , " + member.getName() + " , " + birth + " , " + member.getPhone() + " , " + member.getEmail() + " , " + member.getImage() + " , " + create_date + " , " + update_date);
//	}

	/*訂單歷程查詢*/
/*	@ResponseBody
	@GetMapping(path = "/query/findOrderDetailByAccountId")
	public void findOrderDetailByAccountId(Integer id) {
		Optional<Account> optional = accountDao.findById(id);
		Set<Orders> orders = optional.get().getMember().getOrders();
		
		for(Orders o : orders) {
			System.out.println(o.getOrder_token());
			
			Set<Order_Detail> order_detail = o.getOrder_detail();
			for(Order_Detail d : order_detail) {
				System.out.println(d.getProduct_name());
			}
			
			Set<Payment> payment = o.getPayment();
			for(Payment p : payment) {
				System.out.println(p.getPayment());
				
				Wallet w = p.getWallet();
		        String create_date = DateTimeFormat.format(w.getCreate_at());
				System.out.println(w.getSource_type() + ", " + w.getWallet_amount() + ", " + w.getBonus_point() + ", " + w.getCredit_card_amount() + ", " + create_date);
				
			}
		}		
	}
*/	
	//書瑋
	/* 登入頁面 */
	@GetMapping("/login")
	public String loginAction() {
		return "/frontend/entrance/newlogin";
	}

	/* 確認帳密 */
	@PostMapping(path = "/home")
	public String checkAccount(@RequestParam("account") String account, @RequestParam("password") String password,
			Model m) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException {
		boolean result = loginService.checkAccount(account, password);

		if (!result) {
			return "/frontend/entrance/newloginfail";
		} else {
			Account user = loginService.getBeanByAcc(account);
			Orders orders = ordersService.findUnPaidOrdersByMember(user.getMember());
			if(orders == null) {
				ordersService.insertOrder(user.getMember());
			}
			m.addAttribute("member", user.getMember());
			return "redirect:/";
		}
	}

	@GetMapping(path = "/logout")
	public String logout(SessionStatus status,HttpSession session) {
		session.removeAttribute("pill");
		session.removeAttribute("ordersListContent");
		status.setComplete();
		return "redirect:/";
	}

	/* 會員更改密碼頁面 */
	@GetMapping("/updatepassword")
	public String mailAction() {
		return "/frontend/entrance/updatepassword";
	}

	/* 寄信 */
	@PostMapping("/sendemail")
	public String sendMailToUser(@RequestParam("account") String account, @RequestParam("email") String email) {
		Account user = loginService.checkEmailUpdateCheckCode(account, email);
		if (user != null) {
			String checkcode = loginService.getRandomPassword();
			user.setCheck_code(checkcode);
			loginService.insertAccount(user);
			mailService.prepareAndSend(email, "您的驗證碼為: " + checkcode);
			return "/frontend/entrance/updatenewpassword";

		} else {
			return "/frontend/entrance/updatepasswordfail";
		}
	}

	/*輸入驗證碼確認驗證碼是否正確*/
	@PostMapping(value="/checkCodeCheck", produces = { "application/json" })
	@ResponseBody
	public boolean checkCodeCheck(@RequestParam("checkcode")String checkcode) {
		Account account = aDao.checkCheckCode(checkcode);
		if(account!=null) {
			return true;
		}else 
			return false;
	}
	
	
	/* 輸入驗證碼並更改密碼 */
	@PostMapping("/updatenewpassword")
	public String updatePasswordByCheckcode(@RequestParam("checkcode") String checkcode,
			@RequestParam("password") String password) {
		loginService.updatePwdByCheckcode(checkcode, password);
		return "/frontend/entrance/updatesuccess";
	}

}
