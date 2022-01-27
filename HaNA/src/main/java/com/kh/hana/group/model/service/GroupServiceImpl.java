package com.kh.hana.group.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.hana.group.model.dao.GroupDao;
import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.group.model.vo.GroupBoardComment;
import com.kh.hana.member.model.vo.Member;

import com.kh.hana.group.model.vo.GroupMemberList;
import com.kh.hana.group.model.vo.GroupBoardEntity;

@Service
@Transactional(rollbackFor=Exception.class) // 익셉션 발생시 롤백
public class GroupServiceImpl implements GroupService{

	@Autowired
	private GroupDao groupDao;
	
	@Override
	public Group selectOneGroup(String groupId) {
		return groupDao.selectOneGroup(groupId);
	}

	@Override
	public int insertOneGroup(Group group) {
		return groupDao.insertOneGroup(group);
	}

	@Override
	public List<Group> selectGroupList(Member member) {
		return groupDao.selectGroupList(member);
	}
	
  @Override
	public int insertGroupBoard(GroupBoardEntity groupBoard) {
		return groupDao.insertGroupBoard(groupBoard);
	}

	@Override
	public GroupBoard selectOneBoard(int no) {
		return groupDao.selectOneBoard(no);
	}

	@Override
	public List<Member> selectTagMemberList(GroupBoardEntity groupBoard) {
		return groupDao.selectTagMemberList(groupBoard);
	}

	@Override
	public List<Map<String,String>> selectGroupMemberList(String groupId) {
		return groupDao.selectGroupMemberList(groupId);
	}

	@Override
	public List<GroupBoardEntity> selectGroupBoardList(String groupId) {
		return groupDao.selectGroupBoardList(groupId);
	}

	@Override
	public int insertEnrollGroupForm(Map<String, Object> map) {
		return groupDao.insertEnrollGroupForm(map);
	}

	@Override
	public List<Map<String, Object>> getGroupApplyRequest(String groupId) {
		return groupDao.getGroupApplyRequest(groupId);
	}

  
	 @Override
	 public int insertGroupBoardComment(GroupBoardComment groupBoardComment) {
		return groupDao.insertGroupBoardComment(groupBoardComment);
	 }
	
	@Override
	public int insertGroupMember(Map<String, Object> map) {
		return groupDao.insertGroupMember(map);
	}

	@Override
	public int deleteGroupApplyList(Map<String, Object> map) {
		return groupDao.deleteGroupApplyList(map);
	}	

	@Override
	public List<GroupBoardComment> selectGroupBoardCommentList(int boardNo) {
		return groupDao.selectGroupBoardCommentList(boardNo);
	}
	
	@Override
	public int deleteBoardComment(int no) {
		return groupDao.deleteBoardComment(no);
	}

	@Override
	public int deleteGroupBoard(int no) {
		return groupDao.deleteGroupBoard(no);
	}

	@Override
	public int updateBoardContent(Map<String, Object> param) {
		return groupDao.updateBoardContent(param);
	}

//	@Override
//	public List<Map<String, Object>> groupMemberList(String groupId) {
//		return groupDao.groupMemberList(groupId);
//	}

	@Override
	public Group selectGroupInfo(String groupId) {
		return groupDao.selectGroupInfo(groupId);
	}

	@Override
	public List<Map<String, Object>> groupMemberList2(String groupId) {
		return groupDao.groupMemberList2(groupId);
	}

	public Map<String, Object> selectOneLikeLog(Map<String, Object> param) {
		return groupDao.selectOneLikeLog(param);
	}

	@Override
	public int deleteLikeLog(Map<String, Object> param) {
		return groupDao.deleteLikeLog(param);
	}

	@Override
	public int insertLikeLog(Map<String, Object> param) {
		return groupDao.insertLikeLog(param);
	}

	@Override
	public int selectLikeCount(Map<String, Object> param) {
		return groupDao.selectLikeCount(param);
	}

	@Override
	public int deleteGroupMember(String memberId) {
		return groupDao.deleteGroupMember(memberId);
	}

}
