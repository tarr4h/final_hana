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
	<style>
table th, td {
	text-align: center;
	vertical-align: middle;
}
</style>
	<div class="groupMemberListTableArea">
		<table class="table table-bordered">
			<tr>
				<th>그룹 아이디</th>
				<th>프로필</th>
				<th>멤버 아이디</th>
				<th>회원등급</th>
				<th>조정</th>
			</tr>
			<c:forEach items="${groupMemberList}" var="list">
				<tr>
					<td>${list.GROUP_ID}</td>
					<td><img
						style="width: 100px; height: 100px; border-radius: 50%;"
						src="${pageContext.request.contextPath}/resources/upload/member/profile/${list.PICTURE}"
						alt="" /></td>
					<td>${list.MEMBER_ID}</td>
					<td><c:if test="${list.MEMBER_LEVEL_CODE eq 'ld'}">리더</c:if> <c:if
							test="${list.MEMBER_LEVEL_CODE eq 'mg'}">매니저</c:if> <c:if
							test="${list.MEMBER_LEVEL_CODE eq 'mb'}">멤버</c:if></td>
					<td><a
						href="<c:url value='/group/gradeGroupMember/${list.MEMBER_ID}' />"
						class="btn btn-info" data-toggle="modal" data-target="#moaModal"
						onclick="grade();">등급</a> <a
						href="<c:url value='/group/deleteGroupMember/${list.MEMBER_ID}/${list.GROUP_ID}' />"
						class="btn btn-danger"
						onclick="return confirm('회원 탈퇴를 진행하시겠습니까?');">삭제</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<!-- Moa Modal-->
	<div class="modal fade" id="moaModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to test</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">x</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="#" class="customRadio customCheckbox m-0 p-0">
						<div class="row mb-0">
							<div class="row justify-content-start">
								<div class="col-12">
									<div class="row">
										<input type="radio" name="textEditor" id="dreamweaver" checked>
										<label for="dreamweaver">Back up all files folders</label>
									</div>
									<div class="row">
										<input type="radio" name="textEditor" id="sublime"> <label
											for="sublime">Back up photos and videos</label>
									</div>
									<div class="row">
										<input type="radio" name="textEditor" id="sublime"> <label
											for="sublime">Back up photos and videos</label>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" type="button" data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>






	<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>