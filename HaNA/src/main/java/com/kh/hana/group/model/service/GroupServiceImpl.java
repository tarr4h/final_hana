package com.kh.hana.group.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.hana.group.model.dao.GroupDao;
import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;

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
	public int insertGroupBoard(GroupBoard groupBoard) {
		return groupDao.insertGroupBoard(groupBoard);
	}

}
