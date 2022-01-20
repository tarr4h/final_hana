<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="업체정보 수정" name="title"/>
</jsp:include>

<sec:authentication property="principal" var="loginMember"/>

<h1>shop프로필설정</h1>
<div class="container">
    <div class="row">
    	<!-- 메뉴 영역 -->
        <div class="col-sm-4">
        	<ul class="list-group">
			  <li class="list-group-item active" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/shopInfo'">업체정보 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/password'">비밀번호 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/hashtag'">해시태그 설정</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/reservationSetting'">예약 관리</li>
			</ul>
        </div>
        <!-- 설정 영역 -->
        <div class="col-sm-8">
        	<label for="username">이름</label><input type="text" name="" id="username" />
        	<br />
        	<label for="profile">프로필사진</label><input type="file" name="" id="profile" />
        	<br />
        	<br />
        	
        	<label for="bussiness-hour-start">영업시간</label>
        	<br />
        	<input type="time" name="bussiness-hour-start" />~<input type="time" name="bussiness-hour-end"/>        	
        	<br />
        	<br />
        	<label for="introduce">소개</label>
        	<br />
        	<input type="text" name="introduce" />
        	<br />
        	<br />
        	<label for="location">주소</label>
        	<br />
        	<input type="text" name="addressAll" style="width:300px;"/>
        	<input type="button" value="검색" onclick="execDaumPostcode();" />
        	<br />
        	<label for="location2">상세주소</label>
        	<br />
        	<input type="text" name="addressFull" />
        	<input type="hidden" name="addressFirst" />
        	<input type="hidden" name="addressSecond" />
        	<input type="hidden" name="addressThird" />
        	<br />
        	<br />
        	<input type="button" value="저장하기" />
        	
        	
        </div>
    </div>
</div>
<script>
	$(() => {
		$('[name=introduce]').val(${loginMember.introduce});
		$('[name=addressAll]').val('${loginMember.addressAll}');
		$('[name=addressFull]').val('${loginMember.addressFull}');
		
	});
</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("roadAddress").value = roadAddr;
            document.getElementById("jibunAddress").value = data.jibunAddress;

            console.log(data.buildingName);
            console.log(data.roadAddress);
            console.log(data.jibunAddress);
            
            $("[name=addressFirst]").val(data.sido);
            $("[name=addressSecond]").val(data.sigungu);
            $("[name=addressThird]").val(data.bname);
            $("[name=addressAll]").val(data.roadAddress);
            
            close();
        }
    }).open();
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>>