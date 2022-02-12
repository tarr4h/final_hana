<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<style>
@import url(https://fonts.googleapis.com/css?family=Open+Sans:400,700);

@keyframes bake-pie {
  from {
    transform: rotate(0deg) translate3d(0,0,0);
  }
}
main {
  margin: 30px auto;
}
section {
  margin-top: 30px;
}
.pieID {
  display: inline-block;
  vertical-align: top;
}
.pie {
  height: 200px;
  width: 200px;
  position: relative;
  margin: 0 30px 30px 0;
}
.pie::before {
  content: "";
  display: block;
  position: absolute;
  z-index: 1;
  width: 100px;
  height: 100px;
  background: #EEE;
  border-radius: 50%;
  top: 50px;
  left: 50px;
}
.pie::after {
  content: "";
  display: block;
  width: 120px;
  height: 2px;
  background: rgba(0,0,0,0.1);
  border-radius: 50%;
  box-shadow: 0 0 3px 4px rgba(0,0,0,0.1);
  margin: 220px auto;
  
}
.slice {
  position: absolute;
  width: 200px;
  height: 200px;
  clip: rect(0px, 200px, 200px, 100px);
  animation: bake-pie 1s;
}
.slice span {
  display: block;
  position: absolute;
  top: 0;
  left: 0;
  background-color: black;
  width: 200px;
  height: 200px;
  border-radius: 50%;
  clip: rect(0px, 200px, 200px, 100px);
}
.legend {
  list-style-type: none;
  padding: 0;
  margin: 0;
  background: #FFF;
  padding: 15px;
  font-size: 13px;
  box-shadow: 1px 1px 0 #DDD,
              2px 2px 0 #BBB;
}
.legend li {
  width: 110px;
  height: 1.25em;
  margin-bottom: 0.7em;
  padding-left: 0.5em;
  border-left: 1.25em solid black;
}
.legend em {
  font-style: normal;
}
.legend span {
  float: right;
}
footer {
  position: fixed;
  bottom: 0;
  right: 0;
  font-size: 13px;
  background: #DDD;
  padding: 5px 10px;
  margin: 5px;
}
</style>

<!-- google chart -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="프로필 설정" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberSetting.css" />
<sec:authentication property="principal" var="loginMember"/>
<section>

<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>

<br/><br/><br/><br/>
<div class="container">
    <div class="row">
    	<!-- 메뉴 영역 -->
        <div class="col-sm-4">
        	<ul class="list-group">
        		<li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/personal'">개인정보 변경</li>
				<li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/shopInfo'">업체정보 변경</li>
				<li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/password'">비밀번호 변경</li>
				<li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/hashtag'">해시태그 설정</li>
				<li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/reservationSetting'">예약 관리</li>
				<li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/reservationPriceSetting'">요금 관리</li>
				<li class="list-group-item active" onclick="location.href='${pageContext.request.contextPath}/shop/reservationStatistics'">예약 통계</li>
			</ul>
        </div>
        
        <div class="col-sm-8">
		    <div class="row">   
		        <!-- 탭 영역 -->
		        <div class="col-sm-12 nav nav-pills nav-fill" id="tab" style="width:100%;">
					<!-- 예약 수 -->
					<div class="col-sm-2 nav-item d-flex justify-content-center align-items-center">
				    	<a class="nav-link statsTab active" href="#" id="timeStats">시간대별 예약</a>
				  	</div>
				  	
				  	<!-- 예약 수 -->
					<div class="col-sm-2 nav-item d-flex justify-content-center align-items-center">
				    	<a class="nav-link statsTab" href="#" id="tableStats">테이블 차트</a>
				  	</div>
				  	
				  	<!-- 방문자 평균 -->
					<div class="col-sm-2 nav-item d-flex justify-content-center align-items-center">
				    	<a class="nav-link statsTab" href="#" id="visitorStats">방문자 평균</a>
				  	</div>
				  	
				  	<!-- 방문 회원 리스트 -->
				  	<div class="col-sm-2 nav-item d-flex justify-content-center align-items-center">
				    	<a class="nav-link statsTab" href="#" id="visitorList">방문 회원 목록</a>
				  	</div>
				  	
				  	<!-- 방문 회원 랭킹 -->
				  	<div class="col-sm-2 nav-item d-flex justify-content-center align-items-center">
				    	<a class="nav-link statsTab" href="#" id="visitorRank">방문 회원 랭킹</a>
				  	</div>
		        </div>
   		    </div>
   		    <div class="row">
   		    	<!-- content 영역 -->
   		    	<div class="col-sm-12 d-flex justify-content-center align-items-center">
   		    		<!-- 예약 수 AREA -->
   		    		<div class="contentArea timeStats">
						<section>
							<div class="pieID pie">
							</div>
							<ul class="pieID legend">
							  <li>
							    <em>심야</em>
							    <span>${timeMap.dawnList }</span>
							  </li>
							  <li>
							    <em>주간</em>
							    <span>${timeMap.dayList }</span>
							  </li>
							  <li>
							    <em>야간</em>
							    <span>${timeMap.nightList}</span>
							  </li>
							</ul>
						</section>
					</div>
   		    	
			  		<!-- 방문자 평균 AREA -->
				  	<div class="contentArea visitorStats" style="display:none;">
						<h3>총 방문 인원은 ${visitorAll }명 입니다.</h3>
					  	<!-- google chart -->
				 		<div id="chart_div"></div>
					</div>
					
					<!-- 테이블 통계 AREA -->
					<div class="contentArea tableStats" style="display:none;">
					  	<!-- google chart -->
				 		<div id="chart_div2"></div>
					</div>
					<!-- cotent Area End -->
				</div>
			</div>
		</div>
	</div>		
</div>
<c:if test=""></c:if>

<br /><br /><br />
<script>
/*
	countStats
	tableStats
	visitorStats
	visitorList
	visitorRank
*/
$(".statsTab").click((e) => {
	let targetId = $(e.target).prop('id');
	$(".contentArea").hide();
	$(`.\${targetId}`).show();
	$(".statsTab").removeClass("active");
	$(e.target).addClass("active");
	drawStacked();
	drawStacked2();
});

/* googleChart */
google.charts.load('current', {packages: ['corechart', 'bar']});
google.charts.setOnLoadCallback(drawStacked);
google.charts.setOnLoadCallback(drawStacked2);
/*  1 : 방문자 평균 */
function drawStacked() {
      var data = google.visualization.arrayToDataTable([  
        ['연령대', '남', '여'],
        ['10대', 30, 46],
        ['20대', 27, 59],
        ['30대', 21, 79],
        ['40대', 11, 13],
        ['50대', 8, 2],
        ['60대 이상', 1, 3]
      ]);

      var options = {
        title: '연령대/성별 차트',
        chartArea: {width: '50%'},
        isStacked: true,
        hAxis: {
          title: 'Total Reservation',
          minValue: 0,
        },
        vAxis: {
          title: ''
        }
      };
      var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
      chart.draw(data, options);
}
/*  2 : 테이블 평균 */
function drawStacked2() {
      var data2 = google.visualization.arrayToDataTable([
   	  	['테이블', '예약 수'],
   		<c:forEach items="${tableList }" var="table" varStatus="vs">
    		['${table.tableName}', ${table.count}]
    		<c:if test="${not vs.last}">,</c:if>
   		</c:forEach>
      ]);

      var options = {
        title: '테이블 누적 예약 수',
        chartArea: {width: '50%'},
        isStacked: true,
        hAxis: {
          title: 'Total Reservation',
          minValue: 0,
        },
        vAxis: {
          title: ''
        }
      };
      var chart = new google.visualization.BarChart(document.getElementById('chart_div2'));
      chart.draw(data2, options);
}


/* 1 graph script */
function sliceSize(dataNum, dataTotal) {
	  return (dataNum / dataTotal) * 360;
}

function addSlice(sliceSize, pieElement, offset, sliceID, color) {
  $(pieElement).append("<div class='slice "+sliceID+"'><span></span></div>");
  var offset = offset - 1;
  var sizeRotation = -179 + sliceSize;
  $("."+sliceID).css({
    "transform": "rotate("+offset+"deg) translate3d(0,0,0)"
  });
  $("."+sliceID+" span").css({
    "transform"       : "rotate("+sizeRotation+"deg) translate3d(0,0,0)",
    "background-color": color
  });
}
function iterateSlices(sliceSize, pieElement, offset, dataCount, sliceCount, color) {
  var sliceID = "s"+dataCount+"-"+sliceCount;
  var maxSize = 179;
  if(sliceSize<=maxSize) {
    addSlice(sliceSize, pieElement, offset, sliceID, color);
  } else {
    addSlice(maxSize, pieElement, offset, sliceID, color);
    iterateSlices(sliceSize-maxSize, pieElement, offset+maxSize, dataCount, sliceCount+1, color);
  }
}
function createPie(dataElement, pieElement) {
  var listData = [];
  $(dataElement+" span").each(function() {
    listData.push(Number($(this).html()));
  });
  var listTotal = 0;
  for(var i=0; i<listData.length; i++) {
    listTotal += listData[i];
  }
  var offset = 0;
  var color = [
    "cornflowerblue", 
    "olivedrab", 
    "orange", 
    "tomato", 
    "crimson", 
    "purple", 
    "turquoise", 
    "forestgreen", 
    "navy", 
    "gray"
  ];
  for(var i=0; i<listData.length; i++) {
    var size = sliceSize(listData[i], listTotal);
    iterateSlices(size, pieElement, offset, i, 0, color[i]);
    $(dataElement+" li:nth-child("+(i+1)+")").css("border-color", color[i]);
    offset += size;
  }
}
createPie(".pieID.legend", ".pieID.pie");
</script>


<%-- 
						원형그래프 원본
						<section>
						<div class="pieID pie">
						  
						</div>
						<ul class="pieID legend">
						  <li>
						    <em>Humans</em>
						    <span>718</span>
						  </li>
						  <li>
						    <em>Dogs</em>
						    <span>531</span>
						  </li>
						  <li>
						    <em>Cats</em>
						    <span>868</span>
						  </li>
						  <li>
						    <em>Slugs</em>
						    <span>344</span>
						  </li>
						  <li>
						    <em>Aliens</em>
						    <span>1145</span>
						  </li>
						</ul>
						</section> --%>





</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>