 package com.kh.hana.member.controller;

 
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.common.util.HanaUtils;
import com.kh.hana.member.model.service.MemberService;
import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.vo.Shop;

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
	

//	@GetMapping("/{accountType}")
//	public void memberView(@PathVariable String accountType, @RequestParam String id, Model model) {
//		log.info("id= {}", id);
//	}
	
	@GetMapping("/{view}/{id}")
	public String memberView(@PathVariable String id, @PathVariable String view, Model model) {
		//following 수 조회
		int followingCount = memberService.countFollowing(id);
		log.info("followingCount = {}", followingCount);
		model.addAttribute("followingCount", followingCount);
		
		//follower 수 조회
		int followerCount = memberService.countFollower(id);
		log.info("followerCount = {}", followerCount);
		model.addAttribute("followerCount", followerCount);
		
		//정보 가져오기
		Member member = memberService.selectOneMember(id);
		log.info("member={}", member);
		model.addAttribute("member", member);
		return "/member/"+view;
	}
	
	@GetMapping("/memberSetting/{param}")
	public void memberSetting(@PathVariable String param) {

	}
	
	@GetMapping("/shopSetting/{param}")
	public void shopSetting(@PathVariable String param, Authentication authentication, Model model) {
		Member member = (Member) authentication.getPrincipal();
		String memberId = member.getId();
		try {
			if(param.equals("shopInfo")) {
				Shop shop = memberService.selectOneShopInfo(memberId);
				log.info("shop={}", shop);
				if(shop != null) {
					model.addAttribute(shop);
				} else {
					throw new Exception();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
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
        oldMember.setAddressFull(member.getAddressFull());
        oldMember.setAddressAll(member.getAddressAll());
        oldMember.setPersonality(member.getPersonality());
        oldMember.setInterest(member.getInterest());
        oldMember.setLocationX(member.getLocationX());
        oldMember.setLocationY(member.getLocationY());
     
        log.info("memberSetting result = {}" , result); 
        log.info("memberPersonality={}" , member.getPersonality()); 

        redirectAttr.addFlashAttribute("msg", result > 0? "프로필 편집에 성공했습니다." : "프로필 편집에 실패했습니다.");
        return "redirect:/member/memberSetting/memberSetting";
    }
	
	@PostMapping("/addFollowing")
	public String addFollowing(@AuthenticationPrincipal Member member, @RequestParam String friendId, RedirectAttributes redirectAttr) {
		log.info("member={}", member.getId());
		
		Map<String, Object> map = new HashMap<>();
		map.put("myId", member.getId());
		map.put("friendId", friendId);
		log.info("map ={}", map);
		
		int result = memberService.addFollowing(map);
		log.info("result ={}", result);
		redirectAttr.addFlashAttribute("msg", result > 0? "친구 추가에 성공했습니다." : "친구 추가에 실패했습니다.");
		return "redirect:/member/memberView/"+member.getId();
	}
	
	@GetMapping("/followerList")
	@ResponseBody
	public List<Follower> followerList(@RequestParam String id, Model model) {
		List<Follower> follower = memberService.followerList(id);
		log.info("follower={}", follower);
		model.addAttribute("follower", follower);
		
		return follower;
		
	}
 
	@GetMapping("/followingList")
	@ResponseBody
	public List<Follower> followingList(@RequestParam String id, Model model){
		List<Follower> following = memberService.followingList(id);
		log.info("following={}", following);
		model.addAttribute("following", following);
		
		return following;
	}
	
	
	@GetMapping("/boardForm")
	public void boardForm() {
	}
	
	
	
	@PostMapping("/shopSetting/shopInfo")
	public String updateShopInfo(Shop shop, RedirectAttributes redirectAttr) {
//		log.info("param = {}", param);
//		
//		Member member = (Member)authentication.getPrincipal(); String oldProfile =
//		member.getPicture();
//		  
//		String saveDirectory =
//		application.getRealPath("/resources/upload/member/profile"); File file = new
//		File(saveDirectory, oldProfile); boolean bool = file.delete();
//		log.info("bool = {}", bool);
//		  
//		String renamedFilename = HanaUtils.rename(upFile.getOriginalFilename());
//		  
//		File regFile = new File(saveDirectory, renamedFilename);
//		  
//		try { upFile.transferTo(regFile); } catch (IllegalStateException |
//		IOException e) { log.error(e.getMessage(), e); }
//		  
//		param.put("picture", renamedFilename);
//		  
//		member.setAddressFull(param.get("addressFull"));
//		member.setAddressAll(param.get("addressAll"));
//		member.setLocationX(param.get("locationX"));
//		member.setLocationX(param.get("locationY"));
//		  
//		param.put("id", member.getId());
//		  
//		int result = memberService.updateShopInfo(param, member);
//		  
//		log.info("contResult = {}", result); redirectAttr.addFlashAttribute("msg",
//		"수정되었습니다.");
		
		log.info("shop = {}", shop);
		 
		int result = memberService.updateShopInfo(shop);
		
		
		return "redirect:/member/shopSetting/shopInfo";
	}
	
//	@GetMapping("/memberView/{id}")
//	public int countFollowing(@PathVariable String id, Model model) {
//		
//		int followingCount = memberService.countFollowing(id);
//		log.info("followingCount = {}", followingCount);
//		return followingCount;
//		
//	}
//	



}
