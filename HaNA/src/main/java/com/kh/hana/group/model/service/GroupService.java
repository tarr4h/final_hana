package com.kh.hana.group.model.service;

import java.util.List;
import java.util.Map;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.group.model.vo.GroupBoardComment;
import com.kh.hana.member.model.vo.Member;

import com.kh.hana.group.model.vo.GroupMemberList;
import com.kh.hana.group.model.vo.GroupBoardEntity;


public interface GroupService {

	Group selectOneGroup(String groupId);

	int insertOneGroup(Group group);

	Map<String, String> selectGroupEnrolled(Map<String, String> map);

	List<Group> selectGroupList(Member member);

	int insertGroupBoard(GroupBoardEntity groupBoard);

	GroupBoard selectOneBoard(int no);

	List<Member> selectMemberList(GroupBoardEntity groupBoard);

	List<Member> selectGroupMemberList(String groupId);

	List<GroupBoardEntity> selectGroupBoardList(String groupId);

	int insertGroupBoardComment(GroupBoardComment groupBoardComment);

	int insertEnrollGroupForm(Map<String, Object> map);

	List<Map<String, Object>> getGroupApplyRequest(String groupId);

	List<GroupBoardComment> selectGroupBoardCommentList(int boardNo);

	int deleteBoardComment(int no);
	
	int insertGroupMember(Map<String, Object> map);

	int deleteGroupApplyList(Map<String, Object> map);

	int deleteGroupBoard(int no);

	int updateBoardContent(Map<String, Object> param);

	Map<String, Object> selectOneLikeLog(Map<String, Object> param);

	int deleteLikeLog(Map<String, Object> param);
}
