package com.kh.hana.group.model.service;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;

public interface GroupService {

	Group selectOneGroup(String groupId);

	int insertOneGroup(Group group);

	int insertGroupBoard(GroupBoard groupBoard);

}
