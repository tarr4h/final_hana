package com.kh.hana.group.model.service;

import java.util.List;
import java.util.Map;

import com.kh.hana.group.model.vo.Group;

public interface GroupService {

	Group selectOneGroup(String groupId);

	int insertOneGroup(Group group);

	Group selectGroupEnrolled(Map<String, String> map);


	

}
