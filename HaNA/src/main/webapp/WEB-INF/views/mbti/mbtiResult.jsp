<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mbti.css" />


<div id="mbtiMain-Background">
<h1 id="mainPage-h1">결과</h1>
<div>
	<h4 style="color:#ffffff">${memberMbti[0] }${memberMbti[1] }${memberMbti[2] }${memberMbti[3] }</h4>
</div>
<button onclick="location.href='http://localhost:9090/hana'">홈으로</button>
<button id = "mbtiInsert" >프로필 반영</button>
</div>

<script>


$('#mbtiInsert').on('click', function(){
	
var mbti_IE = ${memberMbti[0] }
var mbti_SN = ${memberMbti[1] }
var mbti_FT = ${memberMbti[2] }
var mbti_JP = ${memberMbti[3] }

var memberMbti = {"mbti_IE" : mbti_IE , "mbti_SN" : mbti_SN ,"mbti_FT" : mbti_FT ,"mbti_JP" : mbti_JP }
   
 $.ajax({
        url: "mbtiInsert.do",
        type: "GET",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        data: memberMbti ,
        success: function(data){
            alert("성공");
        },
        error: function(){  alert("error");  }
    });
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>