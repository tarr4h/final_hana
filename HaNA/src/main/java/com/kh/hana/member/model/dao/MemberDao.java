package com.kh.hana.member.model.dao;

import java.util.Map;

import com.kh.hana.member.model.vo.Member;

public interface MemberDao {

	int memberEnroll(Member member);

	int updateMember(Member member, String id);

	int updatePersonality(Member member, String id);

	int updateInterest(Member member, String id);

	Member selectPersonality(String id);

	int updateShopMember(Member member);

	int updateShopInfo(Map<String, String> param);

	Map<String, Object> selectShopInfo(String id);

	int insertShopInfo(Map<String, String> param);

}
