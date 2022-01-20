<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="마이페이지" name="title"/>
</jsp:include>

<sec:authentication property="principal" var="loginMember"/>

<h1>shop계정페이지</h1>


<div class="container">
	<input type="button" value="설정하기" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/shopInfo'" />
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>