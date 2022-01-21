package com.kh.hana.shop.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.common.util.CalculateArea;
import com.kh.hana.shop.model.dao.ShopDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopDao shopDao;

	@Override
	public List<Map<String, Object>> selectShopList(Map<String, Object> data) {
		List<Map<String, Object>> shopList = shopDao.selectShopList(data);
		log.info("shopList = {}", shopList);
		
		String locationX = (String)data.get("locationX");
		String locationY = (String)data.get("locationY");
		log.info("locationX, Y = {}, {}", locationX, locationY);
		
		List<Map<String, Object>> lastShopList = new ArrayList<>();
		for(Map<String, Object> shop : shopList) {
			String x = (String) shop.get("LOCATION_X");
			String y = (String) shop.get("LOCATION_Y");
			log.info("x = {}, y = {}", x, y);
			boolean bool = CalculateArea.calculateArea(locationX, locationY, x, y);
			log.debug("calTest = {}", bool);
			
			if(bool == true) {
				lastShopList.add(shop);
			}
		}
		log.info("shopList LAsts = {}", lastShopList);
		return lastShopList;
	}
	


	
	
}
