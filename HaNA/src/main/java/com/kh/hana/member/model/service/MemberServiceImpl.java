package com.kh.hana.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.member.model.dao.MemberDao;
import com.kh.hana.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
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
		int result1 = memberDao.updateMember(member);
		int result2 = 0;
		int result3 = 0;
		
		if(member.getId() != null && member.getPersonality() != null) {
			result2 = memberDao.updatePersonality(member);
		}else {
			result2 = memberDao.insertPersonality(id);
		}
		
		if(member.getId() != null && member.getInterest() != null) {
			result3 = memberDao.updateInterest(member);
		}else {
			result3 = memberDao.insertInterest(id);
		}
		
		log.info("id={}", id);
		log.info("member={}", member);
		
		if(result1 == 1 || result2 == 1 || result3 ==1) {
			return 1;
		}
		else {
		return 0;
		}
		
	}

	@Override
	public Member selectPersonality(String id) {
		Member member = memberDao.selectPersonality(id);
		log.info("id={}", id);
		return member;
	}

 
	
	 
	
	
}
              














