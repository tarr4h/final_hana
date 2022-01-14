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

<div class="member-view">
<img src="..." class="img-thumbnail" alt="...">
 <table>
  <thead>
    <tr>
      <th >아이디</th>
      <th>ㅇㅇㅇ</th>
  
    </tr>
  </thead>
  <tbody>
    <tr>
      <th >나의 관심사</th>
      <td>Mark</td>
   
    </tr>
    <tr>
      <th >나의 성격</th>
      <td>Jacob</td>
     
    </tr>
    <tr>
      <th >나의 동네친구 목록</th>
      <td >Larry the Bird</td>
    </tr>
    <tr>
      <th >친구추가</th>
      <td>Larry the Bird</td>
    </tr>
  </tbody>
</table>

</div>
<button type="button" class="btn btn-outline-dark">설정</button>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>