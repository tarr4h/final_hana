package com.kh.hana.chat.model.dao;

import java.util.List;

import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;

public interface ChatDao {

	List<ChatRoom> roomList(String id);

	Chat test();

	List<Chat> roomchat(int no);

	ChatRoom selectChatRoom(int roomNo);

}
