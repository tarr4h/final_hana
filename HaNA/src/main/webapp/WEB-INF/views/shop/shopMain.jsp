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

<!-- autocomplete 라이브러리 -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<!-- 우측 공간확보 -->
<section class="body-section"
	style="width: 200px; height: 100%; float: right; display: block;">
	<span style="float: right;">ㅁㄴ이랸멍리ㅑㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴㅇㄹ</span>
</section>
<section class="body-section">
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

				</form>
			</nav>
		</div>

		<div class="row searchResultArea my-0">
			<div class="hashTagResult" id="hashTagResult">
				<!-- HashTag 검색 후 클릭/엔터 시 동적으로 버튼 생길 공간  -->
			</div>
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit"
				id="searchBtn" >Search</button>
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
	
// 원본유지 용
/* var loading = false;
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
					 list = res;
					console.log(list.length);
					const max = list.length;

					
					if(startNum == 0){
						  for(var i=0; i<endNum; i++){
							console.log("if list[i].ID : " + list[i].ID)
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
									var htmlOut='';
									htmlOut += '<div class="col-md-4 d-flex justify-content-center align-items-center flex-column">';
									htmlOut += '<div class="shopProfile d-flex">';
								    htmlOut += '<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png"/>';
								    htmlOut += '</div>';
								    htmlOut += '<span class = "shopScroll">'+ list[i].ID +'</span>';
									$('#shopList').append(htmlOut);
									// list[i].ID가 마지막이라면 return
									if(i == max -1){
										return;
									}
						 	}
						  }  
				page++;
				endNum -= 1; //  6-1 = 5 
				startNum = (endNum +1) ;  // 6 12
				endNum += 7; //12 18
				console.log("false 전 start :" + startNum) 
				console.log("false 전 end :" +endNum)
				
				loading = false;
				if(list.length === 0){	
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
	}); */
	

var loading = false;
var page = 1;
var endNum = 6;
var startNum = 0;
var selectDataArr = []; //hashTag 담을 배열
var hashTagData = ""; // 검색 데이터 잠시 담을 변수

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
						locationY : y,
						selectDataArr : selectDataArr
				},
				success(res){
					 list = res;
					console.log(list);
					const max = list.length;

					// 해시태그 있을때 
					if(startNum == 0){
						  for(var i=0; i<endNum; i++){
							var htmlOut='';
							htmlOut += '<div class="col-md-4 d-flex justify-content-center align-items-center flex-column">';
							htmlOut += '<div class="shopProfile d-flex">';
						    htmlOut += '<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png"/>';
						    htmlOut += '</div>';
						    htmlOut += '<span class = "shopScroll">'+ list[i].ID + '</span>';
						    if(list[i].TAG_NAME === ""){
							console.log(list[i])
							htmlOut += '<span class = "shopScroll">'+'#'+ list[i].TAG_NAME + '</span>';						    	
						    }
							$('#shopList').append(htmlOut); 
							
						}  
					}else{
						 	for(var i=startNum; i<endNum; i++){  
							console.log(list[i])
									var htmlOut='';
									htmlOut += '<div class="col-md-4 d-flex justify-content-center align-items-center flex-column">';
									htmlOut += '<div class="shopProfile d-flex">';
								    htmlOut += '<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png"/>';
								    htmlOut += '</div>';
								    htmlOut += '<span class = "shopScroll">'+ list[i].ID + '</span>';
								    if(list[i].TAG_NAME === ""){
										console.log(list[i])
									htmlOut += '<span class = "shopScroll">'+'#'+ list[i].TAG_NAME + '</span>';						    	
									}
									$('#shopList').append(htmlOut);
									// list[i].ID가 마지막이라면 return
									if(i == max -1){
										return;
								}
						 	}
						  }  
				page++;
				endNum -= 1; //  6-1 = 5 
				startNum = (endNum +1) ;  // 6 12
				endNum += 7; //12 18
				console.log("false 전 start :" + startNum) 
				console.log("false 전 end :" +endNum)
				
				loading = false;
				if(list.length === 0){	
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

	
 	 // Autocomplete  부분 
  var tagDataArr = [];  // tagButton을 가지고 검색시 tag데이터를 담을 배열
    $("#searchInput").autocomplete({
        source : function(request, response) {
            $.ajax({
                  url : "${pageContext.request.contextPath}/shop/hashTagAutocomplete",
                 data : {search : $("#searchInput").val()},
                 success : function(data){ 
                    		console.log(data)
                    response(
                        $.map(data, function(item) {
                            return {
                                  label : item.tagName  //목록에 표시되는 값
                            };
                        })
                    );  	
                },
                error : function(){ //실패
						console.log("실패")
                }
            });
        	}
        , minLength : 1  // 조회를 위한 최소 글자수  
        , autoFocus : true // 첫번째 항목 자동 포커스(기본값 : false) 
        , select: function( event, ui) {  //  리스트에서 태크 선택 하였을때 선택한 데이터에 의한 이벤트발생

        	 // 검색 데이터 변수에 담기  
        	  hashTagData  = ui.item.value;
        	console.log("변수 " +  hashTagData)
        
        	// 검색 데이터를 클릭/엔터 하면 버튼이 동적으로 생성  
			var hashTagBtn = document.createElement( 'button' );
        	var tagData = document.createTextNode(hashTagData);     	
		    document.getElementById('hashTagResult').appendChild(hashTagBtn);
		    // button style
		    hashTagBtn.style = 'background:linear-gradient(to bottom, #44c767 5%, #5cbf2a 100%); background-color:#44c767;border-radius:20px;border:2px solid #18ab29;color:#ffffff;font-size:12px;padding:5px 10px;font-weight:bold;margin: 4px;';
		    hashTagBtn.appendChild( tagData );
		    
		    console.log( tagData.nodeValue) // 텍스트 노드의 값을 가져오는 API .nodeValue
		    tagDataArr.push(tagData.nodeValue); //배열의 끝에 요소 추가
		   
		    console.log("tagDataArr = " + tagDataArr)
		    console.log("tagDataArr.length = " + tagDataArr.length)
        	
        }
        , focus : function(evt, ui) { //  한글 오류 방지
            return false;
        }
        , close : function(evt){
        	// input에 있는 text  사라지게
        	$("#searchInput").val('');
        	selectDataArr.push(hashTagData);
        	console.log("selectDataArr" + selectDataArr)
        	
        }
        
    }).autocomplete('instance')._renderItem = function(ul, item) {
		return $('<li>')
        .append('<div>' + item.label + '</div>') 
        .appendTo(ul);     
    };
    
    
 //  엔터시 submit 막기  
 document.addEventListener('keydown', function(event) {
  if (event.keyCode === 13) {
    event.preventDefault();
  };
});
  

 
 
 
</script>








</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>