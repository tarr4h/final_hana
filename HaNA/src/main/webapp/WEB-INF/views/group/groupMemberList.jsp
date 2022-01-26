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
	<jsp:param value="소그룹페이지" name="title" />
</jsp:include>
<section class="body-section"
	style="width: 200px; height: 100%; float: right; display: block;">
	<span style="float: right;">ㅁㄴ이랸멍리ㅑㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴㅇㄹ</span>
</section>
<section>
	<script src="https://kit.fontawesome.com/0748f32490.js"
		crossorigin="anonymous">
		
	</script>
	<sec:authentication property="principal" var="loginMember" />

	<div class="groupMemberListTableArea">
		<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>프로필</th>
			<th>그룹 아이디</th>
			<th>멤버 아이디</th>
			<th>회원등급</th>
			<th>강퇴</th>
		</tr>
		<c:forEach items="${groupMemberList}" var="list">
			<tr>
				<td>${list.PICTURE}</td> 
				<td>${list.GROUP_ID}</td>
				<td>${list.MEMBER_ID}</td>
				<td>${list.MEMBER_LEVEL_CODE}</td>
				<td><button type="button" class="btn btn-danger">강퇴</button></td>
			</tr>
		</c:forEach>
	</table>
	</div>








	<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>