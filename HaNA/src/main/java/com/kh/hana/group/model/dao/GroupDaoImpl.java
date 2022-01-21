package com.kh.hana.group.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.group.model.vo.GroupBoard;

@Repository
public class GroupDaoImpl implements GroupDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public Group selectOneGroup(String groupId) {
		return session.selectOne("group.selectOneGroup",groupId);
	}

	@Override
	public int insertOneGroup(Group group) {
		return session.insert("group.insertOneGroup",group);
	}

	@Override
	public Map<String, String> selectGroupEnrolled(Map<String, String> map) {
		return session.selectOne("group.selectGroupEnrolled",map);
	}

	@Override
	public List<Group> selectGroupList(Member member) {
		return session.selectList("group.selectGroupList",member);
	}

	public int insertGroupBoard(GroupBoard groupBoard) {
		return session.insert("group.insertGroupBoard", groupBoard);
	}

	@Override
	public GroupBoard selectOneBoard(int no) {
		return session.selectOne("group.selectOneBoard",no);
	}

	@Override
	public List<Member> selectMemberList(GroupBoard groupBoard) {
		return session.selectList("selectMemberList", groupBoard);
	}

	@Override
	public List<Member> selectGroupMemberList(String groupId) {
		return session.selectList("selectGroupMemberList",groupId);
	}

	@Override
	public List<GroupBoard> selectGroupBoardList(String groupId) {
		return session.selectList("selectGroupBoardList",groupId);
	}

	@Override
	public int insertEnrollGroupForm(Map<String, Object> map) {
		return session.insert("insertEnrollGroupForm", map);
	}

	@Override
	public List<Map<String, Object>> getGroupApplyRequest(String groupId) {
		return session.selectList("getGroupApplyRequest", groupId);
	}
	


}
