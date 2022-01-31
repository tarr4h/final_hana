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

<%
	String[] hashtag = request.getParameterValues("hashtag");
	List<String> hashtagList = hashtag != null ? Arrays.asList(hashtag) : null;
	pageContext.setAttribute("hashtagList", hashtagList);
%> 

<br />
<%--     <div id="enroll-container" class="mx-auto text-center">
        <form:form name="groupUpdateFrm" 
            action="${pageContext.request.contextPath}/group/groupUpdate?${_csrf.parameterName}=${_csrf.token}" 
            enctype="multipart/form-data" 
            method="POST">
            <table class="mx-auto">
             <input type="hidden" name="id" value="${group.groupId}" />
                 <tr>
                 	<th>현재 프로필</th>
                 	<td><img style="width: 100px; height: 100px; border-radius: 50%;" src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}" alt="" /></td>
                 </tr>
                <tr>
                    <th>변경할 프로필</th>
                    <td>
                        <input type="file" class="form-control" name="upFile" id="" value="파일 선택" />
                        <input type="hidden" name="picture" value="${group.image}" />
                    </td>
                </tr>
                 <tr>
                    <th>소모임 아이디</th>
                    <td>
                        <input type="text" class="form-control" name="name" id="name" value="${group.groupId}" required readonly style="background-color: rgb(235, 235, 235);">
                    </td>
                </tr>
                <tr>
                    <th>소모임명</th>
                    <td>
                        <input type="text" class="form-control" name="name" id="name" value="${group.groupName}" required >
                    </td>
                </tr>
                <tr>
                    <th>해시태그</th>
                    <td>
                       <input type="checkbox" name="hashtag" id="hashtag-ex" value="운동" onclick="hash('운동');" ${group.hashtag[0].contains('운동') ? 'checked' : '' } ${group.hashtag[1].contains('운동') ? 'checked' : '' } ${group.hashtag[2].contains('운동') ? 'checked' : '' }/>
                        <label for="hashtag-ex">운동</label>
                        <input type="checkbox" name="hashtag" id="hashtag-re" value="독서" onclick="hash('독서');" ${group.hashtag[0].contains('독서') ? 'checked' : '' } ${group.hashtag[1].contains('독서') ? 'checked' : '' } ${group.hashtag[2].contains('독서') ? 'checked' : '' }/>
                        <label for="hashtag-re">독서</label>
                        <input type="checkbox" name="hashtag" id="hashtag-mu" value="등산" onclick="hash('등산');" ${group.hashtag[0].contains('등산') ? 'checked' : '' } ${group.hashtag[1].contains('등산') ? 'checked' : '' } ${group.hashtag[2].contains('등산') ? 'checked' : '' }/>
                        <label for="hashtag-mu">등산</label>
                    </td>

            </table>
            &nbsp; <input type="submit" class="btn btn-dark">
        </form:form>
    </div> --%>

<div class="container rounded bg-white mt-5 mb-5">
    <div class="row">
        <div class="col-md-5 border-right">
            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}" style="width: 200px; height: 200px; border-radius: 50%;">
            <br />
            <span class="font-weight-bold">소모임 ${group.groupName}의 프로필</span>
            <span class="text-black-50">${group.groupId}</span>
            <span></span></div>
        </div>
        <div class="col-md-5 border-right">
            <div class="p-3 py-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="text-right">Edit your profile</h6>
                </div>
                <div class="row mt-2">
                    <div class="col-md-6"><label class="labels">Name</label><input type="text" class="form-control" placeholder="first name" value="John"></div>
                    <div class="col-md-6"><label class="labels">Surname</label><input type="text" class="form-control" value="Doe" placeholder="Doe"></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12"><label class="labels">Headline</label><input type="text" class="form-control" placeholder="headline" value="UI/UX Developer"></div>
                    <div class="col-md-12"><label class="labels">Current position</label><input type="text" class="form-control" placeholder="headline" value="UI/UX Developer at Boston"></div>
                    <div class="col-md-12"><label class="labels">Education</label><input type="text" class="form-control" placeholder="education" value="Boston University"></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6"><label class="labels">Country</label><input type="text" class="form-control" placeholder="country" value="USA"></div>
                    <div class="col-md-6"><label class="labels">State/Region</label><input type="text" class="form-control" value="Boston" placeholder="state"></div>
                </div>
                <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="button">Save Profile</button></div>
            </div>
        </div>
    </div>
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