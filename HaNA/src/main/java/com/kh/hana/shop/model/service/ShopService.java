package com.kh.hana.shop.model.service;
import java.util.List;
import java.util.Map;

import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.vo.HashTag;
import com.kh.hana.shop.model.vo.Reservation;
import com.kh.hana.shop.model.vo.Table;
public interface ShopService {
	
    List<Map<String, Object>> selectShopList(Map<String, Object> data, List<String> selectDataArr, int limit);
    
    int insertHashTag(HashTag hashTag);
    
    List<HashTag> hashTagAutocomplete(String search);

	int insertShopTable(Table table);

	List<Table> selectShopTableList(String id);

	int deleteShopTable(String tableId);

	int updateTable(Table table);

	Table selectOneTable(Table table);

	int insertReservation(Reservation reservation);

	List<Reservation> selectTableReservation(Map<String, Object> infoMap);

	List<HashTag> selectShopHashTag(String memberId);

	int shopReservationCount(String shopId);

	List<Reservation> selectShopReservationListByDate(Map<String, Object> map);

	Map<String, Object> selectMyReservationList(Map<String, Object> map);

	int cancleReservation(String reservationNo);

	Reservation selectOneReservation(String reservationNo);

	int insertReservationShare(Reservation reservation);

	Reservation checkShareAccepted(Map<String, String> map);

	List<Member> selectAcceptedFriends(String reservationNo);

	List<Table> selectTablePrice(String id);

	int updateTablePrice(Table table);



}
