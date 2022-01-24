package com.kh.hana.shop.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TableManage implements Serializable {

	private String reservationNo;
	private Date reservationDate;
	private Date timeStart;
	private Date timeEnd;
	private int visitorCount;
	private String reqOrder;
	private String reservationStatus;
	private String reqUserId;
	private String reservationTableNo;
	private String shopId;
	
}
