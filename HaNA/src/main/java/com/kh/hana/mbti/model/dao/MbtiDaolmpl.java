package com.kh.hana.mbti.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.mbti.model.vo.Mbti;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MbtiDaolmpl implements MbtiDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Mbti> selectMbtiList() {
		
		return session.selectList("mbti.selectMbtiList");
	}
}