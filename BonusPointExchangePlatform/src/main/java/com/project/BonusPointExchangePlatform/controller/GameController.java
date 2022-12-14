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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.dto.BackendLookGameBonusOfMemberDto;
import com.project.BonusPointExchangePlatform.dto.GameDto;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.service.GameService;

@Controller
public class GameController {

	@Autowired
	private GameService gService;

	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private SimpleDateFormat dateFormat2 = new SimpleDateFormat("-MM-dd");

	// 生日禮
	@ResponseBody
	@GetMapping(path = "/checkBirth", produces = { "application/json;charset=UTF-8" })
	public Game checkBirth(HttpSession session) {
		Date getDate = new Date();
		Game g = new Game();
		Member m = (Member) session.getAttribute("member");
		Integer mId = m.getId();
		String create_at = dateFormat.format(getDate);
		String create_at2 = dateFormat2.format(getDate);
		Member member = gService.checkBirth("%" + create_at2 + "%", mId);
		if (member != null) {
			Game game = gService.checkBirthGift(mId, "%" + create_at + "%");
			if (game == null) {
				gService.insertBirth(m, getDate);
				gService.insertBirthWallet(m, getDate);
				g.setGame_type("恭喜獲得生日禮");
				return g;
			} else {
				g.setGame_type("您今天已經領過生日禮囉");
				return g;
			}
		} else {
			g.setGame_type("您的生日還沒到喔");
			return g;
		}

	}

	// 簽到禮
	@ResponseBody
	@GetMapping(path = "/checkSignIn", produces = { "application/json;charset=UTF-8" })
	public Game checkSignin(HttpSession session) {
		Date getDate = new Date();
		String game_type = "簽到";
		Member m = (Member) session.getAttribute("member");
		Integer mId = m.getId();
		String create_at = dateFormat.format(getDate);
		Game game = gService.checkSignIn(mId, game_type, "%" + create_at + "%");

		if (game == null) {
			Set<Member> set = new HashSet<Member>();
			set.add(m);
			Game g = new Game("簽到", true, null, getDate, getDate, set);
			Set<Game> setGame = m.getGame();
			setGame.add(g);
			gService.insertGame(m, getDate);
			gService.insertSignWallet(m, getDate);
			Game g2 = new Game();
			g2.setGame_type("已完成簽到");
			return g2;
		} else {
			Game g = new Game();
			g.setGame_type("您已簽到過囉");
			return g;
		}
	}

	// 魔水晶禮
	@ResponseBody
	@GetMapping(path = "/checkCrystal", produces = { "application/json;charset=UTF-8" })
	public Game checkCrystal(HttpSession session) {
		Date getDate = new Date();
		Game g = new Game();
		Member m = (Member) session.getAttribute("member");
		Integer mId = m.getId();
		String create_at = dateFormat.format(getDate);
		Game game = gService.checkCrystalGift(mId, create_at);
		if (game == null) {
			gService.insertCrystal(m, getDate);
			gService.insertCrystalWallet(m, getDate);
			g.setGame_type("已完成魔水晶遊戲活動");
			return g;
		} else {
			g.setGame_type("您今日已經玩過遊戲了");
			return g;
		}
	}

	@ResponseBody
	@GetMapping(path = "/selectDate", produces = { "application/json;charset=UTF-8" })
	public List<String> selectDate(Model m, HttpSession session) {
		String game_type = "簽到";
		Member member = (Member) session.getAttribute("member");
		Integer mId = member.getId();
		List<Game> dateList = gService.selectDate(mId, game_type);
		List<String> getDate = new ArrayList<String>();
		for (Game list : dateList) {

			getDate.add(dateFormat.format(list.getCreate_at()));
		}

		return getDate;
	}

//////////////瑋煊的頭//////////////////////////////////

/////////////// 員工查詢遊戲發放的紅利/////////////////////////////////////////////
//navbar連結JSP
	@GetMapping("/game/GameBonus")
	public String getGameBonus(HttpSession session) {
		Employee employee = (Employee) session.getAttribute("employee");

		if (employee == null) {
			return "redirect:/loginEmp";

		}else {
		return "/backend/campaign/memberGameBonus";
		}
	}

//將所有遊戲發放的紅利資料JSON傳到後台
	@GetMapping(value = "/backend/campaign/getGameBonusOfAllMember", produces = { "application/json; charset=UTF-8" })
	@ResponseBody
	public List<GameDto> getGameBonusOfAllMember() {
		List<GameDto> allMemberGameBonus = gService.findGameBonusOfAllMember();

		return allMemberGameBonus;
	}

//將遊戲發放給某會員的紅利資料JSON傳到後台
	@GetMapping(value = "/backend/campaign/getGameBonusOfOneMember", produces = { "application/json; charset=UTF-8" })
	@ResponseBody
	public List<GameDto> getGameBonusOfOneMember(@RequestParam int member_id) {
		List<GameDto> oneMemberGameBonus = gService.findGameBonusOfOneMember(member_id);

		return oneMemberGameBonus;
	}

/////////////////////// 會員查詢遊戲紀錄OK//////////////////////////
//navbar連結JSP
	@GetMapping("/campaign/gameRecord")
	public String gameRecord(HttpSession session) {
		Member member = (Member) session.getAttribute("member");

		if (member == null) {
			return "redirect:/login";
		} else {
			return "frontend/campaign/gameRecord";
		}
	}

//將會員遊戲紀錄的JSON傳到前台
	@GetMapping(value = "/frontend/campaign/memberGameRecords", produces = { "application/json; charset=UTF-8" })
	@ResponseBody
	public List<GameDto> getGameRecordsByMember(HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		System.out.println(member.getName());
		List<GameDto> memberGameRecords = gService.findGameRecordsByMember(member.getId());

		return memberGameRecords;
	}

/////////////////////// 會員查詢遊戲紀錄OK//////////////////////////

//連結遊戲頁面
	@GetMapping("/campaign/game")
	public String gamePage(HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		if(member == null) {
			return "redirect:/login";
		}else {
		return "frontend/campaign/game";
		}
	}

//////////////瑋煊的腳//////////////////////////////////

}
