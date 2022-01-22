<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mbti.css" />

<div id="mbtiList-Background">
	<form action="${pageContext.request.contextPath }/mbti/mbtiList.do" id="mbtiForm" name="mbtiFrm">
		<input type="hidden" name="cPage" value="${cPage }"/>
		<ul id="mbtiListPage-ul">
		 <c:forEach items="${mbtiList}" var="list">
			<li>
				<p class="mbtiListPage-p" style="padding-top:10px;margin-bottom:10px;">${list.no}. ${list.question}</p>
					<input type="hidden" name="no" value="${list.no }" />
					<span>비동의</span>
					<input type="radio" id="cbtest-${list.no}-no" name="memberResult-${list.no}" value="1" checked />
						<label for="cbtest-${list.no}-no" class="cb1"></label>
					<input type="radio" id="cbtest-${list.no}-yes" name="memberResult-${list.no}" value="2"/>	
					 	<label for="cbtest-${list.no}-yes" class="cb2"></label>
					<span>동의</span>
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
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>