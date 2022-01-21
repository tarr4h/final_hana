package com.kh.hana.member.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public int memberEnroll(Member member) {
		return session.insert("member.memberEnroll", member);
	}

	@Override
	public int updateMember(Member member) {
		return session.update("member.updateMember", member);
	}

	@Override
	public int updatePersonality(Member member) {
		return session.update("member.updatePersonality", member);
	}

	@Override
	public int updateInterest(Member member) {
		return session.update("member.updateInterest", member);
	}

	@Override
	public Member selectPersonality(String id) {
		return session.selectOne("member.selectPersonality", id);
	}

	@Override
	public int insertPersonality(Member member) {
		return session.insert("member.insertPersonality", member);
	}

	@Override
	public int insertInterest(Member member) {
		return session.insert("member.insertInterest", member);
	}

	@Override
	public int addFollowing(Map<String, Object> map) {
		return session.insert("member.addFollowing", map);
	}
	
	 

	
}
