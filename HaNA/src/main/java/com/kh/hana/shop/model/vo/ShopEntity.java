package com.kh.hana.shop.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ShopEntity {

	private String id;
	private String bussinessHourStart;
	private String bussinessHourEnd;
	private String locationX;
	private String locationY;
	private String address;
	private String addressDetail;
	private String shopIntroduce;
	
	
}
