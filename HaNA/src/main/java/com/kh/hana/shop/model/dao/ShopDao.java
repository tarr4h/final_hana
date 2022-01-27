package com.kh.hana.shop.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.shop.model.vo.HashTag;
import com.kh.hana.shop.model.vo.Table;

public interface ShopDao {

	List<Map<String, Object>> selectShopList(Map<String, Object> data);

	int insertHashTag(HashTag hashTag);

	 List<HashTag> hashTagAutocomplete(String search);

	int insertShopTable(Table table);

	String verifyTableName(String tableName);

	List<Table> selectShopTableList(String id);

	int deleteShopTable(String tableName);

	

}
