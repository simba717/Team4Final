package com.project.BonusPointExchangePlatform.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.dao.EmployeeDao;
import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.model.Campaign;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.service.CampaignService;

@Controller
public class CampaignController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EmployeeDao employeeDao;
	
	@Autowired
	private CampaignService campaignService;
		
	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	@GetMapping("/say")
	public String hi() {
		return "/frontend/campaign/hi";
		
	}
	
///////////////////////後台的頭///////////////////////////////
	// 會員活動管理JSP
	@GetMapping("/campaign/findAll")
	public String findAllCampaigns() {
		return "/backend/campaign/allCampaigns";
	}
	
	// 會員活動管理JSON
	
	////////////////////////後台的腳//////////////////////////////////

	//雙十一紅利加倍活動
	@GetMapping("/campaign/double11")
	public String double11() {
		return "/frontend/campaign/double11";
	}
	
	
	// 用id查詢活動
	@GetMapping("/campaigns/{id}")
	public Optional<Campaign> readById(@PathVariable Integer id) {
		return campaignService.findById(id);
	}

	
	
	
	@GetMapping("/campaigns/listAll")
	public List<Campaign> readAll() {
		return campaignService.findAll();
	}

	// 新增活動
	@PostMapping("/campaigns/add")
	public Campaign createOne(Campaign campaign) {

//			Campaign campaign2 = new Campaign();
//			campaign2.setTitle("週六會員日");
//			campaign2.setContent("消費滿666可獲得額外66點紅利金");
//			campaign2.setBegin_at(2022-11-01 00:00);
//			campaign2.setEnd_at("2022/11/30 23:59");
//			campaign2.setButton_switch(true);
//			campaign2.setCreate_at("2022/10/13 11:35:00");
//			campaign2.setUpdate_at("2022/10/13 11:35:00");

		return campaignService.save(campaign);
	}

	// 更新活動
	// 含id就是更新, 不含id就是新增
	@PutMapping("/campaigns/update")
	public Campaign updateOne(Campaign campaign) {
		return campaignService.save(campaign);
	}

	// 刪除活動
	@DeleteMapping("/campaigns/delete/{id}")
	public void deleteById(@PathVariable Integer id) {
		campaignService.deleteById(id);
	}

	///////////////////////////////////////////////
	// 查詢活動列表
	@GetMapping("/campaign/list")
	public String list(Model model) {
		List<Campaign> campaign = campaignService.findAll();
		model.addAttribute("campaign", campaign);
		return "/backend/campaign/campaign";

	}

	// 用id查詢活動
	@GetMapping("/campaign/{id}")
	public String detail(@PathVariable Integer id, Model model) {
		Optional<Campaign> campaign = campaignService.findById(id);
		Campaign c = campaign.orElse(null);
		model.addAttribute("campaign", c);
		// 尚未完成
		return "/backend/campaign/campaign";

	}

	// 查詢分頁
	@ResponseBody
	@GetMapping("/campaigns/page/{pageNumber}")
	public List<Campaign> findByPage(@PathVariable Integer pageNumber) {
		// 參數(從第幾頁開始, 每頁幾筆資料, 根據什麼排序)
		// 索引從0開始, 所以要-1
		Pageable pageRequest = PageRequest.of(pageNumber - 1, 3, Sort.Direction.ASC, "id");
		Page<Campaign> page = campaignService.findAll(pageRequest);
		List<Campaign> list = page.getContent();
		return list;

	}

	// 用內容找活動
	// 回傳一筆資料
//	@ResponseBody
//	@GetMapping("/campaigns/content")
//	public Campaign findCampaignByContent(@RequestParam String content) {
//		return campaignService.findCampaignByContent(content);
//	}

	// 回傳多筆資料
//	@ResponseBody
//	@GetMapping("/campaigns/content2")
//	public List<Campaign> findCampaignByContent2(@RequestParam String content) {
//		return campaignService.findCampaignByContent2(content);
//	}

	// 回傳多筆資料
	@ResponseBody
	@GetMapping("/campaigns/content3")
	public List<Campaign> findCampaignByContent3(String content) {
		return campaignService.findCampaignByContent3(content);
	}

	@ResponseBody
	@GetMapping("/campaigns/delete/{id}")
	public boolean deleteCampaignById(Integer id) {
		campaignService.deleteCampaignById(id);
		return true;
	}

	//////////////// 可以用PostMan測//////////////////
	// 用id查詢活動
