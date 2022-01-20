package com.kh.hana.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;
import com.kh.hana.member.model.vo.Member;

@Repository
public class ChatDaoImpl implements ChatDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<ChatRoom> roomList(String id) {
		return session.selectList("chat.roomList",id);
	}

	@Override
	public Chat test() {
		return session.selectOne("chat.test");
	}

	@Override
	public List<Chat> roomchat(int no) {
		return session.selectList("chat.roomchat",no);
	}

	@Override
	public ChatRoom selectChatRoom(int roomNo) {
		return session.selectOne("chat.selectChatRoom", roomNo);
	}

	@Override
	public int insertMessage(Chat chat) {
		return session.insert("chat.insertMessage", chat);
	}

	@Override
	public List<Member> memberList() {
		return session.selectList("chat.memberList");
	}


	@Override
	public List<Chat> chatRoomCheck(Map<String, Object> param) {
		return session.selectList("chat.chatRoomCheck",param);
	}

	@Override
	public int createChatRoom(Map<String, Object> param) {
		return session.insert("chat.createChatRoom",param);
	}

	@Override
	public int insertEnterMessage(Map<String, Object> param) {
		return session.insert("chat.insertEnterMessage",param);
	}
	
	@Override
	public int insertEnterMessage2(Map<String, Object> param) {
		return session.insert("chat.insertEnterMessage2", param);
	}

	@Override
	public int findRoomNo(Map<String, Object> param) {
		return session.selectOne("chat.findRoomNo", param);
	}


}
