package com.kh.hana.shop.model.service;

import java.util.List;
import java.util.Map;

public interface ShopService {

	List<Map<String, Object>> selectShopList(Map<String, Object> data);
	
}
