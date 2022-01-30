package com.kh.hana.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.member.model.vo.Board;
import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.vo.Shop;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public int memberEnroll(Member member) {
		return session.insert("member.memberEnroll", member);
	}

	@Override
	public int updateMember(Member member) {
		return session.update("member.updateMember", member);
	}

//	@Override
//	public int updatePersonality(Member member) {
//		return session.update("member.updatePersonality", member);
//	}
//
//	@Override
//	public int updateInterest(Member member) {
//		return session.update("member.updateInterest", member);
//	}

//	@Override
//	public Member selectPersonality(String id) {
//		return session.selectOne("member.selectPersonality", id);
//	}

//	public int insertPersonality(Member member) {
//		return session.insert("member.insertPersonality", member);
//	}
//
//	@Override
//	public int insertInterest(Member member) {
//		return session.insert("member.insertInterest", member);
//	}

	@Override
	public int addFollowing(Map<String, Object> map) {
		return session.insert("member.addFollowing", map);
	}

	@Override
	public int countFollowing(String id) {
		return session.selectOne("member.countFollowing",id);
	}

	@Override
	public int countFollower(String id) {
		return session.selectOne("member.countFollower", id);
	}
	
	@Override
	public Member selectOneMember(String id) {
		return session.selectOne("member.selectOneMember", id);
	}

	@Override
	public List<Follower> followerList(String friendId) {
		return session.selectList("member.followerList", friendId);
	}

	@Override
 
	public List<Follower> followingList(String friendId) {
		return session.selectList("member.followingList", friendId);
	}
 
	public Shop selectOneShopInfo(String memberId) {
		return session.selectOne("member.selectOneShopInfo", memberId);
	}

	@Override
	public int updateShopInfo(Shop shop) {
		return session.update("member.updateShopInfo", shop);
	}

	@Override
	public int insertShopInfo(String id) {
		return session.insert("member.insertShopInfo", id);
	}

	@Override
	public int insertMemberBoard(Board board) {
		return session.insert("member.insertMemberBoard", board);
	}
 
	@Override
	public int updatePassword(Member updateMember) {
		return session.update("member.updatePassword", updateMember);
	}

	

 


 
	
	
}
