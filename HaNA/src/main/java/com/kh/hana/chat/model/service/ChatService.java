package com.kh.hana.chat.model.service;

import java.util.List;
import java.util.Map;

import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;
import com.kh.hana.group.model.vo.Group;
import com.kh.hana.member.model.vo.Member;

public interface ChatService {

	List<ChatRoom> roomList(String id);

	Chat test();

	List<Chat> roomchat(int no);

	ChatRoom selectChatRoom(int roomNo);

	int insertMessage(Chat chat);

	List<Member> memberList();

	List<ChatRoom> chatRoomCheck(Map<String, Object> param);

	int createChatRoom(Map<String, Object> param);

	int insertEnterMessage(Map<String, Object> param);

	int findRoomNo(Map<String, Object> param);

	ChatRoom selectOneChatRoom(int no);

	int CreateGroupChat(Group group);

	List<Member> memberList(String value);

	String searchPicture(String member);

	List<Map<String, Object>> roomchat2(int no);

	int exitRoom(int roomNo);

}