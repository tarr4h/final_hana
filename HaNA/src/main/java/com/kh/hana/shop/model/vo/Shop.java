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
	
	private List<TableManage> manageTables;

	@Builder
	public Shop(String id, String bussinessHourStart, String bussinessHourEnd, String locationX, String locationY,
			String address, String addressDetail, String shopIntroduce, List<TableManage> manageTables) {
		super(id, bussinessHourStart, bussinessHourEnd, locationX, locationY, address, addressDetail, shopIntroduce);
		this.manageTables = manageTables;
	}


	
	

}
