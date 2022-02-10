package com.kh.hana.shop.model.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Shop extends ShopEntity implements Serializable {
	
	private List<Reservation> manageTables;

	@Builder
	public Shop(String id, String shopName, String bussinessHourStart, String bussinessHourEnd, String locationX, String locationY,
			String address, String addressDetail, String shopIntroduce, List<Reservation> manageTables) {
		super(id, shopName, bussinessHourStart, bussinessHourEnd, locationX, locationY, address, addressDetail, shopIntroduce);
		this.manageTables = manageTables;
	}


	
	

}
