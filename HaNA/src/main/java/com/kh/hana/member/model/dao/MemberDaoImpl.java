package com.kh.hana.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.member.model.vo.Board;
import com.kh.hana.member.model.vo.BoardComment;
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
	
	@Override
	public List<Map<String, Object>> followingListById(Map<String, Object> map) {
		return session.selectList("member.followingListById", map);
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

	@Override
	public Board selectOneBoard(int no) {
		return session.selectOne("member.selectOneBoard", no);
	}

	@Override
	public Map<String, Object> selectOneLikeLog(Map<String, Object> param) {
		return session.selectOne("member.selectOneLikeLog", param);
	}

	@Override
	public List<Board> selectBoardList(String id) {
		return session.selectList("member.selectBoardList", id);
	}

	@Override
	public int enrollBoardComment(BoardComment boardComment) {
		return session.insert("member.enrollBoardComment", boardComment);
	}

	@Override
	public int deleteBoard(int no) {
		return session.delete("member.deleteBoard", no);
	}

	@Override
	public List<BoardComment> selectBoardCommentList(int boardNo) {
		return session.selectList("member.selectBoardCommentList", boardNo);
	}

	@Override
	public int deleteBoardComment(int no) {
		return session.delete("member.deleteBoardComment", no);
	}

	@Override
	public int updateBoardContent(Map<String, Object> param) {
		return session.update("member.updateBoardContent", param);
				}

	@Override
	public int insertLikeLog(Map<String, Object> param) {
		return session.insert("member.insertLikeLog", param);
	}

	@Override
	public int deleteLikeLog(Map<String, Object> param) {
		return session.delete("member.deleteLikeLog", param);
	}

	@Override
	public int selectLikeCount(Map<String, Object> param) {
		return session.selectOne("selectLikeCount",param);
	}
			 

	@Override
	public int updateMemberProfile(Member member) {
		return session.update("member.updateMemberProfile", member);
	}

	

 


 
	
	
}
