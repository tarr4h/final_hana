package com.kh.hana.group.model.dao;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;

public interface GroupDao {
	
	public Group selectOneGroup(String groupId);

	public int insertOneGroup(Group group);

	public int insertGroupBoard(GroupBoard groupBoard);

}
