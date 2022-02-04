package com.kh.hana.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.member.model.dao.MemberDao;
import com.kh.hana.member.model.vo.Board;
import com.kh.hana.member.model.vo.BoardComment;
import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.vo.Shop;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public int memberEnroll(Member member) {
		int result = memberDao.memberEnroll(member);
		if(member.getAccountType() == 0) {
			result = memberDao.insertShopInfo(member.getId());
		}
		return result;
	}

	@Override
	public int updateMember(Member member, Member oldMember) {
		int result = memberDao.updateMember(member);
		log.info("result ={}", result);
//		int result2 = 0;
//		int result3 = 0;
//  	log.info("memberPersonality ={}", member.getPersonality());
//		if(oldMember.getPersonality() != null) {
//			result2 = memberDao.updatePersonality(member);
//		}else {
//			result2 = memberDao.insertPersonality(member);
//		}
//		
//		if(oldMember.getInterest() != null) {
//			result3 = memberDao.updateInterest(member);
//		}else {
//			result3 = memberDao.insertInterest(member);
//		}		
//		if(result1 == 1) {
//			return 1;
//		}
//		else {
//			return 0;
//		}
		return result;		
	}

//	@Override
//	public Member selectPersonality(String id) {
//		Member member = memberDao.selectPersonality(id);
//		log.info("id={}", id);
//		return member;
//	}

	@Override
	public int updateShopInfo(Shop shop) {
		try {
			return memberDao.updateShopInfo(shop);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return 0;
		}
	}

	@Override
	public Shop selectOneShopInfo(String memberId) {
		return memberDao.selectOneShopInfo(memberId);
	}

	@Override
	public int addFollowing(Map<String, Object> map) {
		return memberDao.addFollowing(map);
	}

	@Override
	public int countFollowing(String id) {
		return memberDao.countFollowing(id);
	}

	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	@Override
	public int countFollower(String id) {
		return memberDao.countFollower(id);
	}

	@Override
	public List<Follower> followerList(String friendId) {
		return memberDao.followerList(friendId);
	}

	@Override
	public List<Follower> followingList(String friendId) {
		return memberDao.followingList(friendId);
	}

	@Override
	public int insertMemberBoard(Board board) {
		return memberDao.insertMemberBoard(board);
	}

	@Override
	public int updateMemberProfile(Member member) {
		return memberDao.updateMemberProfile(member);
	}
	
	public int updatePassword(Member updateMember) {
		return memberDao.updatePassword(updateMember);
	}

	@Override
	public Board selectOneBoard(int no) {
		return memberDao.selectOneBoard(no);
	}

	@Override
	public List<Board> selectBoardList(String id) {
		return memberDao.selectBoardList(id);
	}

	@Override
	public int enrollBoardComment(BoardComment boardComment) {
		return memberDao.enrollBoardComment(boardComment);
	}

	@Override
	public int deleteBoard(int no) {
		return memberDao.deleteBoard(no);
	}

	@Override
	public List<BoardComment> selectBoardCommentList(int boardNo) {
		return memberDao.selectBoardCommentList(boardNo);
	}

	@Override
	public int deleteBoardComment(int no) {
		return memberDao.deleteBoardComment(no);
	}

	@Override
	public int updateBoardContent(Map<String, Object> param) {
		return memberDao.updateBoardContent(param);
	}

	@Override
	public int insertLikeLog(Map<String, Object> param) {
		return memberDao.insertLikeLog(param);
	}

	@Override
	public Map<String, Object> selectOneLikeLog(Map<String, Object> param) {
		return memberDao.selectOneLikeLog(param);
	}

	@Override
	public int deleteLikeLog(Map<String, Object> param) {
		return memberDao.deleteLikeLog(param);
	}

	@Override
	public int selectLikeCount(Map<String, Object> param) {
		return memberDao.selectLikeCount(param);
	}

	 
	
	
}
              

