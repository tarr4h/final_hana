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
	<jsp:param value="소모임멤버리스트" name="title" />
</jsp:include>

<section>
<script src="https://kit.fontawesome.com/0748f32490.js" crossorigin="anonymous"></script>
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
					<td>
						<input type="button" class="btn btn-info" data-toggle="modal" data-target="#moaModal"
						onclick="grade('${list.MEMBER_LEVEL_CODE}')" value="등급"/>
						
						<a href="<c:url value='/group/deleteGroupMember/${list.MEMBER_ID}/${list.GROUP_ID}' />"
						class="btn btn-danger"
						onclick="return confirm('회원 탈퇴를 진행하시겠습니까?');">탈퇴</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
<script>
function grade(code){
	console.log(code);
	console.log(code == 'ld');
	if(code == 'ld'){
		$("#ld").prop('checked', true);	
	}
	if(code == 'mg'){
		$("#mg").prop('checked', true);
	}
	if(code == 'mb'){
		$("#mb").prop('checked', true);
	}
}
</script>

	<!-- 회원 조정 모달 -->
	<div class="modal fade" id="moaModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">등급조정</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">x</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="${pageContext.request.contextPath}/group/gradeGroupMember" 
						class="customRadio customCheckbox m-0 p-0">
						<div class="row mb-0">
							<div class="row justify-content-start">
								<div class="col-12">
									<div class="row">
										<input type="radio" name="level" id="ld" value="ld" >
										<label for="ld" class="form-check-label">리더</label>
									</div>
									<div class="row">
										<input type="radio" name="level" id="mg" value="mg"> 
										<label for="mg" class="form-check-label">매니저</label>
									</div>
									<div class="row">
										<input type="radio" name="level" id="mb" value="mb">
										<label for="mb" class="form-check-label">멤버</label>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<a href="${contextPath.request.pageContext}/group/gradeGroupMember/${list.MEMBER_ID}/${list.MEMBER_LEVEL_CODE}"><button class="btn btn-primary" type="submit" data-dismiss="modal" onclick="return confirm('회원 등급을 변경하시겠습니까?');">save</button></a>
				</div>
			</div>
		</div>
	</div>

<style>
 html,
 body,
 div,
 span,
 h1,
 h2,
 h3,
 h4,
 h5,
 h6,
 a,
 b,
 u,
 i,
 center,
 form,
 label {
     margin: 0;
     padding: 0;
     border: 0;
     font-size: 100%;
     font: inherit;
     vertical-align: baseline
 }

 html {
     box-sizing: border-box
 }

 *,
 *:before,
 *:after {
     box-sizing: inherit
 }

 * {
     max-height: 1000000px;
     margin: 0;
     padding: 0
 }

 body {
     line-height: 1;
     font: 300 18px/1.5 'Roboto', sans-serif;
     color: #311B92;
 }

 #Modal_button {
     margin-top: 200px;
     position: relative;
     width: 20%;
     border: none
 }

 .holder {
     padding: 0 0 30px;
     margin: 0 0 30px
 }

 .row {
     margin: 0 0 10px
 }

 h2 {
     font-weight: 500;
     font-size: 30px;
     margin: 0 0 20px
 }

 .customRadio input[type="radio"] {
     position: absolute;
     left: -9999px
 }

 .customRadio input[type="radio"]+label {
     position: relative;
     padding: 3px 0 0 40px;
     cursor: pointer
 }

 .customRadio input[type="radio"]+label:before {
     content: '';
     background: #fff;
     border: 2px solid #311B92;
     height: 25px;
     width: 25px;
     border-radius: 50%;
     position: absolute;
     top: 0;
     left: 0
 }

 .customRadio input[type="radio"]+label:after {
     content: '';
     background: #311B92;
     width: 15px;
     height: 15px;
     border-radius: 50%;
     position: absolute;
     top: 5px;
     left: 5px;
     opacity: 0;
     transform: scale(2);
     transition: transform 0.3s linear, opacity 0.3s linear
 }

 .customRadio input[type="radio"]:checked+label:after {
     opacity: 1;
     transform: scale(1)
 }


 .modal-title {
     font-weight: bold !important
 }

 .modal-header,
 .modal-footer {
     border-bottom: 0;
     border-top: 0;
     max-width: 500px !important;
     position: relative
 }

 .model-content {
     width: 500px;
     width: 30% !important
 }

 .modal-footer {
     max-width: 500px !important;
     position: relative
 }

 .modal-footer>:not(:last-child) {
     margin-right: 2rem
 }

 .modal-footer>:not(:first-child) {
     margin-left: 0.5rem
 }

 .modal-dialog {
     position: relative;
     width: auto;
     margin: 0 auto;
     max-width: 500px
 }

 .box-shadow--16dp {
     box-shadow: 0 16px 24px 2px rgba(0, 0, 0, .14), 0 6px 30px 5px rgba(0, 0, 0, .12), 0 8px 10px -5px rgba(0, 0, 0, .2)
 }

 @media only screen and (max-width: 780px) {
     .my_checkbox {
         margin-left: 7%
     }

     .modal-dialog {
         position: relative
     }
 }

 .container button focus {
     -moz-box-shadow: none !important;
     -webkit-box-shadow: none !important;
     box-shadow: none !important;
     border: none;
     outline-width: 0
 }

 @media only screen and (max-width: 580px) {
     .modal-dialog {
         position: relative
     }

     .my_checkbox {
         margin-left: 6%
     }
 }

 .btn-outline-light {
     color: #BDBDBD
 }

 #modal_footer {
     color: #BDBDBD;
     cursor: pointer;
     background: #fff
 }

 #modal_footer_support {
     color: #BDBDBD;
     width: 100%
 }

 .btn-success {
     background-color: #311B92 !important;
     border-radius: 8px;
     padding-right: 35px;
     padding-left: 35px
 }
</style>




<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>