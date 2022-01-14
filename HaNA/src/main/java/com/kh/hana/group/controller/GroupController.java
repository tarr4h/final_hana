package com.kh.hana.group.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	
	@GetMapping("/groupDetail/{groupId}")
	public String groupDetail(@PathVariable String groupId, Model model) {
		Group group = groupService.selectOneGroup(groupId);
		log.debug("group = {}", group);
		model.addAttribute("group", group);
		return "group/groupPage";
	}
	
	
	@GetMapping("/groupList")
	public void groupList(@AuthenticationPrincipal Member member) {
		log.debug("loginMember = {}", member);
		
	}

}

