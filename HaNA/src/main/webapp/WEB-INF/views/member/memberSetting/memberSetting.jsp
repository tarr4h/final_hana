<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="설정화면" name="memberSetting/"/>
</jsp:include>
<!-- 우측 공간확보 -->
<section class="body-section" style="width:200px;height:100%;float:right;display:block;">
<span style="float:right;">ㅁㄴ이랸멍리ㅑㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴㅇㄹ</span>
</section>
<section>
<sec:authentication property="principal" var="loginMember"/>

<c:if test="${not empty msg}">
	<script>
		$(() => {
			alert("${msg}");
		})
	</script>	
</c:if>
 
<div class="settingBar">
  <a class="settingList" href="${pageContext.request.contextPath}/member/memberSetting/memberSetting">프로필편집</a>
  <a class="settingList" href="#">비밀번호 변경</a>
  <a class="settingList" href="#">계정 공개</a>
  <a class="settingList" href="#">정보 공개</a>
  <a class="settingList" href="#">예약 관리</a> 
</div>
  
<style>
 .settingBar{
    height: 60px;
    text-align: center;
    margin-top: 80px;
    margin-bottom: 60px;
    border-bottom-style: ridge;
    }
.settingList {
	font-size: 16px;
    margin-left: 34px;
      color: black;
    text-decoration: none;
}
.form-control {
    display: block;
    width: 450px;
    height : 50px;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    border-radius: 0.25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    margin-bottom : 15px;
} 
.custom-select{
	width : 450px;
	height : 38px;
	margin-bottom : 15px;
}
</style>


<div id="enroll-container" class="mx-auto text-center">
	<form:form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data" method="POST">
		<table class="mx-auto">
		 <input type="hidden" name="id" value="${loginMember.id}" />
			<tr>
				<th>이름</th>
				<td>
					<div id="memberId-container">
						<input type="text" class="form-control" name="name" id="name" value="${loginMember.name}" required >
					 				
					</div>
				</td>
			</tr>
			<tr>
				<th>프로필사진</th>
				<td>
					<input type="file" class="form-control" name="upFile" id="" value="파일 선택" />
					<input type="hidden" name="picture" value="${loginMember.picture }" />
				</td>
			</tr>
		
			<tr>
				<th>소개</th>
				<td>
				<!-- <input type="text" class="form-control" name="introduce" id="introduce" value="${loginMember.introduce}" required> -->	
				<textarea class="form-control" name="introduce" id="introduce" cols="55" rows="20" >  ${loginMember.introduce} </textarea>
				
				</td>
			</tr>
			<tr>
				<th>지역</th>
	  		  	<td>	
					<input type="text" class="form-control" id="postcode" placeholder="우편번호">
					<input type="button" class="form-control" onclick="execDaumPostcode()" value="우편번호 찾기">
					<input type="text" class="form-control" id="roadAddress" placeholder="도로명주소" value="${loginMember.addressAll }">
					<input type="text" class="form-control" id="detailAddress" name="addressFull" placeholder="상세주소" value="${loginMember.addressFull }" required>
					<input type="hidden" name="addressAll" />
					<input type="hidden" name="locationX" />
					<input type="hidden" name="locationY" />
				</td>
			</tr>  
			<tr>
				<th>내 성격</th>
				<td>	
					<select name="personality" id="personality" class="custom-select" required>
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
				</td>
			</tr>
			<tr>
				<th>내 관심사</th>
				<td>	
				<select name="interest" class="custom-select" required>
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
				</td>
			</tr> 

		</table>
 
		<input type="submit" class="btn btn-dark"></button>
		<input type="reset" class="btn btn-dark"></button>
	</form:form>
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

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("roadAddress").value = roadAddr;
            
            $("[name=addressAll]").val(data.roadAddress);
            
        	var Addr_val = $('[name=addressAll]').val();

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

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>