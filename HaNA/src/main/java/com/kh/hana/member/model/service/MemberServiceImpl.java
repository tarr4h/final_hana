package com.kh.hana.member.model.service;

import java.util.Map;

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
	public int updateMember(Member member, Member oldMember, String id) {
		int result1 = memberDao.updateMember(member);
		log.info("result1 ={}", result1);
		int result2 = 0;
		int result3 = 0;
		log.info("memberPersonality ={}", member.getPersonality());
		if(oldMember.getPersonality() != null) {
			result2 = memberDao.updatePersonality(member);
		}else {
			result2 = memberDao.insertPersonality(member);
		}
		
		if(oldMember.getInterest() != null) {
			result3 = memberDao.updateInterest(member);
		}else {
			result3 = memberDao.insertInterest(member);
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

	@Override
	public int updateShopInfo(Map<String, String> param, Member member) {
		try {
			log.info("serv Member = {}", member);
			log.info("param = {}", param);
			int result = memberDao.updateShopMember(member);
			if(result < 1) {
				throw new Exception();
			}
			
			Map<String, Object> map = memberDao.selectShopInfo(member.getId());
			log.info("map = {}", map);
			
			if(map == null) {
				result = memberDao.insertShopInfo(param);
			} else {
				result = memberDao.updateShopInfo(param);				
			}
			if(result < 1) {
				throw new Exception();
			}
			return result;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return 0;
		}
	}

	@Override
	public int addFollowing(Map<String, Object> map) {
		return memberDao.addFollowing(map);
	}

	 

	
	 
	
	
}
              














