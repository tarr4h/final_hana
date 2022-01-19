package com.kh.hana.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.chat.model.service.ChatService;
import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;
import com.kh.hana.member.model.vo.Member;

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
    
    //전체목록에서 친구목록으로 나중에 쿼리 변경
    @GetMapping("/memberList.do")
    public ResponseEntity<?> memberList(){
    	List<Member> member = chatService.memberList();
    	log.info("memberList = {}", member);
    	return ResponseEntity.ok(member);
    }
    
    @GetMapping("/sendchat.do")
    public String sendchat(String memberId, String loginId, RedirectAttributes redirectAttr) {
    	log.info("member id= {}", memberId);
    	log.info("loginId = {}", loginId);
    	
    	Map<String, Object> param = new HashMap<>();
    	param.put("memberId", memberId);
    	param.put("loginId", loginId);
    	param.put("login_Member", loginId+memberId);
    	
    	//단톡생성 하게되면 쿼리 바꾸거나 체크 삭제
    	//너무 복잡한데;
    	List<Chat> chatlist = chatService.chatRoomCheck(param);
    	log.info("채팅방 생성 or 보내기 chatlist= {}, size = {}", chatlist, chatlist);
    	if(chatlist.size() == 0) {
    		int result = chatService.createChatRoom(param);
    		log.info("createChatRoom result = {}", result);
    		if(result > 0) {
    			int roomNo = chatService.findRoomNo(param);
    			param.put("roomNo", roomNo);
    			int result2 = chatService.insertEnterMessage(param);
    			log.info("insertEnterMessage result2 = {}, result3 = {}", result2);
    			if(result2 > 0)
    				redirectAttr.addFlashAttribute("msg", "채팅방 생성 성공");
    			else
    				redirectAttr.addFlashAttribute("msg", "채팅방 생성 실패");
    			
    			
    		}
    		else
    			redirectAttr.addFlashAttribute("msg", "채팅방이 있습니다");
    		
    		
    	}
    	return "redirect:/chat/chat.do";
    }
}
