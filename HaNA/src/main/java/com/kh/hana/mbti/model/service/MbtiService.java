package com.kh.hana.mbti.model.service;

import java.util.List;
import java.util.Map;

import com.kh.hana.mbti.model.vo.Mbti;

public interface MbtiService {

	List<Mbti> selectMbtiList(int Cpage);

	int insertList(Map<Integer, Integer> resultOfNo, String memberId);


}