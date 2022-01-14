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

<sec:authentication property="principal" var="loginMember"/>

  <div>
     

        <section style="position: relative; border: 1px black solid; width: 100%; height: 300px;">
            <div style="border-radius: 50%; background-color: gray; width: 100px; height: 100px; position: relative; top: 30%; left: 15%; display: inline-block;">
                <img src="/final/user.png" alt="" style="width: 80px; height: 80px;"></div>
            <div style="position: relative; top: 30%; left: 25%; display: inline-block;">
                <table>
                    <tr>
                        <td>아이디</td>
                        <td colspan="3"><sec:authenticaion property='principal.username'/></td>
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
			<button type="button" class="btn btn-outline-dark">설정</button>
    </div>

 
 
 

<a href="/" class="badge badge-dark">Dark</a>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>