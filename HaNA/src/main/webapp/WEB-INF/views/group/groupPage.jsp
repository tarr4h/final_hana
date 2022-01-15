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
<script src="https://kit.fontawesome.com/0748f32490.js" crossorigin="anonymous"></script>

<div class="group-page">

	<div>
		<section class="group-page-section">
			<div class="group-page-image">
				<c:if test="${empty group.image}">
					<img src="${pageContext.request.contextPath}/resources/images/user.png" alt="" />
				</c:if>
				<c:if test="${not empty group.image}">
					<img
						style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border-radius: 50%;"
						src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}"
						alt="" />
				</c:if>
				<!-- <img style="position: absolute; top:0; left: 0; width: 100%; height: 100%; border-radius: 50%;" src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}" alt="" /> -->
			</div>
			<div class="group-page-table"
				style="position: relative; top: 25%; left: 35%; display: inline-block;">
				<table>
					<tr>
						<td>아이디&nbsp</td>
						<td colspan="3">${group.groupId}</td>
					</tr>
					<tr>
						<td>게시물&nbsp</td>
						<td>${group.boardCount}&nbsp&nbsp&nbsp&nbsp</td>
						<td>회원수&nbsp</td>
						<td>${group.memberCount}</td>
					</tr>
					<tr>
						<td colspan="2">소모임이름&nbsp</td>
						<td colspan="2">${group.groupName}</td>
					</tr>
				</table>
			</div>
			<div style="display:inline-block; position: relative; top : 12%; left: 45%;">
				<br>
				<c:if test="${empty groupMember || empty loginMember}">
					<button class="group-page-enroll-button">가입신청</button>
				</c:if>
			</div>
		</section>
		<div class="icon">
			<i class="fas fa-pencil-alt"></i>
			<i class="fas fa-calendar-alt"></i>
			<i class="far fa-comments"></i>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>