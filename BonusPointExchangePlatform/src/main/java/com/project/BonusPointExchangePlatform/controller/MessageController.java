package com.project.BonusPointExchangePlatform.controller;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.service.MailService;

@Controller
@SessionAttributes(names = { "member" })
public class MessageController {

    SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy/MM/dd");
    SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    @Autowired
    private MailService mailService;
    
    @GetMapping("/monthsearch")
    public String monthsearch() {
        return "backend/message/MonthSearch";
    }
    
    @GetMapping("/day7search")
    public String day7search() {
        return "backend/message/Day7Search";
    }
    
    @GetMapping("/mainsearch")
    public String mainsearch() {
        return "backend/message/MainSearch";
    }

    @GetMapping("/message")
    public String message() {
        return "/frontend/message/first";
    }

    @GetMapping("/mail")
    public String report() {
        return "/frontend/message/mail";
    }

    @GetMapping("/reportcomplete")
    public String reportok() {
        return "/frontend/message/reportcomplete";
    }

    @GetMapping("/piechar")
    public String analyze1() {
        return "/backend/message/PieChar";
    }

    @GetMapping("/barchar")
    public String analyze2() {
        return "/backend/message/BarChar";
    }

    /* 客戶問題寄信 */
    @PostMapping("/problemsemail")
    public String sendMailUs(@RequestParam("message") String message, HttpSession httpSession) {
        Member m1 = (Member) httpSession.getAttribute("member");
        System.out.println(m1.getId());
        System.out.println("session get");

        String finalmessage = new String("會員編號:" + m1.getId() + "問題" + message);
        mailService.problemsend(finalmessage);
        return "/frontend/message/reportcomplete";

    }
}
