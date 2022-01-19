package com.kh.hana.group.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.member.model.vo.Member;

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
	


}
