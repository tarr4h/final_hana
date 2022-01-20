package com.kh.hana.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.hana.chat.model.service.ChatService;
import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class WebSocketHandler extends TextWebSocketHandler{
	
	@Autowired
	private ChatService chatService;
	
	private final ObjectMapper objectMapper = new ObjectMapper();

	 // 채팅방 목록 <방 번호, List<session> >이 들어간다.
    private Map<Integer, List<WebSocketSession>> RoomList = new HashMap<>();
    // session, 방 번호가 들어간다.
    private Map<WebSocketSession, Integer> sessionList = new HashMap<>();
    
    private static int i;
	
	//연결
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		i++;
		log.info("{} 연결 성공 => 접속 인원 : {}명", session.getId(),i);
		log.info("RoomList = {} , sessionList = {}", RoomList, sessionList);

	}
	
	//메세지
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("handleTextMessage = {}, session = {}", message, session);
	    // 전달받은 메세지
        String msg = message.getPayload();
        
        // Json객체 → Java객체
        // 출력값 : {"roomNo":21,"name":"jeonyeseong","message":"ENTER"}
        Chat chat = objectMapper.readValue(msg,Chat.class);
        log.info("handleTextMessage - chat = {}", chat);
        
        // 받은 메세지에 담긴 roomId로 해당 채팅방을 찾아온다.
        ChatRoom chatRoom = chatService.selectChatRoom(chat.getRoomNo());
        log.info("handleTextMessage - chatRoom = {}", chatRoom);
        
        // roomlist 생성
        if(RoomList.get(chatRoom.getRoomNo()) == null && chat.getMessage().equals("ENTER") && chatRoom != null) {
            
            // 채팅방에 들어갈 session들
            List<WebSocketSession> sessionTwo = new ArrayList<>();
            // session 추가
            sessionTwo.add(session);
            // sessionList에 추가
            sessionList.put(session, chatRoom.getRoomNo());
            // RoomList에 추가
            RoomList.put(chatRoom.getRoomNo(), sessionTwo);
            // 확인용
            log.info("RoomList 생성 {}", RoomList);
            log.info("sessionList에 session, roomNo 저장 {}", sessionList);
        }
        
        else if(RoomList.get(chatRoom.getRoomNo()) != null && chat.getMessage().equals("ENTER") && chatRoom != null) {
        	RoomList.get(chatRoom.getRoomNo()).add(session);
        	sessionList.put(session, chatRoom.getRoomNo());
        	log.info("{}RoomList에 session 저장",chatRoom.getRoomNo());
        }
        
        else if(RoomList.get(chatRoom.getRoomNo()) != null && !chat.getMessage().equals("ENTER") && chatRoom != null) {
        	// 메세지에 이름, 이메일, 내용을 담는다.
            TextMessage textMessage = new TextMessage(chat.getMemberId() + ","  + chat.getMessage());
            log.info("메세지 보내기 testMessage = {}", textMessage);
            
            //읽음 표시 나중에 현재 session 수
            //int sessionCount = 0;
            
            for(WebSocketSession sess : RoomList.get(chat.getRoomNo())) {
            	sess.sendMessage(textMessage);
                //sessionCount++;
            }
            
            // 동적쿼리에서 사용할 sessionCount 저장
            // sessionCount == 2 일 때는 unReadCount = 0,
            // sessionCount == 1 일 때는 unReadCount = 1
            //chat.setSessionCount(sessionCount);
            
            //DB에 저장한다.
            int a = chatService.insertMessage(chat);
            
            if(a == 1) {
            	log.info("메세지 전송 및 DB 저장 성공");
            }else {
            	log.info("메세지 전송 실패!!! & DB 저장 실패!!");
            }
            
        }
		
	}
	
	//연결 끝
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {		
		i--;
		log.info("{} 연결 종료 => 접속 인원 : {}명", session.getId(),i);
        // sessionList에 session이 있다면
		log.info("sessionList.get(session) = {}", sessionList.get(session));
        if(sessionList.get(session) != null) {
            // 해당 session의 방 번호를 가져와서, 방을 찾고, 그 방의 List<session>에서 해당 session을 지운다.
            RoomList.get(sessionList.get(session)).remove(session);
            sessionList.remove(session);
        }
        log.info("연결 끝 RoomList = {} , sessionList = {}", RoomList, sessionList);
	}


}
