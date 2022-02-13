<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/admin/common/adminHeader.jsp"/>

<table>
	<thead>
		<tr>
			<td colspan="3">제제 유저 리스트</td>
		</tr>
		<tr>
			<td>no</td>
			<td>아이디</td>
			<td>석방일시</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="rs" varStatus="vs">
			<tr>
				<td>
					${vs.count }
				</td>
				<td>
					${rs.ID }
				</td>
				<td>
					${rs.RESTRICTED_DATE }
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="rsPageBar">
	${pageBar }
</div>

<jsp:include page="/WEB-INF/views/admin/common/adminFooter.jsp"/>