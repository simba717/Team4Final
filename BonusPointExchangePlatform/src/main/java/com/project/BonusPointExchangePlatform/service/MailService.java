package com.project.BonusPointExchangePlatform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

@Service
public class MailService {
 
    private JavaMailSender mailSender;
 
    @Autowired
    public MailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }
 
    public void prepareAndSend(String recipient, String message) {
       MimeMessagePreparator messagePreparator = mimeMessage -> {
             MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage);
             messageHelper.setFrom("eeit4team@gmail.com");
             messageHelper.setTo(recipient);
             messageHelper.setSubject("您的驗證碼");
             messageHelper.setText(message);
         };
         try {
             mailSender.send(messagePreparator);
             System.out.println("sent");
         } catch (MailException e) {
             System.out.println(e);
             // runtime exception; compiler will not force you to handle it
         }
    }
    
    public void problemsend(String message) {
        MimeMessagePreparator messagePreparator = mimeMessage -> {
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage);
            messageHelper.setFrom("eeit4team@gmail.com");
            messageHelper.setTo("eeit15119@outlook.com");
            messageHelper.setSubject("問題回報");
            messageHelper.setText(message);
        };
        try {
            mailSender.send(messagePreparator);
            System.out.println("sent");
        } catch (MailException e) {
            System.out.println(e);
            // runtime exception; compiler will not force you to handle it
        }
    }
 
}