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

<c:if test=" ${not empty msg}">
	<script>
	alert("${msg}");
	</script>
</c:if>
 
<div class="settingBar">
  <a class="settingList" href="${pageContext.request.contextPath}/member/memberSetting/memberSetting">프로필편집</a>
  <a class="settingList" href="#">비밀번호 변경</a>
  <a class="settingList" href="#">계정 공개</a>
  <a class="settingList" href="#">정보 공개</a>
  <a class="settingList" href="#">예약 관리</a> 
</div>
  
<style>
 .settingBar{
    height: 60px;
    text-align: center;
    margin-top: 80px;
    margin-bottom: 60px;
    border-bottom-style: ridge;
    }
.settingList {
	font-size: 16px;
    margin-left: 34px;
      color: black;
    text-decoration: none;
}
.form-control {
    display: block;
    width: 450px;
    height : 50px;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    border-radius: 0.25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    margin-bottom : 15px;
} 
.custom-select{
	width : 450px;
	height : 38px;
	margin-bottom : 15px;
}
</style>


<div id="enroll-container" class="mx-auto text-center">
	<form:form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate" method="POST">
		<table class="mx-auto">
		 <input type="hidden" name="id" value="${loginMember.id}" />
			<tr>
				<th>이름</th>
				<td>
					<div id="memberId-container">
						<input type="text" class="form-control" name="name" id="name" value="${loginMember.name}" required >
					 				
					</div>
				</td>
			</tr>
		
			<tr>
				<th>소개</th>
				<td>
				<!-- <input type="text" class="form-control" name="introduce" id="introduce" value="${loginMember.introduce}" required> -->	
				<textarea class="form-control" name="introduce" id="introduce" cols="55" rows="20" >  ${loginMember.introduce} </textarea>
				
				</td>
			</tr>
			<tr>
				<th>지역</th>
	  		  	<td>	
					<input type="text" class="form-control" id="" name="addressFirst" value="${loginMember.addressFull}" required>
				</td>
			</tr>  
			<tr>
				<th></th>
				<td>	
					<input type="text" class="form-control" id="" name="addressSecond" value="${loginMember.addressAll}" required>
				</td>
			</tr>  
			<tr>
				<th>내 성격</th>
				<td>	
					<select name="personality" id="personality" class="custom-select" required>
					 
					  <option value="차분한" ${loginMember.personality  eq '차분한'? 'selected' : ''}>차분한</option>
					  <option value="활발한" ${loginMember.personality  eq '활발한'? 'selected' : ''}>활발한</option>
					  <option value="내향적인" ${loginMember.personality  eq '내향적인'? 'selected' : ''}>내향적인</option>
					  <option value="외향적인" ${loginMember.personality  eq '외향적인'? 'selected' : ''}>외향적인</option>
					  <option value="열정적인" ${loginMember.personality  eq '열정적인'? 'selected' : ''}>열정적인</option>
					  <option value="느긋한" ${loginMember.personality  eq '느긋한'? 'selected' : ''}>느긋한</option>
					  <option value="다정한" ${loginMember.personality  eq '다정한'? 'selected' : ''}>다정한</option>
					  <option value="헌신적인" ${loginMember.personality  eq '헌신적인'? 'selected' : ''}>헌신적인</option>
					  <option value="솔직한" ${loginMember.personality  eq '솔직한'? 'selected' : ''}>솔직한</option>
					  <option value="낙천적인" ${loginMember.personality  eq '낙천적인'? 'selected' : ''}>낙천적인</option>
					   <option value="호기심많은" ${loginMember.personality  eq '호기심많은'? 'selected' : ''}>호기심많은</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>내 관심사</th>
				<td>	
				<select name="interest" class="custom-select" required>
				  <option value="책" ${loginMember.interest  eq '책'? 'selected' : ''}>책</option>
				   <option value="패션" ${loginMember.interest  eq '패션'? 'selected' : ''}>패션</option>
				   <option value="음식" ${loginMember.interest  eq '음식'? 'selected' : ''}>음식</option>
				    <option value="동물" ${loginMember.interest  eq '동물'? 'selected' : ''}>동물</option>
				    <option value="여행" ${loginMember.interest  eq '여행'? 'selected' : ''}>여행</option>
				  <option selected value="게임" ${loginMember.interest  eq '게임'? 'selected' : ''}>게임</option>
				  <option value="영화" ${loginMember.interest  eq '영화'? 'selected' : ''}>영화</option>
				    <option value="건강" ${loginMember.interest  eq '건강'? 'selected' : ''}>건강</option>
				     <option value="음악" ${loginMember.interest  eq '음악'? 'selected' : ''}>음악</option>
				      <option value="패션" ${loginMember.interest  eq '패션'? 'selected' : ''}>패션</option>
				   <option value="스포츠" ${loginMember.interest  eq '스포츠'? 'selected' : ''}>스포츠</option>
				</select>
				</td>
			</tr> 

		</table>
 
		<input type="submit" class="btn btn-dark"></button>
		<input type="reset" class="btn btn-dark"></button>
	</form:form>
</div>

 
 