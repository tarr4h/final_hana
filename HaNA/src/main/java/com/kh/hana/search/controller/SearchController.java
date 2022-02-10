package com.kh.hana.search.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.search.model.service.SearchService;

import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;


@RequestMapping("/search")
@Slf4j
@RestController
public class SearchController {
	
	@Autowired
	private SearchService searchService;
	
	@GetMapping("/member")
	public ResponseEntity<List<Member>> selectMemberListBySearch(@RequestParam String keyword){
		try{
			List<Member> list = searchService.selectMemberListBySearch(keyword);
			log.info("list = {}",list);
			return ResponseEntity.ok(list);			
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			throw e;
		}
	}
	@GetMapping("/group")
	public ResponseEntity<List<Group>> selectGroupListBySearch(@RequestParam String keyword){
		try{
			List<Group> list = searchService.selectGroupListBySearch(keyword);
			log.info("list = {}",list);
			return ResponseEntity.ok(list);			
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			throw e;
		}
	}
	@GetMapping("/shop")
	public ResponseEntity<List<Member>> selectShopListBySearch(@RequestParam String keyword){
		try{
			List<Member> list = searchService.selectShopListBySearch(keyword);
			log.info("list = {}",list);
			return ResponseEntity.ok(list);			
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			throw e;
		}
	}

	@GetMapping("/location")
	public ResponseEntity<List<Map<String,Object>>> selectLocationListBySearch(@RequestParam String keyword){
		try{
			List<Map<String,Object>> list = searchService.selectLocationListBySearch(keyword);
			log.info("list = {}",list);
			return ResponseEntity.ok(list);			
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			throw e;
		}
	}
}
