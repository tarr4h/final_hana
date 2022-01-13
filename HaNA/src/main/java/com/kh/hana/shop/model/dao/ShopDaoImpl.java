package com.kh.hana.shop.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDaoImpl implements ShopDao {

	@Autowired
	public SqlSession session;
	
	@Override
	public String test() {
		return session.selectOne("shop.selectTest");
	}
	
}
