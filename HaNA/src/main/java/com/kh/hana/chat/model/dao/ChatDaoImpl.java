package com.kh.hana.chat.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;

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

}
