package com.kh.hana.mbti.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.mbti.model.vo.Mbti;
import com.kh.hana.mbti.model.vo.MemberMbti;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MbtiDaolmpl implements MbtiDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Mbti> selectMbtiList(Map<String, Object> number) {
		return session.selectList("mbti.selectMbtiList", number);
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

	@Override
	public List<Map<String, Object>> selectMbtiResult(String memberId) {
		log.info("selectMbtiResult = {}", memberId);
		return  session.selectList("mbti.selectMbtiResult", memberId);
	}

	@Override
	public MemberMbti selectProfile(Map<String, Object> map) {
		log.info("selectProfile = {}",map);
		return session.selectOne("mbti.selectProfile", map);
	}

	@Override
	public int insertProfile(Map<String, Object> map) {
		log.info("insertProfile = {}",map);
		return  session.insert("mbti.insertProfile", map);

	}

	@Override
	public int updateProfile(Map<String, Object> map) {
		log.info("updateProfile = {}",map);
		return  session.update("mbti.updateProfile", map);
		
	}

	

	


	
	


}