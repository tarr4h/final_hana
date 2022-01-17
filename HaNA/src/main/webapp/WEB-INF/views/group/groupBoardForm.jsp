<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메인화면" name="main"/>
</jsp:include>

<div class="create-group-form-container">
	<form
		action="${pageContext.request.contextPath}/group/enrollGroupBoard"
		method="post"
		enctype="multipart/form-data">
		<table>
			<tr>
			<td><input type="hidden" value="<sec:authentication property='principal.username'/>" name="memberId"/></td>
			</tr>
		</table>

	</form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
