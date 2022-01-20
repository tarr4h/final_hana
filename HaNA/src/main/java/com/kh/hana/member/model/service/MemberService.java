package com.kh.hana.member.model.service;
 
import java.util.Map;

import com.kh.hana.member.model.vo.Member;

public interface MemberService {

	String test();

	int memberEnroll(Member member);

	int updateMember(Member member, Member oldMember, String id);

	Member selectPersonality(String id);
	

	int updateShopInfo(Map<String, Object> param);

}
