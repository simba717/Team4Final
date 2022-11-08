package com.project.BonusPointExchangePlatform.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Product;

@Repository
public interface ProductDao extends JpaRepository<Product, Integer> {

	@Query(value = "select * from product order by update_at desc", nativeQuery = true)
	List<Product> findAllProduct();

	@Query(value = "select * from product where product_name = :product_name ", nativeQuery = true)
	Product findByProductName(@Param(value = "product_name") String product_name);

	@Transactional
	@Modifying
	@Query(value = "update product set product_name = :product_name, product_content = :product_content, product_type = :product_type, price = :price, quantity = :quantity, button_switch =:button_switch, image = :image, employee_id = :employee_id, update_at = getdate() "
			+ "where id = :id ", nativeQuery = true)
	void updateProductById(@Param(value = "product_name") String product_name,
			@Param(value = "product_content") String product_content,
			@Param(value = "product_type") String product_type, @Param(value = "price") Integer price,
			@Param(value = "quantity") Integer quantity, @Param(value = "button_switch") boolean button_switch,
			@Param(value = "image") byte[] image, @Param(value = "employee_id") Employee employee_id,
			@Param(value = "id") Integer id);

	@Transactional
	@Modifying
	@Query(value = "update product set button_switch =:button_switch " + "where id = :id ", nativeQuery = true)
	void updateButtonBycheck(@Param(value = "button_switch") boolean button_switch, @Param(value = "id") Integer id);

	@Query(value = "select * from product where product_name like :search or product_content like :search or product_type like :search order by update_at desc", nativeQuery = true)
	List<Product> search(@Param(value = "search") String search);

	@Query(value = "select * from product where button_switch = 1 order by update_at desc ", nativeQuery = true)
	List<Product> findAllBySwitchOn();

	@Transactional
	@Modifying
	@Query(value = "update product set best_seller = :best_seller "
			+ "where product_name = :product_name ", nativeQuery = true)
	void updateQuantity(@Param(value = "product_name") String product_name,
			@Param(value = "best_seller") Integer best_seller);

	@Transactional
	@Modifying
	@Query(value = "update product set best_seller = :best_seller , update_at = getdate()"
			+ "where product_name = :product_name ", nativeQuery = true)
	void updateLastQuantity(@Param(value = "product_name") String product_name,
			@Param(value = "best_seller") Integer best_seller);

    //Ray
	@Query(value = "select * from Product where product_type = '食品'", nativeQuery = true)
	List<Product> searchgroup1();

	@Query(value = "select * from Product where product_type = '運動用品'", nativeQuery = true)
	List<Product> searchgroup2();

	@Query(value = "select * from Product where product_type = '家庭用品'", nativeQuery = true)
	List<Product> searchgroup3();

	@Query(value = "select * from Product where product_type = '其他種類'", nativeQuery = true)
	List<Product> searchgroup4();

	@Query(value = "select * from Product where DateDiff(dd,create_at,getdate())<=7 and product_type = '食品'", nativeQuery = true)
	List<Product> day7group1();

	@Query(value = "select * from Product where DateDiff(dd,create_at,getdate())<=7 and product_type = '運動用品'", nativeQuery = true)
	List<Product> day7group2();

	@Query(value = "select * from Product where DateDiff(dd,create_at,getdate())<=7 and product_type = '家庭用品'", nativeQuery = true)
	List<Product> day7group3();

	@Query(value = "select * from Product where DateDiff(dd,create_at,getdate())<=7 and product_type = '其他種類'", nativeQuery = true)
	List<Product> day7group4();

	@Query(value = "select * from Product where DateDiff(mm,create_at,getdate())=0 and product_type = '食品'", nativeQuery = true)
	List<Product> monthgroup1();

	@Query(value = "select * from Product where DateDiff(mm,create_at,getdate())=0 and product_type = '運動用品'", nativeQuery = true)
	List<Product> monthgroup2();

	@Query(value = "select * from Product where DateDiff(mm,create_at,getdate())=0 and product_type = '家庭用品'", nativeQuery = true)
	List<Product> monthgroup3();

	@Query(value = "select * from Product where DateDiff(mm,create_at,getdate())=0 and product_type = '其他種類'", nativeQuery = true)
	List<Product> monthgroup4();
///////////////////////////////////////////////////////////////////////////////////////////////
}
