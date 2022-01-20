package com.kh.hana.group.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
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

}
