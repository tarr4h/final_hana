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
	<h1>그룹 정보 수정</h1>
		<form name="groupUpdateFrm">
			<table class="tbl-group">
				<tr>
					<th>그룹명</th>
					<td>
						<input type="text" name="groupName" required/>
					</td>
				</tr>
				<tr>
					<th>그룹아이디</th>
					<td>
						<input type="text" name="groupId" required readonly/>
					</td>
				</tr>
				<tr>
					<th>리더</th>
					<td>
						<input type="text" name="leaderId"  required/>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="수정" onclick="updateGroup();"/>
						<input type="button" value="삭제" onclick="deleteGroup();" />
					</td>
				</tr>
			</table>
		</form>



<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>