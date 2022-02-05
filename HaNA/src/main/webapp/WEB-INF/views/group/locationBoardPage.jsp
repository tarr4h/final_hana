<%@page import="com.kh.hana.group.model.vo.GroupBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/group.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/groupPlus.css" />

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<sec:authentication property="principal" var="loginMember" />
    
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe4df2cda826ac2a53225fb7dea2a307&libraries=services"></script>

<script>
let gb; // 스크립트에서 사용할 게시물 정보 

//계정페이지로 이동
function goMemberView(memberId){
	location.href=`${pageContext.request.contextPath}/member/memberView/\${memberId}`;
}
</script>
<style>
.location-container{
	border-bottom:1px solid gray;
	margin:auto;
	width:75%;
	height:500px;
	padding-top:100px;
	padding-bottom:100px;
}
.info-container {
	width:80%;
	height:100%;
	margin:auto;
}

#loca-info {
	width:100%;
	height:40%;
	margin-top:25%;
	padding-left:20%;
}
.group-board-container {
	padding-top:100px;
}
#locaInfo-placeName {
	font-size:1.2em;
	font-weight:bold;
}
#locaInfo-placeAddress {
	font-size:1.2em;

	color:gray;
}
</style>
<!-- 지도 및 (상호명 + 주소) -->
<section>
	<div class="location-container">
		<div class="info-container row" >
			<div class="col-sm-8">
				<div id="map" style="width:100%; height:100%;"></div>
			</div>
			<div id="loca-info-container" class="col-sm-4">
				<div id="loca-info">
					<span id="locaInfo-placeName">${locaInfo.placeName}</span>
					<br />
					<span id="locaInfo-placeAddress">${locaInfo.placeAddress}</span>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- 게시물 목록 -->
<section>
	<div class="group-board-container">
		<c:forEach items="${groupBoardList}" var="board" varStatus="vs">
			${vs.index%3 == 0? "<div style='margin-bottom:30px;' class='row'>" : ""}
		        <div class="col-sm-4" style="min-height:300px;">
		        	<input type="hidden" value="${board.no}" id="group-board-no"/>
					<img class="board-main-image" style="width:100%; height:100%; margin-bottom: 10%"
						src="${pageContext.request.contextPath}/resources/upload/group/board/${board.image[0]}"
						alt="" />
		        </div>
			${vs.index%3 == 2? "</div>" : ""}
		</c:forEach>
	</div>
</section>

<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(${locaInfo.locationY}, ${locaInfo.locationX}), // 지도의 중심좌표
        level: 2 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(${locaInfo.locationY}, ${locaInfo.locationX}); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>

    
<jsp:include page="/WEB-INF/views/group/modal/groupBoardDetail.jsp"/>
    
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>