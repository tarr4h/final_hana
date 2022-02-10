<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberView.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="마이페이지" name="title"/>
</jsp:include>

<!-- 우측 공간확보 -->
<section class="body-section" style="width:200px;height:100%;float:right;display:block;">
		<span style="float:right;">ㅁㄴ이랸멍리ㅑㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴㅇㄹ</span>
</section>


<section class="body-section">

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="https://kit.fontawesome.com/0748f32490.js"	crossorigin="anonymous">
</script>
<sec:authentication property="principal" var="loginMember"/>

<c:if test="${not empty msg}">
	<script>
	alert("${msg}");
	</script>
</c:if>

<div class="container profile mt-2">
    <div class="row" id="myInfo">
    	<!-- 프로필이미지 영역 -->
        <div class="col-sm-5 d-flex justify-content-center align-items-center flex-column" id="profileImg">
        	<div class="profileImg d-flex">
        		<!-- 이미지를 넣으세요 -->
        		<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${member.picture}" alt=""/>
        	</div>
        	<div class="profileBtn">
        		<c:if test="${loginMember.id.equals(member.id) }">
        		<div class="extraSet">
        		<!-- (+)버튼을 -->
        		<form:form name="profileUpdateFrm" action="${pageContext.request.contextPath }/member/profileUpdate?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
	        		<label class="input-file-button" for="input-file">
	        			<img src="${pageContext.request.contextPath }/resources/images/icons/plusIcon.png" alt="" />
	        		</label>
	        		<input type="file" name="upFile" id="input-file" style="display:none;"/>
        		</form:form>
        		</div>
        		</c:if>
        	</div>
        </div>

        <!-- 프로필 세부정보 영역 -->
        <div class="col-sm-7" id="profileStatus">
        <br /><br /><br />
        	<span class="followTitle">팔로잉 :</span>
        	<button  type="button" class="btn btn-secondary" id="btn-following-list">${followerCount}명</button>
        	<span class="followTitle">팔로워 : </span>
        	 <button  type="button" class="btn btn-secondary" id="btn-follower-list">${followingCount}명</button>
        	 
        	<!-- 설정버튼 : 본인계정일땐 설정, 아닐땐 친구추가 버튼 -->
        	<c:if test="${loginMember.id.equals(member.id) }">
        	<button type="button" class="btn btn-outline-dark icon" id="settingBtn" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/personal'">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/setting.png" alt="" />
        	</button>
        	</c:if>
        	<c:if test="${!loginMember.id.equals(member.id) }">
        	<button type="button" class="btn btn-outline-dark icon" id="addFriendBtn" onclick="addFollowing();">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/man.png" alt="" />
        	</button>
        	<!-- 친구추가frm -->
  	        <form:form name="addFollowingFrm" action="${pageContext.request.contextPath}/member/addFollowing" method = "POST">
        		<input type="hidden" name ="friendId" value="${member.id}" />
        		<input type="hidden" name ="myId" value="${loginMember.id}" />
        	</form:form>
        	</c:if>

            <br /><br />
            
            <div class="profileTableArea">
				<table id="profileTable">
					<tbody>
						<tr>
							<td class="tableKey">아이디</td>
							<td class="tableValue">${member.id}</td>
						</tr>
						<tr>
							<td><span class="tableKey">지역</span></td>
							<td>${shopInfo.address}</td>
						</tr>
						<tr>
							<td rowspan=2><span class="tableKey">소개</span></td>
							<td class="tableValue" rowspan=2>
								 ${shopInfo.shopIntroduce} 
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td><span class="tableKey">평점</span></td>
							<td>
								<span class="tableValue grade">4.9</span>
							</td>
						</tr>
						
						<!-- 본인인 경우 예약확인버튼 노출 -->
						<c:if test="${loginMember.id.equals(member.id) }">
						<tr>
							<td>
								<input type="button" value="예약확인" id="reservationListBtn"/>
								
								<!-- reservation check Modal -->
								<jsp:include page="/WEB-INF/views/member/modal/shopReservationList.jsp"></jsp:include>
							</td>
						</tr>
						</c:if>
						
						<!-- 본인이 아닌 경우 예약하기 버튼 노출 -->
						<c:if test="${!loginMember.id.equals(member.id) }">
						<tr>
							<td>
								<input type="button" value="예약" id="reservationBtn"/>
								
								<!-- reservation Modal -->
								<jsp:include page="/WEB-INF/views/member/modal/shopReservation.jsp"></jsp:include>
							</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<!-- 글쓰기버튼 -->
			<c:if test="${loginMember.id.equals(member.id) }">
        	<button id="boardModalBtn" style="float:right; margin-top:30px"><i style="font-size: 30px;" class="fas fa-pencil-alt"></i></button>
        	<jsp:include page="/WEB-INF/views/member/boardModal/boardModal.jsp"></jsp:include>
        	</c:if>
		</div>
    </div>
</div> 

<div class="container mt-2">       
    <div class="row">   
        <!-- 탭 영역 -->
        <div class="col-sm-12 nav nav-pills nav-fill" id="tab">   	
		  <div class="col-sm-6 nav-item d-flex justify-content-center align-items-center">
		    <a class="nav-link active" href="#" id="normalTabBtn">게시물</a>
		  </div>
		  <div class="col-sm-6 nav-item d-flex justify-content-center align-items-center">
		    <a class="nav-link" href="#" id="reviewTabBtn">후기</a>
		  </div>
        </div>
    </div>

    <div class="row" id="normalArea">
	    <jsp:include page="/WEB-INF/views/member/shopViewBoardArea/normalBoard.jsp"></jsp:include>
    </div>
    <div class="row" id="reviewArea" style="display:none;">
    	<jsp:include page="/WEB-INF/views/member/shopViewBoardArea/reviewBoard.jsp"></jsp:include>
    </div>
</div>

<script>
	$("#reviewTabBtn").click((e) => {
		$("#normalArea").hide();
		$("#reviewArea").show();
		$(e.target).addClass("active");
		$("#normalTabBtn").removeClass("active");
	});
	$("#normalTabBtn").click((e) => {
		$("#normalArea").show();
		$("#reviewArea").hide();
		$(e.target).addClass("active");
		$("#reviewTabBtn").removeClass("active");
	});

	/* profile 사진 업데이트 */
	$(".input-file-button").click((e) => {
		if(!confirm("파일을 등록하시겠습니까?")){
			return false;
		};
	});
	$("#input-file").change((e) => {
		console.log("파일등록");
		$(document.profileUpdateFrm).submit();
	});
	
	//친구추가하기
	function addFollowing(){
		if(confirm("친구추가를 하시겠습니까?")){
			$(document.addFollowingFrm).submit();
		}
	};
	
	//게시물 목록
	$('.board-main-image').click((e)=>{
		let boardNo = $(e.target).siblings("#boardNo").val();
		console.log("boardNo1",boardNo);
		getPageDetail(boardNo);
		
		$('#pageDetail').modal("show");
	});
	
	/* 업체 평점 구하기 */
	function getShopGrade(shopId){
		$.ajax({
			url: '${pageContext.request.contextPath}/shop/getShopGrade',
			data:{
				shopId
			},
			success(res){
				console.log(res);
			},
			error: console.log
		});
	};
	
	$(() => {
		let shopId = '${shopInfo.id}';
		getShopGrade(shopId);
	})

</script>

  

<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>