package com.kh.hana.mbti.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.mbti.model.vo.Mbti;

public interface MbtiDao {

	List<Mbti> selectMbtiList();

	int insertList(Map<Integer, Integer> resultOfNo, String memberId);

}