//	@GetMapping("/campaigns/search/{id}")
//	@ResponseBody
//	public Optional<Campaign> readById1(@PathVariable Integer id) {
//		return campaignService.findById(id);
//	}
//
//	// 查詢所有活動
//	@GetMapping("/campaigns")
//	@ResponseBody
//	public List<Campaign> readAll1() {
//		return campaignService.findAll();
//	}
//
//	// 新增活動
//	@PostMapping("/campaigns/add")
//	@ResponseBody
//	public Campaign createOne1(Campaign campaign) {
//
////			Campaign campaign2 = new Campaign();
////			campaign2.setTitle("週六會員日");
////			campaign2.setContent("消費滿666可獲得額外66點紅利金");
////			campaign2.setBegin_at(2022-11-01 00:00);
////			campaign2.setEnd_at("2022/11/30 23:59");
////			campaign2.setButton_switch(true);
////			campaign2.setCreate_at("2022/10/13 11:35:00");
////			campaign2.setUpdate_at("2022/10/13 11:35:00");
//
//		return campaignService.save(campaign);
//	}
//
//	// 更新活動
//	// 含id就是更新, 不含id就是新增
//	@PutMapping("/campaigns/update")
//	@ResponseBody
//	public Campaign updateOne1(Campaign campaign) {
//		return campaignService.save(campaign);
//	}
//
//	// 刪除活動
//	@DeleteMapping("/campaigns/delete/{id}")
//	@ResponseBody
//	public void deleteById1(@PathVariable Integer id) {
//		campaignService.deleteById(id);
//	}
	
	////////////////////////////////////////////////////////////////////
	
	//取得玩家ID
//		@GetMapping("/userID")
//		@ResponseBody
//		public String getUserName(
//				@RequestParam("userName") String user) {
//			
//			return "Hi" + user;
//		}
	
		@GetMapping("/OneData")
		@ResponseBody
		public String getOneData() {
			BufferedReader br;
			String data = "";
			try {
				File file = new File("C:\\Users\\Student\\Desktop\\_workspace\\gamaData\\gameResult.json");
				FileInputStream fis = new FileInputStream(file);
				InputStreamReader isr = new InputStreamReader(fis);
				br = new BufferedReader(isr);

				data = br.readLine();

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return data;
		}

		@GetMapping("/ManyData")
		@ResponseBody
		public String getManyData() {
			BufferedReader br;
			String data = "";
			try {
				File file = new File("C:\\Users\\Student\\Desktop\\_workspace\\gamaData\\gameResult2.json");
				FileInputStream fis = new FileInputStream(file);
				InputStreamReader isr = new InputStreamReader(fis);
				br = new BufferedReader(isr);

				data = br.readLine();

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return data;
		}

		// 取得單一玩家成績
//		@GetMapping("/OneData2")
//		public String getOneData2(Model model) throws Exception {
//			// 讀取Json文件
//			FileReader jsonFile = new FileReader("C:\\Users\\Student\\Desktop\\_workspace\\gamaData\\gameResult.json");
//
//			BufferedReader br = new BufferedReader(jsonFile);
//			String jsonStr = br.readLine();
//
//			ObjectMapper objectMapper = new ObjectMapper();
//			// Json物件轉JavaPOJO
//			Player player = objectMapper.readValue(jsonStr, Player.class);
//			System.out.println("玩家名稱: " + player.getUserName());
//			System.out.println("玩家成績: " + player.getUserScore());
//
//			model.addAttribute("UserName", player.getUserName());
//			model.addAttribute("UserScore", player.getUserScore());
//
//			return "showOne";
//
//		}
//
//		// 取得所有玩家成績
//		@GetMapping("/ManyData2")
//		public String getManyData2(Model model) throws Exception {
//
//			// 讀取Json文件
//			FileReader jsonFile = new FileReader("C:\\Users\\Student\\Desktop\\_workspace\\gamaData\\gameResult2.json");
//			BufferedReader br = new BufferedReader(jsonFile);
//
//			String jsonStr = br.readLine();
//			System.out.println(jsonStr);
//
//			// TypeFactory
//			ObjectMapper objectMapper = new ObjectMapper();
//			TypeFactory typeFactory = objectMapper.getTypeFactory();
//			CollectionType listType = typeFactory.constructCollectionType(List.class, Player.class);
//			List<Player> playerList = objectMapper.readValue(jsonStr, listType);
//			
//			for(Player player : playerList) {
//				System.out.println("玩家名稱: " + player.getUserName() + "    玩家得分: " + player.getUserScore());
//			}
//			
//			model.addAttribute("PlayerList", playerList);
//
//			
//			return "showAll";
//
//		}

	/*
	 * @ResponseBody
	 * 
	 * @GetMapping(path = "/query/findGameByMember") public void
	 * findGameByMember(@RequestParam String name, @RequestParam Integer
	 * check_status){ List<Member> aa = memberDao.findGameByMember(name,
	 * check_status);
	 * 
	 * Set<Game> game = null; for(int i = 0; i < aa.size(); i++) { game =
	 * aa.get(i).getGame(); } for(Game g : game) {
	 * System.out.println(g.getGame_type()); } }
	 * 
	 * @ResponseBody
	 * 
	 * @GetMapping(path = "/query/findCampaignByEmployee") public void
	 * findCampaignByEmployee() { List<Employee> employee =
	 * employeeDao.findCampaignByEmployee();
	 * 
	 * for(int i = 0; i < employee.size(); i++) { Set<Campaign> campaign =
	 * employee.get(i).getCampaign();
	 * 
	 * for(Campaign camp : campaign) { System.out.println(camp.getTitle()); } } }
	 */

	
	

}
