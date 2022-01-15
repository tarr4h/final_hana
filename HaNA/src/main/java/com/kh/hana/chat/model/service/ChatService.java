package com.kh.hana.chat.model.service;

import java.util.List;

import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;

public interface ChatService {

	List<ChatRoom> roomList(String id);

	Chat test();

	List<Chat> roomchat(int no);

}
