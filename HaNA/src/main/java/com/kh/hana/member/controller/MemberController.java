package com.kh.hana.member.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.common.util.HanaUtils;
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
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/login")
	public void loginMain() {
		
	}
	
	@GetMapping("/memberEnrollMain")
	public void memberEnrollMain() {
		
	}
	
	@PostMapping("/memberEnroll")
	public String memberEnroll(Member member, @RequestParam(name="pictureFile") MultipartFile upFile, RedirectAttributes redirectAttr) {
		
		log.info("member = {}", member);
		
		String password = member.getPassword();
		String encodedPassword = bcryptPasswordEncoder.encode(password);
		member.setPassword(encodedPassword);
		
		String originalFilename = upFile.getOriginalFilename();
		String renamedFilename = HanaUtils.rename(originalFilename);
		
		String saveDirectory = application.getRealPath("/resources/upload/member/profile");
		
		File saveImg = new File(saveDirectory, renamedFilename);
		try {
			upFile.transferTo(saveImg);
		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage(), e);
		}
		
		member.setPicture(renamedFilename);		
		
		int result = memberService.memberEnroll(member);
		
		log.debug("result");
		
		redirectAttr.addFlashAttribute("msg", result > 0 ? "회원가입에 성공했습니다." : "회원가입에 실패했습니다.");
		
		return "redirect:/member/login";		
	}
	
	@GetMapping("/{accountType}")
	public void memberView(@AuthenticationPrincipal Member member, @PathVariable String accountType) {
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
	
	@GetMapping("/shopSetting/{param}")
	public void shopSetting(@PathVariable String param) {
		
	}
	
	
	
	
	
	
	
	
	



}