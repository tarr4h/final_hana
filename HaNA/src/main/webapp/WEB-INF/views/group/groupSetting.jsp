<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.kh.hana.group.model.vo.Group, java.util.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="프로필수정" name="title" />
</jsp:include>
<section>
<script src="https://kit.fontawesome.com/0748f32490.js" crossorigin="anonymous"> </script>
<sec:authentication property="principal" var="loginMember" />

<br />

<div class="container rounded bg-white mt-5 mb-5">
	<form:form name="groupUpdateFrm" action="${pageContext.request.contextPath}/group/groupUpdate?${_csrf.parameterName}=${_csrf.token}" method="POST" enctype="multipart/form-data">
	    <div class="row">
	        <div class="col-md-6 border-right">
	            <div class="d-flex flex-column align-items-center text-center p-3 py-5">
		            <img src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}" style="width: 180px; height: 180px; border-radius: 50%;"><br />
		            <span class="font-weight-bold">소모임 ${group.groupName}의 프로필</span>
		            <span class="text-black-50">${group.groupId}</span>
		            <input type="hidden" name="groudId" value="${group.groupId }" />
		            <span></span>
	            </div>
	        </div>
	        <div class="col-md-5 border-right">
	            <div class="p-3 py-5">
	                <div class="d-flex justify-content-between align-items-center mb-3">
	                    <h5 class="text-right">Edit your profile</h5>
	                </div>
	                <div class="row mt-2">
	                    <div class="col-md-7"><label class="labels">소모임 아이디</label><input type="text" class="form-control" placeholder="first name" name="groupId" value="${group.groupId}" required readonly></div>
	                </div>
	                <div class="row mt-3">
	                    <div class="col-md-7"><label class="labels">소모임명</label><input type="text" class="form-control" placeholder="headline" name="groupName" value="${group.groupName}" required></div>
	                </div>
	                <div class="row mt-3">
	                    <div class="col-md-12"><label class="labels">해시태그</label><br />
	                    	<input type="checkbox" name="hashtag" id="hashtag-ex" value="운동" onclick="hash('운동');" ${group.hashtag[0].contains('운동') ? 'checked' : '' } ${group.hashtag[1].contains('운동') ? 'checked' : '' } ${group.hashtag[2].contains('운동') ? 'checked' : '' }/>
	                        <label for="hashtag-ex">운동</label>
	                        <input type="checkbox" name="hashtag" id="hashtag-re" value="독서" onclick="hash('독서');" ${group.hashtag[0].contains('독서') ? 'checked' : '' } ${group.hashtag[1].contains('독서') ? 'checked' : '' } ${group.hashtag[2].contains('독서') ? 'checked' : '' }/>
	                        <label for="hashtag-re">독서</label>
	                        <input type="checkbox" name="hashtag" id="hashtag-mu" value="등산" onclick="hash('등산');" ${group.hashtag[0].contains('등산') ? 'checked' : '' } ${group.hashtag[1].contains('등산') ? 'checked' : '' } ${group.hashtag[2].contains('등산') ? 'checked' : '' }/>
	                        <label for="hashtag-mu">등산</label>
	                    </div>
	                </div>
	                <div class="row mt-3">
	                    <div class="col-md-7"><label class="labels">프로필 사진</label><input type="file" class="form-control" placeholder="country" name="upFile" value="파일 선택">
	                    <input type="hidden" name="image" value="${group.image}" />
	                    </div>
	                </div>
	                <input type="hidden" name="leaderId" value="${group.leaderId}">
	                <div class="mt-5 text-left"><button class="btn btn-primary profile-button" type="submit" onclick="return confirm('정보를 수정하시겠습니까?')">Save Profile</button></div>
	            </div>
	        </div>
	    </div>
    </form:form>
</div>

<script>
function hash(tag){
	console.log(tag);
	if(tag == '운동'){
		$("#hashtag-ex").prop('checked');	
	}
	if(tag == '독서'){
		$("#hashtag-re").prop('checked');	
	}
	if(tag == '등산'){
		$("#hashtag-mu").prop('checked');	
	}
}
</script> 


<style>
.form-control:focus {
    box-shadow: none;
    border-color: #BA68C8
}

.back:hover {
    color: #682773;
    cursor: pointer
}

.labels {
    font-size: 11px
}

.add-experience:hover {
    background: #BA68C8;
    color: #fff;
    cursor: pointer;
    border: solid 1px #BA68C8
}
</style>

<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>