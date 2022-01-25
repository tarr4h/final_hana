<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="AroundME" name="title" />
</jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/shop/shopMain.css" />

<sec:authentication property="principal" var="loginMember" />

<div class="container mb-4">
	<div class="row hashTagRank">
		<table class="table table-striped table-dark my-0">
			<thead>
				<tr>
					<th colspan="5" class="bg-white text-dark" id="hashTagRankTitle">HashTag
						Ranking</th>
				</tr>
				<tr>
					<th scope="col">Rank</th>
					<th scope="col">음식점</th>
					<th scope="col">카페</th>
					<th scope="col">헤어샵</th>
					<th scope="col">노래방</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">1</th>
					<td>Mark ★</td>
					<td>Otto ★</td>
					<td>@mdo ★</td>
					<td>@mdo ★</td>
				</tr>
				<tr>
					<th scope="row">2</th>
					<td>Jacob</td>
					<td>Thornton</td>
					<td>@fat</td>
					<td>@fat</td>
				</tr>
				<tr>
					<th scope="row">3</th>
					<td>Larry</td>
					<td>the Bird</td>
					<td>@twitter</td>
					<td>@twitter</td>
				</tr>
				<tr>
					<th scope="row">4</th>
					<td>Larry</td>
					<td>the Bird</td>
					<td>@twitter</td>
					<td>@twitter</td>
				</tr>
			</tbody>
		</table>
	</div>

	<!-- 검색 영역 -->
	<div class="row searchArea my-0">
		<nav class="navbar navbar-light bg-light justify-content-end">
			<span class="navbar-brand mb-0 h1" id="searchTitle">Search
				HashTag</span>
			<form class="form-inline d-flex">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search" id="searchInput">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit"
					id="searchBtn">Search</button>
			</form>
		</nav>
	</div>

	<!-- 매장 랭킹 영역 -->
	<div class="row shopRank bg-dark text-white">
		<div
			class="col-md-4 d-flex justify-content-center align-items-center flex-column">
			<span class="d-flex align-items-start">★★★</span> <span class="mb-4">조회
				수 1위 매장</span>
			<div class="shopProfile d-flex">
				<!-- 프로필사진 영역 -->
				<a href="#"> <img class="shopProfileImg"
					src="${pageContext.request.contextPath }/resources/images/duck.png"
					alt="" />
				</a>
			</div>
			<span>매장ID</span> <span>조회 수</span>
		</div>
		<div
			class="col-md-4 d-flex justify-content-center align-items-center flex-column">
			<span class="d-flex align-items-start">★★★</span> <span class="mb-4">리뷰
				수 1위 매장</span>
			<div class="shopProfile d-flex">
				<!-- 프로필사진 영역 -->
				<img class="shopProfileImg"
					src="${pageContext.request.contextPath }/resources/images/duck.png"
					alt="" />
			</div>
			<span>매장ID</span> <span>리뷰 수</span>
		</div>
		<div
			class="col-md-4 d-flex justify-content-center align-items-center flex-column">
			<span class="d-flex align-items-start">★★★</span> <span class="mb-4">예약
				수 1위 매장</span>
			<div class="shopProfile d-flex">
				<!-- 프로필사진 영역 -->
				<img class="shopProfileImg"
					src="${pageContext.request.contextPath }/resources/images/duck.png"
					alt="" />
			</div>
			<span>매장ID</span> <span>예약 수</span>
		</div>
	</div>
	<div class="row shopList bg-secondary text-white" id="shopList">
		<!-- 
       <div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
        	<div class="shopProfile d-flex">
	             프로필 사진 영역   	
	        	<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
       		</div>
       		<span class = "shopScroll">매장ID</span>
        </div>
       -->
	</div>

	<!-- pageBar -->
	<div>pageNation</div>
</div>

<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ik4yiy9sdi&submodules=geocoder">
</script>
<script>

var loading = false;
var page = 1;
var endNum = 6;
var startNum = 0;

function scrollPage(){
$(() => {

		console.log("${loginMember.addressAll}");
		var Addr_val = "${loginMember.addressAll}";
	

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

	    	$.ajax({
				url: `${pageContext.request.contextPath}/shop/shopList`,
				data: {
						id : "${loginMember.id}",
						locationX : x,
						locationY : y
				},
				success(res){
					console.log(res);
					 list = res;
					console.log(list);

//				  for(var i=0; i<list.length;i++){
					if(startNum == 0){
						  for(var i=0; i<endNum; i++){
						    console.log(list[i].ID)
						    console.log(endNum)
							var htmlOut='';
							htmlOut += '<div class="col-md-4 d-flex justify-content-center align-items-center flex-column">';
							htmlOut += '<div class="shopProfile d-flex">';
						    htmlOut += '<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png"/>';
						    htmlOut += '</div>';
						    htmlOut += '<span class = "shopScroll">'+ list[i].ID + '</span>';
							$('#shopList').append(htmlOut); 
						}  
					}  
						else{
						 	for(var i=startNum; i<endNum; i++){
						 		 console.log(startNum)
								    console.log(endNum)
									var htmlOut='';
									htmlOut += '<div class="col-md-4 d-flex justify-content-center align-items-center flex-column">';
									htmlOut += '<div class="shopProfile d-flex">';
								    htmlOut += '<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png"/>';
								    htmlOut += '</div>';
								    htmlOut += '<span class = "shopScroll">'+ list[i].ID + '</span>';
									$('#shopList').append(htmlOut); 
						 	}
						  }  
				page++;
				console.log(page);
				startNum = (endNum + 1);  //7  14 
				endNum += 8; //13 21
				console.log("false 전 start :" + startNum) // 7
				console.log("false 전 end :" +endNum)
				
				loading = false;
				if(list.length === 0){
				console.log(list.length);					
				console.log(startNum)
				console.log(endNum)
				
					loading = true;
				}
				},
				error:console.log			
			});
	    });
	});
};
	// scroll 위치지정 및 ajax실행
	$(window).scroll(function(){
		if($(window).scrollTop() + 10 >= $(document).height() - $(window).height()){
			if(!loading){
				loading = true;
				scrollPage();
			}
		}
	});

	
</script>







<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>