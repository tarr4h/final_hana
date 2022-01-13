package com.kh.hana.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.member.model.dao.MemberDao;
import com.kh.hana.shop.model.service.ShopService;

@Service
public class MemberServiceImpl implements ShopService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public String test() {
		// TODO Auto-generated method stub
		return null;
	}

}
