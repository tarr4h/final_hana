package com.kh.hana.member.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.Member;

public interface MemberDao {

	int memberEnroll(Member member);

	int updateMember(Member member);

	int updatePersonality(Member member);

	int updateInterest(Member member);

	Member selectPersonality(String id);

	int updateShopMember(Member member);

	int updateShopInfo(Map<String, String> param);

	Map<String, Object> selectShopInfo(String id);

	int insertShopInfo(Map<String, String> param);

	int insertPersonality(Member member);

	int insertInterest(Member member);

	int addFollowing(Map<String, Object> map);

	int countFollowing(String id);

	Member selectOneMember(String id);

	int countFollower(String id);

	List<Follower> followerList(String id);

	List<Follower> followingList(String id);

}
