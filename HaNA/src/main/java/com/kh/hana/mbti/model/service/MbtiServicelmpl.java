package com.kh.hana.mbti.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.mbti.model.dao.MbtiDao;
import com.kh.hana.mbti.model.vo.Mbti;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MbtiServicelmpl implements MbtiService {

	@Autowired
	private MbtiDao mbtiDao;

	@Override
	public List<Mbti> selectMbtiList(int cPage) {
		return mbtiDao.selectMbtiList(cPage);
	}

	@Override
	public int insertList(Map<Integer, Integer> resultOfNo, String memberId) {
		return mbtiDao.insertList(resultOfNo, memberId);
	}


}