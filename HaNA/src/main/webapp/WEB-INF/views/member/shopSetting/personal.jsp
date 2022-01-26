<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="프로필 설정" name="title"/>
</jsp:include>

<sec:authentication property="principal" var="loginMember"/>

<h1>shop프로필설정</h1>
<div class="container">
    <div class="row">
    	<!-- 메뉴 영역 -->
        <div class="col-sm-4">
        	<ul class="list-group">
			  <li class="list-group-item active" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/personal'">개인정보 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/shopInfo'">업체정보 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/password'">비밀번호 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/hashtag'">해시태그 설정</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/reservationSetting'">예약 관리</li>
			</ul>
        </div>
        
        <div class="col-sm-8">
        	<form:form name="personalUpdateFrm" method="POST" action="${pageContext.request.contextPath }/member/memberUpdate?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
	        	<label for="username">이름</label>
	        	<input type="text" name="name" id="name" value="${loginMember.name }"/>
	        	<br />
	        	<label for="picture">프로필사진</label>
	        	<img src="${pageContext.request.contextPath }/resources/upload/member/profile/${loginMember.picture}" alt="" style="width:50%;"/>
	        	<input type="file" name="upFile" value="${loginMember.picture }"/>
	        	<input type="hidden" name="picture" value="${loginMember.picture }" />
	        	<br />
	        	<label for="introduce">소개</label>
	        	<br />
	        	<input type="text" name="introduce" value="${loginMember.introduce }"/>
	        	<br />
	        	<label for="addressAll">주소</label>
	        	<br />
	        	<input type="text" name="addressAll" style="width:300px;" value="${loginMember.addressAll }"/>
	        	<input type="button" value="검색" onclick="execDaumPostcode();" />
	        	<br />
	        	<label for="addressFull">상세주소</label>
	        	<br />
	        	<input type="text" name="addressFull" value="${loginMember.addressFull }" required/>
	        	<input type="hidden" name="locationX" value="${loginMember.locationX }"/>
	        	<input type="hidden" name="locationY" value="${loginMember.locationY }"/>
	        	<input type="hidden" name="id" value="${loginMember.username }"/>
	        	<br />
		        
				<br />
				<label for="personality">내 성격</label>	
					<select name="personality" id="personality" class="custom-select">
					  <option value="" disabled selected>선택해주세요</option>
					  <option value="차분한" ${loginMember.personality  eq '차분한'? 'selected' : ''}>차분한</option>
					  <option value="활발한" ${loginMember.personality  eq '활발한'? 'selected' : ''}>활발한</option>
					  <option value="내향적인" ${loginMember.personality  eq '내향적인'? 'selected' : ''}>내향적인</option>
					  <option value="외향적인" ${loginMember.personality  eq '외향적인'? 'selected' : ''}>외향적인</option>
					  <option value="열정적인" ${loginMember.personality  eq '열정적인'? 'selected' : ''}>열정적인</option>
					  <option value="느긋한" ${loginMember.personality  eq '느긋한'? 'selected' : ''}>느긋한</option>
					  <option value="다정한" ${loginMember.personality  eq '다정한'? 'selected' : ''}>다정한</option>
					  <option value="헌신적인" ${loginMember.personality  eq '헌신적인'? 'selected' : ''}>헌신적인</option>
					  <option value="솔직한" ${loginMember.personality  eq '솔직한'? 'selected' : ''}>솔직한</option>
					  <option value="낙천적인" ${loginMember.personality  eq '낙천적인'? 'selected' : ''}>낙천적인</option>
					   <option value="호기심많은" ${loginMember.personality  eq '호기심많은'? 'selected' : ''}>호기심많은</option>
					</select>

				<br />

				<label for="interest">내 관심사</label>	
				<select name="interest" class="custom-select">
					<option value="" disabled selected>선택해주세요</option>
					<option value="책" ${loginMember.interest  eq '책'? 'selected' : ''}>책</option>
				 	<option value="패션" ${loginMember.interest  eq '패션'? 'selected' : ''}>패션</option>
				   	<option value="음식" ${loginMember.interest  eq '음식'? 'selected' : ''}>음식</option>
				    <option value="동물" ${loginMember.interest  eq '동물'? 'selected' : ''}>동물</option>
				    <option value="여행" ${loginMember.interest  eq '여행'? 'selected' : ''}>여행</option>
				  	<option value="게임" ${loginMember.interest  eq '게임'? 'selected' : ''}>게임</option>
				  	<option value="영화" ${loginMember.interest  eq '영화'? 'selected' : ''}>영화</option>
				    <option value="건강" ${loginMember.interest  eq '건강'? 'selected' : ''}>건강</option>
				   	<option value="음악" ${loginMember.interest  eq '음악'? 'selected' : ''}>음악</option>
				    <option value="패션" ${loginMember.interest  eq '패션'? 'selected' : ''}>패션</option>
				   	<option value="스포츠" ${loginMember.interest  eq '스포츠'? 'selected' : ''}>스포츠</option>
				</select>
				<br />
	        	<input type="submit" value="저장하기" id="formBtn"/>	
        	</form:form>
        </div>
        
    </div>
</div>

<script type="text/javascript" 
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ik4yiy9sdi&submodules=geocoder">
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
            
            if(data.roadAddress == null){
            	alert("유효하지 않은 도로명 주소입니다. 다시 선택해주세요");
            }
            
            $("[name=addressAll]").val(data.roadAddress);     
            
        	var Addr_val = data.roadAddress;
        	// 도로명 주소를 좌표 값으로 변환(API)
          	naver.maps.Service.geocode({
                query: Addr_val
            }, function(status, response) {
                if (status !== naver.maps.Service.Status.OK) {
                    return alert('잘못된 주소값입니다.');
                }

                var result = response.v2, // 검색 결과의 컨테이너
                    items = result.addresses; // 검색 결과의 배열
                    
                // 리턴 받은 좌표 값을 변수에 저장
                let x = parseFloat(items[0].x);
                let y = parseFloat(items[0].y);
                
                $('[name=locationX]').val(x);
                $('[name=locationY]').val(y);
                
                console.log(x);
                console.log(y);
                
            	close();
            });
        }
    }).open();
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>