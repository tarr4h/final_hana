<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자페이지" name="title"/>
</jsp:include>
<style>
.admin-total {
 margin:100px 0px;
 min-height:1100px;
}
.admin-side{
	border-right:1.3px solid gray;
	padding-right:70px;
}
.admin-side-menu {
width:100%;
margin-top:200px;
}
.admin-side-menu ul{
	list-style:none;
	text-align:right;
}
.admin-side-menu ul li {
	margin-bottom:20px;
}

.admin-side-menu ul li a{
	color:gray;
	text-decoration:none;
	font-size:1.5em;
	font-weight:500;
}
</style>
<section>
<div class="row admin-total" >
	<div class="col-sm-3 admin-side">
		<div class="admin-side-menu">
			<ul>
			<li><a href="">신고 내역</a></li>
			<li><a href="">제제 내역</a></li>
			<li><a href="">검색 통계</a></li>
			<li><a href="">소모임 해시태그 관리</a></li>
			</ul>
		</div>
	</div>
	<div class="col-sm-9">