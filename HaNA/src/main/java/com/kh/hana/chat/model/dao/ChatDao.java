package com.kh.hana.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;
import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.member.model.vo.Board;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.member.model.vo.memberBoard;

public interface ChatDao {

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

	int insertEnterMessage2(Map<String, Object> param);

	ChatRoom selectOneChatRoom(int no);

	int CreateGroupChat(Group group);

	List<Member> memberList(String value);

	String searchPicture(String member);

	List<Map<String, Object>> roomchat2(Map<String, Object> param);

	int exitRoom(int roomNo);

	int insertFileMessage(Chat chat);

	int updateUnreadCount(Chat chat);

	List<String> selectListReceiver(Chat chat);

	int dmalarm(String id);

	int roomUnreadChat(Chat chat);

	int insertGroupMessage(Group group);

	int selectGroupRoomNo(Group group);

	int insertGroupMessage22(Map<String, Object> param);

	List<GroupBoard> selectListGroupBoard(String memberId);

	List<memberBoard> selectListMemberBoard(String memberId);

	List<Member> followingRecommendList(String memberId);

	List<Member> groupRecommendList(String memberId);


}