package com.kh.hana.mbti.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<Mbti> selectMbtiList(int cPage) {
		
		return session.selectList("mbti.selectMbtiList",cPage);
	}

	@Override
	public int insertList(Map<Integer, Integer> resultOfNo, String memberId) {
		log.info("map = {}", resultOfNo);
		
		for(int m : resultOfNo.keySet()) {			
			int no = m;
			int result = resultOfNo.get(m);
			Map<String, Object> map = new HashMap<>();
			map.put("no", no);
			map.put("result", result);
			map.put("memberId", memberId);
			
			int insertResult = session.insert("mbti.insertList", map);
			log.info("insertResult = {}", insertResult);
			
		}
		
		return 0;
	}


}