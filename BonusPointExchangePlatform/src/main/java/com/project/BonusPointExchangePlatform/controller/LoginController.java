package com.project.BonusPointExchangePlatform.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.service.LoginService;
import com.project.BonusPointExchangePlatform.service.OrdersService;

@Controller
@SessionAttributes(names = {"member","employee"})
public class LoginController {

	/* 測試登入狀態 */
	@GetMapping("/test")
	public String loginTest() {
		return "/frontend/entrance/newlogin";
	}

	@GetMapping("/uptest")
	public String updateTest() {
		return "/frontend/entrance/updatesuccess";
	}

	@GetMapping("/uptestemp")
	public String empupdateTest() {
		return "/backend/entrance/updatesuccessemp";
	}
	
	@GetMapping(path = "/toBack")
	public String toBack(SessionStatus status,HttpSession session) {
		session.removeAttribute("pill");
		session.removeAttribute("ordersListContent");
		status.setComplete();
		return "/layout/BackNavbar";
	}

	
	@GetMapping(path = "/toFront")
	public String toFront(SessionStatus status,HttpSession session) {
		session.removeAttribute("pill");
		session.removeAttribute("ordersListContent");
		status.setComplete();
		return "/layout/Navbar";
	}
	

}
