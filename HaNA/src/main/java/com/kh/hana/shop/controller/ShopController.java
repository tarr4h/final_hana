package com.kh.hana.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.hana.shop.model.service.ShopService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	private ShopService shopService;
	
	@GetMapping("/shopMain")
	public void shopMain() {
		
	}
	
}
