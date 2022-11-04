package com.project.BonusPointExchangePlatform.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Member;

@Controller
public class ViewController {
	
	/*HomePage*/
	@GetMapping("/")
	public String goMemberHome() {
		return "redirect:/showProduct";

	}
	
	@GetMapping("/backend")
	public String goEmployeeHome() {
		return "layout/BackNavbar";
	}
	
	/*INSERT*/
	@GetMapping(path = "/product/create")
	public String FileUpload() {
		return "/backend/mall/productCreate";
	}
	
	/*SELECT*/
	@GetMapping(path = "/product/findAll")
	public String showAllBooksAjax(HttpSession session) {
		Employee employee = (Employee)session.getAttribute("employee");
		if(employee == null) {
			return "redirect:/loginEmp";
		}
		return "/backend/mall/productQuery";
	}
	
	@GetMapping(path = "/orders/findAll")
	public String findAllOrdersByEmployee(HttpSession session) {
		Employee employee = (Employee)session.getAttribute("employee");  
		if(employee == null) {
			return "redirect:/loginEmp";
		}
		return "/backend/order/employeeOrdersQuery";
	}
	
	@GetMapping(path = "/orders/findAllByMember")
	public String findAllOrdersByMember(HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		if(member == null) {
			return "redirect:/login";
		}
		return "/frontend/member/memberOrdersQuery";
	}
	
	/*UPDATE*/
	@GetMapping(value = "/product/edit/{id}", produces = { "application/json; charset=UTF-8 " })
	public String editProduct(@PathVariable Integer id, Model model) {
		model.addAttribute("id", id);
		return "/backend/mall/productEdit";
	}
	
	

}
