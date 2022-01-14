package com.kh.hana.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hana.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/loginMain")
	public void loginMain() {
		
	}
	
	@GetMapping("/memberView")
	public void memberView() {}
	
	
	
	
	
	
	
	
	

}
