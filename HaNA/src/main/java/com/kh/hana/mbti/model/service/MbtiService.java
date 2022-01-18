package com.kh.hana.mbti.model.service;

import java.util.List;

import com.kh.hana.mbti.model.vo.Mbti;

public interface MbtiService {

	List<Mbti> selectMbtiList();

	Object insertList(String[] checkList);

}