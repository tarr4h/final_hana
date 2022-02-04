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
		action="${pageContext.request.contextPath}/group/createGroup?${_csrf.parameterName}=${_csrf.token}"
		method="post"
		enctype="multipart/form-data">
		<table>
			<tr><td>
				<input type="text" name="groupId" id="groupId"/>
				<label for="groupId">아이디</label>
			</td></tr>
			<tr><td>
				<input type="text" name="groupName" id="groupName"/>
				<label for="groupName">이름</label>
			</td></tr>
			<tr>
			<td><input type="hidden" value="<sec:authentication property='principal.username'/>" name="leaderId"/></td>
			</tr>
			<tr>
			<td>
				<input type="checkbox" name="hashtag" value="운동" id="hashtag-ex"/>
				<label for="hashtag-ex">운동</label>
				<input type="checkbox" name="hashtag" value="독서" id="hashtag-re"/>
				<label for="hashtag-re">독서</label>
				<input type="checkbox" name="hashtag" value="등산" id="hashtag-mu"/>
				<label for="hashtag-mu">운동</label>
			</td>
			</tr>
			<tr><td>
				<label for="profileImage">프로필사진</label>
				<input type="file" name="profileImage" id="profileImage"/>
			</td></tr>
			<tr>
			<td><input type="submit" /></td>
			</tr>
		</table>
	</form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
