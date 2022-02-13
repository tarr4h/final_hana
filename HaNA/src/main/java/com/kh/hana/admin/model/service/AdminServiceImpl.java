package com.kh.hana.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.hana.admin.model.dao.AdminDao;

@Service
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminDao adminDao;

	@Override
	public List<Map<String, Object>> selectSearchStatistics(Map<String, Object> param) {
		return adminDao.selectSearchStatistics(param);
	}

	@Override
	public int insertHashtag(String name) {
		return adminDao.insertHashtag(name);
	}

	@Override
	public int deleteHashtag(String name) {
		return adminDao.deleteHashtag(name);
	}

}
