package com.kh.hana.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

	
	@GetMapping("/common/main.do")
	public void test() {
		
	}
}
