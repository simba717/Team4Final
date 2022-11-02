package com.project.BonusPointExchangePlatform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {
	
	// @GetMapping("/")
	// public String goHome() {
	// 	return "layout/Navbar";
	// }

	
	@GetMapping("/navbar")
	public String goNavbar() {
		return "layout/Navbar";
	}
	
	@GetMapping("/navbar2")
	public String goNavbar2() {
		return "layout/Navbar2";
	}
	
	@GetMapping("/backnavbar")
	public String goBackNavbar() {
		return "layout/BackNavbar";
	}
	
	@GetMapping("/editEmployee")
	public String goeditEmployee() {
		return "/backend/personManage/EditEmployee";
	}
	
	
}
