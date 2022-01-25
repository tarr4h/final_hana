package com.kh.hana.chat.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.chat.model.service.ChatService;
import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;
import com.kh.hana.common.util.HanaUtils;
import com.kh.hana.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/chat.do")
	public void chat() {}

	
    @GetMapping("/roomList.do")
    public ResponseEntity<?> roomlist(String id) {
        
    	List<ChatRoom> cList = chatService.roomList(id);
        
        log.info("cList = {}", cList);
        String members= "";
        String member = "";
        for(int i = 0; i < cList.size(); i++) {
            if(cList.get(i).getRoomType() != 1) {
            	members = cList.get(i).getMembers().replace(id, "");
            	member = members.replace(",", "");
            	cList.get(i).setMembers(member);
            	String roomImg = chatService.searchPicture(member);
            	cList.get(i).setGroupImg(roomImg);
            	
            }
        }

        return ResponseEntity.ok(cList);

    }
    
    @GetMapping("/roomchat.do")
    public ResponseEntity<?> roomchat(int no){
    	log.info("no = {}",no);
    	
    	List<Map<String, Object>> chat = chatService.roomchat2(no);
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
    	param.put("members", loginId+","+memberId);
    	
    	//단톡생성 하게되면 쿼리 바꾸거나 체크 삭제
    	//너무 복잡한데;
    	//나중에 room
    	List<ChatRoom> chatlist = chatService.chatRoomCheck(param);
    	log.info("채팅방 생성 or 보내기 chatlist= {}, size = {}", chatlist, chatlist);
    	if(chatlist.size() == 0) {
    		int result = chatService.createChatRoom(param);
    		log.info("createChatRoom result = {}", result);
    		if(result > 0) {
    			redirectAttr.addFlashAttribute("msg", "채팅방 생성 성공");
    			//불필요한 부분
//    			int roomNo = chatService.findRoomNo(param);
//    			param.put("roomNo", roomNo);
//    			int result2 = chatService.insertEnterMessage(param);
//    			log.info("insertEnterMessage result2 = {}, result3 = {}", result2);
//    			if(result2 > 0)
//    				redirectAttr.addFlashAttribute("msg", "채팅방 생성 성공");
//    			else
//    				redirectAttr.addFlashAttribute("msg", "채팅방 생성 실패");
    		}
    		else
    			redirectAttr.addFlashAttribute("msg", "채팅방이 있습니다");
    			
    	}
    	return "redirect:/chat/chat.do";
    }
    			
    @GetMapping("/roomheader.do")
    public ResponseEntity<?> RoomHeader(String id, int no){
    	log.info("roomheader id = {}, no = {}", id ,no);
    	
    	ChatRoom chatroom = chatService.selectOneChatRoom(no);
    	log.info("roomheader chatroom = {}", chatroom);
    	
    	if(chatroom.getRoomType() != 1) {
    		String members = chatroom.getMembers().replace(id, "");
    		String member = members.replace(",", "");
    		chatroom.setMembers(member);
    		String roomImg = chatService.searchPicture(member);
    		chatroom.setGroupImg(roomImg);
    	}
    	return ResponseEntity.ok(chatroom);
    }
    		
    	
    
    @GetMapping("/searchFriend.do")
    public ResponseEntity<?> searchFriend(String value){
    	log.info("searchFriend value = {}", value);
    	List<Member> member = chatService.memberList(value);
    	
    	
    	return ResponseEntity.ok(member);
    }
    
    @GetMapping("/main.do")
    public void main() {}
    
    @GetMapping("/exitRoom.do")
    public String exitRoom(int roomNo, RedirectAttributes redirectAttr) {
    	int result = chatService.exitRoom(roomNo);
    	if(result > 0)
    		redirectAttr.addFlashAttribute("msg", "채팅방을 나갔습니다.");
    	else
    		redirectAttr.addFlashAttribute("msg", "채팅방 나가기 실패");
    	return "redirect:/chat/chat.do";
    }
    
    @PostMapping("/sendFile.do")
    public ResponseEntity<?> sendFile(MultipartHttpServletRequest filerequest){
    	
    	MultipartFile upfile = filerequest.getFile("image");
    	log.info("sendFile upfile = {}", upfile);
    	String saveDirectory = application.getRealPath("/resources/upload/chat");
    	log.info("sendFile saveDirectory = {}", saveDirectory);
		
    	String originalFilename = upfile.getOriginalFilename();
		String renamedFilename = HanaUtils.rename(originalFilename);
		
		File saveImg = new File(saveDirectory, renamedFilename);
		try {
			upfile.transferTo(saveImg);
		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage(), e);
		}
		log.info("upfile originalfilename = {}",upfile.getOriginalFilename());
		log.info("upfile renamedFilename = {}",renamedFilename);
		
    	return ResponseEntity.ok(renamedFilename);
    }
    		
}