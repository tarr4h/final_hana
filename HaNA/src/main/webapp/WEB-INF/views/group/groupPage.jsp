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
	<jsp:param value="메인화면" name="main" />
</jsp:include>

<div class="group-page">

	<div>
		<section
			style="position: relative; border: 1px black solid; width: 100%; height: 300px;">
			<div
				style="border-radius: 50%; background-color: gray; width: 100px; height: 100px; position: relative; top: 30%; left: 35%; display: inline-block;">
				<img style="position: absolute; top:0; left: 0; width: 100%; height: 100%;" src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}" alt="" />
			</div>
			<div
				style="position: relative; top: 25%; left: 40%; display: inline-block;">
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
		</section>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>