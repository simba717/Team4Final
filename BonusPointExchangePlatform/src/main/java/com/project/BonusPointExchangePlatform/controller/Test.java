package com.project.BonusPointExchangePlatform.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.hibernate.boot.model.source.spi.JoinedSubclassEntitySource;
import org.hibernate.internal.build.AllowSysOut;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.dto.CheckoutDto;
import com.project.BonusPointExchangePlatform.model.Order_Detail;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;

@Controller
public class Test {
	
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	@GetMapping("/public/ecpay")
    @ResponseBody
    public String testEcpay(@ModelAttribute(name = "checkout")CheckoutDto checkoutDto) {		
		Date date = new Date();
		String getDate = DateTimeFormat.format(date);		
		List<String> list = new ArrayList<>();
		Set<Order_Detail> order_detail = checkoutDto.getOrder_detail();
		for(Order_Detail o : order_detail) {
			list.add(o.getProduct_name());
		}
		
		StringBuilder sb = new StringBuilder();
		if(list != null && list.size() > 0) {
			for(int i = 0 ; i < list.size(); i++) {
				sb.append(i == 0 ? list.get(i) : "," + list.get(i));
			}
		}
		
    	AllInOne all = new AllInOne(" ");
        AioCheckOutALL obj = new AioCheckOutALL();
        // FIXME:測試訂單應該要隨機生成字串
        UUID uid = UUID.randomUUID();
        obj.setMerchantTradeNo(uid.toString().replaceAll("-", "").substring(0,20));
        obj.setMerchantTradeDate(getDate);
        obj.setTotalAmount(checkoutDto.getCreditCard().toString());
        obj.setTradeDesc("test Description");
        obj.setItemName(sb.toString());
        // TODO:新增付款成功頁面
        obj.setReturnURL("http://localhost:8082/");
        obj.setNeedExtraPaidInfo("N");
        obj.setClientBackURL("http://localhost:8080/my-app/showProduct");
        String form = all.aioCheckOut(obj, null);
        return form;
    }
}
