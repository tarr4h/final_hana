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

	<table class="memberListTable">
		<tbody>
			<tr>
				<th>그룹아이디</th>
				<th>프로필</th>
				<th>멤버아이디</th>
				<th>회원등급</th>
			</tr>
		</tbody>
	</table>


	<script>
	$(() => {
		console.log("hi");
		/* memberList(); */
/* 		$.ajax({
			url: "${pageContext.request.contextPath}/group/groupMemberList/${groupId}",
			data: groupId = '${groupId}',
			contentType: "application/json; charset=utf-8",
			success(json){
				console.log(json)
				var listAdd = "<tr>" +
				"<td>"+json.memberList[i].GroupId+"</td>"+
				"<td>"+json.memberList[i].Picture+"</td>"+
				"<td>"+json.memberList[i].MemberId+"</td>"+
				"<td>"+json.memberList[i].MemberLevelCode+"</td>"+
				"</tr>";
				$(".table tbody").append(listAdd);
			},
			
			error: fuction(xhr) {
				alert("에러 : " + status);
			}
		}); */
	})

	</script>






	<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>