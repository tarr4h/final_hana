package com.kh.hana.common.aspect;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.kh.hana.search.model.service.SearchService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@Aspect
public class SearchLogAspect {

	@Autowired
	private SearchService searchService;
	
	@Pointcut("execution(* com.kh.hana.search.controller.SearchController.*(..))")
	public void groupPage() {}
	
	// 소모임 방문 로그 남기기
	@AfterReturning(pointcut="groupPage()", returning="returnObj")
	public void afterReturningAdvice(JoinPoint joinPoint, Object returnObj) throws Throwable{
		Object args[] = joinPoint.getArgs();
		
		Map<String,Object> param = new HashMap<>();
		String keyword = (String)args[0];
		String uri = ((HttpServletRequest)args[1]).getRequestURI();
		
		log.info("keyword = {}",keyword);
		log.info("uri = {}",uri);
		
	}
	
}
