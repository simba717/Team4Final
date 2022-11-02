package com.project.BonusPointExchangePlatform.controller;

import java.io.UnsupportedEncodingException;
import java.util.UUID;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.BonusPointExchangePlatform.dto.CheckoutDto;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;

@Controller
public class Test {
	
	@GetMapping("/public/ecpay")
    @ResponseBody
    public String testEcpay(@ModelAttribute(name = "checkout")CheckoutDto checkoutDto) {
		System.out.println("8888888"+checkoutDto.getCreditCard());
		
        	AllInOne all = new AllInOne(" ");
            AioCheckOutALL obj = new AioCheckOutALL();
            // FIXME:測試訂單應該要隨機生成字串
            UUID uid = UUID.randomUUID();
            obj.setMerchantTradeNo(uid.toString().replaceAll("-", "").substring(0,20));
            obj.setMerchantTradeDate("2017/01/01 08:05:23");
            obj.setTotalAmount("50");
            obj.setTradeDesc("test Description");
            obj.setItemName("TestItem");
            // TODO:新增付款成功頁面
            obj.setReturnURL("http://localhost:8082/");
            obj.setNeedExtraPaidInfo("N");
            obj.setClientBackURL("http://localhost:8082/");
            String form = all.aioCheckOut(obj, null);
            return form;


    }
}
