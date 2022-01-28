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


    <div id="enroll-container" class="mx-auto text-center">
        <form:form name="groupUpdateFrm" 
            action="${pageContext.request.contextPath}/group/groupUpdate?${_csrf.parameterName}=${_csrf.token}" 
            enctype="multipart/form-data" 
            method="POST">
            <table class="mx-auto">
             <input type="hidden" name="id" value="${group.groupId}" />
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
                        <input type="checkbox" name="hashtag" id="hashtag-ex" value="운동" onclick="hash('ex');"/>
                        <label for="hashtag-ex">운동</label>
                        <input type="checkbox" name="hashtag" id="hashtag-re" value="독서" onclick="hash('re');"/>
                        <label for="hashtag-re">독서</label>
                        <input type="checkbox" name="hashtag" id="hashtag-mu" value="등산" onclick="hash('mu');"/>
                        <label for="hashtag-mu">등산</label>
                    </td>
                <tr>
                    <th>프로필사진</th>
                    <td>
                        <input type="file" class="form-control" name="upFile" id="" value="파일 선택" />
                        <input type="hidden" name="picture" value="${group.image}" />
                    </td>
                </tr>
            </table>
            <input type="submit" class="btn btn-dark"></button>
        </form:form>
    </div>

<script>
function hash(tag){
	console.log(tag);
	if(tag == 'ex'){
		$("#hashtag-ex").prop('checked', true);	
	}
	if(tag == 're'){
		$("#hashtag-re").prop('checked', true);	
	}
	if(tag == 'mu'){
		$("#hashtag-mu").prop('checked', true);	
	}
}
</script>

<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>