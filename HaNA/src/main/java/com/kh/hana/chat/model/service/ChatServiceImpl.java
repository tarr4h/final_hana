package com.kh.hana.chat.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.chat.model.dao.ChatDao;
import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;

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

}
