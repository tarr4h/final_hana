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
<sec:authentication property="principal" var="loginMember"/>
<div class="row">
  <div class="col-2">
    <div class="list-group" id="list-tab" role="tablist">
      <a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href='${pageContext.request.contextPath}/member/memberUpdate' role="tab" aria-controls="profile">프로필편집</a>
      <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="password">비밀번호 변경</a>
      <a class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list" href="#list-messages" role="tab" aria-controls="public">계정 공개 설정</a>
      <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list" href="#list-settings" role="tab" aria-controls="information">내 정보 공개</a>
            <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list" href="#list-settings" role="tab" aria-controls="reservation">예약내역</a>
    </div>
  </div>
</div>
<div id="enroll-container" class="mx-auto text-center">
	<form:form name="memberUpdateFrm" action="${pageContext.request.contextPath }/member/memberUpdate" method="POST">
		<table class="mx-auto">
		 <input type="hidden" name="id" value="${loginMember.id}" />
			<tr>
				<th>이름</th>
				<td>
					<div id="memberId-container">
						<input type="text" class="form-control" name="name" id="name" value="${loginMember.name}" required>
					 				
					</div>
				</td>
			</tr>
		
			<tr>
				<th>소개</th>
				<td>
					<input type="text" class="form-control" name="introduce" id="introduce" value="${loginMember.introduce}" required>
				</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>	
					<input type="text" class="form-control" id="" name="addressFirst" value="${loginMember.addressFirst}" required>
				</td>
			</tr>  
			<tr>
				<th></th>
				<td>	
					<input type="text" class="form-control" id="" name="addressSecond" value="${loginMember.addressSecond}" required>
				</td>
			</tr>  
			<tr>
				<th></th>
				<td>	
					<input type="text" class="form-control" id="" name="addressThird" value="${loginMember.addressThird}" required>
				</td>
			</tr>  
			<tr>
			<th></th>
				<td>	
					<input type="text" class="form-control" id="" name="addressFull" value="${loginMember.addressFull}" required>
				</td>
			</tr>
			<tr>
				<th>내 성격</th>
				<td>	
					<select name="personality" class="custom-select">
					  <option selected>선택&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
					  <option value="personality2" >차분한</option>
					  <option value="personality3" >활발한</option>
					  <option value="personality4" >내향적인</option>
					  <option value="personality5" >외향적인</option>
					  <option value="personality6" >열정적인</option>
					  <option value="personality7" >느긋한</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>내 관심사</th>
				<td>	
				<select name="interest" class="custom-select">
				  <option selected>Open this select menu</option>
				  <option value="interest1"  >One</option>
				  <option value="interest2"  >Two</option>
				  <option value="interest3"  >Three</option>
				</select>
				</td>
			</tr> 
			 
			
			 
		 
		</table>
		<input type="submit" value="완료" >
		<input type="reset" value="취소">
	</form:form>
</div>

 