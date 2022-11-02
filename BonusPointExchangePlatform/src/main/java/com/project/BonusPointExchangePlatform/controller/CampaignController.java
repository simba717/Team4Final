package com.project.BonusPointExchangePlatform.controller;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.dao.EmployeeDao;
import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.model.Campaign;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;

@Controller
public class CampaignController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EmployeeDao employeeDao;
		
	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	@GetMapping("/say")
	public String hi() {
		return "/frontend/campaign/hi";
		
	}
	
/*	@ResponseBody
	@GetMapping(path = "/query/findGameByMember")
	public void findGameByMember(@RequestParam String name, @RequestParam Integer check_status){
		List<Member> aa = memberDao.findGameByMember(name, check_status);
		
		Set<Game> game = null;
		for(int i = 0; i < aa.size(); i++) {
			game = aa.get(i).getGame();
		}
		for(Game g : game) {
			System.out.println(g.getGame_type()); 
		}
	}

	@ResponseBody
	@GetMapping(path = "/query/findCampaignByEmployee")
	public void findCampaignByEmployee() {
		List<Employee> employee = employeeDao.findCampaignByEmployee();
		
		for(int i = 0; i < employee.size(); i++) {
			Set<Campaign> campaign = employee.get(i).getCampaign();
			
			for(Campaign camp : campaign) {
				System.out.println(camp.getTitle()); 
			}
		}
	}
*/	

	
	

}
