package com.kh.hana.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.chat.model.dao.ChatDao;
import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;
import com.kh.hana.group.model.vo.Group;
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
	public List<ChatRoom> chatRoomCheck(Map<String, Object> param) {
		return chatDao.chatRoomCheck(param);
	}

	@Override
	public int createChatRoom(Map<String, Object> param) {	
		return chatDao.createChatRoom(param);
	}

	@Override
	public int insertEnterMessage(Map<String, Object> param) {
		int result2 = 0;
		int result = chatDao.insertEnterMessage(param);
		if(result > 0)
			result2 = chatDao.insertEnterMessage2(param);
		return result2;
	}

	@Override
	public int findRoomNo(Map<String, Object> param) {
		return chatDao.findRoomNo(param);
	}

	@Override
	public ChatRoom selectOneChatRoom(int no) {
		return chatDao.selectOneChatRoom(no);
	}

	@Override
	public int CreateGroupChat(Group group) {
		return chatDao.CreateGroupChat(group);
	}

	@Override
	public List<Member> memberList(String value) {
		return chatDao.memberList(value);
	}

	@Override
	public String searchPicture(String member) {
		return chatDao.searchPicture(member);
	}

	@Override
	public List<Map<String, Object>> roomchat2(int no) {
		return chatDao.roomchat2(no);
	}

	@Override
	public int exitRoom(int roomNo) {
		return chatDao.exitRoom(roomNo);
	}

	@Override
	public int insertFileMessage(Chat chat) {
		return chatDao.insertFileMessage(chat);
	}

	@Override
	public int updateUnreadCount(Chat chat) {
		return chatDao.updateUnreadCount(chat);
	}

	@Override
	public List<String> selectListReceiver(Chat chat) {
		return chatDao.selectListReceiver(chat);
	}

	@Override
	public List<Chat> dmalarm(String id) {
		return chatDao.dmalarm(id);
	}





}