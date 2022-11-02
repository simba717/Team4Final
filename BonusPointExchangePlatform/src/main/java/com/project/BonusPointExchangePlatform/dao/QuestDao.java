package com.project.BonusPointExchangePlatform.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Quest;

@Repository
public interface QuestDao extends JpaRepository<Quest, Integer> {

}
