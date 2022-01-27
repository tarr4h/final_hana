package com.kh.hana.shop.model.service;
import java.util.List;
import java.util.Map;
import com.kh.hana.shop.model.vo.HashTag;
import com.kh.hana.shop.model.vo.Table;
public interface ShopService {
	
    List<Map<String, Object>> selectShopList(Map<String, Object> data);
    
    int insertHashTag(HashTag hashTag);
    
    List<HashTag> hashTagAutocomplete(String search);

	int insertShopTable(Table table);

	List<Table> selectShopTableList(String id);

	int deleteShopTable(String tableName);

	int updateTable(Table table);
    
}
