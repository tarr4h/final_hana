package com.kh.hana.group.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.hana.group.model.vo.Group;

@Mapper
public class GroupDao {

	@Autowired
	private SqlSessionTemplate session;
	
	public Group selectOneGroup(String groupId) {
		return session.selectOne("group.selectOneGroup", groupId);
	}

}
