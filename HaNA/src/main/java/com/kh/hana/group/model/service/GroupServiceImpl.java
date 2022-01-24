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

import com.kh.hana.group.model.vo.GroupBoardEntity;
import com.kh.hana.member.model.vo.Member;

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
	public Map<String, String> selectGroupEnrolled(Map<String, String> map) {
		return groupDao.selectGroupEnrolled(map);
	}

	@Override
	public List<Group> selectGroupList(Member member) {
		return groupDao.selectGroupList(member);
	}
		
	public int insertGroupBoard(GroupBoardEntity groupBoard) {
		return groupDao.insertGroupBoard(groupBoard);
	}

	@Override
	public GroupBoard selectOneBoard(int no) {
		return groupDao.selectOneBoard(no);
	}

	@Override
	public List<Member> selectMemberList(GroupBoardEntity groupBoard) {
		return groupDao.selectMemberList(groupBoard);
	}

	@Override
	public List<Member> selectGroupMemberList(String groupId) {
		return groupDao.selectGroupMemberList(groupId);
	}

	@Override
	public List<GroupBoardEntity> selectGroupBoardList(String groupId) {
		return groupDao.selectGroupBoardList(groupId);
	}

	@Override
	public int insertGroupBoardComment(GroupBoardComment groupBoardComment) {
		return groupDao.insertGroupBoardComment(groupBoardComment);
	}

}
