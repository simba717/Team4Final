package com.project.BonusPointExchangePlatform.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Message;

@Repository
public interface MessageDao extends JpaRepository<Message, Integer> {
	
	
	

}
