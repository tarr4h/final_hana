package com.kh.hana.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.hana.admin.model.service.AdminService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/searchStatistics")
	public void searchStatistics() {}
	
	@GetMapping("/restrictionList")
	public void restrictionList(@RequestParam(defaultValue="1") int cPage) {
    	int limit = 10;
    	int offset = (cPage -1) * limit;
		
		List<Map<String, Object>> restrictedUserList = adminService.selectRestrictionList(limit, offset);
		
	}
}
