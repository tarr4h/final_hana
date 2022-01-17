<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메인화면" name="main" />
</jsp:include>
<script src="https://kit.fontawesome.com/0748f32490.js"
	crossorigin="anonymous"></script>

<div class="group-page">
	<section class="group-page-section">
		<div class="group-page-image">
			<c:if test="${empty group.image}">
				<img
					src="${pageContext.request.contextPath}/resources/images/user.png"
					alt="" />
			</c:if>
			<c:if test="${not empty group.image}">
				<img
					src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}"
					alt="" />
			</c:if>
			<!-- <img style="position: absolute; top:0; left: 0; width: 100%; height: 100%; border-radius: 50%;" src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}" alt="" /> -->
		</div>
		<div class="group-page-table">
			<table>
				<tr>
					<td class="td">아이디&nbsp</td>
					<td colspan="3">${group.groupId}</td>
				</tr>
				<tr>
					<td class="td">게시물&nbsp</td>
					<td style="padding-right:30px;">${group.boardCount}&nbsp&nbsp&nbsp&nbsp</td>
					<td class="td" style="padding-right:10px;">회원수&nbsp</td>
					<td>${group.memberCount}</td>
				</tr>
				<tr>
					<td style="padding-right:10px;" class="td">소모임이름</td>
					<td colspan="3">${group.groupName}</td>
				</tr>
			</table>

		</div>
		<div class="group-page-enroll-button">
			<br>
			<c:if test="${empty groupMember || empty loginMember}">
				<a href="#" class="enroll-button">가입신청</a>
			</c:if>
		</div>
	</section>
	<div class="icon">
		<a href="#"><i class="fas fa-pencil-alt"></i></a> 
		<a href="#"><i class="fas fa-calendar-alt"></i></a> 
		<a href="#"><i class="far fa-comments"></i></a>
	</div>
	<div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>