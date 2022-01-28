package com.kh.hana.shop.controller;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.shop.model.service.ShopService;
import com.kh.hana.shop.model.vo.HashTag;
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
        hashTag.setTagId("shop");
        
        int result = shopService.insertHashTag(hashTag);
        log.info("hashTag Result = {}", result);
        
        return "redirect:/member/shopSetting/hashtag";
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
    
    @DeleteMapping(value="/deleteShopTable/{tableId}", produces="application/text;charset=utf8")
    @ResponseBody
    public ResponseEntity<?> deleteShopTable(@PathVariable String tableId){
    	log.info("tableId = {}", tableId);
    	
    	int result = shopService.deleteShopTable(tableId);
    	log.info("result = {}", result);
    	
    	String msg = result > 0 ? "삭제되었습니다." : "삭제되지 않았습니다."; 
    	return ResponseEntity.ok(msg);
    }
    
    @PutMapping(value="/updateShopTable", produces="application/text;charset=utf8")
    @ResponseBody
    public ResponseEntity<?> updateShopTable(@RequestBody Table table){
    	log.info("updateTable = {}", table);
    	
    	int result = shopService.updateTable(table);
    	log.info("updateResult = {}", result);
    	
    	String msg = result > 0 ? "수정되었습니다." : "수정되지 않았습니다."; 
    	return ResponseEntity.ok(msg);
    }
    
    @GetMapping("/selectOneTable/getReservationTime")
    public ResponseEntity<?> getReservationTime(Table reqTable){
    	log.info("selectOneTable = {}", reqTable);
    	
    	Table table = shopService.selectOneTable(reqTable);
    	
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
				log.info("시작 = {}, 종료 = {}", sdf.format(eachStartTime), sdf.format(psStartTime));
		    	Map<String, Object> timeMap = new HashMap<>();
				timeMap.put("startTime", sdf.format(eachStartTime));
				timeMap.put("endTime", sdf.format(psStartTime));
				timeMapList.add(timeMap);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	
    	log.info("timeList = {}", timeMapList);
    	
    	
    	return ResponseEntity.ok(timeMapList);
    }
}