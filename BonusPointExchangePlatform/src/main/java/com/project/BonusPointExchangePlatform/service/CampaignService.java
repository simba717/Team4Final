package com.project.BonusPointExchangePlatform.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.project.BonusPointExchangePlatform.dao.CampaignDao;
import com.project.BonusPointExchangePlatform.model.Campaign;

@Service
public class CampaignService {
	
	@Autowired
	private CampaignDao campaignDao;
	
	//查詢所有活動
		public List<Campaign> findAll(){
			return campaignDao.findAll();
		}
	
	//用id查詢活動
	public Optional<Campaign> findById(Integer id) {
		return campaignDao.findById(id);
	}
	
	
	
	//新增or更新活動
	public Campaign save(Campaign campaign) {
		return campaignDao.save(campaign);
	}
	
	//刪除活動
	public void deleteById(Integer id) {
		campaignDao.deleteById(id);
	}

	//查詢分頁
	public Page<Campaign> findAll(Pageable pageRequest) {
		return campaignDao.findAll(pageRequest);
	}

	// 用內容查詢活動
		// 回傳一筆資料
//		public Campaign findCampaignByContent(String content) {
//			return campaignDao.findCampaignByContent(content);
//		}

		// 回傳多筆資料
//		public List<Campaign> findCampaignByContent2(String content) {
//			return campaignDao.findCampaignByContent2(content);
//		}

		// 回傳多筆資料
		public List<Campaign> findCampaignByContent3(String content) {
			return campaignDao.findCampaignByContent3(content);
		}
		
		@Transactional
		public boolean deleteCampaignById(Integer id) {
			campaignDao.deleteCampaignById(id);
			return true;
		}
	
	

}
