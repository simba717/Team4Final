package com.project.BonusPointExchangePlatform.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.project.BonusPointExchangePlatform.dao.ProductDao;
import com.project.BonusPointExchangePlatform.dto.ProductDto;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Product;

@Service
public class ProductService {

	@Autowired
	private ProductDao productDao;

	/* 查詢商品 */
	public Product findById(Integer id) {
		Optional<Product> optional = productDao.findById(id);

		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	/* 查詢所有商品 */
	public List<ProductDto> findAll() {
		List<Product> products = productDao.findAllProduct();
		List<ProductDto> productDto = new ArrayList<>();

		for (Product p : products) {
			ProductDto dto = new ProductDto(p);
			if (dto.getProduct().getBest_seller() == dto.getProduct().getQuantity()) {
				productDao.updateButtonBycheck(false, dto.getProduct().getId());
				dto.getProduct().setButton_switch(false);
			}
			productDto.add(dto);
		}
		return productDto;
	}

	/* 查詢所有商品頁數 */
	public Page<Product> findByPage(Integer pageNum) {
		Pageable pgb = PageRequest.of(pageNum - 1, 5, Sort.Direction.DESC, "updateDate");
		Page<Product> page = productDao.findAll(pgb);
		return page;
	}

	/* 模糊查詢 */
	public List<ProductDto> search(String search) {
		List<Product> products = productDao.search("%" + search + "%");
		List<ProductDto> productDto = new ArrayList<>();

		for (Product p : products) {
			ProductDto dto = new ProductDto(p);
			productDto.add(dto);
		}
		return productDto;
	}

	/* 新增單筆商品 */
	public void insert(Product product, Employee employee) {
		Date getDate = new Date();
		product.setEmployee(employee);
		product.setBest_seller(0);
		product.setButton_switch(true);
		product.setCreate_at(getDate);
		product.setUpdateDate(getDate);
		productDao.save(product);
	}

	/* 更新商品 */
	public void update(String product_name, String product_content, String product_type, Integer price,
			Integer quantity, boolean button_switch, byte[] image, Integer id, Employee employee) {		
		productDao.updateProductById(product_name, product_content, product_type, price, quantity, button_switch, image,
				employee, id);
	}

	/* 刪除商品 */
	public void delete(Integer id) {
		productDao.deleteById(id);
	}

	/* 查詢上架商品 */
	public List<Product> findAllFrontend() {
		findAll();
		List<Product> products = productDao.findAllBySwitchOn();
		return products;
	}

	/* 用商品名查詢上架商品 */
	public Product findByProductName(String product_name) {
		return productDao.findByProductName(product_name);
	}

	/* 修改熱銷數 */
	public void updateLastQuantity(String product_name, Integer best_seller) {
		productDao.updateLastQuantity(product_name, best_seller);
	}

	// Ray
	/* group食品 */
	public List<Product> searchgroup1() {
		return productDao.searchgroup1();
	}

	/* group運動用品 */
	public List<Product> searchgroup2() {
		return productDao.searchgroup2();
	}

	/* group家庭用品 */
	public List<Product> searchgroup3() {
		return productDao.searchgroup3();
	}

	/* group其他 */
	public List<Product> searchgroup4() {
		return productDao.searchgroup4();
	}

	/* 7days食品 */
	public List<Product> day7group1() {
		return productDao.day7group1();
	}

	/* 7days運動用品 */
	public List<Product> day7group2() {
		return productDao.day7group2();
	}

	/* 7days家庭用品 */
	public List<Product> day7group3() {
		return productDao.day7group3();
	}

	/* 7days其他用品 */
	public List<Product> day7group4() {
		return productDao.day7group4();
	}

	/* 本月食品 */
	public List<Product> monthgroup1() {
		return productDao.monthgroup1();
	}

	/* 本月運動用品 */
	public List<Product> monthgroup2() {
		return productDao.monthgroup2();
	}

	/* 本月家庭用品 */
	public List<Product> monthgroup3() {
		return productDao.monthgroup3();
	}

	/* 本月其他用品 */
	public List<Product> monthgroup4() {
		return productDao.monthgroup4();
	}

	/* 新增多筆商品 */
	/*
	 * public List<Product> insertAll(List<Product> product) { Optional<Employee>
	 * optional = employeeDao.findById(1); for(Product p : product) {
	 * p.setEmployee(optional.get()); p.setBest_seller(0); p.setButton_switch(true);
	 * p.setCreate_at(getDate); p.setUpdate_at(getDate); } return
	 * productDao.saveAll(product); }
	 */

}
