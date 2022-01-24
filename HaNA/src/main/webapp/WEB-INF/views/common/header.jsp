<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title }</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/group.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/29546d6ff0.js" crossorigin="anonymous"></script>
<style>
	.body-section {min-height : 1000px;}
	.navbar-expand-lg { height : 10em;}
	.navbar-brand head { height : 10em;}
	.img-thumbnail { height : 8em;}
</style>
<c:if test="${param.error != null }">
	<script>
		alert("아이디 또는 비밀번호가 잘못 입력되었습니다.");
		location.href = '${pageContext.request.contextPath}/member/login';
	</script>
</c:if>
</head>
<body>
	<sec:authentication property="principal" var="loginMember"/>	
	
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-dark pr-3">
			<div class="title-image-box" style="margin-left:20px;">
			  <a class="navbar-brand head" href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath }/resources/images/duck.png" alt="..." class="img-thumbnail" style="width:130px;height:130px;border-radius:100%;"></a>
			</div>
			<span class="navbar-brand text-white" style="font-size:40px;">DNHBQ</span>			 
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="collapse navbar-collapse flex-row-reverse" id="navbarNavDropdown">
		    <ul class="navbar-nav">
		      <li class="nav-item active">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath}/">Home</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath }/shop/shopMain">AroundMe</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath}/mbti/mbti.do">MBTI</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath}/group/groupList">소모임</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath}/chat/chat.do">DM</a>
		      </li>
		      <li class="nav-item">
		      	<sec:authorize access="isAnonymous()">
			        <a class="nav-link text-light" href="${pageContext.request.contextPath }/member/login">로그인(임시)</a>		      	
		      	</sec:authorize>					
		      </li>
		      <sec:authorize access="isAuthenticated()">
				    <li class="nav-item dropdown">
				    	<c:if test="${loginMember.accountType eq 1}">
			        	<a id="linkd" class="nav-link dropdown-toggle text-light" href="${pageContext.request.contextPath}/member/memberView/${loginMember.id}" >
				          <span><sec:authentication property="principal.username"/></span>
				        </a>				    	
				    	</c:if>
				    	<c:if test="${loginMember.accountType eq 0}">
			        	<a id="linkd" class="nav-link dropdown-toggle text-light" href="${pageContext.request.contextPath}/member/shopView/${loginMember.id}" >
				          <span><sec:authentication property="principal.username"/></span>
				        </a>				    	
				    	</c:if>
				        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				          <a class="dropdown-item" href="#">게시글 작성</a>
				          <a class="dropdown-item" href="#">예약 목록</a>
				          <a class="dropdown-item" href="#">계정 설정</a>
				        </div>
				    </li>
			    <li class="nav-item">
		      		<form:form method="POST" action="${pageContext.request.contextPath }/member/logout">
						<input type="submit" value="로그아웃" />
					</form:form>
				</li>
		      </sec:authorize>
		   			
		    </ul>
		  </div>
		</nav>
	</header>
	
	<sec:authorize access="isAuthenticated()">
		<script>
 
		
  
		</script>
	</sec:authorize>
	<section class="body-section">