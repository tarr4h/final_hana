package com.kh.hana.common.util;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CreateCalendar {
	
	public static Map<String, Object> createCalendar(int year, int month){
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month-1);
		cal.set(Calendar.DATE, 1);
		
		int lastDay = cal.getActualMaximum(cal.DAY_OF_MONTH);		
		log.info("lastDay", lastDay);
		
		int startDow = cal.get(cal.DAY_OF_WEEK);
		
//		String dow = "";
//		switch(startDow){
//		case 1: dow = "일"; break;
//		case 2: dow = "월"; break;
//		case 3: dow = "화"; break;
//		case 4: dow = "수"; break;
//		case 5: dow = "목"; break;
//		case 6: dow = "금"; break;
//		case 7: dow = "토"; break;
//		};
		
		Date todayDate = new Date();
		Calendar todayCal = Calendar.getInstance();
		todayCal.setTime(todayDate);
		int today = todayCal.get(Calendar.DATE);
		
		Map<String, Object> dateMap = new HashMap<>();
		dateMap.put("startDow", startDow);
//		dateMap.put("dow", dow);
		dateMap.put("today", today);
		dateMap.put("lastDay", lastDay);
		
		return dateMap;
	}
}
