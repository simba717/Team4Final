package com.project.BonusPointExchangePlatform.dto;

import java.io.Serializable;
import java.util.Base64;
import com.project.BonusPointExchangePlatform.model.Campaign;
import com.project.BonusPointExchangePlatform.model.Employee;

public class CampaignDto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer employeeId;
	
	private String employeeName;
	
	
	
	private int campaignId;
	
	private byte[] campaignPhoto;
	
	private String campaignName;
	
	private String campaignContent;
	
	private String campaignStart_at;
	
	private String campaignEnd_at;
	
	private Integer employeeNo;
	
	private String campaignCreat_at;
	
	private String campaignUpdate_at;

	private boolean campaignStatus;
	
	private String fileDataUrl;
	
//	private String employee_name;
	
	private Campaign campaign;
	
	private Employee employee;
	
	public CampaignDto() {
		
	}
	
	public CampaignDto(Campaign campaign) {
		this.campaign = campaign;
//		this.employee_name = campaign.getEmployee().getName();
//		this.employee_no = campaign.getEmployee().getEmployee_no();

	}

	public CampaignDto(Integer employeeId, String employeeName, int campaignId, byte[] campaignPhoto,
			String campaignName, String campaignContent, String campaignStart_at, String campaignEnd_at,
			String campaignCreat_at, String campaignUpdate_at, boolean campaignStatus) {
		this.employeeId = employeeId;
		this.employeeName = employeeName;
		this.campaignId = campaignId;
		this.campaignPhoto = campaignPhoto;
		this.campaignName = campaignName;
		this.campaignContent = campaignContent;
		this.campaignStart_at = campaignStart_at;
		this.campaignEnd_at = campaignEnd_at;
		this.campaignCreat_at = campaignCreat_at;
		this.campaignUpdate_at = campaignUpdate_at;
		this.campaignStatus = campaignStatus;
	}




	public Integer getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public int getCampaignId() {
		return campaignId;
	}

	public void setCampaignId(int campaignId) {
		this.campaignId = campaignId;
	}

	public byte[] getCampaignPhoto() {
		return campaignPhoto;
	}

	public void setCampaignPhoto(byte[] campaignPhoto) {
		this.campaignPhoto = campaignPhoto;
	}

	public String getCampaignName() {
		return campaignName;
	}

	public void setCampaignName(String campaignName) {
		this.campaignName = campaignName;
	}

	public String getCampaignContent() {
		return campaignContent;
	}

	public void setCampaignContent(String campaignContent) {
		this.campaignContent = campaignContent;
	}

	public String getCampaignStart_at() {
		return campaignStart_at;
	}

	public void setCampaignStart_at(String campaignStart_at) {
		this.campaignStart_at = campaignStart_at;
	}

	public String getCampaignEnd_at() {
		return campaignEnd_at;
	}

	public void setCampaignEnd_at(String campaignEnd_at) {
		this.campaignEnd_at = campaignEnd_at;
	}

	public String getCampaignCreat_at() {
		return campaignCreat_at;
	}

	public void setCampaignCreat_at(String campaignCreat_at) {
		this.campaignCreat_at = campaignCreat_at;
	}

	public String getCampaignUpdate_at() {
		return campaignUpdate_at;
	}

	public void setCampaignUpdate_at(String campaignUpdate_at) {
		this.campaignUpdate_at = campaignUpdate_at;
	}

	public boolean getCampaignStatus() {
		return campaignStatus;
	}

	public void setCampaignStatus(boolean campaignStatus) {
		this.campaignStatus = campaignStatus;
	}

	public String getFileDataUrl() {
		return fileDataUrl;
	}

	public void setFileDataUrl(String fileDataUrl) {
		this.fileDataUrl = fileDataUrl;
	}

//	public String getEmployee_name() {
//		return employee_name;
//	}
//
//	public void setEmployee_name(String employee_name) {
//		this.employee_name = employee_name;
//	}

	public Campaign getCampaign() {
		return campaign;
	}

	public void setCampaign(Campaign campaign) {
		this.campaign = campaign;
	}
	
	public byte[] convertImage() {
		String base64 = fileDataUrl.substring(fileDataUrl.indexOf(",") + 1);
	    byte[] a = Base64.getMimeDecoder().decode(base64);
	    return a;
	}

	public Integer getEmployeeNo() {
		return employeeNo;
	}

	public void setEmployeeNo(Integer employeeNo) {
		this.employeeNo = employeeNo;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

//	public void employeeNo(Integer employee_no) {
//		// TODO Auto-generated method stub
//		
//	}
	
	
}
