package com.kh.hana.mbti.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String mbtiList(Model model, @RequestParam("cPage") int cPage, MbtiData data) {
		log.info("data = {}", data);
		log.info("cPage={}", cPage);
		int endPage = cPage + 5;
		Map<String, Object> number = new HashMap<>();
		number.put("cPage", cPage);
		number.put("endPage", endPage);
		List<Mbti> mbtiList = mbtiService.selectMbtiList(number);

		cPage += 6;
		
		if(data.getNo() != null) {
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
				log.info("per={}",per);

			}
			int result = mbtiService.insertList(resultOfNo, memberId);
		}
		
		model.addAttribute("mbtiList",mbtiList);
		model.addAttribute("cPage", cPage);
		log.info("mbtiList = {}", mbtiList);
		return "mbti/mbtiList";
	}
	
//	@PostMapping("/mbtiinsert.do")
//	public String memberCheck(MbtiData data, @RequestParam("cPage") int cPage) {
//		log.info("data = {}", data);
//		int[] no = data.getNo();
//		int[] memberResult = data.getMemberResult();
//		log.info("no = {}", no);
//		log.info("memberResult = {}", memberResult);
//		
//		Map<Integer, Integer> resultOfNo = new HashMap<>(); 
//		
//		String memberId = data.getMemberId();
//		
//		int i = 0;
//		for(int per : no) {
//			resultOfNo.put(per, memberResult[i]);
//			i++;
//		}
//		
//		int result = mbtiService.insertList(resultOfNo, memberId);
//		
//		
//		return "forward:/mbti/mbtiList.do?cPage="+cPage;
//	}
	
	@ResponseBody
	@PostMapping("/mbtiinsert.do")
	public String memberCheck(MbtiData data, @RequestParam("cPage") int cPage, HttpServletRequest request) {
		log.info("data = {}", data);
//		int[] no = data.getNo();
//		int[] memberResult = data.getMemberResult();
		
		int no =  Integer.parseInt(request.getParameter("no"));
		int memberResult = Integer.parseInt(request.getParameter("memberResult"));


		log.info("no  = {}", no);
		log.info("memberResult = {}", memberResult);
		
		Map<Integer, Integer> resultOfNo = new HashMap<>(); 
		
		String memberId = data.getMemberId();
		
//		int i = 0;
//		for(int per : no) {
//			resultOfNo.put(per, memberResult[i]);
//			i++;
//		}
		
		int result = mbtiService.insertList(resultOfNo, memberId);
		
		
		return "forward:/mbti/mbtiList.do?cPage="+cPage;
	}

}