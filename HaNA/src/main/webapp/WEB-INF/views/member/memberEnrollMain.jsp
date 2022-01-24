<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

<div class="container mt-5">
	<div class="row">
		<div class="col-sm">
			<h1>회원가입</h1>
	
			<form:form action="${pageContext.request.contextPath }/member/memberEnroll?${_csrf.parameterName}=${_csrf.token}" method="POST" name="enrollFrm" enctype="multipart/form-data">
				<table>
					<tbody>
						<tr>
							<td>계정 구분</td>
							<td>
								<label for="user">일반사용자</label><input type="radio" name="accountType" value="1" />
								<label for="shop">업체</label><input type="radio" name="accountType" value="0" />
							</td>
						</tr>
						<tr>
							<td>아이디</td>
							<td>
								<input type="text" name="id" id="memberId" />
							</td>
						</tr>
						<tr>
							<td>이름</td>
							<td>
								<input type="text" name="name" />
							</td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td>
								<input type="password" name="password" />
							</td>
						</tr>
						<tr>
							<td>비밀번호확인</td>
							<td>
								<input type="password" name="passwordChk" id="" />
							</td>
						</tr>
						<tr>
							<td>주민번호</td>
							<td>
								<input type="text" name="ssn1" id="" />
								-
								<input type="password" name="ssn2" id="" />
								<input type="hidden" name="personalId" />
							</td>
						</tr>
						<tr>
							<td>프로필사진</td>
							<td>
								<input type="hidden" name="picture" value="notYet" />
								<input type="file" name="pictureFile" id="" />
							</td>
						</tr>
						<tr>
							<td>주소</td>
							<td>
								<input type="text" id="postcode" placeholder="우편번호">
								<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
								<input type="text" id="roadAddress" placeholder="도로명주소">
								<span id="guide" style="color:#999;display:none"></span>
								
								<input type="text" id="detailAddress" name="addressFull" placeholder="상세주소" required>
								<input type="hidden" name="addressAll" />
								<input type="hidden" name="locationX" />
								<input type="hidden" name="locationY" />
							</td>
						</tr>
						<tr>
							<td>소개글</td>
							<td>
								<input type="text" name="introduce" id="introduce" />
							</td>
						</tr>
					</tbody>
				</table>
				<button>가입하기</button>
			</form:form>
		</div>
	</div>
</div>


<script type="text/javascript" 
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ik4yiy9sdi&submodules=geocoder">
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$("[name=ssn2]").blur((e) => {
		const ssn1 = $("[name=ssn1]").val();
		const ssn2 = $("[name=ssn2]").val();
		
		const pId = ssn1 + '-' + ssn2;
		$("[name=personalId]").val(pId);
		console.log(pId);
	});

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

            console.log(data.buildingName);
            console.log(data.roadAddress);
            
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
            	
                close();
            });
        	
        }
    }).open();
}
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>