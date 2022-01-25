package com.kh.hana.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.member.model.dao.MemberDao;
import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.vo.Shop;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public int memberEnroll(Member member) {
		return memberDao.memberEnroll(member);
	}

	@Override
	public int updateMember(Member member, Member oldMember) {
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
	public int updateShopInfo(Shop shop) {
		try {
			Shop searchShop = memberDao.selectOneShopInfo(shop.getId());
			log.info("searchShop = {}", searchShop);
			
			int result = 0;
			if(searchShop == null) {
				result = memberDao.insertShopInfo(shop);
				return result;
			} else {
				result = memberDao.updateShopInfo(shop);
				return result;
			}
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return 0;
		}
	}

	@Override
	public Shop selectOneShopInfo(String memberId) {
		return memberDao.selectOneShopInfo(memberId);
	}

	@Override
	public int addFollowing(Map<String, Object> map) {
		return memberDao.addFollowing(map);
	}

	@Override
	public int countFollowing(String id) {
		return memberDao.countFollowing(id);
	}

	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	@Override
	public int countFollower(String id) {
		return memberDao.countFollower(id);
	}

	@Override
	public List<Follower> followerList(String id) {
		return memberDao.followerList(id);
	}

	@Override
	public List<Follower> followingList(String id) {
		return memberDao.followingList(id);
	}
 
 
	
	 
	
	
}
              

