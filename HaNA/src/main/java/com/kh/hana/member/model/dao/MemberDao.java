package com.kh.hana.member.model.dao;

import java.util.Map;

import com.kh.hana.member.model.vo.Member;

public interface MemberDao {

	int memberEnroll(Member member);

	int updateMember(Member member);

	int updatePersonality(Member member);

	int updateInterest(Member member);

	Member selectPersonality(String id);

	int insertPersonality(Member member);

	int insertInterest(Member member);

	int addFollowing(Map<String, Object> map);

}
