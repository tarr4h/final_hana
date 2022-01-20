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
						<input type="checkbox" id="shapes_2" name="memberResult" value="1"/>
						<input type="checkbox" id="shapes_2" name="memberResult" value="2"/>
					<span>동의</span>
			</li>
		 </c:forEach>
		</ul>
		<div  id="btn1" style="display:block;">
		<button id="mbtiListPage-buttonPrev" ><i class="fas fa-angle-double-left"></i> prev</button>
		</div>
		<button type="submit" form="mbtiForm" id="mbtiListPage-buttonNext">next <i class="fas fa-angle-double-right"></i></button>
		<div id="btn" style="display: none; ">
		<br /><br />
		<button id="mbtiListPage-buttonResult">결과보기 <i class="fas fa-angle-double-right"></i></button>
		</div>
	</form>
</div>


<script>
window.onload = function(){
	
	console.log($('form[name=mbtiFrm]').attr('action'));
	console.log($('input[name=cPage]').val());
	
	if($('input[name=cPage]').val() == 7){
		document.getElementById("btn1").style.display = 'none';
	}
	
	if($('input[name=cPage]').val() == 37){
		$("#mbtiListPage-buttonNext").hide();
		document.getElementById("btn").style.display = 'block';
		const path = '${pageContext.request.contextPath}/mbti/mbtiResult.do';
		console.log(path);
		$('form[name=mbtiFrm]').attr('action', path);
	}

}

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>