package com.kh.hana.member.model.dao;

import com.kh.hana.member.model.vo.Member;

public interface MemberDao {

	int memberEnroll(Member member);

	int updateMember(Member member, String id);

	int updatePersonality(Member member, String id);

	int updateInterest(Member member, String id);

	Member selectPersonality(String id);

	int addFollowing(String id);

}
