package com.kh.hana.mbti.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.hana.mbti.model.service.MbtiService;
import com.kh.hana.mbti.model.vo.Mbti;
import com.kh.hana.mbti.model.vo.MbtiData;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mbti")
@Slf4j
public class MbtiController {
	
	@Autowired
	private MbtiService mbtiService;
	
	@GetMapping("/mbti.do")
	public String mbtiMain() {
		return "/mbti/mbtiMain";
	}
	
	@GetMapping("/mbtiList.do")
	public String mbtiList(Model model, @RequestParam int cPage) {
		List<Mbti> mbtiList = mbtiService.selectMbtiList();
		
		model.addAttribute("mbtiList",mbtiList);
		log.info("mbtiList = {}", mbtiList);
		return "/mbti/mbtiList";
	}
	
	
	@PostMapping("/mbtiinsert.do")
	public String memberCheck(MbtiData data) {
		log.info("data = {}", data);
		int[] no = data.getNo();
		int[] memberResult = data.getMemberResult();
		log.info("no = {}", no);
		log.info("memberResult = {}", memberResult);
		
		Map<Integer, Integer> resultOfNo = new HashMap<>(); 
		
		String memberId = data.getMemberId();
		
		int i = 0;
		for(int per : no) {
			resultOfNo.put(per, memberResult[i]);
			i++;
		}
		
		int result = mbtiService.insertList(resultOfNo, memberId);
		
		
		
		log.info("map = {}", resultOfNo);
		
		for(int m : resultOfNo.keySet()) {
			log.info("m = {}", m);
			int value = resultOfNo.get(m);
			log.info("value = {}", value);
		}
		
		
		return null;
	}

}