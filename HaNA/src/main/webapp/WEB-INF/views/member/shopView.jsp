<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>


<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="마이페이지" name="title"/>
</jsp:include>

<!-- 우측 공간확보 -->
<section class="body-section" style="width:200px;height:100%;float:right;display:block;">
		<span style="float:right;">ㅁㄴ이랸멍리ㅑㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴㅇㄹ</span>
</section>


<section class="body-section">


<script src="https://kit.fontawesome.com/0748f32490.js"
	crossorigin="anonymous">
</script>
<sec:authentication property="principal" var="loginMember"/>

<c:if test="${not empty msg}">
	<script>
	alert("${msg}");
	</script>
</c:if>


<div class="container">
	
</div>


<style>
	#myInfo{
		border: 1px solid black;
	}
	#profileImg{
		height: 400px;
	}
	#profileStatus{
		height: 400px;
	}
	/* 세팅 버튼 */
	.icon {
		float: right;
		height:50px;
		width: 50px;
		border-radius: 100%;
		border: none;
	}
	.icon img {
		width: 130%;
	}
	
	/* 프로필이미지 */
	.profileImg.d-flex{
		width:230px;
		height:230px;
		border:1px solid black;
		border-radius:100%;
		background-color: red;
	}
	.profileImg img {
		width: 100%;
		border-radius: 100%;
	}
	.profileBtn{
		border: 1px solid black;
		width: 50px;
		height: 50px;
		border-radius:100%;
		transform: translateX(80px) translateY(-50px);
		z-index: 1;
		background-color: white;
	}
	.profileBtn img {
		width: 100%;
		border-radius: 100%;
	}

	/* 프로필정보 */
	.follow {
		display: inline-block;
		width: 100px;
		height: 30px;
		border: 1px solid black;
	}
	.followCount{
		display: inline-block;
		width: 100px;
		height: 30px;
		border: 1px solid black;
	}
	#profileTable{
		width: 100%;
		table-layout:fixed;
	}
	.tableKey{
		width: 20%;
	}
	.tableValue{
		width: 80%;
	}
	pre{
		margin:0;
	}
	#textArea{
		width: 100%;
		height: 150px;
		border: none;
		resize: none;
		background-color: white;
		padding-top: 30px;
		font-size:16px;
	}
	
	/* thumbnail list */
	.thumbnail{
		height: 300px;
		border: 1px solid black;
		padding: 5px;
	}
	.thumbnail img{
		width: 100%;
	}

</style>

<div class="container profile mt-2">
    <div class="row" id="myInfo">
    	<!-- 프로필이미지 영역 -->
        <div class="col-sm-5 d-flex justify-content-center align-items-center flex-column" id="profileImg">
        	<div class="profileImg d-flex">
        		<!-- 이미지를 넣으세요 -->
        		<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${member.picture}" alt=""/>
        	</div>
        	<div class="profileBtn">
        		<!-- (+)버튼을 -->
        		<img src="${pageContext.request.contextPath }/resources/images/icons/plusIcon.png" alt="" />
        	</div>
        </div>

        <!-- 프로필 세부정보 영역 -->
        <div class="col-sm-7" id="profileStatus">
        	<div class="follow">팔로잉 :</div>
        	<div class="followCount">1234명</div>
        	<div class="follow">팔로워 :</div>
        	<div class="followCount">389명</div>
        	<!-- 설정버튼 : 본인계정일땐 설정, 아닐땐 친구추가 버튼 -->
        	<c:if test="${loginMember.id.equals(member.id) }">
        	<button type="button" class="btn btn-outline-dark icon" id="settingBtn" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/personal'">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/setting.png" alt="" />
        	</button>
        	</c:if>
        	<c:if test="${!loginMember.id.equals(member.id) }">
        	<button type="button" class="btn btn-outline-dark icon" id="addFriendBtn" onclick="">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/man.png" alt="" />
        	</button>
        	</c:if>

            <br />
            
            <div class="profileTableArea">
				<table id="profileTable">
					<tbody>
						<tr>
							<td class="tableKey">아이디</td>
							<td class="tableValue">${member.id}</td>
						</tr>
						<tr>
							<td><span class="tableKey">성격</span></td>
							<c:if test="${empty member.personality}">
							<td><button type="button" onclick="goSetting();">설정해주세요.</button></td>
							</c:if>
							<td>${member.personality}</td>
						</tr>
						<tr>
							<td><span class="tableKey">관심</span></td>
							<c:if test="${empty member.interest}">
							<td><button type="button" onclick="goSetting();">설정해주세요.</button></td>
							</c:if>
							<td>${member.interest}</td>
						</tr>
						<tr>
							<td><span class="tableKey">지역</span></td>
							<td>${member.addressAll}</td>
						</tr>
						<tr>
							<td rowspan=2><span class="tableKey">소개</span></td>
							<td class="tableValue" rowspan=2>
								 ${member.introduce} 
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td><span class="tableKey">평점</span></td>
							<td><span class="tableValue">4.9</span></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 글쓰기버튼 -->
        	<button style="float:right;"><i style="font-size: 30px;" class="fas fa-pencil-alt"></i></button>
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

</script>
        
        
        

<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>