package com.kh.hana.group.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hana.account.model.vo.Account;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/group")
public class GroupController {
	
	@GetMapping("/groupList")
	public void groupList(@AuthenticationPrincipal Account account) {
		log.debug("loginMember = {}",account);
		
	}
	
}
