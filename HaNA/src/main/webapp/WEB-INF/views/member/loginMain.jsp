<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="로그인화면" name="title"/>
</jsp:include>

<h1>로그인화면</h1>
<label for="idInput">ID</label><input type="text" id="idInput" />
<br />
<label for="pwInput">PW</label><input type="text" id="pwInput"/>
<br />
<br />
<input type="button" value="회원가입" onclick="location.href='${pageContext.request.contextPath}/member/memberEnrollMain'"/>





<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>