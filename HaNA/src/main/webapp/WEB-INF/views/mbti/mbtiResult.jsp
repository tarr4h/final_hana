<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<section class="body-section" style="width:200px;height:100%;float:right;display:block;">
<span style="float:right;">ㅁㄴ이랸멍리ㅑㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴㅇㄹ</span>
</section>
<section>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/mbti.css" />


<div id="mbtiMain-Background">
<img src="/hana/resources/images/learn-g9ed443a84_1920.png" alt="이미지" style="width: 100%; height: 100%;
    position: relative;"/>
	<h1 id="mainResultPage-h1">나의 성격 유형</h1>
	
	<div>
		<h4 style="color: #ffffff; position: relative; bottom: 350px;">${memberMbti[0] }${memberMbti[1] }${memberMbti[2] }${memberMbti[3] }</h4>
		<input type="hidden" id="mbtiResult"
			value="${memberMbti[0] }${memberMbti[1] }${memberMbti[2] }${memberMbti[3] }" />
		<input type="hidden" id="memberId"
			value="${memberId}" />
	</div>
	<button id= "hoomButton" onclick="location.href='http://localhost:9090/hana'">홈으로</button>
	<button id="mbtiInsert">프로필 반영</button>

</div>


<script>
	$('#mbtiInsert').on('click', function() {

		var mbti = $("#mbtiResult").val();		

	 	$.ajax({
			url : "${pageContext.request.contextPath}/mbti/addMbtiProfile.do",
			method : "GET",
			data : {
				"mbti" : mbti
			},
			success(map) {
				console.log(map)
				alert("프로필에 반영 되었습니다.")
				location.href='http://localhost:9090/hana'
			},
			error: console.log
			
		}); 
	
	});
</script>


</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>