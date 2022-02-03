package com.kh.hana.shop.controller;
import java.beans.PropertyEditor;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.common.util.CreateCalendar;
import com.kh.hana.shop.model.service.ShopService;
import com.kh.hana.shop.model.vo.HashTag;
import com.kh.hana.shop.model.vo.Reservation;
import com.kh.hana.shop.model.vo.Table;

import lombok.extern.slf4j.Slf4j;
@Controller
@Slf4j
@RequestMapping("/shop")
public class ShopController {
    @Autowired
    private ShopService shopService;
    
    @GetMapping("/shopMain")
    public void shopMain() {
        
    }
    
	/*
	 * @GetMapping("/shopList") public ResponseEntity<?>
	 * selectShopList(@RequestParam String id, @RequestParam String
	 * locationX, @RequestParam String locationY) { Map<String, Object> data = new
	 * HashMap<>(); data.put("id", id); data.put("locationX", locationX);
	 * data.put("locationY", locationY);
	 * 
	 * // 8.23km내 double maxX = Double.parseDouble(locationX) + 0.0927; double maxY
	 * = Double.parseDouble(locationY) + 0.074;
	 * 
	 * String maxLocationX = Double.toString(maxX); String maxLocationY =
	 * Double.toString(maxY);
	 * 
	 * data.put("maxLocationX", maxLocationX); data.put("maxLocationY",
	 * maxLocationY);
	 * 
	 * log.info("data = {}", data);
	 * 
	 * List<Map<String, Object>> shopList = shopService.selectShopList(data);
	 * log.info("length = {}", shopList.size());
	 * 
	 * return ResponseEntity.ok(shopList); }
	 */    
    
    @GetMapping("/shopList")
    public ResponseEntity<?> selectShopList(@RequestParam(value="selectDataArr[]",required=false) List<String> selectDataArr , @RequestParam String id, @RequestParam String locationX, @RequestParam String locationY) {
    	log.info("selectDataArr = {}", selectDataArr);
        Map<String, Object> data = new HashMap<>();
        data.put("id", id);
        data.put("locationX", locationX);
        data.put("locationY", locationY);
        
//      8.23km내
        double maxX = Double.parseDouble(locationX) + 0.0927;
        double maxY = Double.parseDouble(locationY) + 0.074;
        
        String maxLocationX = Double.toString(maxX);
        String maxLocationY = Double.toString(maxY);
        
        data.put("maxLocationX", maxLocationX);
        data.put("maxLocationY", maxLocationY);
        
        log.info("data = {}", data);
   
        List<Map<String, Object>> shopList = shopService.selectShopList(data,selectDataArr);
        log.info("length = {}", shopList.size());
        
        return ResponseEntity.ok(shopList);
    }
    
    @PostMapping("/insertHashTag")
    public String insertHashTag(HashTag hashTag, RedirectAttributes redirectAttr) {
        log.info("hashTag = {}", hashTag);
        hashTag.setTagId("shop-hashtag-");
        
        int result = shopService.insertHashTag(hashTag);
        log.info("hashTag Result = {}", result);
        
        String msg = "";
        if(result > 0) {
        	msg = "등록에 성공했습니다.";
        } else {
        	msg = "이미 등록된 해시태그 입니다.";
        }
        
        redirectAttr.addFlashAttribute("msg", msg);
        
        return "redirect:/member/shopSetting/hashtag";
    }
    
    @GetMapping("/selectShopHashTag")
    public ResponseEntity<?> selectShopHashTag(@RequestParam String memberId){
    	log.info("memberId = {}", memberId);
    	
    	List<HashTag> shopHashTagList = shopService.selectShopHashTag(memberId);
    	log.info("shopHashTag List = {}", shopHashTagList);
    	
    	return ResponseEntity.ok(shopHashTagList);
    }
    
    @GetMapping("/hashTagAutocomplete")
    public ResponseEntity<?> hashTagAutocomplete( String search) {
        log.info("search = {}", search);
        List<HashTag> tagList = shopService.hashTagAutocomplete(search);
        log.info("tagList = {}", tagList);
        
        return ResponseEntity.ok(tagList);
    }

