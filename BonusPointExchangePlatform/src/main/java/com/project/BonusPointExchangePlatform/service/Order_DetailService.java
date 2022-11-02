package com.project.BonusPointExchangePlatform.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.dao.Order_DetailDao;
import com.project.BonusPointExchangePlatform.dao.OrdersDao;
import com.project.BonusPointExchangePlatform.dao.ProductDao;
import com.project.BonusPointExchangePlatform.dao.WalletDao;
import com.project.BonusPointExchangePlatform.dto.OrdersDto;
import com.project.BonusPointExchangePlatform.dto.ShoppingCartDto;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.model.Product;
import com.project.BonusPointExchangePlatform.model.Wallet;

@Service
public class Order_DetailService {

	@Autowired
	private OrdersDao ordersDao;

	@Autowired
	private Order_DetailDao order_DetailDao;

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private ProductDao productDao;

	@Autowired
	private WalletDao walletDao;

	/*查詢訂單明細(員工)*/
	public List<OrdersDto> findOrderDetail(){
		List<Order_Detail> order_detail = order_DetailDao.findAllOrder_Detail();
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Order_Detail d : order_detail) {
			OrdersDto dto = new OrdersDto(d);
			ordersDto.add(dto);
		}		
		return ordersDto;		
	}
	
	/*查詢訂單明細(會員)*/
	public List<OrdersDto> findOrderDetailByMember(Member member){
		Optional<Member> optional = memberDao.findById(member.getId());
		List<Order_Detail> order_detail = order_DetailDao.findAllOrder_DetailByMember(optional.get());
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Order_Detail d : order_detail) {
			OrdersDto dto = new OrdersDto(d);
			ordersDto.add(dto);
		}		
		return ordersDto;		
	}
	
	/*建立購物車訂單明細*/
	public void insertOrderDetail(Orders orders, Product product, Integer orderNumber, Member member) {
		List<Order_Detail> unPaidOrder_Detail = order_DetailDao.findAllUnPaidOrder_DetailByMember(member);		
		boolean compare = false;
		Integer tmpTotal = 0;
		Order_Detail tmpOrder_detail = new Order_Detail();
		for(Order_Detail d : unPaidOrder_Detail) {
			if(d.getProduct_name().equals(product.getProduct_name())) {
				tmpOrder_detail.setQuantity(d.getQuantity());
				tmpOrder_detail.setTotal(d.getTotal());
				compare = true;
			}
			tmpTotal += d.getTotal();
		}		
		
		Product tmpProduct = productDao.findByProductName(product.getProduct_name());
		Date getDate = new Date();
		Order_Detail order_detail = new Order_Detail();		
		if(compare) {
			order_DetailDao.updateOrderDetail((tmpOrder_detail.getQuantity() + orderNumber), (tmpOrder_detail.getTotal() + orderNumber * product.getPrice()), product.getProduct_name());
			ordersDao.updateOrdersTotal(member, tmpTotal - tmpOrder_detail.getTotal() + (tmpOrder_detail.getTotal() + orderNumber * product.getPrice()));
			productDao.updateQuantity(product.getProduct_name(), tmpProduct.getBest_seller() + orderNumber);
		} else {
			order_detail.setProduct_name(product.getProduct_name());
			order_detail.setProduct_content(product.getProduct_content());
			order_detail.setQuantity(orderNumber);
			order_detail.setTotal(orderNumber * product.getPrice());
			order_detail.setOrders(orders);
			order_detail.setCreate_at(getDate);
			order_detail.setUpdate_at(getDate);
			productDao.updateQuantity(product.getProduct_name(), tmpProduct.getBest_seller() + orderNumber);
			order_DetailDao.save(order_detail);
			ordersDao.updateOrdersTotal(member, tmpTotal + orderNumber * product.getPrice());
		}		
	}
	
	/*員工查詢訂單編號*/
	public List<OrdersDto> searchByOrder(String search) {
		List<Order_Detail> searchByOrder = order_DetailDao.searchByOrder("%" + search + "%");
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Order_Detail d : searchByOrder) {
			OrdersDto dto = new OrdersDto(d);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*會員查詢訂單編號*/
	public List<OrdersDto> memberSearchByOrder(Member member, String search) {
		List<Order_Detail> searchByOrder = order_DetailDao.memberSearchByOrder(member, "%" + search + "%");
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Order_Detail d : searchByOrder) {
			OrdersDto dto = new OrdersDto(d);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	/*員工查詢會員訂單*/
	public List<OrdersDto> searchByMember(Member member) {
		List<Order_Detail> searchByOrder = order_DetailDao.searchByMember(member);
		List<OrdersDto> ordersDto = new ArrayList<>();
		
		for(Order_Detail d : searchByOrder) {
			OrdersDto dto = new OrdersDto(d);
			ordersDto.add(dto);
		}		
		return ordersDto;
	}
	
	//顯浩
	/* 查詢全部訂單By訂單id */
	public List<Order_Detail> findAllByOrderDetailId(Orders orders) {
		return order_DetailDao.findAllByOrderDetailId(orders);
	}

	/* 查詢全部訂單By訂單name */
	public List<Order_Detail> findAllByOrderDetailName(String product_name) {
		return order_DetailDao.findAllByOrderDetailName(product_name);
	}

	/* 更新訂單 */
	public void updateOrderDetail(Integer quantity, Integer total, String product_name) {
		order_DetailDao.updateOrderDetail(quantity, total, product_name);
	}

	/* 查詢訂單ById */
	public Order_Detail findById(Integer id) {
		Optional<Order_Detail> optional = order_DetailDao.findById(id);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	/* 查詢訂單By訂單id跟訂單name */
	public Order_Detail findOneByOrderDetailIdProductName(Orders orders, String product_name) {
		return order_DetailDao.findOneByOrderDetailIdProductName(orders, product_name);
	}

	/* 熱銷數與detail更新 */
	public void updateBestSellerAndOrderDetail(String productName, Integer checlTotal, Integer orderDetailQuantity,
			Integer OrderDetailTotal, Orders orders) {
		productDao.updateLastQuantity(productName, checlTotal);
		order_DetailDao.updateOrderDetailByOrderId(orders, orderDetailQuantity, OrderDetailTotal, productName);
	}

	/* 訂單更新 */
	public void updateOrdersTotal(Member member_id, Orders orders) {
		Integer tmpOrderTotal = 0;
		List<Order_Detail> orderDetailList = order_DetailDao.findAllByOrderDetailId(orders);
		System.out.println("66666666666666666666666");
		for (Order_Detail detail : orderDetailList) {
			System.out.println(detail.getTotal());
			tmpOrderTotal += detail.getTotal();
		}
		ordersDao.updateOrdersTotal(member_id, tmpOrderTotal);
	}

//	/* 得到商品更新後資料與訂單detail更新後資料的Dto */
//	public ShoppingCartDto getShoppingCartDto(String productName, Orders orders) {
//		Product productNew = productDao.findByProductName(productName);
//		System.out.println("777777777777" + productNew.getBest_seller());
//		Order_Detail orderDetailNew = order_DetailDao.findOneByOrderDetailIdProductName(orders, productName);
//		System.out.println("88888888888" + orderDetailNew.getQuantity());
//		ShoppingCartDto shoppingCartDto = new ShoppingCartDto();
//		shoppingCartDto.setOrder_Detail(orderDetailNew);
//		shoppingCartDto.setProduct(productNew);
//		return shoppingCartDto;
//	}

	/* 得到商品更新後資料與訂單detail更新後資料的Dto */
	public OrdersDto getShoppingCartDto(Member member) {
		Orders order = ordersDao.findUnPaidOrdersByMember(member);
		// 排序ID
		Set<Order_Detail> order_detailListOld = order.getOrder_detail();
		Set<Order_Detail> sortSet = new TreeSet<Order_Detail>((o1, o2) -> (o1.getId() - o2.getId()));
		sortSet.addAll(order_detailListOld);
		order.setOrder_detail(sortSet);
		OrdersDto ordersDto = new OrdersDto();
		ordersDto.setOrders(order);
		Set<Order_Detail> order_details = sortSet;

		List<Product> detailList = new ArrayList<Product>();
		for (Order_Detail order_detail : order_details) {
			Product product = productDao.findByProductName(order_detail.getProduct_name());
			detailList.add(product);
		}
		ordersDto.setProductList(detailList);

		// 紅利金跟儲蓄金計算
		Integer remainingBonus = 0;
		Integer remainingWallet = 0;
		List<Wallet> walletList = walletDao.findMemberWalletAmount(member);
		for (Wallet wallet : walletList) {
			remainingWallet += wallet.getWallet_amount();
		}

		List<Wallet> bonusList = walletDao.findMemberBonusAmount(member);
		for (Wallet bonus : bonusList) {
			remainingBonus += bonus.getBonus_point();
		}
		ordersDto.setRemainingBonus(remainingBonus);
		ordersDto.setRemainingWallet(remainingWallet);

		return ordersDto;
	}

	/* 刪除訂單並更新order與product */
	public void deleteOrderDetail(Integer id, Integer checlTotal, String productName, Integer orderDetailTotal,
			Orders orders, Member member_id) {
		// 商品熱銷更新
		productDao.updateLastQuantity(productName, checlTotal);

		// orderTotal更新
		Integer tmpOrderTotal = orders.getSub_total() - orderDetailTotal;
		ordersDao.updateOrdersTotal(member_id, tmpOrderTotal);

		order_DetailDao.deleteById(id);
	}
}
