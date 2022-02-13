<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page autoFlush="true" buffer="1094kb"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메인화면" name="title"/>
</jsp:include>

<!-- chatcontroller 맨 밑에서 requestmapping -->

<sec:authorize access="hasRole('USER')">
<jsp:forward page="/common/main.do"/>
</sec:authorize>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>