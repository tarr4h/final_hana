<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가입신청화면" name="title" />
</jsp:include>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소그룹 가입 신청 폼</title>
</head>
<body>

<div style="position:relative; display: inline-block; top: 50%; left: 25%; padding: 5px 100px; background-color: rgb(224,224,224); margin-top: 10%;">
        <form:form name="enrollGroupForm" method="post" action="${pageContext.request.contextPath}/group/enrollGroupForm">
        <h1 style="text-align: center;">${groupId}</h1>
		<table>
			<thead>
            <tr>
				<th style="position: relative; top: 30%; left: 0%; display: inline-block;">신청이유</th>
			</tr>
        </thead>
        <tbody>
        <tr>
            <td>
            	<textarea name="content" id="" cols="30" rows="10"></textarea>
				<input type="hidden" name="groupId" value="${groupId}"/>
				<input type="hidden" name="memberId" value="<sec:authentication property='principal.username'/>"/>
            </td>        
        </tr>
        <tr>
	        <td>
				<br />
				<input style="position: relative; float: right;" type="submit" value="가입신청" />  
				<br /><br />      
	        </td>
        </tr>
        </tbody>
		</table>
	</form:form>
    </div>
</body>
</html>