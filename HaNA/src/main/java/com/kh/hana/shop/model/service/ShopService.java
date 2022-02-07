package com.kh.hana.shop.model.service;
import java.util.List;
import java.util.Map;
import com.kh.hana.shop.model.vo.HashTag;
import com.kh.hana.shop.model.vo.Reservation;
import com.kh.hana.shop.model.vo.Table;
public interface ShopService {
	
    List<Map<String, Object>> selectShopList(Map<String, Object> data, List<String> selectDataArr);
    
    int insertHashTag(HashTag hashTag);
    
    List<HashTag> hashTagAutocomplete(String search);
    
    int insertRankingData(Map<String, Object> rankingMap);

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

	int deleteReservation(String reservationNo);

	

}
