package com.project.BonusPointExchangePlatform.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.service.GameService;

@Controller
public class GameController {
	
	@Autowired
	private GameService gService;
	
	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	
	@GetMapping(path = "/campaign")
	public String processMainAction() {
		return "frontend/campaign/SignIn";
	}
	
	@ResponseBody
	@GetMapping(path = "/checkSignIn" ,produces = {"application/json;charset=UTF-8"})
	public Game checkSignin(HttpSession session) {
		Date getDate = new Date();
		String game_type = "簽到";
		Member m = (Member)session.getAttribute("member");
		Integer mId = m.getId();
		String create_at = dateFormat.format(getDate);
		Game game = gService.checkSignIn(mId, game_type, "%"+create_at+"%");
		
		System.out.println("88888888"+game);
		if(game==null) {
			Set<Member> set = new HashSet<Member>();
			set.add(m);
			Game g = new Game("簽到",true,null,getDate,getDate,set);
			Set<Game> setGame = m.getGame();
			setGame.add(g);
			gService.insertGame(m, getDate);
			Game g2 = new Game();
			g2.setGame_type("成功");
			return g2;
		}
		else {
			Game g = new Game();
			g.setGame_type("已簽到過");
			return g;
		}
	}
	
	@ResponseBody
	@GetMapping(path = "/selectDate" ,produces = {"application/json;charset=UTF-8"})
	public List<String> selectDate(Model m,HttpSession session) {
		String game_type = "簽到";
		Member member = (Member)session.getAttribute("member");
		Integer mId = member.getId();
		List<Game> dateList = gService.selectDate(mId, game_type);
		List<String> getDate = new ArrayList<String>();
		for(Game list:dateList) {
			
			getDate.add(dateFormat.format(list.getCreate_at()));
		}
		
//		m.addAttribute("list",getDate);
		return getDate;
	}
}
