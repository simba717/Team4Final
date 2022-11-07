package com.project.BonusPointExchangePlatform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.dto.FrontendOrdersListDto;
import com.project.BonusPointExchangePlatform.dto.ProductDto;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Product;
import com.project.BonusPointExchangePlatform.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;

	/* INSERT */
	@PostMapping(path = "/product/insert", produces = "application/json; charset=UTF-8 ")
	public void insert(@RequestBody ProductDto productDto, HttpSession httpSession) {
		Employee employee = (Employee) httpSession.getAttribute("employee");
		System.out.println(employee.getName());
		productDto.convertImage();
		Product product = productDto.getProduct();
		productService.insert(product, employee);
	}
	
	/* SELECT */
	@GetMapping(value = "/getAllProducts.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<ProductDto> getAllProducts() {
		return productService.findAll();
	}

	@GetMapping(value = "/getAllProductsPages.json", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Page<Product> findByPage(@RequestParam(name = "p", defaultValue = "1") Integer pageNumber) {
		Page<Product> page = productService.findByPage(pageNumber);
		return page;
	}

	@GetMapping("/getProductImage")
	public ResponseEntity<byte[]> getProductImage(@RequestParam("id") Integer id) {
		Product product = productService.findById(id);
		byte[] image = product.getImage();
		return new ResponseEntity<byte[]>(image, HttpStatus.OK);
	}

	@GetMapping(path = "/products/search={search}", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<ProductDto> search(@PathVariable String search) {
		return productService.search(search);
	}

	/* UPDATE */	
	@PostMapping(path = "/product", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Product editProduct(@RequestBody Product product) {
		System.out.println(product.getId());
		Product result = productService.findById(product.getId());
		return result;
	}

	@PutMapping(value = "/products/{id}", consumes = { "application/json" }, produces = {
			"application/json; charset=UTF-8" })
	public @ResponseBody Map<String, String> updateProduct(@RequestBody ProductDto productDto,
			@PathVariable Integer id, HttpSession httpSession) {
		Employee employee = (Employee) httpSession.getAttribute("employee");
		Map<String, String> map = new HashMap<>();
		try {
			if (productDto.getFileDataUrl() == null) {
				Product product = productService.findById(id);
				productService.update(productDto.getProduct().getProduct_name(),
						productDto.getProduct().getProduct_content(), productDto.getProduct().getProduct_type(),
						productDto.getProduct().getPrice(), productDto.getProduct().getQuantity(),
						productDto.getProduct().isButton_switch(), product.getImage(), id, employee);
			} else {
				productDto.convertImage();
				productService.update(productDto.getProduct().getProduct_name(),
						productDto.getProduct().getProduct_content(), productDto.getProduct().getProduct_type(),
						productDto.getProduct().getPrice(), productDto.getProduct().getQuantity(),
						productDto.getProduct().isButton_switch(), productDto.getProduct().getImage(), id, employee);
			}
			map.put("success", "更新成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("fail", "更新失敗");
		}
		return map;
	}

	@GetMapping(value = "/product/control")
	public String switchControl(@RequestParam Integer id, @RequestParam boolean button_switch, HttpSession httpSession) {
		Employee employee = (Employee) httpSession.getAttribute("employee");
		Product product = productService.findById(id);
		productService.update(product.getProduct_name(), product.getProduct_content(), product.getProduct_type(),
				product.getPrice(), product.getQuantity(), button_switch, product.getImage(), id, employee);
		return "redirect:/product/findAll";
	}

	@GetMapping(value = "/product/delete")
	public String deleteProduct(@RequestParam Integer id) {
		productService.delete(id);
		return "redirect:/product/findAll";
	}

	// 顯浩
	@GetMapping(path = "/showProduct")
	public String processMainAction() {
		return "frontend/mall/showProduct";
	}

	@ResponseBody
	@GetMapping(path = "/product/findOne/{id}")
	public Product findOne(@PathVariable Integer id) {
		Product product = productService.findById(id);
		product.setEmployee(null);
		return product;
	}

	// pill
	@ResponseBody
	@GetMapping(path = "/product/pill")
	public String pillNumber(HttpSession httpSession) {
		String pillNumber = (String) httpSession.getAttribute("pill");
		if (pillNumber == null) {
			return "";
		}
		return pillNumber;
	}

	// pill session
	@ResponseBody
	@PostMapping(path = "/product/pillSession", produces = { "application/json; charset=UTF-8" })
	public void pillNumberSession(@RequestBody String pillNumber, HttpSession httpSession) {
		httpSession.setAttribute("pill", pillNumber);
//			return "frontend/mall/showProduct";
	}

	// pill ordersListContent session清掉
	
	@GetMapping("/product/pillSessionClear")
	public String processMainAction3(HttpSession httpSession) {
		httpSession.removeAttribute("pill");
		httpSession.removeAttribute("ordersListContent");
		return "redirect:/shoppingCart";
	}

	@GetMapping("/product/downloadImage/{id}")
	public ResponseEntity<byte[]> downloadImage(@PathVariable Integer id) {
		Product product = productService.findById(id);
		byte[] photoFile = product.getImage();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG);// image的content type 要是image/jpeg 所以要轉檔
		// 資料, header, HttpStatus
		return new ResponseEntity<byte[]>(photoFile, headers, HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(path = "/product/findAllFrontend")
	public List<Product> findAllProduct() {
		List<Product> products = productService.findAllFrontend();
		for (Product product : products) {
			product.setEmployee(null);
			if (product.getProduct_type().equals("家庭用品")) {
				product.setProduct_type("houseitem");
			} else if (product.getProduct_type().equals("食品")) {
				product.setProduct_type("fooditem");
			} else if (product.getProduct_type().equals("運動用品")) {
				product.setProduct_type("sportitem");
			} else {
				product.setProduct_type("other");
			}
		}
		return products;
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@GetMapping(path = "/product/navbarOrderList")
	public List<FrontendOrdersListDto> navbarOrderList(HttpSession httpSession) {
		List<FrontendOrdersListDto> list = (List<FrontendOrdersListDto>) httpSession.getAttribute("ordersListContent");
		return list;
	}

	/* group by */
	// Ray
	@ResponseBody
	@GetMapping(value = "/product/searchgroup1", produces = { "application/json; charset=UTF-8" })
	public Integer searchgroup1() {
		Integer total = 0;
		List<Product> list = productService.searchgroup1();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		System.out.println(total);
		return total;
	}

	@ResponseBody
	@GetMapping(value = "/product/searchgroup2", produces = { "application/json; charset=UTF-8" })
	public Integer searchgroup2() {
		Integer total = 0;
		List<Product> list = productService.searchgroup2();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	@ResponseBody
	@GetMapping(value = "/product/searchgroup3", produces = { "application/json; charset=UTF-8" })
	public Integer searchgroup3() {
		Integer total = 0;
		List<Product> list = productService.searchgroup3();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	@ResponseBody
	@GetMapping(value = "/product/searchgroup4", produces = { "application/json; charset=UTF-8" })
	public Integer searchgroup4() {
		Integer total = 0;
		List<Product> list = productService.searchgroup4();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	////////////////////////////////////////////////////////////////////////////////////
	// 7days

	@ResponseBody
	@GetMapping(value = "/product/day7group1", produces = { "application/json; charset=UTF-8" })
	public Integer day7group1() {
		Integer total = 0;
		List<Product> list = productService.day7group1();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	@ResponseBody
	@GetMapping(value = "/product/day7group2", produces = { "application/json; charset=UTF-8" })
	public Integer day7group2() {
		Integer total = 0;
		List<Product> list = productService.day7group2();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	@ResponseBody
	@GetMapping(value = "/product/day7group3", produces = { "application/json; charset=UTF-8" })
	public Integer day7group3() {
		Integer total = 0;
		List<Product> list = productService.day7group3();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	@ResponseBody
	@GetMapping(value = "/product/day7group4", produces = { "application/json; charset=UTF-8" })
	public Integer day7group4() {
		Integer total = 0;
		List<Product> list = productService.day7group4();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	////////////////////////////////////////////////////////////////////////////////////
	// 30days
	@ResponseBody
	@GetMapping(value = "/product/monthgroup1", produces = { "application/json; charset=UTF-8" })
	public Integer monthgroup1() {
		Integer total = 0;
		List<Product> list = productService.monthgroup1();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	@ResponseBody
	@GetMapping(value = "/product/monthgroup2", produces = { "application/json; charset=UTF-8" })
	public Integer monthgroup2() {
		Integer total = 0;
		List<Product> list = productService.monthgroup2();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	@ResponseBody
	@GetMapping(value = "/product/monthgroup3", produces = { "application/json; charset=UTF-8" })
	public Integer monthgroup3() {
		Integer total = 0;
		List<Product> list = productService.monthgroup3();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}

	@ResponseBody
	@GetMapping(value = "/product/monthgroup4", produces = { "application/json; charset=UTF-8" })
	public Integer monthgroup4() {
		Integer total = 0;
		List<Product> list = productService.monthgroup4();
		for (Product product : list) {
			total += product.getBest_seller();
		}
		return total;
	}
	
}
