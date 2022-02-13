package com.kh.hana.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
	private SqlSession session;

	@Override
	public List<Map<String, Object>> selectSearchStatistics(Map<String, Object> param) {
		return session.selectList("admin.selectSearchStatistics",param);
	}

	@Override
	public int insertHashtag(String name) {
		return session.insert("admin.insertHashtag",name);
	}

	@Override
	public int deleteHashtag(String name) {
		return session.delete("deleteHashtag",name);
	}
	
}
