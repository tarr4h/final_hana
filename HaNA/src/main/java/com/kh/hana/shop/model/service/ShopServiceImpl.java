package com.kh.hana.shop.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hana.common.util.CalculateArea;
import com.kh.hana.shop.model.dao.ShopDao;
import com.kh.hana.shop.model.vo.HashTag;
import com.kh.hana.shop.model.vo.Reservation;
import com.kh.hana.shop.model.vo.Table;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopDao shopDao;

	@Override
	public List<Map<String, Object>> selectShopList(Map<String, Object> data,List<String> selectDataArr) {
		List<Map<String, Object>> shopList = new ArrayList<Map<String, Object>>();
		
		// 해시태그가 없을때 
		if(selectDataArr == null) {
			 shopList = shopDao.selectShopList(data);			
			log.info("해시태그가 없는 = {}", shopList);
		}else {
			// 해시태그가 있을때 
			List<String> tags = new ArrayList<>();
			for(String str : selectDataArr) {
				tags.add(str);
				data.put("tags", tags);
				log.info("tags = {}", tags);
				log.info("data = {}", data);
			}
			 shopList = shopDao.selectHashTagShopList(data);			
			 log.info("해시태그 있는  = {}", shopList);
		}
		String locationX = (String)data.get("locationX");
		String locationY = (String)data.get("locationY");
		
		List<Map<String, Object>> lastShopList = new ArrayList<>();
		for(Map<String, Object> shop : shopList) {
			String x = (String) shop.get("LOCATION_X");
			String y = (String) shop.get("LOCATION_Y");
			log.info("serv shop = {}", shop);
			boolean bool = CalculateArea.calculateArea(locationX, locationY, x, y);
			log.info("calTest = {}", bool);
			
			if(bool == true) {
				lastShopList.add(shop);
			}
		}
		log.info("shopList LAsts = {}", lastShopList);
		log.info("listSize = {}", lastShopList.size());
		return lastShopList;
		
	}

	/*
	 * @Override public List<Map<String, Object>> selectShopList(Map<String, Object>
	 * data) { List<Map<String, Object>> shopList = shopDao.selectShopList(data);
	 * log.info("shopList = {}", shopList);
	 * 
	 * String locationX = (String)data.get("locationX"); String locationY =
	 * (String)data.get("locationY");
	 * 
	 * List<Map<String, Object>> lastShopList = new ArrayList<>(); for(Map<String,
	 * Object> shop : shopList) { String x = (String) shop.get("LOCATION_X"); String
	 * y = (String) shop.get("LOCATION_Y"); log.info("serv shop = {}", shop);
	 * boolean bool = CalculateArea.calculateArea(locationX, locationY, x, y);
	 * log.info("calTest = {}", bool);
	 * 
	 * if(bool == true) { lastShopList.add(shop); } }
	 * log.info("shopList LAsts = {}", lastShopList); log.info("listSize = {}",
	 * lastShopList.size()); return lastShopList; }
	 */
	
	@Override
	public int insertHashTag(HashTag hashTag) {
		HashTag tag = shopDao.searchHashTag(hashTag);
		
		int result = 0;
		if(tag == null) {
			result = shopDao.insertHashTag(hashTag);
			if(result > 0) {
				result = shopDao.insertShopHashTag(hashTag);
			}
		} else {
			hashTag.setTagId(tag.getTagId());
			HashTag shopHashTag = shopDao.searchShopHashTag(hashTag);
			if(shopHashTag == null) {
				result = shopDao.insertShopHashTag(hashTag);				
			}
		}
		return result;
	}

	@Override
	public List<HashTag> selectShopHashTag(String memberId) {
		return shopDao.selectShopHashTag(memberId);
	}

	@Override public List<HashTag> hashTagAutocomplete(String search) { 
		  return shopDao.hashTagAutocomplete(search); 
	}

	@Override
	public int insertShopTable(Table table) {
		String verifyName = shopDao.verifyTableName(table);
		log.info("verify? = {}", verifyName == null);
		int result = 0;
		if(verifyName == null) {
			result = shopDao.insertShopTable(table);			
			return result;
		} else {
			return result;
		}
	}

	@Override
	public List<Table> selectShopTableList(String id) {
		return shopDao.selectShopTableList(id);
	}

	@Override
	public int deleteShopTable(String tableId) {
		return shopDao.deleteShopTable(tableId);
	}

	@Override
	public int updateTable(Table table) {
		return shopDao.updateShopTable(table);
	}

	@Override
	public Table selectOneTable(Table table) {
		return shopDao.selectOneTable(table);
	}

	@Override
	public int insertReservation(Reservation reservation) {
		return shopDao.insertReservation(reservation);
	}

	@Override
	public List<Reservation> selectTableReservation(Map<String, Object> infoMap) {
		return shopDao.selectTableReservation(infoMap);
	}


	

}
