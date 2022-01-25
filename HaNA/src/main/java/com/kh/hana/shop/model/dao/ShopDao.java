package com.kh.hana.shop.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.shop.model.vo.HashTag;

public interface ShopDao {

	List<Map<String, Object>> selectShopList(Map<String, Object> data);

	int insertHashTag(HashTag hashTag);

	

}
