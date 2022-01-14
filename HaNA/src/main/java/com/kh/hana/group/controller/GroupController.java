package com.kh.hana.group.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import com.kh.hana.group.model.service.GroupService;
import com.kh.hana.group.model.vo.Group;
import com.kh.hana.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/group")
@Slf4j
public class GroupController {
	
	@Autowired
	private GroupService groupService;
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/groupPage/{groupId}")
	public String groupPage(@PathVariable String groupId, Model model) {
		Group group = groupService.selectOneGroup(groupId);
		log.debug("group = {}", group);
		model.addAttribute(group);
		return "group/groupPage";
	}
	
	@GetMapping("/groupList")
	public void groupList(@AuthenticationPrincipal Member member) {
		log.debug("loginMember = {}",member);

	}
	
	@GetMapping("/createGroupForm")
	public void createGroupForm() {}
	
	
	@PostMapping("/createGroup")
	public String insertGroup(Group group,
		@RequestParam(name="profileImage",required=false)MultipartFile profileImage,
		RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		try{
			log.info("group = {}",group);
			log.info("profileImage = {}",profileImage);
			// 파일저장경로
			// 가장 생명주기가 긴 ServletContext객체로부터 디렉토리 정보 얻어옴
			String saveDirectory = application.getRealPath("/resources/upload/group/profile");
			
			if(profileImage != null) {
				String originalFilename = profileImage.getOriginalFilename();
				String renamedFilename = HanaUtils.rename(originalFilename);
				
				File dest = new File(saveDirectory, renamedFilename);
				profileImage.transferTo(dest);
				
				group.setImage(renamedFilename);
			}
			
			int result = groupService.insertOneGroup(group);
			redirectAttr.addFlashAttribute("msg", "소모임 등록 성공!");	
			redirectAttr.addFlashAttribute("result", result);	
			return "redirect:/group/groupPage/"+group.getGroupId();
		
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			redirectAttr.addFlashAttribute("msg", "소모임 등록 실패 : 관리자에게 문의하세요.");	
			return "redirect:/group/groupList";
		}
	}
		
}

