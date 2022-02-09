<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="설정화면" name="memberSetting/"/>
</jsp:include>
<section>
<sec:authentication property="principal" var="loginMember"/>


<br><br><br>
<div class="container">
    <div class="row">
    	<!-- 메뉴 영역 -->
        <div class="col-sm-4">
        	<ul class="list-group">
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/memberSetting/memberSetting'">프로필 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/memberSetting/updatePassword'">비밀번호 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/'memberSetting/accountPrivate'">계정 공개</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/'">정보 공개</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/memberSetting/myReservationList'">내 예약내역</li>
			</ul>
        </div>
        
        
         <div class="col-sm-8">
        <form:form name="accountPrivateFrm" 
        	action="${pageContext.request.contextPath}/member/accountPrivate?${_csrf.parameterName}=${_csrf.token}" 
        	enctype="multipart/form-data" 
        	method="POST">
       			<input type="hidden" name="id" value="${loginMember.id}" />
        		<input type="checkbox" name="publicProfile" id="publicProfile" <c:if test="${member.publicProfile eq '2'}"/>checked >계정 비공개
        		 <!-- <input type="hidden" name="accountCheckYN" id="input_check_hidden" value='1' /> --> 
        		<input type="submit" class="btn btn-dark" value="변경">
        	<br><br>     	 
        </form:form>
        </div>
</div>
<script>
$(accountPrivateFrm).submit((e) => {
	if ($("input[name='publicProfile']").is(":checked")) {
	$("input[name='publicProfile']").val(2);

	} else {
		$("input[name='publicProfile']").val(1);
	}
});
//if(document.getElementById("account").checked) {
 //   document.getElementById("input_check_hidden").disabled = true;
//}
</script>