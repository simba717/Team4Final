package com.project.BonusPointExchangePlatform.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Credit_Card;

@Repository
public interface Credit_CardDao extends JpaRepository<Credit_Card, Integer> {
	
	
	

}
