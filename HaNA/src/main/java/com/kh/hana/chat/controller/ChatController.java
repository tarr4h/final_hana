package com.kh.hana.chat.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.chat.model.service.ChatService;
import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;
import com.kh.hana.common.util.HanaUtils;
import com.kh.hana.group.model.service.GroupService;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.group.model.vo.GroupBoardComment;
import com.kh.hana.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value= {"/chat","/common"})
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@Autowired
	private GroupService groupService;
	
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
    public ResponseEntity<?> roomchat(int no, String id){
    	log.info("no = {}",no);
    	Map<String, Object> param = new HashMap<String, Object>();
    	param.put("roomNo", no);
    	param.put("memberId", id);
    	
    	List<Map<String, Object>> chat = chatService.roomchat2(param);
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
    	

    	List<ChatRoom> chatlist = chatService.chatRoomCheck(param);
    	log.info("채팅방 생성 or 보내기 chatlist= {}, size = {}", chatlist, chatlist);
    	if(chatlist.size() == 0) {
    		int result = chatService.createChatRoom(param);
    		log.info("createChatRoom result = {}", result);
    		if(result > 0) {
    			
    			//나중에 selectKey로 바꾸기
    			int roomNo = chatService.findRoomNo(param);
    			param.put("roomNo", roomNo);
    			int insert1 = chatService.insertEnterMessage(param);
    			if(insert1 > 0)
    				redirectAttr.addFlashAttribute("msg", "채팅방 생성 성공");
    			}
    			else
    				redirectAttr.addFlashAttribute("msg", "채팅방 생성 실패");
    		}
    		else
    			redirectAttr.addFlashAttribute("msg", "채팅방이 있습니다");
    			
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
    	String saveDirectory = application.getRealPath("/resources/upload/chat/chat");
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
    
    @GetMapping(value="/Filedownload.do",
    		produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    public Resource Filedownload(String filename, HttpServletResponse response){
    	log.info("filename = {}", filename);
    	
		// 다운로드받을 파일 경로
		String saveDirectory = application.getRealPath("/resources/upload/chat/chat");
		File downFile = new File(saveDirectory, filename);
		String location = "file:" + downFile; // file객체의 toString은 절대경로로 오버라이드되어 있다.
		log.info("location = {}",location);
		Resource resource = resourceLoader.getResource(location);
		
		//헤더설정  (이거 안하면 바로보기됨!!)
		response.addHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename);
    	
    	return resource;
    }
    
    @GetMapping("/updateunreadcount.do")
    public ResponseEntity<?> updateunreadcount(Chat chat){
    	log.info("updateunreadcount.do chat = {}", chat);
    	
    	int result = chatService.updateUnreadCount(chat);
    	log.info("이건 onmessage 메세지 수신받을때 읽음처리");
    	log.info("{}",result > 0 ? "읽음 처리 완료!" : "읽음 처리 실패!");
    	
    	return null;
    }
    
    @GetMapping("/dmalarm.do")
    public ResponseEntity<?> dmalarm(String id){

    	int unreadChat = chatService.dmalarm(id);

    	
    	return ResponseEntity.ok(unreadChat); 
    }
    
    @GetMapping("/roomUnreadChat.do")
    public ResponseEntity<?> roomUnreadChat(Chat chat){
    	int roomUnreadChat = chatService.roomUnreadChat(chat);
    	return ResponseEntity.ok(roomUnreadChat);
    }
    
    
    
    
    //main페이지
    @RequestMapping(value="/main.do", method = RequestMethod.GET)
    public void main(Authentication authentication, Model model) {
    	//자기가 속한 소모임 최근게시글 3개
    	String memberId = authentication.getName();
    	List<GroupBoard> groupboard = chatService.selectListGroupBoard(memberId);
    	//log.info("groupboard 몇개 나왔는지= {}", groupboard.size());
    	
    	//팔로잉 친구 최근게시글 3개
    	
    	//추천친구 (같은 그룹에 있지만 팔로잉 안된 친구 or 나를 팔로잉한 친구 or mbti나 취향?이 같은 친구)
    	
    	
    	
    	
    	model.addAttribute("groupboard", groupboard);
    }
    
    @GetMapping("/boardcommentList.do")
    public ResponseEntity<?> boardcommentList(int boardNo){
    	log.info("boardcommentList boardNo = {}", boardNo);
		List<GroupBoardComment> list = groupService.selectGroupBoardCommentList(boardNo);
		log.info("list = {}",list);
    	
    	return ResponseEntity.ok(list);
    };
    
    		
}