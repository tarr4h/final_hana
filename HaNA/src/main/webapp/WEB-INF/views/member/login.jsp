<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="로그인화면" name="title"/>
</jsp:include>

<c:if test="${not empty msg }">
	<script>
		alert("${msg}");
	</script>
</c:if>

<div class="container mt-5">
	<div class="row">
		<div class="col-sm"></div>
		<div class="col-sm">			
			<form:form action="${pageContext.request.contextPath }/member/login" method="POST">
			  <div class="form-group mb-3">
			    <label for="exampleInputEmail1">ID</label>
			    <input type="text" name="userId" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="아이디를 입력하세요">
			    <small id="emailHelp" class="form-text text-muted">아이디 잘못되었을 경우 안내문구 노출자리</small>
			  </div>
			  <div class="form-group mb-3">
			    <label for="exampleInputPassword1">Password</label>
			    <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="비밀번호를 입력하세요">
			  </div>
			  <div class="form-check">
			    <input type="checkbox" class="form-check-input" id="exampleCheck1">
			    <label class="form-check-label" for="exampleCheck1">Remember Me(미개발)</label>
			  </div>
			  <button type="submit" class="btn btn-primary">로그인</button>
			  <br />
			  <input type="button" class="btn btn-info mt-3" value="회원가입" onclick="location.href='${pageContext.request.contextPath}/member/memberEnrollMain'"/>
			</form:form>
		</div>
		<div class="col-sm"></div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>