    @PostMapping("/insertShopTable")
    public ResponseEntity<?> insertShopTable(@RequestBody Table table){
    	log.info("table = {}", table);
    	
    	int result = shopService.insertShopTable(table);
    	log.info("insertTable result = {}", result);
    	
    	String msg = "";
    	if(result == 1) {
    		msg = "등록되었습니다.";
    	} else {
    		msg = "중복된 테이블명 입니다. 테이블명을 수정해주세요";
    	}
    	Map<String, Object> msgMap = new HashMap<>();
    	msgMap.put("msg", msg);
    	
    	return ResponseEntity.ok(msgMap);
    }
    
    @GetMapping("/loadShopTable")
    public ResponseEntity<?> selectShopTableList(@RequestParam String id){
    	log.info("loadShopTable id = {}", id);
    	
    	List<Table> tableList = shopService.selectShopTableList(id);
    	
    	return ResponseEntity.ok(tableList);
    }
    
    @DeleteMapping(value="/deleteShopTable", produces="application/text;charset=utf8")
    @ResponseBody
    public ResponseEntity<?> deleteShopTable(@RequestBody Table table){
    	
    	String tableId = table.getTableId();
    	log.info("tableId = {}", tableId);
    	
    	int result = shopService.deleteShopTable(tableId);
    	log.info("result = {}", result);
    	 
    	return ResponseEntity.ok().build();
    }
    
    @PutMapping(value="/updateShopTable", produces="application/text;charset=utf8")
    @ResponseBody
    public ResponseEntity<?> updateShopTable(@RequestBody Table table){
    	log.info("updateTable = {}", table);
    	
    	int result = shopService.updateTable(table);
    	log.info("updateResult = {}", result);
    	 
    	return ResponseEntity.ok().build();
    }
    
    @GetMapping("/selectOneTable/getReservationTime")
    public ResponseEntity<?> getReservationTime(Table reqTable, @RequestParam Date date){    	
    	Table table = shopService.selectOneTable(reqTable);
    	
    	Map<String, Object> infoMap = new HashMap<>();
    	infoMap.put("date", date);
    	infoMap.put("tableId", reqTable.getTableId());
    	
    	List<Reservation> reservation = shopService.selectTableReservation(infoMap);
    	
    	List<Map<String, Object>> timeMapList = new ArrayList<>();
    	
    	String startTime = table.getAllowStart();
    	int timeDiv = table.getTimeDiv();
    	String endTime = table.getAllowEnd();
    	
    	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
    	
    	Date psStartTime = new Date();
    	Date psEndTime = new Date();
    	try {
			psStartTime = sdf.parse(startTime);
			psEndTime = sdf.parse(endTime);
			
			while(true) {
				Date eachStartTime = psStartTime;  
				Calendar cal = Calendar.getInstance();
				cal.setTime(psStartTime);
				cal.add(Calendar.MINUTE, timeDiv);
				psStartTime = cal.getTime();
				if(psStartTime.after(psEndTime)) {
					cal.add(Calendar.MINUTE, -timeDiv);
					psStartTime = cal.getTime();
					break;
				}
		    	Map<String, Object> timeMap = new HashMap<>();
				timeMap.put("startTime", sdf.format(eachStartTime));
				timeMap.put("endTime", sdf.format(psStartTime));
		    	for(Reservation res : reservation) {
		    		if(res.getTimeStart().equals(sdf.format(eachStartTime))) {
		    			timeMap.put("status", res.getReservationStatus());
		    		}
		    	}
				
				timeMapList.add(timeMap);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	
    	log.info("timeList = {}", timeMapList);
    	
    	
    	return ResponseEntity.ok(timeMapList);
    }
    
    @PostMapping(value="/reservation/insert", produces="application/text;charset=utf8")
    @ResponseBody
    public ResponseEntity<?> insertReservation(@RequestBody Reservation reservation){
    	
    	log.info("insertReservation REs = {}", reservation);
    	
    	int result = shopService.insertReservation(reservation);
    	log.info("reservation result = {}", result);
    	
    	String msg = result > 0 ? "등록되었습니다." : "예약 실패, 다시 시도해주세요";
    	
    	return ResponseEntity.ok(msg);
    }
    
    @GetMapping("/createCalendar")
    @ResponseBody
    public ResponseEntity<?> createCalendar(@RequestParam int year, @RequestParam int month){
    	log.info("year, month = {}, {}", year, month);
    	
    	Map<String, Object> map = CreateCalendar.createCalendar(year, month);
    	log.info("map = {}", map);
    	
    	return ResponseEntity.ok(map);
    }
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	PropertyEditor editor = new CustomDateEditor(sdf, true);
    	binder.registerCustomEditor(Date.class, editor);
    }
}