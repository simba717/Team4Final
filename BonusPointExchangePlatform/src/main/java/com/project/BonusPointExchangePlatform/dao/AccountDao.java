package com.project.BonusPointExchangePlatform.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.project.BonusPointExchangePlatform.model.Account;

@Repository
public interface AccountDao extends JpaRepository<Account, Integer> {
	
	@Query(value = "select * from Account "
			+ "where account = :account and password = :password ", nativeQuery = true)
	Account checkAccount(@Param(value = "account") String acc, @Param(value = "password") String pwd);
	
	
	

	@Query(value = "select * from Account "
			+ "where account = :account ", nativeQuery = true)
	Account checkAccountByAcc(@Param(value = "account") String acc);
	
	@Query(value = "select * from Account "
			+ "where account = :account and password = :password and (account_type= 2 or account_type= 3 )", nativeQuery = true)
	Account checkAccountEmp(@Param(value = "account") String acc, @Param(value = "password") String pwd);
	
	@Query(value = "select * from Account "
			+ "where account = :account and password = :password and account_type= 1 ", nativeQuery = true)
	Account checkAccountMember(@Param(value = "account") String acc, @Param(value = "password") String pwd);
	
	
	@Query(value = "select * from Account "
			+ "where account = :account  and account_type= 1 ", nativeQuery = true)
	Account checkPwdByAcc(@Param(value = "account") String acc);
	
	@Query(value ="select a.* from Member m "
			+ "join account a on m.id = a.member_id "
			+ "where m.id = :id " , nativeQuery = true)
	Account showMemberById(@Param(value="id") Integer id); 
	
	@Modifying 
	@Transactional
	@Query(value="update Account set password = :password , update_at = getdate() where member_id = :id ",nativeQuery = true)
	void editAccountDetail(@Param(value="password") String password ,@Param(value="id") Integer id);
	
	@Modifying 
	@Transactional
	@Query(value="update Account set password = :password , update_at = getdate() where employee_id = :id ",nativeQuery = true)
	void editAccountDetailByEmployee(@Param(value="password") String password ,@Param(value="id") Integer id);
	
	@Query(value = "select * from Account a "
			+ "join Member m on m.id = a.member_id "
			+ "where a.account = :account  and m.email= :email", nativeQuery = true)
	Account checkAccountByemail(@Param(value = "account") String acc,@Param(value="email") String email);
	
	@Query(value = "select * from Account a "
			+ "join Employee e on e.id = a.employee_id "
			+ "where a.account = :account  and e.email= :email", nativeQuery = true)
	Account checkAccountByemailEmp(@Param(value = "account") String acc,@Param(value="email") String email);
	
	@Modifying 
	@Transactional
	@Query(value = "update Account set password = :password , update_at = getdate() where check_code = :checkcode ", nativeQuery = true)
	void updatePwdByCheckcode(@Param(value = "checkcode") String checkcode, @Param(value = "password") String pwd);
	
	@Query(value = "select * from Account  " + "where check_code = :checkcode  ", nativeQuery = true)
	Account checkCheckCode(@Param(value = "checkcode") String checkcode);
	
	@Query(value = "select a.* from Member m " 
			+ "join account a on m.id = a.member_id " 
			+" where a.account_type in(1 , 0) order by m.update_at DESC " , nativeQuery = true)
	List<Account> getAccountTypeByDESC();
	
	@Query(value = "select a.* from Member m " 
			+ "join account a on m.id = a.member_id " 
			+" where a.account_type in(1 , 0) order by m.update_at ASC " , nativeQuery = true)
	List<Account> getAccountTypeByASC();
	
	@Query(value = "select a.* from Member m " 
			+ "join account a on m.id = a.member_id " 
			+" where a.account_type in(1 , 0) and m.name like :name order by m.update_at ASC" , nativeQuery = true)
	List<Account> getAccountTypeSearchByASC(@Param(value="name") String name );
	
	@Query(value = "select a.* from Member m " 
			+ "join account a on m.id = a.member_id " 
			+" where a.account_type in(1 , 0) and m.name like :name order by m.update_at DESC" , nativeQuery = true)
	List<Account> getAccountTypeSearchByDESC(@Param(value="name") String name );
	
	@Modifying 
	@Transactional
	@Query(value="update Account set account_type = :type where member_id = :id",nativeQuery = true)
	void restorepermission(@Param(value="id") Integer id ,@Param(value="type") Integer newtype);
	
	
	@Query(value = "select a.* from Employee e " 
			+ "join account a on e.id = a.employee_id " 
			+" where a.account_type in(2 , 0) order by e.update_at DESC " , nativeQuery = true)
	List<Account> getAccountTypefromEmployeeByDESC();
	
	@Query(value = "select a.* from Employee e " 
			+ "join account a on e.id = a.employee_id " 
			+" where a.account_type in(2 , 0) order by e.update_at ASC " , nativeQuery = true)
	List<Account> getAccountTypefromEmployeeByASC();
	
	
	@Query(value = "select a.* from Employee e " 
			+ "join account a on e.id = a.employee_id " 
			+" where a.account_type in(2 , 0) and e.name like :name order by e.update_at ASC" , nativeQuery = true)
	List<Account> getAccountTypeSearchfromEmployeeByASC(@Param(value="name") String name );
	
	@Query(value = "select a.* from Employee e " 
			+ "join account a on e.id = a.employee_id " 
			+" where a.account_type in(2 , 0) and e.name like :name order by e.update_at DESC" , nativeQuery = true)
	List<Account> getAccountTypeSearchfromEmployeeByDESC(@Param(value="name") String name );
	
	
	@Modifying 
	@Transactional
	@Query(value="update Account set account_type = :type where employee_id = :id",nativeQuery = true)
	void employeerestorepermission(@Param(value="id") Integer id ,@Param(value="type") Integer newtype);
	
	@Query(value ="select a.*,e.* from Employee e "
			+ "join account a on e.id = a.employee_id "
			+ "where e.id= :id " , nativeQuery = true)
	Account showEmployeeById(@Param(value="id") Integer id); 
		
}
