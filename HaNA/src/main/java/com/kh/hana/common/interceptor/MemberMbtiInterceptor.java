package com.kh.hana.common.interceptor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.hana.member.model.vo.MemberEntity;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
// 로그인 후 mbti 검사 클릭시 해당 Id Mbtidata 삭제 
public class MemberMbtiInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private SqlSessionTemplate session;
	private String memberId;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
		MemberEntity id = (MemberEntity) authentication.getPrincipal();
		memberId = id.getId();
		log.info("memberId = {}" , memberId);

		if(memberId != null) {
			 session.delete("mbti.deleteData",memberId);			
		}
		
		return super.preHandle(request, response, handler);		
	}
	

	
}
