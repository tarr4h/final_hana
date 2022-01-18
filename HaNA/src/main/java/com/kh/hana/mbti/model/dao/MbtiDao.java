package com.kh.hana.mbti.model.dao;

import java.util.List;

import com.kh.hana.mbti.model.vo.Mbti;

public interface MbtiDao {

	List<Mbti> selectMbtiList();

	Object insertList(String[] checkList);

}