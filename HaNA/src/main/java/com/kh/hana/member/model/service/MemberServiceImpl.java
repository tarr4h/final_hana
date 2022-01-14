package com.kh.hana.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.member.model.dao.MemberDao;
import com.kh.hana.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public String test() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int memberEnroll(Member member) {
		return memberDao.memberEnroll(member);
	}
	
	
}
