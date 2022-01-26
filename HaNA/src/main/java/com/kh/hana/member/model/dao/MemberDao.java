package com.kh.hana.member.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.vo.Shop;

public interface MemberDao {

	int memberEnroll(Member member);

	int updateMember(Member member);

	int updatePersonality(Member member);

	int updateInterest(Member member);

	Member selectPersonality(String id);

	int insertPersonality(Member member);

	int insertInterest(Member member);

	int addFollowing(Map<String, Object> map);

	int countFollowing(String id);

	Member selectOneMember(String id);

	int countFollower(String id);

	List<Follower> followerList(String friendId);

 
	List<Follower> followingList(String friendId);
 
	Shop selectOneShopInfo(String memberId);

	int updateShopInfo(Shop shop);

	int insertShopInfo(String id);

 

}
