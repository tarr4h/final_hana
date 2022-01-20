package com.kh.hana.member.model.dao;

import com.kh.hana.member.controller.Personality;
import com.kh.hana.member.model.vo.Member;

public interface MemberDao {

	int memberEnroll(Member member);

	int updateMember(Member member);

	int updatePersonality(Member member);

	int updateInterest(Member member);

	Member selectPersonality(String id);

	int insertPersonality(String id);

	int insertInterest(String id);

}
