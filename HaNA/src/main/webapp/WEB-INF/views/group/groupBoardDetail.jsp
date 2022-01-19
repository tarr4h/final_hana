
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메인화면" name="main"/>
</jsp:include>

<div id="map" style="width:100%;height:350px;"></div>
<c:forEach items="${tagMembers}" var="member">
<div>
	<div> ${member.id} <img src="${pageContext.request.contextPath}/resources/upload/member/profile/${member.picture}" style="height:100px" /></div>
</div>
</c:forEach>
${groupBoard.content}
${groupBoard.writer}
${groupBoard.likeCount}
${groupBoard.regDate}
${groupBoard.placeName}


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe4df2cda826ac2a53225fb7dea2a307"></script>
<script>

const x = <c:out value='${groupBoard.locationX}'/>;
const y = <c:out value='${groupBoard.locationY}'/>;
console.log(x,y);
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(y, x); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>