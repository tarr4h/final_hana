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
 <script src="https://kit.fontawesome.com/0748f32490.js"
	crossorigin="anonymous">
</script>
<sec:authentication property="principal" var="loginMember"/>

<c:if test="${not empty msg}">
	<script>
	alert("${msg}");
	</script>
</c:if>

<script>
function goSetting(){
	location.href = "${pageContext.request.contextPath}/member/memberSetting/memberSetting";
}


function addFollowing(){
	if(confirm("친구추가를 하시겠습니까?")){
		$(document.addFollowingFrm).submit();
	}
}
 

	$.ajax({
		url : "${pageContext.request.contextPath}/member/memberView",
		data : {
			id : ${member.id}
		},
		success(resp){
			console.log(resp);
		},
		error : console.log

	});
 
 
 
 
 
 
 
 
 
 
 

</script>
			

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
	#settingBtn {
		float: right;
		height:50px;
		width: 50px;
		border-radius: 100%;
		border: none;
	}
	#settingBtn img {
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

<div class="container mt-2">
    <div class="row" id="myInfo">
    	<!-- 프로필이미지 영역 -->
        <div class="col-sm-5 d-flex justify-content-center align-items-center flex-column" id="profileImg">
        	<div class="profileImg d-flex">
        		<!-- 이미지를 넣으세요 -->
        		<img src="${pageContext.request.contextPath}/resources/images/duck.png" alt=""/>
        	</div>
        	<div class="profileBtn">
        		<!-- (+)버튼을 이미지로 넣고, 클릭 시 변경 이벤트 걸기 -->
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

        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="goSetting();">설정</button>
        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="addFollowing();">친구추가</button>
        	<form:form name="addFollowingFrm" action="${pageContext.request.contextPath}/member/addFollowing" method = "POST">
        		<input type="hidden" name ="id" value="qwerty" />
        	</form:form>

        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="goSetting();">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/setting.png" alt="" />
        	</button>
        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/man.png" alt="" />
        	</button>
        	

            <br />
            
            <div class="profileTableArea">
				<table id="profileTable">
					<tbody>
						<tr>
							<td class="tableKey">아이디</td>
							<td class="tableValue">${loginMember.id}</td>
						</tr>
						<tr>
							<td><span class="tableKey">성격</span></td>
							<c:if test="${empty loginMember.personality}">
							<td><button type="button" onclick="goSetting();">설정해주세요.</button></td>
							</c:if>
							<td>${loginMember.personality}</td>
						</tr>
						<tr>
							<td><span class="tableKey">관심</span></td>
							<c:if test="${empty loginMember.interest}">
							<td><button type="button" onclick="goSetting();">설정해주세요.</button></td>
							</c:if>
							<td>${loginMember.interest}</td>
						</tr>
						<tr>
							<td><span class="tableKey">지역</span></td>
							<td>${loginMember.addressFirst}</td>
						</tr>
				<!--  		<tr>
							<td><span class="tableKey">취미</span></td>
							<td>낚시</td>
						</tr>-->
						<tr>
							<td rowspan=2><span class="tableKey">소개</span></td>
							<td class="tableValue" rowspan=1>
								 ${loginMember.introduce} 
							<!-- <pre><textarea id="textArea" readonly disabled>  
								</textarea></pre> --> 	
							</td>
						</tr>
						<tr>
							
						</tr>
					</tbody>
				</table>
			</div>

        	<button style="float:right;"><i style="font-size: 30px;" class="fas fa-pencil-alt"></i></button>
	</div>
        </div>
	</div> 
       
    <div class="row">   
        <!-- 탭 영역 -->
        <div class="col-sm-12 d-flex justify-content-center align-items-center" id="tab">
        	<input type="button" class="m-3" value="버튼1" />
        	<input type="button" class="m-3" value="버튼2" />
        	<input type="button" class="m-3" value="버튼3" />
        </div>
    </div>
        
    <div class="row">    
        <!-- thumbnail 1st line -->
        <div class="thumbnail col-sm-4 ">
        	<img src="${pageContext.request.contextPath}/resources/images/duck.png" alt=""/>
        </div>
        <div class="thumbnail col-sm-4">
        	<img src="${pageContext.request.contextPath}/resources/images/duck.png" alt=""/>
        </div>
        <div class="thumbnail col-sm-4">
        </div>
        
        <!-- thumbnail 2nd line  -->
        <div class="thumbnail col-sm-4">
        </div>
        <div class="thumbnail col-sm-4">
        </div>
        <div class="thumbnail col-sm-4">
        </div>
        
        <!-- thumbnail 3rd line -->
        <div class="thumbnail col-sm-4">
        </div>
        <div class="thumbnail col-sm-4">
        </div>
        <div class="thumbnail col-sm-4">
        </div>
    </div>
</div>
        
 
        
        
        

<a href="/" class="badge badge-dark">Dark</a>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>