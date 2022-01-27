package com.kh.hana.shop.model.service;
import java.util.List;
import java.util.Map;
import com.kh.hana.shop.model.vo.HashTag;
public interface ShopService {
	
    List<Map<String, Object>> selectShopList(Map<String, Object> data);
    
    int insertHashTag(HashTag hashTag);
    
    List<HashTag> hashTagAutocomplete(String search);
    
}
