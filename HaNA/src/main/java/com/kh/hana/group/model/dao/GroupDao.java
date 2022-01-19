package com.kh.hana.group.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.group.model.vo.GroupBoard;

public interface GroupDao {
	
	public Group selectOneGroup(String groupId);

	public int insertOneGroup(Group group);

	public Map<String, String> selectGroupEnrolled(Map<String, String> map);

	public List<Group> selectGroupList(Member member);
	
	public int insertGroupBoard(GroupBoard groupBoard);

}
