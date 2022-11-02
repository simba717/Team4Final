package com.project.BonusPointExchangePlatform.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Campaign;

@Repository
public interface CampaignDao extends JpaRepository<Campaign, Integer> {
	
	
	

}
