package com.project.BonusPointExchangePlatform.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import com.project.BonusPointExchangePlatform.model.Websocket;

@Controller
public class WebSocketController {
    
        @SuppressWarnings("null")
        @MessageMapping("/chat.register")
        @SendTo("/topic/public")
        public Websocket register(@Payload Websocket chatMessage, SimpMessageHeaderAccessor headerAccessor) {
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        return chatMessage;
    }
        @MessageMapping("/chat.send")
        @SendTo("/topic/public")
        public Websocket sendMessage(@Payload Websocket chatMessage) {
            return chatMessage;
        }
        
//      @GetMapping("/")
//      public String map1() {
//          return "index";
//      }
//  
//      @ResponseBody
//      @GetMapping("/123")
//      public String hihi() {
//         System.out.println("in");
//          return "hihi";
//      }
        
}
