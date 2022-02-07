package com.kh.hana.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ShopHashTagInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("=========shopHashTagInterceptor===========");
		log.debug("=========shopHashTagInterceptor===========");
		 return super.preHandle(request, response, handler);
	
	}

	
}
