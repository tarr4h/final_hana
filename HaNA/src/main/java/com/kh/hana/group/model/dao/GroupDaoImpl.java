package com.kh.hana.group.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.group.model.vo.Group;
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
	public Map<String, String> selectGroupEnrolled(Map<String, String> map) {
		return session.selectOne("group.selectGroupEnrolled",map);
	}

	@Override
	public List<Group> selectGroupList(Member member) {
		return session.selectList("group.selectGroupList",member);
	}

	


}
