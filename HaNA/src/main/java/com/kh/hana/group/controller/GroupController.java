package com.kh.hana.group.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@GetMapping("/groupPage/{groupId}")
	public void groupDetail(@PathVariable String groupId) {
		log.debug("groupId = {}", groupId);
		Group group = groupService.selectOneGroup(groupId);
		log.debug("group = {}", group);
		System.out.println(groupId);
		System.out.println(group);
	}
	
	@GetMapping("/groupList")
	public void groupList(@AuthenticationPrincipal Member member) {
		log.debug("loginMember = {}",member);
		
	}

	@PostMapping("/createGroup")
	public void insertGroup(Group group) {
		log.debug("group = {}",group);
		
	}
		
}

