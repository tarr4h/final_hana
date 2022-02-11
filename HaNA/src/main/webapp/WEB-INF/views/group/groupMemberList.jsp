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
<script>
/* 전역변수 생성 */
let memberId2;
let memberLevelCode2;

/* 현재 등급 체크 함수 */
/* const grade2=(code)=>{
	console.log("asdfadf1",code);
};  */

</script>

<style>
table th, td {
	text-align: center;
	vertical-align: middle;
	border:none;
}
tr {
border-top:1px solid #8080803b;
}
</style>

	<div class="groupMemberListTableArea">
	<div class="page-label"> [${groupId}] 소모임 회원 관리 </div>
		<table class="table">
			<tr>
				<th>프로필</th>
				<th>멤버 아이디</th>
				<th>회원등급</th>
				<th>조정</th>
			</tr>
			<c:forEach items="${groupMembers}" var="member">
				<tr>
					<td><img
						style="width: 100px; height: 100px; border-radius: 50%;cursor: pointer;"
						src="${pageContext.request.contextPath}/resources/upload/member/profile/${member.profile}" />
					</td>
					<td>${member.memberId}</td>
					<td>
						<c:if test="${member.memberLevelCode eq 'ld'}"><span style="color:#ff5722;">리더</span></c:if> 
						<c:if test="${member.memberLevelCode eq 'mg'}"><span style="color:orange">매니저</span></c:if> 
						<c:if test="${member.memberLevelCode eq 'mb'}">멤버</c:if></td>
					<td>
						<input type="button" class="btn btn-secondary" data-toggle="modal" data-target="#moaModal"
						onclick="grade('${member.memberLevelCode}','${member.memberId}','${group.groupId}')" value="등급"/>
						<%-- grade2(${member.memberLevelCode},${member.memberId},${group.groupId}); --%>
						
						<button
						class="btn btn-danger"
						onclick="deleteMember('${member.memberId}');">탈퇴</button>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<!-- 회원 조정 모달 -->
	<div class="modal fade" id="moaModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<div class="head-label">
						등급조정
					</div>
				</div>
				
				<div class="modal-body">
					<form:form name="groupGradeUpdateFrm" action="${pageContext.request.contextPath}/group/updateGroupGrade?${_csrf.parameterName}=${_csrf.token}" method="POST" 
						class="customRadio customCheckbox m-0 p-0">
						<div class="row mb-0">
							<div class="row justify-content-start">
								<div class="col-12">
									<div class="row_">
										<input type="hidden" name="groupId" value="${groupId}"/>
										<input type="hidden" name="memberId" />
										<input type="hidden" name="memberLevelCode" />
										
										<input type="radio" name="level" id="ld" value="ld" >
										<label for="ld" class="form-check-label">리더</label>
									</div>
									<div class="row_">
										<input type="radio" name="level" id="mg" value="mg"> 
										<label for="mg" class="form-check-label">매니저</label>
									</div>
									<div class="row_">
										<input type="radio" name="level" id="mb" value="mb">
										<label for="mb" class="form-check-label">멤버</label>
									</div>
								</div>
							</div>
						</div>
							<div class="modal-footer">
								<button class="btn btn-primary" type="submit" data-dismiss="modal" onclick="updateGroupGradeFunc();">save</button>
							</div>
					</form:form>
				</div>
					<%-- <a href="${contextPath.request.pageContext}/group/gradeGroupMember/${list.MEMBER_ID}/${list.MEMBER_LEVEL_CODE}"></a> --%>
			</div>
		</div>
	</div>

<script>
function deleteMember(memberId){
	if(confirm("회원을 방출하시겠습니까?")){
		$.ajax({
			url:"${pageContext.request.contextPath}/group/deleteGroupMember",
			method:"POST",
			data:{
				"memberId":memberId,
				"groupId":'${groupId}'
			},
			success(data){
				console.log(data);
				location.reload();
			},
			error:console.log
		})
	}
}

function grade(code,memberId,groupId){
	/* console.log("asdfadf1",code);
	console.log("asdfadf1",memberId);
	console.log("asdfadf1",groupId); */
	<!-- memberId2는 제가 header에 memberId에다가 로그인id넣어둔거 가져와서 쓴거같아요-->
	memberId2 = memberId;
	memberLevelCode2 = code;
	console.log(memberId2);
	console.log(memberLevelCode2);

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

/* 회원 등급 변경 함수 */
function updateGroupGradeFunc(){
	if(confirm("회원 등급을 변경하시겠습니까? (리더직을 위임할 경우 '나의 등급'은 일반 멤버로 전환됩니다.)")){
		<!--  -->
		console.log("updateGroupGradeFunc = ",memberId2);
		console.log("updateGroupGradeFunc = ",memberLevelCode2);
		$("[name=groupGradeUpdateFrm] input[name=memberId]").val(memberId2);
		$("[name=groupGradeUpdateFrm] input[name=memberLevelCode]").val(memberLevelCode2);
		$(document.groupGradeUpdateFrm).submit();
	}
}; 
</script>

<style>
.head-label {
	margin:auto;
	font-weight:bold;
	font-size:1.1em;
}
.page-label {
	font-size:1.5em;
	font-weight:600;
	text-align:center;
	margin-bottom:50px;
	border-top:1px solid gray;
	border-bottom:1px solid gray;
	padding:20px 0px;
}

.groupMemberListTableArea {
	width:60vw;
	margin:auto;
	margin-top:100px;
	margin-bottom:100px;
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

 .row_ {
 width:30%;
     margin: 0 100px 10px 150px;
     
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
     border: 2px solid black;
     height: 25px;
     width: 25px;
     border-radius: 50%;
     position: absolute;
     top: 0;
     left: 0
 }

 .customRadio input[type="radio"]+label:after {
     content: '';
     background: black;
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
     max-width: 300px !important;
     position: relative
 }
 .modal-header {
 margin:auto;
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