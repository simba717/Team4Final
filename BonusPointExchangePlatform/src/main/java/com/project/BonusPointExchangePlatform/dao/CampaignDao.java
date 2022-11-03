package com.project.BonusPointExchangePlatform.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Campaign;

@Repository
public interface CampaignDao extends JpaRepository<Campaign, Integer> {
	
	
//////////////瑋煊的頭//////////////////
// 第一種寫法 ? (跨資料庫)
// 回傳一筆資料
//@Query(value = "from Campaign where content like %?%1")
//Campaign findCampaignByContent(String content);

// 第二種寫法 HQL的@Param (跨資料庫), 操作的屬性是Entity的欄位
// 回傳多筆資料
//@Query(value = "from Campaign where content like %:content%")
//List<Campaign> findCampaignByContent2(@Param("content") String content);

// 第三種寫法 原生SQL(沒有跟Hibernate做mapping, 不能跨資料庫), 操作的屬性是資料庫Table的欄位

//查詢所有會員活動: 
//@Query(value = "select * from Campaign", nativeQuery = true)
//List<Campaign> findCampaignByContent3(@Param("content") String content);
//


// 回傳多筆資料
@Query(value = "select * from Campaign where content like %:content%", nativeQuery = true)
List<Campaign> findCampaignByContent3(@Param("content") String content);

// 查詢並修改或刪除資料 @Modifying
@Modifying
@Query(value = "delete from Campaign where id = :id", nativeQuery = true)
void deleteCampaignById(@Param("id") Integer id);

//跨資料表模糊查詢

//////////////瑋煊的腳/////////////////////	

}
