package com.project.BonusPointExchangePlatform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class ViewController {
	
	/*HomePage*/
	@GetMapping("/")
	public String goMemberHome() {
		return "layout/Navbar";
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
	public String showAllBooksAjax() {
		return "/backend/mall/productQuery";
	}
	
	@GetMapping(path = "/orders/findAll")
	public String findAllOrdersByEmployee() {
		return "/backend/order/employeeOrdersQuery";
	}
	
/*	@GetMapping(value = "/orders/employeeFindById/{id}", produces = { "application/json; charset=UTF-8 " })
	public String employeeFindById(@PathVariable Integer id, Model model) {
		model.addAttribute("id", id);
		return "/backend/order/employeeOrdersQuery";
	}
*/	
	@GetMapping(path = "/orders/findAllByMember")
	public String findAllOrdersByMember() {
		return "/frontend/member/memberOrdersQuery";
	}
/*	
	@GetMapping(value = "/orders/memberFindById/{id}", produces = { "application/json; charset=UTF-8 " })
	public String memberFindById(@PathVariable Integer id, Model model) {
		model.addAttribute("id", id);
		return "/frontend/order/memberOrdersQuery";
	}
*/	
	
	/*UPDATE*/
	@GetMapping(value = "/product/edit/{id}", produces = { "application/json; charset=UTF-8 " })
	public String editProduct(@PathVariable Integer id, Model model) {
		model.addAttribute("id", id);
		return "/backend/mall/productEdit";
	}
	
	

}
