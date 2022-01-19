package com.kh.hana.member.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.member.controller.Personality;
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
	public int updateMember(Member member, String id) {
		return session.update("member.updateMember", member);
	}

	@Override
	public int updatePersonality(Member member , String id) {
		return session.update("member.updatePersonality", member);
	}

	@Override
	public int updateInterest(Member member , String id) {
		return session.update("member.updateInterest", member);
	}

	@Override
	public Member selectPersonality(String id) {
		return session.selectOne("member.selectPersonality", id);
	}

	
}
