<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="계정화면" name="member/"/>
</jsp:include>
<<<<<<< HEAD

<sec:authentication property="principal" var="loginMember"/>
<script>
function goSetting(){
	location.href = "${pageContext.request.contextPath}/member/memberSetting";
}
</script>


=======
 
>>>>>>> branch 'master' of https://github.com/tarr4h/final_hana.git

  <div>
        <section style="position: relative; border: 1px black solid; width: 100%; height: 300px;">
          	<div class="group-page-image">
			<c:if test="${empty group.image}">
				<img
					src="${pageContext.request.contextPath}/resources/images/user.png"
					alt="" />
			</c:if>
			<c:if test="${not empty group.image}">
				<img
					src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}"
					alt="" />
			</c:if>
			<!-- <img style="position: absolute; top:0; left: 0; width: 100%; height: 100%; border-radius: 50%;" src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}" alt="" /> -->
		</div>
                <table>
                    <tr>
                        <td>아이디</td>
<<<<<<< HEAD
                        <td colspan="3">${loginMember.id}</td>
=======
                        <td colspan="3"></td>
>>>>>>> branch 'master' of https://github.com/tarr4h/final_hana.git
                    </tr>
                    <tr>
                        <td>나의 관심사</td>
                        <td>..</td>
                    </tr>
                    <tr>
                     	<td>나의 성격</td>
                        <td>..</td>
                    </tr>
                    <tr>
                        <td colspan="2">나의 동네친구 목록</td>
                        <td colspan="2">..</td>
                    </tr>
                    <tr>
                        <td colspan="2">친구 추가</td>
                        <td colspan="2">..</td>
                    </tr>
                     <tr>
                        <td colspan="2">소개글</td>
                        <td colspan="2">..</td>
                    </tr>
                </table>
            </div>
        </section>
			<button type="button" class="btn btn-outline-dark" onclick="goSetting();">설정</button>
    

 
 
 

<a href="/" class="badge badge-dark">Dark</a>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>