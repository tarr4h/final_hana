package com.kh.hana.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDaoImpl implements ShopDao {

	@Autowired
	public SqlSession session;

	@Override
	public List<Map<String, Object>> selectShopList(Map<String, Object> data) {
		return session.selectList("shop.selectShopList", data);
	}
	
	
}
