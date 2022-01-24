package com.kh.hana.shop.model.dao;

import java.util.List;
import java.util.Map;

public interface ShopDao {

	List<Map<String, Object>> selectShopList(Map<String, Object> data);

	

}
