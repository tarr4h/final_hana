<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="계정화면" name="member"/>
</jsp:include>

<img src="..." class="img-thumbnail" alt="...">
<div id="introduce">소개글부분~~~~~~~~~~~~~~~~~</div>
<div class="member-view">
 <table>
  <thead>
    <tr>
      <td>아이디</td>
      <td>${member.name}</td>
  
    </tr>
  </thead>
  <tbody>
    <tr>
      <th >나의 관심사</th>
      <td>${member.interest}</td>
   
    </tr>
    <tr>
      <th >나의 성격</th>
      <td>${member.personality}</td>
     
    </tr>
    <tr>
      <th>나의 동네친구 목록</th>
      <td>Larry the Bird</td>
    </tr>
    <tr>
      <th>친구추가</th>
      <td>Larry the Bird</td>
    </tr>
  </tbody>
</table>
</div>
 
 
 
<button type="button" class="btn btn-outline-dark">설정</button>
<a href="/" class="badge badge-dark">Dark</a>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>