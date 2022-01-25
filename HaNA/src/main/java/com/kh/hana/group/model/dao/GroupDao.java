package com.kh.hana.group.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.group.model.vo.GroupMemberList;
import com.kh.hana.group.model.vo.GroupBoardComment;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.group.model.vo.GroupBoardEntity;

public interface GroupDao {
	
	public Group selectOneGroup(String groupId);

	public int insertOneGroup(Group group);

	public Map<String, String> selectGroupEnrolled(Map<String, String> map);

	public List<Group> selectGroupList(Member member);
	
	public int insertGroupBoard(GroupBoardEntity groupBoard);

	public GroupBoard selectOneBoard(int no);

	List<Member> selectMemberList(GroupBoardEntity groupBoard);

	public List<Member> selectGroupMemberList(String groupId);

	public List<GroupBoardEntity> selectGroupBoardList(String groupId);

	public int insertGroupBoardComment(GroupBoardComment groupBoardComment);

	public int insertEnrollGroupForm(Map<String, Object> map);

	public List<Map<String, Object>> getGroupApplyRequest(String groupId);

	public int insertGroupMember(Map<String, Object> map);

	public int deleteGroupApplyList(Map<String, Object> map);

}
