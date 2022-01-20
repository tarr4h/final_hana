package com.kh.hana.mbti.controller;


import java.util.ArrayList;
import java.util.Collection;
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
	
	// 메인 페이지
	@GetMapping("/mbti.do")
	public String mbtiMain() {
		return "/mbti/mbtiMain";
	}
	
	// mbti 문항 불러오기
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
	
	// mbti 결과 불러오기
	@GetMapping("/mbtiResult.do")
		public String mbtiResult(Model model , MbtiData data) {
		log.info("data = {}", data);
		
		if(data.getNo() != null) {
			int[] no = data.getNo(); 
			int[] memberResult =  data.getMemberResult();
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
		
		String id = data.getMemberId();
		List<Map<String, Object>> mbtiResult = mbtiService.selectMbtiResult(id);
		log.info("mbtiResult = {}", mbtiResult);
		
		List<String> memberMbti = new ArrayList<>();
		
		int num = 0;
		int mbti = 0;
		int I = 0;
		int E = 0;
		int T = 0;
		int F = 0;
		int S = 0;
		int N = 0;
		int P = 0;
		int J = 0;
		
		
		for(Map<String, Object> map : mbtiResult) {
			String no = (String) map.get("question_no");
			String result = (String) map.get("result");			
			log.info("map ={}", map);
			log.info("no={}", map.get("QUESTION_NO"));
			
			 num = Integer.parseInt(String.valueOf(map.get("QUESTION_NO")));
			log.info("num ={}", num);
			 mbti = Integer.parseInt(String.valueOf(map.get("RESULT")));
			log.info("mbti ={}", mbti);
			
			if(num < 10 && mbti == 1) {
					I += 1;
				if(num < 10 && mbti == 2) {
					E += 1;
				}
			}
			if(num >= 10 && num < 19 && mbti == 1) {
					T += 1;
				if( num >= 10 && num < 19 && mbti == 2) {
					F += 1;
				}
			}
			if(num >= 19 && num < 28 && mbti == 1) {
					S += 1;
				if(num >= 19 && num < 28 && mbti == 2) {
					N += 1;
				}
			}
			if(num >= 28 && num < 37 && mbti == 1) {
				P += 1;
				if(num >= 28 && num < 37 && mbti == 2) {
					J += 1;
				}
			}
		}
		
		log.info("I ={}", I);
		log.info("E ={}", E);
		log.info("T ={}", T);
		log.info("F ={}", F);
		log.info("S ={}", S);
		log.info("N ={}", N);
		log.info("P ={}", P);
		log.info("J ={}", J);
		
		
		if(I > E) {
			memberMbti.add("I");
		}else{
			memberMbti.add("E");				
			
		}
		
		if(T > F) {
			memberMbti.add("T");
		}else{
			memberMbti.add("F");			
			
		}
		
		if(S > N) {
			memberMbti.add("S");
		}else{
			memberMbti.add("N");				
			
		}
		
		if(P > J) {
			memberMbti.add("P");
		}else{
			memberMbti.add("J");
		}

		model.addAttribute("memberMbti", memberMbti);
		log.info("memberMbti ={}", memberMbti);
		
			
		return "mbti/mbtiResult";
	}
	


}
