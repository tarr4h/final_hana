package com.kh.hana.chat.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.hana.chat.model.service.ChatService;
import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@GetMapping("/chat.do")
	public void chat() {}

	
    @GetMapping("/roomList.do")
    public ResponseEntity<?> roomlist(String id) {
    	log.info("id = {}", id);
        
    	List<ChatRoom> cList = chatService.roomList(id);
        
        log.info("cList = {}", cList);
//        for(int i = 0; i < cList.size(); i++) {
//            message.setRoomId(cList.get(i).getRoomId());
//            message.setEmail(userEmail);
//            int count = cService.selectUnReadCount(message);
//            cList.get(i).setUnReadCount(count);
//        }

        return ResponseEntity.ok(cList);

    }
    
    @GetMapping("/roomchat.do")
    public ResponseEntity<?> roomchat(int no){
    	log.info("no = {}",no);
    	
    	List<Chat> chat = chatService.roomchat(no);
    	//log.info("chat = {}", chat); 	  	
    	
    	return ResponseEntity.ok(chat);
    }
}
