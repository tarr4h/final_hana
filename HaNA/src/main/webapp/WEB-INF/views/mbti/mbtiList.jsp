<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="body-section" style="width:200px;height:100%;float:right;display:block;">
<span style="float:right;">ㅁㄴ이랸멍리ㅑㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴㅇㄹ</span>
</section>
<section>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mbti.css" />

<div id="mbtiList-Background">
	
	<form action="${pageContext.request.contextPath }/mbti/mbtiList.do" id="mbtiForm" name="mbtiFrm">
		<input type="hidden" name="cPage" value="${cPage }"/>
		<ul id="mbtiListPage-ul">
		 <c:forEach items="${mbtiList}" var="list">
			<li>
				<p class="mbtiListPage-p" style="padding-top:10px;margin-bottom:10px;">${list.no}. ${list.question}</p>
					<input type="hidden" name="no" value="${list.no }" />
					<!-- memberResult-${list.no} 안넣어주면 리스트로 질문을 받기 때문에 라디오 박스가 딱 하나만 체크 되는데 문제마다 동의 또는 비동의로 
					     하나만 체크 되게 하고 싶은 거니까 input과 label을 name 값으로 이어주고 ${list.no}를 줘서 문항 마다 체크를(동의 또는 비동의) 
					     로 하나만 되게 할수 있도록 해주었다  -->
					   <!-- 동의 -->
					<span><i class="far fa-circle"></i></span>
					<input type="radio" id="cbtest-${list.no}-yes" name="memberResult-${list.no}" value="2" checked/>	
					 	<label for="cbtest-${list.no}-yes" class="cb2"></label>
					<input type="radio" id="cbtest-${list.no}-no" name="memberResult-${list.no}" value="1" />
						<label for="cbtest-${list.no}-no" class="cb1"></label>
					   <!-- 비동의 -->
					<span><i class="fas fa-times"></i></span>
			</li>
		 </c:forEach>
		</ul>
		<button type="submit" form="mbtiForm" id="mbtiListPage-buttonNext">next <i class="fas fa-angle-double-right"></i></button>
		<div id="btn" style="display: none; ">
		<button id="mbtiListPage-buttonResult">결과보기 <i class="fas fa-angle-double-right"></i></button>
		</div>
	</form>

</div>

<script>
window.onload = function(){
	
	if($('input[name=cPage]').val() == 37){
		$("#mbtiListPage-buttonNext").hide();
		document.getElementById("btn").style.display = 'block';
		const path = '${pageContext.request.contextPath}/mbti/mbtiResult.do';
		$('form[name=mbtiFrm]').attr('action', path);
	}
	
}

</script>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>