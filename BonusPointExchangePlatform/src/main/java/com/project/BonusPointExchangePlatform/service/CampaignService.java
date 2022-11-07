package com.project.BonusPointExchangePlatform.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.project.BonusPointExchangePlatform.dao.CampaignDao;
import com.project.BonusPointExchangePlatform.dao.EmployeeDao;
import com.project.BonusPointExchangePlatform.dto.CampaignDto;
import com.project.BonusPointExchangePlatform.model.Campaign;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Product;

@Service
public class CampaignService {

	@Autowired
	private CampaignDao campaignDao;

	@Autowired
	private EmployeeDao employeeDao;

	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

	// 新增活動OK
	public void insert(Campaign campaign) {
		
		Date getDate = new Date();
		campaign.setButton_switch(true);
		campaign.setCreate_at(getDate);
		campaign.setUpdate_at(getDate);

		campaignDao.save(campaign);
	}

	// 刪除活動 ok
	public void delete(Integer id) {
		campaignDao.deleteById(id);
	}

	// 用id查詢活動 ok
	public Campaign findById(Integer id) {
		Optional<Campaign> myId = campaignDao.findById(id);

		if (myId.isPresent()) {
			return myId.get();
		}
		return null;
	}
//	public CampaignDto findById(Campaign Campaign){
//		System.out.println(employee_id);
//
//		Campaign campaign = campaignDao.findOneCampaignById(employee_id);
//		CampaignDto campaignDto = new CampaignDto();
//		
//		campaignDto.setCampaignName(campaign.getTitle());
//		campaignDto.setCampaignContent(campaign.getContent());
//		
//		String beginAt = dateFormat.format(campaign.getBegin_at());
//		campaignDto.setCampaignStart_at(beginAt);
//		String endAt = dateFormat.format(campaign.getEnd_at());
//		campaignDto.setCampaignEnd_at(endAt);
//		
//		String createAt = dateFormat.format(campaign.getCreate_at());
//		campaignDto.setCampaignUpdate_at(createAt);
//		String updateAt = dateFormat.format(campaign.getUpdate_at());
//		campaignDto.setCampaignUpdate_at(updateAt);
//		
//		campaignDto.setCampaignPhoto(campaign.getImage());
//		System.out.println(campaignDto.getCampaignStart_at());
//		return campaignDto;
//		
//	}


	// 更新活動OK
	public void update(
			String campaign_name, 
			String campaign_content, 
			String begin_at, 
			String end_at, 
			byte[] image,
			boolean button_switch, 
			Integer employee_id, 
			Integer id) {
				
			campaignDao.updateCampaignById(campaign_name, campaign_content, begin_at, end_at, image, button_switch,
					employee_id, id);
			}
	
	
	/* 更新商品 */
//		public void update(String product_name, String product_content, String product_type, Integer price,
//				Integer quantity, boolean button_switch, byte[] image, Integer id) {
//			Optional<Employee> optional = employeeDao.findById(2);
//			Employee employee_id = optional.get();
//			productDao.updateProductById(product_name, product_content, product_type, price, quantity, button_switch, image,
//					employee_id, id);
//		}	

	// 前台會員查詢所有活動 ok
	public List<CampaignDto> findMemberCampaigns() {
		List<Campaign> allCampaign = campaignDao.findMemberCampaigns();
		List<CampaignDto> allCampaignDto = new ArrayList<>();

		for (Campaign campaign : allCampaign) {
			CampaignDto campaignDto = new CampaignDto();
//			campaignDto.setCampaignId(campaign.getId());
			campaignDto.setCampaignName(campaign.getTitle());
			campaignDto.setCampaignPhoto(campaign.getImage());
			campaignDto.setCampaignContent(campaign.getContent());

			String beginAt = dateFormat1.format(campaign.getBegin_at());
			campaignDto.setCampaignStart_at(beginAt);
			String endAt = dateFormat1.format(campaign.getEnd_at());
			campaignDto.setCampaignEnd_at(endAt);

			String updateAt = dateFormat.format(campaign.getUpdate_at());
			campaignDto.setCampaignUpdate_at(updateAt);

			allCampaignDto.add(campaignDto);
		}
		return allCampaignDto;

	}

	// 後台員工查詢所有活動 OK
	public List<CampaignDto> findAllCampaign() {

		List<Campaign> allCampaign = campaignDao.findAllCampaign();
		List<CampaignDto> allCampaignDto = new ArrayList<>();

		for (Campaign campaign : allCampaign) {
			CampaignDto campaignDto = new CampaignDto();
			campaignDto.setEmployeeId(campaign.getEmployee().getId());
			campaignDto.setEmployeeName(campaign.getEmployee().getName());
			campaignDto.setEmployeeNo(campaign.getEmployee().getEmployee_no());
			campaignDto.setCampaignId(campaign.getId());
			campaignDto.setCampaignName(campaign.getTitle());
			campaignDto.setCampaignPhoto(campaign.getImage());
			campaignDto.setCampaignContent(campaign.getContent());

			// 活動開始和結束時間之後由員工手動修改
			String beginAt = dateFormat1.format(campaign.getBegin_at());
			campaignDto.setCampaignStart_at(beginAt);
			String endAt = dateFormat1.format(campaign.getEnd_at());
			campaignDto.setCampaignEnd_at(endAt);

			String createAt = dateFormat.format(campaign.getCreate_at());
			campaignDto.setCampaignCreat_at(createAt);
			String updateAt = dateFormat.format(campaign.getUpdate_at());
			campaignDto.setCampaignUpdate_at(updateAt);

			campaignDto.setCampaignStatus(campaign.getButton_switch());

			allCampaignDto.add(campaignDto);
		}
		return allCampaignDto;
	}

	// 查詢分頁
	public Page<Campaign> findAll(Pageable pageRequest) {
		return campaignDao.findAll(pageRequest);
	}

	// 用內容查詢活動
//		public List<Campaign> findCampaignByContent3(String content) {
//			return campaignDao.findCampaignByContent3(content);
//		}

}
