package com.kh.hana.mbti.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String mbtiList(Model model) {
		List<Mbti> mbtiList = mbtiService.selectMbtiList();
		
		model.addAttribute("mbtiList",mbtiList);
		log.info("mbtiList = {}", mbtiList);
		return "/mbti/mbtiList";
	}
	
	
	@PostMapping("/mbtiinsert.do")
	public String memberCheck(MbtiData data, HttpServletRequest request, HttpServletResponse response) {
//		String[] checkList = request.getParameterValues("check");
		log.info("data = {}", data);
//		mbtiService.insertList(checkList);
		
//		return "/mbti/mbtiList";
		return null;
	}

}