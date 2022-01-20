 package com.kh.hana.member.controller;

 
import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		
		redirectAttr.addFlashAttribute("msg", result > 0 ? "회원가입에 성공했습니다." : "회원가입에 실패했습니다.");
		return "redirect:/member/login";					
	}
	
	@GetMapping("/{accountType}")
	public void memberView(Authentication authentication, @PathVariable String accountType, Model model) {
		log.info("authentication = {}", authentication);
	}
	
	@GetMapping("/memberSetting/{param}")
	public void memberSetting(@PathVariable String param) {
		
	}
	
	@GetMapping("/shopSetting/{param}")
	public void shopSetting(@PathVariable String param) {
		
	}
	
	@PostMapping("/memberUpdate")
    public String memberUpdate(Member member,
                                String id,
                                @AuthenticationPrincipal Member oldMember,
                                RedirectAttributes redirectAttr) {
        log.info("member={}", member);
        log.info("oldMember={}", oldMember);
        int result = memberService.updateMember(member, oldMember, id);

        //spring-security memberController memberUpdate쪽
        oldMember.setName(member.getName());
        oldMember.setIntroduce(member.getIntroduce());
        oldMember.setAddressFirst(member.getAddressFirst());
        oldMember.setAddressSecond(member.getAddressSecond());
        oldMember.setAddressThird(member.getAddressThird());
        oldMember.setAddressFull(member.getAddressFull());
        oldMember.setAddressAll(member.getAddressAll());
        oldMember.setPersonality(member.getPersonality());
        oldMember.setInterest(member.getInterest());
     
        log.info("memberSetting result = {}" , result); 
        log.info("memberPersonality={}" , member.getPersonality()); 

        redirectAttr.addFlashAttribute("msg", result > 0? "프로필 편집에 성공했습니다." : "프로필 편집에 실패했습니다.");
        return "redirect:/member/memberSetting/memberSetting";
    }
	
	@PostMapping("/addFollowing")
	public String addFollowing(@RequestParam String id, RedirectAttributes redirectAttr) {
		int result = memberService.addFollowing(id);
		redirectAttr.addFlashAttribute("msg", result > 0? "친구 추가에 성공했습니다." : "친구 추가에 실패했습니다.");
		log.info("result ={}", result);
		return "redirect:/member/memberView";
	}
	
	
	@PostMapping("/shopSetting/shopInfo")
	public String updateShopInfo(@RequestParam Map<String, Object> param, @RequestParam(name="profile") MultipartFile upFile, Authentication authentication, RedirectAttributes redirectAttr) {
		log.info("param = {}", param);
		log.info("time = {}", param.get("bussiness-hour-end"));
		log.info("upFile = {}", upFile.getOriginalFilename());
		Member member = (Member)authentication.getPrincipal();
		String oldProfile = member.getPicture();
		log.info("pic = {}", member.getPicture());
		
		String saveDirectory = application.getRealPath("/resources/upload/member/profile");
		File file = new File(saveDirectory, oldProfile);
		boolean bool = file.delete();
		log.info("bool = {}", bool);
		
		String renamedFilename = HanaUtils.rename(upFile.getOriginalFilename()); 
		
		File regFile = new File(saveDirectory, renamedFilename);
		
		try {
			upFile.transferTo(regFile);
		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage(), e);
		}
		
		param.put("picture", renamedFilename);

		
		int result = memberService.updateShopInfo(param);
		
		
		redirectAttr.addFlashAttribute("msg", "redi수정완료");
		return "redirect:/member/shopSetting/shopInfo";
	}
	
	
	
	
	



}
