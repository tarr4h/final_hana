package com.kh.hana.shop.model.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.hana.shop.model.service.ShopService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ShopController {

	@Autowired
	private ShopService shopService;
	
	@GetMapping("/shop/test")
	public void test() {
		String name = shopService.test();
		log.info("name = {}", name);
	}
}
