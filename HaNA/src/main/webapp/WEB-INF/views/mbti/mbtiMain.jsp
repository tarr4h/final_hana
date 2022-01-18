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

<div id="mbtiMain-Background">
<h1 id="mainPage-h1">나의 mbti 는 ?</h1>
<button id="mainPage-button" onclick="location.href='${pageContext.request.contextPath}/mbti/mbtiList.do?cPage=1'">검사하기</button>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>