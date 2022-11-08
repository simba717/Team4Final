package com.project.BonusPointExchangePlatform.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.project.BonusPointExchangePlatform.model.Campaign;
import com.project.BonusPointExchangePlatform.model.Employee;

@Repository
public interface CampaignDao extends JpaRepository<Campaign, Integer> {

//////////////瑋煊的頭//////////////////
//前台會員查詢所有活動	OK
	@Query(value = "select * from Campaign c " + "	join Employee e " + "	on c.employee_id = e.id "
			+ " where button_switch = 1 order by c.update_at DESC", nativeQuery = true)
	List<Campaign> findMemberCampaigns();

//後台員工查詢所有活動(圖片 名稱 內容 開始和結束時間 上下架狀態 新增和修改時間 員工ID + 編輯的"員工編號")OK
	@Query(value = "select * from Campaign c " + "	join Employee e "
			+ "	on c.employee_id = e.id order by c.update_at DESC", nativeQuery = true)
	List<Campaign> findAllCampaign();
	
//查詢單一活動ByID(圖片 名稱 內容 開始和結束時間 上下架狀態 新增和修改時間 員工ID + 編輯的"員工編號")OK
//		@Query(value = "select * from Campaign "
//				+ " where employee_id = :employee_id ", nativeQuery = true)
//		Campaign findOneCampaignById(@Param(value = "employee_id") Integer id);
	
	
//跨資料表模糊查詢
//要登入員工帳號才有ID
//更新活動 Param的值是DB表單欄位名稱 對應的值是前端表單的name屬性
	@Transactional
	@Modifying
	@Query(value = "update Campaign set "
			+ " title = :title,"
			+ " content = :content, "
			+ " begin_at = :begin_at, "
			+ " end_at = :end_at, "
			+ " image = :image, "
			+ " button_switch = :button_switch, "
			+ " employee_id = :employee_id, "
			+ " update_at = getdate() "
			+ " where id = :id ", nativeQuery = true)
	void updateCampaignById(
			@Param(value = "title") String title, 
			@Param(value = "content") String content, 
			@Param(value = "begin_at") String begin_at, 
			@Param(value = "end_at") String end_at, 
			@Param(value = "image") byte[] image,
			@Param(value = "button_switch") boolean button_switch, 
			@Param(value = "employee_id") Integer employee_id, 
			@Param(value = "id") Integer id);



//////////////瑋煊的腳/////////////////////	

}
