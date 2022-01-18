package com.kh.hana.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.chat.model.dao.ChatDao;
import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;
import com.kh.hana.member.model.vo.Member;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatDao chatDao;

	@Override
	public List<ChatRoom> roomList(String id) {
		return chatDao.roomList(id);
	}

	@Override
	public Chat test() {
		return chatDao.test();
	}

	@Override
	public List<Chat> roomchat(int no) {
		return chatDao.roomchat(no);
	}

	@Override
	public ChatRoom selectChatRoom(int roomNo) {
		return chatDao.selectChatRoom(roomNo);
	}

	@Override
	public int insertMessage(Chat chat) {
		return chatDao.insertMessage(chat);
	}

	@Override
	public List<Member> memberList() {
		return chatDao.memberList();
	}


	@Override
	public Chat chatRoomCheck(Map<String, Object> param) {
		return chatDao.chatRoomCheck(param);
	}

	@Override
	public int createChatRoom(Map<String, Object> param) {
//		int result = chatDao.createChatRoom(param);
//		//로그인맴버가 chatroom생성
//		if(result > 0)
			
		return chatDao.createChatRoom(param);
	}

}
