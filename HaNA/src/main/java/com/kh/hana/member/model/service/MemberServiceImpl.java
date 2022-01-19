package com.kh.hana.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.member.controller.Personality;
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

	@Override
	public int updateMember(Member member, String id) {
		int result1 = memberDao.updateMember(member,id);
		int result2 = memberDao.updatePersonality(member, id);
		int result3 = memberDao.updateInterest(member, id);
		
		if(result1 == 1 && result2 == 1 && result3 ==1) {
			return 1;
		}
		else {
			return 0;
		}
	}

	@Override
	public Member selectPersonality(String id) {
		Member member = memberDao.selectPersonality(id);
		return member;
	}

 
	
	 
	
	
}
              














