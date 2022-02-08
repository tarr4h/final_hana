package com.kh.hana.group.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.hana.chat.model.dao.ChatDao;
import com.kh.hana.group.model.dao.GroupDao;
import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.group.model.vo.GroupBoardComment;
import com.kh.hana.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

import com.kh.hana.group.model.vo.GroupMemberList;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.group.model.vo.GroupCalendar;

@Service
@Slf4j
@Transactional(rollbackFor=Exception.class) // 익셉션 발생시 롤백
public class GroupServiceImpl implements GroupService{

	@Autowired
	private GroupDao groupDao;
	@Autowired
	private ChatDao chatDao;
	
	@Override
	public Group selectOneGroup(String groupId) {
		return groupDao.selectOneGroup(groupId);
	}

	@Override
	public int insertOneGroup(Group group) {
		int result = 0;
		try {
			result = groupDao.insertOneGroup(group);
			result = chatDao.CreateGroupChat(group);
		}catch(Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public List<Group> selectGroupList(Member member) {
		return groupDao.selectGroupList(member);
	}
	
  @Override
	public int insertGroupBoard(GroupBoard groupBoard) {
		return groupDao.insertGroupBoard(groupBoard);
	}

	@Override
	public GroupBoard selectOneBoard(int no) {
		return groupDao.selectOneBoard(no);
	}

	@Override
	public List<Member> selectTagMemberList(GroupBoard groupBoard) {
		return groupDao.selectTagMemberList(groupBoard);
	}

	@Override
	public List<Map<String,String>> selectGroupMemberList(String groupId) {
		return groupDao.selectGroupMemberList(groupId);
	}

	@Override
	public List<GroupBoard> selectGroupBoardList(String groupId) {
		return groupDao.selectGroupBoardList(groupId);
	}

	@Override
	public int insertEnrollGroupForm(Map<String, Object> map) {
		return groupDao.insertEnrollGroupForm(map);
	}

	@Override
	public List<Map<String, Object>> selectGroupApplyList(String groupId) {
		return groupDao.selectGroupApplyList(groupId);
	}

  
	 @Override
	 public int insertGroupBoardComment(GroupBoardComment groupBoardComment) {
		return groupDao.insertGroupBoardComment(groupBoardComment);
	 }
	
	@Override
	public int insertGroupMember(Map<String, Object> map) {
		int result = 0;
		try {
			result = groupDao.insertGroupMember(map); // 멤버 추가
			result = groupDao.updateApplyHandled(map); // 처리여부 업데이트
    		result = chatDao.insertGroupMessage22(map); // 그룹톡 입장
		}catch(Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public int updateApplyHandled(Map<String, Object> map) {
		return groupDao.updateApplyHandled(map);
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


	@Override
	public Group selectGroupInfo(String groupId) {
		return groupDao.selectGroupInfo(groupId);
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

	@Override
	public int updateGroupGrade(Map<String, Object> map) {
		return groupDao.updateGroupGrade(map);
	}

	@Override
	public int updateGroup(Group group) {
		return groupDao.updateGroup(group);
	}

	
	public int deleteAllCalendar(String groupId) {
		return groupDao.deleteAllCalendar(groupId);
	}

	@Override
	public int insertCalendarData(Map<String, Object> p) {
		return groupDao.insertCalendarData(p);
	}

	@Override
	public List<GroupCalendar> selectCalendarData(String groupId) {
		return groupDao.selectCalendarData(groupId);
	}

	@Override
	public int profileImage(Group group) {
		return groupDao.profileImage(group);
	}

	public int deleteCalendarData(Map<String, Object> param) {
		return groupDao.deleteCalendarData(param);
	}

	@Override
	public List<GroupBoard> selectGroupBoardListByLocation(GroupBoard groupBoard) {
		return groupDao.selectGroupBoardListByLocation(groupBoard);
	}

	@Override
	public int insertGroupVisitLog(Map<String, Object> param) {
		int result = 0;
		Map<String,Object> map = groupDao.selectGroupVisitLog(param);
		if(map==null) {
			result = groupDao.insertGroupVisitLog(param);
		}
		
		return result;
	}

	@Override
	public List<Map<String, Object>> selectVisitCountList(Map<String, Object> param) {
		return groupDao.selectVisitCountList(param);
	}

	@Override
	public List<Map<String, Object>> selectCommentCountList(Map<String, Object> param) {
		return groupDao.selectCommentCountList(param);
	}

	@Override
	public List<Map<String, Object>> selectLikeCountList(Map<String, Object> param) {
		return groupDao.selectLikeCountList(param);
	}

}
