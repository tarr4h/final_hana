package com.kh.hana.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.member.model.service.MemberService;
import com.kh.hana.member.model.vo.Member;


import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping("/login")
	public void loginMain() {
		
	}
	
	@GetMapping("/memberEnrollMain")
	public void memberEnrollMain() {
		
	}
	
	@PostMapping("/memberEnroll")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		
		log.info("member = {}", member);
		
		String password = member.getPassword();
		String encodedPassword = bcryptPasswordEncoder.encode(password);
		member.setPassword(encodedPassword);
		
		int result = memberService.memberEnroll(member);
		
		log.debug("result");
		
		redirectAttr.addFlashAttribute("msg", result > 0 ? "회원가입에 성공했습니다." : "회원가입에 실패했습니다.");
		
		return "redirect:/member/login";		
	}
	
	@GetMapping("/memberView")
	public void memberView(@AuthenticationPrincipal Member member) {
 
		log.debug("member={}", member);	
	}
	
	@GetMapping("/shopView")
	public void shopView(@AuthenticationPrincipal Member member) {
		log.debug("member={}", member);
	}
	
	
	@GetMapping("/memberSetting")
	public void memberSetting() {}
	
	
	@PostMapping("/memberUpdate")
	public String memberUpdate(Member member,
								String id,
								RedirectAttributes redirectAttr) {
		log.info("member={}", member);
		int result = memberService.updateMember(member, id);
	log.info("memberPersonality={}" , member.getPersonality()); 
		
		redirectAttr.addFlashAttribute("msg", result > 0? "프로필 편집에 성공했습니다." : "프로필 편집에 실패했습니다.");
		return "redirect:/member/memberSetting";
	}
	
	
	
	
	
	
	
	
	



}