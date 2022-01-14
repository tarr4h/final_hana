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
<style>
	.body-section {min-height : 1000px;}
	.navbar-expand-lg { height : 10em;}
	.navbar-brand head { height : 10em;}
	.img-thumbnail { height : 8em;}
</style>

</head>
<body>
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-dark pr-3">
			<div class="title-image-box">
			  <a class="navbar-brand head" href="#"><img src="${pageContext.request.contextPath }/resources/images/duck.png" alt="..." class="img-thumbnail"></a>
			</div>			  
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="collapse navbar-collapse flex-row-reverse" id="navbarNavDropdown">
		    <ul class="navbar-nav">
		      <li class="nav-item active">
		        <a class="nav-link text-light" href="#">Home <span class="sr-only">(current)</span></a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-light" href="#">친구추가</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-light" href="#">나침반</a>
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
		        
		        <sec:authorize access="isAuthenticated()">
					<a class="nav-link text-light"><span><sec:authentication property="principal.username"/></span></a>
					<form:form method="POST" action="${pageContext.request.contextPath }/member/logout">
						<input type="submit" value="로그아웃" />
					</form:form>
				</sec:authorize>
		      </li>
		      <li class="nav-item dropdown">
		        <a class="nav-link dropdown-toggle text-light" href="${pageContext.request.contextPath}/account/accountView" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          내 계정
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		          <a class="dropdown-item" href="#">게시글 작성</a>
		          <a class="dropdown-item" href="#">예약 목록</a>
		          <a class="dropdown-item" href="#">계정 설정</a>
		        </div>
		      </li>
		    </ul>
		  </div>
		</nav>
	</header>
	
	<section class="body-section">
		
		<h1>몸통입니다..</h1>
		<sec:authorize access="isAuthenticated()">
			<span><sec:authentication property="principal.username"/></span>
		</sec:authorize>
		<button onclick="location.href='${pageContext.request.contextPath}/shop/test.do'">DB테스트</button>
