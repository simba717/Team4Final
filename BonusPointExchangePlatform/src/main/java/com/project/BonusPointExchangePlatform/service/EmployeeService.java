package com.project.BonusPointExchangePlatform.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.BonusPointExchangePlatform.dao.AccountDao;
import com.project.BonusPointExchangePlatform.dao.BankDao;
import com.project.BonusPointExchangePlatform.dao.EmployeeDao;
import com.project.BonusPointExchangePlatform.dto.EmployeeDto;
import com.project.BonusPointExchangePlatform.dto.MemberDto;
import com.project.BonusPointExchangePlatform.dto.WalletDto;
import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Bank;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Wallet;

@Service
@Transactional
public class EmployeeService {
	
	@Autowired
	private EmployeeDao eDao;
	
	@Autowired
	private AccountDao aDao;
	
	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	
	public List<EmployeeDto> getAllEmployee(String orderby){
		
		List<Account> type;
		System.out.println(orderby);
		if(orderby!=null&&orderby.equals("ASC")) {
			type = aDao.getAccountTypefromEmployeeByASC();
		}else {
			type = aDao.getAccountTypefromEmployeeByDESC();
		}
		
		System.out.println(type);
			
		List<EmployeeDto> employeeDto = new ArrayList<EmployeeDto>();
		if (type != null) {
			for (Account X : type) {
				EmployeeDto Employee = new EmployeeDto();
				Employee.setAccount_type(X.getAccount_type());
				Employee.setEmployee(X.getEmployee());
				Employee.setArrived_date(DateFormat.format(X.getEmployee().getArrived_at()));
				Employee.setCreate_date(DateTimeFormat.format(X.getEmployee().getCreate_at()));
				Employee.setUpdate_date(DateTimeFormat.format(X.getEmployee().getUpdate_at()));
				employeeDto.add(Employee);
			}
			System.out.println(employeeDto);

			return employeeDto;

		} else
			return null;
		
	}
	
	
	
	public List<EmployeeDto> getAllEmployeeSearch(String name , String orderby) {
		
		List<EmployeeDto> employeeDto = new ArrayList<EmployeeDto>();
		if (name != " ") {
			
			List<Account> type;
			System.out.println(orderby);
			if(orderby!=null&&orderby.equals("ASC")) {
				type = aDao.getAccountTypeSearchfromEmployeeByASC("%" + name + "%");
			}else {
				type = aDao.getAccountTypeSearchfromEmployeeByDESC("%" + name + "%");
			}
			
			for (Account X : type) {
				EmployeeDto employee = new EmployeeDto();
				employee.setAccount_type(X.getAccount_type());
				employee.setEmployee(X.getEmployee());
				employee.setArrived_date(DateFormat.format(X.getEmployee().getArrived_at()));
				employee.setCreate_date(DateTimeFormat.format(X.getEmployee().getCreate_at()));
				employee.setUpdate_date(DateTimeFormat.format(X.getEmployee().getUpdate_at()));
				employeeDto.add(employee);
			}
			System.out.println(employeeDto);
			
		}else{
			List<Account> type1;
			System.out.println(orderby);
			if(orderby!=null&&orderby.equals("ASC")) {
				type1 = aDao.getAccountTypeSearchfromEmployeeByASC("%" + name + "%");
			}else {
				type1 = aDao.getAccountTypeSearchfromEmployeeByDESC("%" + name + "%");
			}

			if (type1 != null) {
				for (Account X : type1) {
					EmployeeDto employee = new EmployeeDto();
					employee.setAccount_type(X.getAccount_type());
					employee.setEmployee(X.getEmployee());
					employee.setArrived_date(DateFormat.format(X.getEmployee().getArrived_at()));
					employee.setCreate_date(DateTimeFormat.format(X.getEmployee().getCreate_at()));
					employee.setUpdate_date(DateTimeFormat.format(X.getEmployee().getUpdate_at()));
					employeeDto.add(employee);
				}
				System.out.println(employeeDto);

				
			}
		}
		if(employeeDto!=null) {
		return employeeDto;
		}else
			return null;
	}
	
	
	
	public List<EmployeeDto> employeerestorepermission(int id , int newtype , String orderby) {
		System.out.println(id);
		System.out.println(newtype);
		aDao.employeerestorepermission(id,newtype);
		
		List<Account> all ;
		System.out.println(orderby);
		if(orderby!=null&&orderby.equals("ASC")) {
			all = aDao.getAccountTypefromEmployeeByASC();
		}else {
			all = aDao.getAccountTypefromEmployeeByDESC();
		}
		
		System.out.println(all);

		List<EmployeeDto> employeeDto = new ArrayList<EmployeeDto>();
		if (all != null) {
			for (Account X : all) {
				EmployeeDto Employee = new EmployeeDto();
				Employee.setAccount_type(X.getAccount_type());
				Employee.setEmployee(X.getEmployee());
				Employee.setArrived_date(DateFormat.format(X.getEmployee().getArrived_at()));
				Employee.setCreate_date(DateTimeFormat.format(X.getEmployee().getCreate_at()));
				Employee.setUpdate_date(DateTimeFormat.format(X.getEmployee().getUpdate_at()));
				employeeDto.add(Employee);
			}
			

			return employeeDto;

		} else
			return null;

	}
	
	public EmployeeDto findoneEmployeebyId(int id) {
		System.out.println(123);
		Employee employee = eDao.findOneEmployeebyId(id);
		EmployeeDto Employee = new EmployeeDto();
		Employee.setEmployee(employee);
		Employee.setArrived_date(DateFormat.format(employee.getArrived_at()));
		Employee.setCreate_date(DateTimeFormat.format(employee.getCreate_at()));
		Employee.setUpdate_date(DateTimeFormat.format(employee.getUpdate_at()));
		return Employee;
	}
	
	
	public void editBacknedEmployeeDetail(String name, int employee_no, LocalDate arrived_at, String phone, String email,
			byte[] image, Integer id ) {
		
		
		eDao.editBacknedEmployeeDetail(name, employee_no , arrived_at,phone, email ,image, id);

	}
	
	public Account showEmployeeById(Integer id) {
		aDao.showEmployeeById(id);
		System.out.println(123);

		if (aDao.showEmployeeById(id) != null) {
			return aDao.showEmployeeById(id);
		} else
			return null;
	}
	
	public Map<String, Object> editEmployeeDetail(String name, String arrived, int employee_no, String email,String phone, String password, byte[] image2, int id) {
		Map<String, Object> map = new HashMap<>();
		eDao.editEmployeeDetail(name, arrived,employee_no,email, phone, image2, id);
		System.out.println(123);
		aDao.editAccountDetail(password, id);
		System.out.println(456);
		Employee employee = eDao.findById(id).get();
		Account a = aDao.findById(id).get();
		map.put("Employee", employee);
		map.put("Account", a);

		return map;
	}

	
	
}


//	/*根據銀行帳號找ID*/
//	public Bank findIdByAccountNo(String account_no) {
//		return bankDao.findIdByAccountNo(account_no);
//	}


