package com.kh.hana.group.model.dao;

import java.util.Map;

import com.kh.hana.group.model.vo.Group;

public interface GroupDao {
	
	public Group selectOneGroup(String groupId);

	public int insertOneGroup(Group group);

	public Group selectGroupEnrolled(Map<String, String> map);

}
