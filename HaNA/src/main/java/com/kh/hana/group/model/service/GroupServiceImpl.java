package com.kh.hana.group.model.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.hana.group.model.dao.GroupDao;
import com.kh.hana.group.model.vo.Group;

public class GroupServiceImpl implements GroupService{

	@Autowired
	private GroupDao groupDao;
	
	@Override
	public Group selectOneGroup(String groupId) {
		return groupDao.selectOneGroup(groupId);
	}

}
