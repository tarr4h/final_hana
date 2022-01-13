package com.kh.hana.group.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/group")
@Slf4j
public class GroupController {

	@GetMapping("/groupDetail.do")
	public void groupDetail(Authentication authentication) {
		log.debug("authentication = {}", authentication);
	}
	
	@GetMapping("/groupList")
	public void groupList() {
		
	}

}
