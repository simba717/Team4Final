package com.project.BonusPointExchangePlatform.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.dao.EmployeeDao;
import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.dto.CampaignDto;
import com.project.BonusPointExchangePlatform.dto.GameDto;
import com.project.BonusPointExchangePlatform.dto.ProductDto;
import com.project.BonusPointExchangePlatform.model.Campaign;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Product;
import com.project.BonusPointExchangePlatform.service.CampaignService;

@Controller
public class CampaignController {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private EmployeeDao employeeDao;

	@Autowired
	private CampaignService campaignService;
	
	private SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

///////////////////////瑋煊的頭///////////////////////////////

	//控制上下架按鈕OK
	
	@GetMapping(value = "/campaign/control")
	public String switchControl(@RequestParam Integer id, @RequestParam boolean button_switch, HttpSession session) {
		Campaign campaign = campaignService.findById(id);
		
		Employee sessionemployee =(Employee)session.getAttribute("employee");
		
		campaignService.update(
				campaign.getTitle(), 
				campaign.getContent(),
				dateFormat1.format(campaign.getBegin_at()),
				dateFormat1.format(campaign.getEnd_at()),
				campaign.getImage(),
				button_switch, 
				sessionemployee.getId(),
				id);
		return "redirect:/campaign/findAll";
	}
	
	
	// 新增活動OK
	@PostMapping(path = "/campaign/insert", produces = "application/json; charset=UTF-8 ")
	public void insert(@RequestBody CampaignDto campaignDto, HttpSession session) {
		campaignDto.convertImage();
		Campaign campaign = new Campaign();
		campaign.setTitle(campaignDto.getCampaignName());
		campaign.setContent(campaignDto.getCampaignContent());
		
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(campaignDto.getCampaignStart_at());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		campaign.setBegin_at(date);
		
		Date date2 = null;
		try {
			date2 = new SimpleDateFormat("yyyy-MM-dd").parse(campaignDto.getCampaignEnd_at());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		campaign.setEnd_at(date2);
		
		campaign.setEmployee((Employee)session.getAttribute("employee"));
		System.out.println("+++++++++++++" + (Employee)session.getAttribute("employee"));
		campaign.setImage(campaignDto.convertImage());
		campaignService.insert(campaign);
	}
		
	// 刪除活動ok
	@GetMapping("/campaign/delete")
	public String deleteCampaign(@RequestParam Integer id) {
		campaignService.delete(id);
		return "redirect:/campaign/findAll";
	}

	 //取得圖片OK
	@GetMapping("/getCampaignImage")
	public ResponseEntity<byte[]> getCampaignImage(@RequestParam("id") Integer id) {
		Campaign campaign = campaignService.findById(id);
		byte[] image = campaign.getImage();
		return new ResponseEntity<byte[]>(image, HttpStatus.OK);
	}

	// 編輯活動1 OK
	@PostMapping(path = "/campaigns", produces = { "application/json; charset=UTF-8" })
	@ResponseBody
	public CampaignDto editCampaign(@RequestBody Campaign campaign) {
		Campaign result = campaignService.findById(campaign.getId());
		CampaignDto campaignDto = new CampaignDto();
		campaignDto.setCampaignName(result.getTitle());
		campaignDto.setCampaignContent(result.getContent());
		String beginAt = dateFormat1.format(result.getBegin_at());
		campaignDto.setCampaignStart_at(beginAt);
		String endAt = dateFormat1.format(result.getEnd_at());
		campaignDto.setCampaignEnd_at(endAt);
		campaignDto.setCampaignPhoto(result.getImage());
		System.out.println(campaignDto.getCampaignStart_at());
		
		return campaignDto;
		
	}
	
//編輯活動2 OK
	@PutMapping(value = "/campaigns/{id}", consumes = { "application/json" }, produces = {
	"application/json; charset=UTF-8" })
@ResponseBody
public Map<String, String> updateCampaign(@RequestBody CampaignDto campaignDto,
	@PathVariable Integer id, HttpSession session) {
Map<String, String> map = new HashMap<>();
Employee employee = (Employee)session.getAttribute("employee");

try {
	// 沒有要更新圖片的話
	if (campaignDto.getFileDataUrl() == null) {
//		Campaign campaign = campaignService.findById(id);
		campaignService.update(
				campaignDto.getCampaignName(), 
				campaignDto.getCampaignContent(),
				campaignDto.getCampaignStart_at(), 
				campaignDto.getCampaignEnd_at(),
				campaignDto.convertImage(), 
				campaignDto.getCampaignStatus(), 
				employee.getId(),
				id);

		// 有要更新圖片的話
	} else {
		Campaign campaign = campaignService.findById(id);
		campaignDto.convertImage();
		System.out.println("+++++++++++++++++++++++++");
		campaignService.update(campaignDto.getCampaignName(), 
				campaignDto.getCampaignContent(),
				campaignDto.getCampaignStart_at(), 
				campaignDto.getCampaignEnd_at(),
				campaignDto.convertImage(),
				campaignDto.getCampaignStatus(), 
				employee.getId(),
				id);

	}
	map.put("success", "更新成功");

} catch (Exception e) {
	e.printStackTrace();
	map.put("fail", "更新失敗");
}
return map;
}
	
	
	
	
//	

	// 後台員工查詢所有活動 navbar連結JSP OK
	@GetMapping("/campaign/findAll")
	public String findAllCampaigns() {

		return "/backend/campaign/memberCampaigns";
	}

	// 後台員工查詢所有活動 OK
	@GetMapping("/backend/campaign/getCampaigns")
	@ResponseBody
	public List<CampaignDto> getCampaigns() {
		List<CampaignDto> allCampaign = campaignService.findAllCampaign();

		return allCampaign;

	}

	// 前台會員查詢所有活動 navbar連結JSP OK
	@GetMapping("/frontend/campaign/findAll")
	public String memberFindAllCampaigns() {

		return "/frontend/campaign/showAllCampaigns";
	}

	// 前台會員查詢所有活動 OK
	@GetMapping("/frontend/campaign/getCampaigns")
	@ResponseBody
	public List<CampaignDto> getMemberCampaigns() {
		List<CampaignDto> allCampaign = campaignService.findMemberCampaigns();

		return allCampaign;

	}

	//雙十一紅利加倍活動
		@GetMapping("/campaign/bonusCampaign")
		public String double11() {
			return "/frontend/campaign/bonusCampaign";
		}

////////////////////////瑋煊的腳//////////////////////////////////

	

//	// 用id查詢活動
//	@GetMapping("/campaigns/{id}")
//	public Optional<Campaign> readById(@PathVariable Integer id) {
//		return campaignService.findById(id);
//	}


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
//	@ResponseBody
//	@GetMapping("/campaigns/content3")
//	public List<Campaign> findCampaignByContent3(String content) {
//		return campaignService.findCampaignByContent3(content);
//	}


// 取得玩家ID
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
