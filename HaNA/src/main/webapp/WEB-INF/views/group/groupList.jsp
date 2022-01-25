<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="그룹메인" name="title" />
</jsp:include>

<section
	style="position: relative; width: 30%; height: 120px; margin: auto;">
	<c:forEach items="${groupList}" var="group" varStatus="vs">
	<div class="group-container" onclick="location.href='${pageContext.request.contextPath}/group/groupPage/${group.groupId}'">
		<div
			style="border-radius: 50%; background-color: gainsboro; width: 100px; height: 100px; position: relative; top: 10%; left: 10%; display: inline-block;">
			<c:if test="${empty group.image}">
				<img
					style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border-radius: 50%;"
					src="${pageContext.request.contextPath}/resources/images/user.png"
					alt=""
					 />
			</c:if>
			<c:if test="${not empty group.image}">
				<img
					style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border-radius: 50%;"
					src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}"
					alt=""/>
			</c:if>
		</div>
	<div
		style="position: relative; margin-bottom:25px;left: 20%; display: inline-block;">
		<table>
			<tr>
				<td>${group.groupName}</td>
			</tr>
			<tr>
				<td>${group.memberCount}</td>
			</tr>
		</table>
	</div>
	</div>
	<br />
	</c:forEach>
</section>
<style>
.group-container:hover {
	cursor:pointer;
}

</style>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>