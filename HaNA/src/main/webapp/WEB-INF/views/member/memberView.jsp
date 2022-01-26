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
<section>
 <script src="https://kit.fontawesome.com/0748f32490.js"
	crossorigin="anonymous">
</script>
<sec:authentication property="principal" var="loginMember"/>

<c:if test="${not empty msg}">
	<script>
	alert("${msg}");
	</script>
</c:if>
 

			

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
		font-size: 16px;
		padding-bottom : 6px;
	}
	.tableValue{
		width: 80%;
		font-size: 18px;
		padding-bottom : 6px;
	}
	tbody, td, tfoot, th, thead, tr {
    border-color: inherit;
    border-style: solid;
    border-width: 0;
    font-size: 16px;
    padding-bottom : 6px;
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
        	<span>팔로잉 : </span>
        	 <button  type="button" class="btn btn-secondary" id="btn-following-list">${followerCount}명</button>
        	&nbsp;&nbsp;&nbsp;&nbsp; 
        	<span>팔로워 : </span>
        	 <button  type="button" class="btn btn-secondary" id="btn-follower-list">${followingCount}명</button> 
 			
 			
<script>
$("#btn-following-list").on( "click", function() {
    $("#test_modal").modal();
});

$("#btn-follower-list").on( "click", function() {
    $("#test_modal1").modal();
});
</script>

 <!-- 팔로잉리스트 모달창 -->
       <div class="modal fade" id="test_modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel"></h4>
			</div>
			<div class="modal-body">
				<table class="table" style="text-align: center;" name="modalTable">
					<thead class="table-light">
						<tr>
							<th>팔로잉</th>
						</tr>
					</thead>
					<tbody id="modalTbody">
						<%-- <tr>
							<td>프로필</td>
							<td>아이디</td>
							<td><button type="button"
									class="btn btn-default btn-sm btn-success"
									style="margin-right: 1%;">승인</button>
								<button type="button" class="btn btn-default btn-sm btn-danger">거절</button></td>
						</tr> --%>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
			<!-- <button type="button" class="btn btn-primary">Save changes</button> -->	
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- 팔로워리스트 모달창 -->
       <div class="modal fade" id="test_modal1" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel"></h4>
			</div>
			<div class="modal-body">
				<table class="table" style="text-align: center;" name="modalTable">
					<thead class="table-light">
						<tr>
							<th>팔로워</th>
						</tr>
					</thead>
					<tbody id="modalTbody1">
						<%-- <tr>
							<td>프로필</td>
							<td>아이디</td>
							<td><button type="button"
									class="btn btn-default btn-sm btn-success"
									style="margin-right: 1%;">승인</button>
								<button type="button" class="btn btn-default btn-sm btn-danger">거절</button></td>
						</tr> --%>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
			<!-- <button type="button" class="btn btn-primary">Save changes</button> -->	
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<!-- 글쓰기모달 -->
    <div class="modal fade" id="boardFormModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel"></h4>
			</div>
			<div class="modal-body">
				<table class="table" style="text-align: center;" name="modalTable">
					<thead class="table-light">
					</thead>
					<tbody id="modalTbody">
	<form:form
		name="boardFrm" 
		action="${pageContext.request.contextPath}/member/memberBoardEnroll?${_csrf.parameterName}=${_csrf.token}" 
		method="post"
		enctype="multipart/form-data"
		>
		<input type="text" class="form-control" name="writer" value="${loginMember.id}" readonly required>
		<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
		<div class="input-group mb-3" style="padding:0px;">
		  <!-- <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일1</span>
		  </div> -->
		   
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="uploadFile" id="upFile1" multiple>
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		</div>
	 <div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일2</span>
		  </div>
		 
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="file" id="upFile2" multiple>
		    <label class="custom-file-label" for="upFile2">파일을 선택하세요</label>-->
		  </div>
		</div>
	    <textarea class="form-control" name="content" placeholder="내용" required></textarea>
		<br />
		<input type="submit" class="btn btn-outline-success" value="저장" >
	</form:form>
						<%-- <tr>
							<td>프로필</td>
							<td>아이디</td>
							<td><button type="button"
									class="btn btn-default btn-sm btn-success"
									style="margin-right: 1%;">승인</button>
								<button type="button" class="btn btn-default btn-sm btn-danger">거절</button></td>
						</tr> --%>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
			<!-- <button type="button" class="btn btn-primary">Save changes</button> -->	
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>      
        </div>
</div>
        
        
        
        	<!-- 설정버튼 : 본인계정일땐 설정, 아닐땐 친구추가 버튼 -->
        
			<c:if test="${loginMember.id.equals(member.id) }">
        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="goSetting();">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/setting.png" alt="" />
        	</button>
        	</c:if>
        	<c:if test="${!loginMember.id.equals(member.id) }">
        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="addFollowing()">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/man.png" alt="" />
        	</button>
        	</c:if>
        	<form:form name="addFollowingFrm" action="${pageContext.request.contextPath}/member/addFollowing" method = "POST">
        		<input type="hidden" name ="friendId" value="${member.id}" />
        		<input type="hidden" name ="myId" value="${loginMember.id}" />
        	</form:form>

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
							<td><button type="button" class="btn btn-dark" onclick="goSetting();">설정하기</button></td>
						 
							</c:if>
							<td>${member.personality}</td>
						</tr>
						<tr>
							<td><span class="tableKey">관심</span></td>
							<c:if test="${empty member.interest}">
							<td><button type="button" class="btn btn-dark" onclick="goSetting();">설정하기</button></td>
							</c:if>
							<td>${member.interest}</td>
						</tr>
						<tr>
							<td><span class="tableKey">지역</span></td>
							<td>${member.addressFull}</td>
						</tr>
				<!--  		<tr>
							<td><span class="tableKey">취미</span></td>
							<td>낚시</td>
						</tr>-->
						<tr>
							<td rowspan=2><span class="tableKey">소개</span></td>
							<td class="tableValue" rowspan=1>
								 ${member.introduce} 
							<!-- <pre><textarea id="textArea" readonly disabled>  
								</textarea></pre> --> 	
							</td>
						</tr>
						<tr>
							
						</tr>
					</tbody>
				</table>
			</div>

        	<button style="float:right; margin-top:80px"><i style="font-size: 30px;" class="fas fa-pencil-alt"></i></button>
		</div>
   </div>
</div> 
    
    <c:if test="${loginMember.id.equals(member.id) }">
    <div class="row" style="height:50px">    
       	<input type="button" id="btn-add" 
       			style="float:right;" >
       	<i style="font-size: 30px;" class="fas fa-pencil-alt"></i>
	</div> 
	</c:if>
<div class="container mt-2">       
    <div class="row">   
 
        <!-- 탭 영역 -->
        <!-- <div class="col-sm-12 d-flex justify-content-center align-items-center" id="tab">
        	<input type="button" class="m-3" value="버튼1" />
        	<input type="button" class="m-3" value="버튼2" />
        	<input type="button" class="m-3" value="버튼3" />
        </div> -->
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
        
<script>
//설정페이지로 이동
function goSetting(){
	location.href = "${pageContext.request.contextPath}/member/memberSetting/memberSetting";
}

//친구추가하기
function addFollowing(){
	if(confirm("친구추가를 하시겠습니까?")){
		$(document.addFollowingFrm).submit();
	}
}

//글쓰기
/* $("#btn-add").click((e) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/member/boardForm",	
		success(resp){
			console.log(resp);
		},
		error : console.log
	});
});
  */

//팔로잉 리스트 가져오기
$("#btn-following-list").click((e) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/member/followingList",
		data : $("[name=friendId]"),
		success(resp){
			console.log(resp);
			

			$("#modalTbody").empty();
			
			const {memberId} = resp;
			$.each(resp, (i, e) => {
				console.log(e.followers[0].memberId);
				console.log(e.picture);
				let tr= `
				<tr>
				<td>
					\${e.followers[0].memberId}
					
					 <img src="${pageContext.request.contextPath}/resources/upload/member/profile/\${e.picture}" alt=""/>
					 
				</td>
			</tr>
			`;
			console.log(tr);
			$("#modalTbody").append(tr);
		})
	},
	error: console.log
	})
});
 
 

//팔로워 리스트 가져오기 
$("#btn-follower-list").click((e) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/member/followerList",
		data : $("[name=friendId]"),
		success(resp){
			console.log(resp);
			
			$("#modalTbody1").empty();
			
			const {followingId} = resp;
			$.each(resp, (i, e) => {
				console.log(e.followingId);
				let tr= `
				<tr>
				<td>
					\${e.followingId}
				</td>
			</tr>
			`;
			$("#modalTbody1").append(tr);
			
		})
	},
	error: console.log
	})
});
 
 

//글쓰기
$("#btn-add").click(()=> {
	console.log("ddd");
  $("#boardFormModal").modal();
});
</script>
        
        
        

<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>