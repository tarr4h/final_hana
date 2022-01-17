<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="AroundME" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/shop/shopMain.css" />


<div class="container mb-4">
	<!-- <div class="row header mb-0 mt-3">
		<nav class="navbar navbar-light justify-content-center">
			<span class="navbar-brand mb-0 h5">업체 추천 메뉴</span>
		</nav>
	</div> -->

    <div class="row hashTagRank">
		<table class="table table-striped table-dark my-0">
		  <thead>
		  	<tr>
		  		<th colspan="5" class="bg-white text-dark" id="hashTagRankTitle">HashTag Ranking</th>
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
        	<span class="navbar-brand mb-0 h1" id="searchTitle">Search HashTag</span>
		 	<form class="form-inline d-flex">
		    	<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" id="searchInput">
		    	<button class="btn btn-outline-success my-2 my-sm-0" type="submit" id="searchBtn">Search</button>
		  	</form>
		</nav>
    </div>
    
    <!-- 매장 랭킹 영역 -->
    <div class="row shopRank bg-dark text-white">
        <div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
       		<span class="mb-4">조회 수 1위 매장</span>
        	<div class="shopProfile d-flex">
	        	<!-- 프로필사진 영역 -->
	        	<a href="#">
	        		<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
	        	</a>
       		</div>
       		<span>매장ID</span>
       		<span>조회 수</span>
        </div>
        <div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
       		<span class="mb-4">리뷰 수 1위 매장</span>
        	<div class="shopProfile d-flex">
	        	<!-- 프로필사진 영역 -->
	        	<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
       		</div>
       		<span>매장ID</span>
       		<span>리뷰 수</span>
        </div><div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
       		<span class="mb-4">예약 수 1위 매장</span>
        	<div class="shopProfile d-flex">
	        	<!-- 프로필사진 영역 -->
	        	<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
       		</div>
       		<span>매장ID</span>
       		<span>예약 수</span>
        </div>
    </div>
    <div class="row shopList bg-secondary text-white">
        <div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
        	<div class="shopProfile d-flex">
	        	<!-- 프로필사진 영역 -->
	        	<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
       		</div>
       		<span>매장ID</span>
        </div>
        <div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
        	<div class="shopProfile d-flex">
	        	<!-- 프로필사진 영역 -->
	        	<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
       		</div>
       		<span>매장ID</span>
        </div>
        <div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
        	<div class="shopProfile d-flex">
	        	<!-- 프로필사진 영역 -->
	        	<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
       		</div>
       		<span>매장ID</span>
        </div>
        <div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
        	<div class="shopProfile d-flex">
	        	<!-- 프로필사진 영역 -->
	        	<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
       		</div>
       		<span>매장ID</span>
        </div>
        <div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
        	<div class="shopProfile d-flex">
	        	<!-- 프로필사진 영역 -->
	        	<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
       		</div>
       		<span>매장ID</span>
        </div>
        <div class="col-md-4 d-flex justify-content-center align-items-center flex-column">
        	<div class="shopProfile d-flex">
	        	<!-- 프로필사진 영역 -->
	        	<img class="shopProfileImg" src="${pageContext.request.contextPath }/resources/images/duck.png" alt=""/>
       		</div>
       		<span>매장ID</span>
        </div>
	</div>
	
	<!-- pageBar -->
	<div>
		pageNation
	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>