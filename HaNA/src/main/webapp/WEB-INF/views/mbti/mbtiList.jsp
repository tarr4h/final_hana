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
	<form action="" id="mbtiForm">
		<ul id="mbtiListPage-ul">
		 <c:forEach items="${mbtiList}" var="list">
			<li>
				<p class="mbtiListPage-p" style="padding-top:10px;margin-bottom:10px;">${list.no}. ${list.question}</p>
					<span>비동의</span>
						<input type="checkbox" id="shapes_1" name="check" value="-1"/>
						<input type="checkbox" id="shapes_2" name="check" value="-1"/>
						<input type="checkbox" id="shapes_3" name="check" value="-1"/>
						<input type="checkbox" id="shapes_4" name="check" value="1"/>
						<input type="checkbox" id="shapes_5" name="check" value="1"/>
						<input type="checkbox" id="shapes_6" name="check" value="1"/>
						<input type="checkbox" id="shapes_7" name="check" value="1"/>
					<span>동의</span>
			</li>
		 </c:forEach>
		</ul>
		<button id="mbtiListPage-buttonPrev" ><i class="fas fa-angle-double-left"></i> prev</button>
		<button type="submit" form="mbtiForm" id="mbtiListPage-buttonNext" >next <i class="fas fa-angle-double-right"></i></button>
	</form>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>