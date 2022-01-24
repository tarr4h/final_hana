package com.kh.hana.member.model.service;
 
import java.util.List;
import java.util.Map;

import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.Member;

public interface MemberService {

	String test();

	int memberEnroll(Member member);

	int updateMember(Member member, Member oldMember, String id);

	Member selectPersonality(String id);

	int updateShopInfo(Map<String, String> param, Member member);

	int addFollowing(Map<String, Object> map);

	int countFollowing(String id);

	Member selectOneMember(String id);

	int countFollower(String id);

	List<Follower> followerList(String id);

	List<Follower> followingList(String id);

}
