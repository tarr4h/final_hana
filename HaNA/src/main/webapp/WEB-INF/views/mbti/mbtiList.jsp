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
<ul id="mbtiListPage-ul">
 <c:forEach items="${mbtiList}" var="list">
	<li>
		<p class="mbtiListPage-p" style="padding-top:10px;margin-bottom:10px;">${list.no}. ${list.question}</p>
			<span>비동의</span>
				<button id="shapes_1"></button>
				<button id="shapes_2"></button>
				<button id="shapes_3"></button>
				<button id="shapes_4"></button>
				<button id="shapes_5"></button>
				<button id="shapes_6"></button>
				<button id="shapes_7"></button>
			<span>동의</span>
	</li>
 </c:forEach>
 

</ul>

			

			
		



<button id="mbtiListPage-buttonPrev" ><i class="fas fa-angle-double-left"></i> prev</button>
<button id="mbtiListPage-buttonNext" >next <i class="fas fa-angle-double-right"></i></button>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>