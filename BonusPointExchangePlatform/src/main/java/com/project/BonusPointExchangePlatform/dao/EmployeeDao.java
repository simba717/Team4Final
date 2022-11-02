package com.project.BonusPointExchangePlatform.dao;

import java.time.LocalDate;
import java.util.List;

import javax.transaction.Transactional;
import javax.xml.crypto.Data;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Member;

@Repository
public interface EmployeeDao extends JpaRepository<Employee, Integer> {
	
	@Query(value = "select * from Employee e "
			+ "join Campaign c on c.employee_id = e.id", nativeQuery = true)
	List<Employee> findCampaignByEmployee();
	
	@Query(value="select * from Employee where id = :id ",nativeQuery = true)
	Employee findOneEmployeebyId(@Param(value="id")int id);
	
	@Modifying
	@Transactional
	@Query(value="update Employee set name = :name, employee_no = :employee_no , arrived_at = :arrived_at, phone = :phone , email = :email , update_at = getdate(),image=:image where id = :id ",nativeQuery = true)
	void editBacknedEmployeeDetail(@Param(value="name")String name, @Param(value="employee_no")int employee_no,@Param(value="arrived_at")LocalDate arrived_at,@Param(value="phone")String phone,@Param(value="email")String email,@Param(value="image")byte[] image,@Param(value="id")Integer id);
	
	@Modifying
	@Transactional
	@Query(value="update Employee set name = :name, arrived_at= :arrived_at , employee_no= :employee_no , email= :email, phone=:phone , update_at = getdate(),image=:image where id = :id  ",nativeQuery = true)
	void editEmployeeDetail(@Param(value="name")String name, @Param(value="arrived_at") String arrived,@Param(value="employee_no")int employee_no,@Param(value="email")String email,@Param(value="phone")String phone,@Param(value="image")byte[] image,@Param(value="id")Integer id );
	
	
}
