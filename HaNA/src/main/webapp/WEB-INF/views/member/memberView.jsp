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

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
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
  
 
<div class="container mt-2">
    <div class="row" id="myInfo">
    	<!-- 프로필이미지 영역 -->
        <div class="col-sm-5 d-flex justify-content-center align-items-center flex-column" id="profileImg">
        	<div class="profileImg d-flex">
        		<!-- 이미지를 넣으세요 -->
        		<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${member.picture}" alt=""/>
        	</div>
        	<div class="profileBtn">
        		<!-- (+)버튼을 이미지로 넣고, 클릭 시 변경 이벤트 걸기 -->
        		<img src="${pageContext.request.contextPath }/resources/images/icons/plusIcon.png" alt="" />
        	</div>
        </div>
        <!-- 프로필 세부정보 영역 -->
        <div class="col-sm-7" id="profileStatus">
		<br><br><br>
        	<span class="followTitle">팔로잉 : </span>
        	 <button  type="button" class="btn btn-secondary" id="btn-following-list">${followerCount}명</button>
        	&nbsp;&nbsp;&nbsp;&nbsp; 
        	<span class="followTitle">팔로워 : </span>
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
    <div class="modal fade" id="boardFormModal" tabindex="-1"  >
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">게시글 작성</h4>
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
		enctype="multipart/form-data">
		<input type="text" class="form-control" name="writer" value="${loginMember.id}" readonly required>
		<input type="hidden" name="id" value="${loginMember.id}" />
		<br>
		 <!-- <div class="input-group mb-3" style="padding:0px;">
		 <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일1</span>
		  </div> -->
		   
		   
		    <input type="file" style="display: block;"  name="uploadFile" id="input-multiple-image" class="multi" maxlength="2" 
		    	 required> 
		  	<br>
		  	<div id="multiple-container">
			</div>
		  	<br><br>
		</div>
	    <textarea class="form-control" name="content" placeholder="내용을 입력하세요." rows="17" cols="15" required></textarea>
		<br>
				<input type="submit" class="btn btn-secondary save" value="등록하기" >
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	</form:form>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
			<!-- <button type="button" class="btn btn-primary">Save changes</button> -->	
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

            <br /><br/>
            
            <div class="profileTableArea">
				<table id="profileTable">
					<tbody>
						<tr>
							<td><span class="tableKey">아이디</span></td>
							<td class="tableValue">${member.id}</td>
						</tr>
					<!-- <tr>
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
						 -->	
						<tr>
							<td><span class="tableKey">지역</span></td>
							<td class="tableValue">${member.addressAll}</td>
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
					</tbody>
				</table>
			</div>
    <c:if test="${loginMember.id.equals(member.id) }">
        	<button id="btn-add" style="float:right; margin-top:80px"><i style="font-size: 30px;" class="fas fa-pencil-alt"></i></button>
	</c:if>
		</div>
   </div>
</div> 
<br>
<div class="container mt-2">       
    <div class="row">   
    </div>
<!-- 게시물목록 -->        
    <div class="row">    
        <c:forEach items="${boardList}" var="board" varStatus="vs">
	        <div class="thumbnail col-sm-4" >     
	       	 	<input type="hidden" value="${board.no}" id="boardNo" name="no"/>
	        	<img class="board-main-image" style="width:100%; height:100%; margin-bottom: 10%"
						src="${pageContext.request.contextPath}/resources/upload/member/board/${board.picture[0]}"
						alt=""  />
			 
	        </div>
        </c:forEach>
    </div>
</div>
<!-- 게시물 상세보기 Modal-->
	<div class="modal fade" id="groupPageDetail" tabindex="-1">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
				<table>
					<tr>
						<td rowspan="2" id="member-profile"><img src="" style="height:50px;width:50px; border-radius:50%"/></td>
						<th id="member-id"></th>
					</tr>
					<tr>
						<td><span id="reg-date"></span><a href="#" id="tag-place" style="color:black; text-decoration:none;"></a></td>
					</tr>
				</table>
				<div style="position:relative;margin-right:-665px; margin-bottom:5%;">
				<img src="https://img.icons8.com/plasticine/100/000000/like--v2.png" class="heart unlike" onclick="like();" style="position:absolute; width:50px;"/>
				<img src="https://img.icons8.com/plasticine/100/000000/like--v1.png" class="heart like" onclick="unlike();" style="position:absolute; width:50px;"/>
				</div>
				<div style="color:gray; margin-right:1%;">
					<span class="like_count"></span>
				</div>
				</div>
				<div class="modal-body">
					<div class="container">
					    <div class="row">
					        <div class="col-sm-7" id="group-board-img-container" style="background-color:black; display: flex; align-items: center; position:relative;">
 					        </div>
					        <div class="col-sm-5" style="">
					        	<div class="container">
								    <div class="row">
								        <div class="col-sm-12" id="group-board-tag-member-list" style="border-bottom:solid #80808040 1px; height:100px; overflow:auto; padding:0px 20px 20px 20px;">
								        	<p style="color:gray;">with</p>
								        	<table id="tagMemberListTable">
								        	
								        	</table>
								        </div>
								        <div class="col-sm-12" id="group-board-content" style="border-bottom:solid #80808040 1px; height:300px; overflow:auto; padding:20px;"></div>
								        <div class="col-sm-12" id="group-board-comment-list" style="border-bottom:solid #80808040 1px; height:500px; overflow-x:hidden; overflow-y:auto; padding:20px;">
										<table style="width:100%;">
										
										</table>
										</div>
								        <div class="col-sm-12" id="group-board-comment-submit"style="height:150px; padding:20px;">
								        	<form:form action="" name="boardCommentSubmitFrm">
								        		<input type="hidden" name="writer" value="<sec:authentication property='principal.username'/>">
								        		<input type="hidden" name="boardNo" id="boardNo" value=""/> 
								        		<input type="hidden" name="commentLevel" value="1"/>
								        		<input type="hidden" name="commentRef" value="0"/>
									        	<textarea name="content" id="" cols="30" rows="10" placeholder="댓글입력..." ></textarea>									        	   
									        	<div><input type="submit" data-no="${board.no}" value="게시"/></div>	
				 						        	
								        	</form:form>
								        </div>
								    </div>
								</div>
					        </div>
					    </div>
					</div>
				</div>
				<div class="modal-footer">
					<div style="margin:10px 0px;">
						<form:form name="boardDeleteFrm" action="${pageContext.request.contextPath}/member/deleteBoard" method="POST">
 							<input type="hidden" name="id" value="${member.id}"/>
						<c:forEach items="${boardList}" var="board" varStatus="vs">
							<input type="hidden" name="no" value="${board.no}" />
						</c:forEach>
						</form:form>
						<button type="submit" class="btn-deleteBoard" onclick="deleteBoardFunc();">게시물 삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
let boardDetail;
//게시물 목록
$('.board-main-image').click((e)=>{
	let boardNo = $(e.target).siblings("#boardNo").val();
	console.log("boardNo1",boardNo);
	goBoardDetail(boardNo);
	
	$('#groupPageDetail').modal("show");
});
//게시물 상세보기
function goBoardDetail(boardNo){
	console.log("boardNo2",boardNo);
	 $.ajax({
			url : "${pageContext.request.contextPath}/member/memberBoardDetail/"+boardNo,
			success(resp){
				console.log("확인", resp);
				const data = resp;
				boardDetail = data;
				console.log("확인", boardDetail);
			
				 
				
	 			const date = moment(boardDetail.regDate).format("YYYY년 MM월 DD일");
				let src = `<%=request.getContextPath()%>/resources/upload/member/profile/\${boardDetail.writerProfile}`;
		 		$("#member-profile").children("img").attr("src",src); // 글쓴이 프로필 이미지
	 	 		$("#member-id").html(`<a href="javascript:void(0);" onclick="goMemberView('\${boardDetail.writer}');" style="color:black; text-decoration:none;">&nbsp;&nbsp;\${boardDetail.boardDetail.writer}</a>`); // 글쓴이 아이디
		 		$("#reg-date").html(`&nbsp;&nbsp;\${date}`) // 날짜 
		 		
		 		// 이미지
		 		$("#group-board-img-container").empty();
	 			$.each(boardDetail.boardDetail.picture, (i,e)=>{
	 				console.log("e", e);
	 				let img = `<img src='<%=request.getContextPath()%>/resources/upload/member/board/\${e}' alt="" class="group-board-img"/>`
	 				$("#group-board-img-container").append(img); // 이미지 추가
	 				
	 			})
	 			$(".group-board-img").css("width","100%");
	 			$(".group-board-img").css("position","absolute");
	  			$(".group-board-img").css("left","0");
		 		
	 			//내용
	 			let content = `\${boardDetail.boardDetail.content}</br>`
	  			$("#group-board-content").html(content);
	 			
	 			//댓글 리스트
	 			//getCommentList(boardNo);
	 			
	 			//댓글 입력창
	 			$("#group-board-comment-submit #boardNo").val(board.no);
	 			
			},
			error(xhr, statusText, err){
				switch(xhr.status){
				default: console.log(xhr, statusText, err);
				}
				console.log
			}
		})
}
//게시물 삭제 함수
function deleteBoardFunc(){
	if(confirm("게시물을 삭제하시겠습니까?")){
		$(document.boardDeleteFrm).submit();
	}
}
//댓글 입력
$(document.boardCommentSubmitFrm).submit((e)=>{
	e.preventDefault();
	submitCommentFunc(e);
	console.log("eee!!!",e)
})
//댓글 제출 함수
function submitCommentFunc(e){
	console.log("eeee???", e.target);
	console.log("boardDetail", boardDetail);
 	let boardNo = boardDetail.boardDetail.no;
 	console.log("boardNo = ",boardDetail.boardDetail.no);
 	 
	let o = {
		boardNo:boardNo,
		writer:$("[name=writer]",e.target).val(),
		commentLevel:$("[name=commentLevel]",e.target).val(),			
		commentRef:$("[name=commentRef]",e.target).val(),			
		content:$("[name=content]",e.target).val(),	
	}
	console.log(o);
	const jsonStr = JSON.stringify(o);
	console.log("가져온 값",jsonStr);
	$.ajax({
		url:"<%=request.getContextPath()%>/member/enrollBoardComment",
		method:"POST",
		dataType:"json",
		data:jsonStr,
		contentType:"application/json; charset=utf-8",
		success(data){
			console.log(data);
			$("[name=content]",e.target).val("");
			//getCommentList(boardNo);
		},
		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			console.log
		}
	})
};  
//계정페이지로 이동
function goMemberView(memberId){
	location.href=`${pageContext.request.contextPath}/member/memberView/\${memberId}`;
}
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
			console.log("결과 :"+ resp);
			

			$("#modalTbody").empty();
			
			const {memberId} = resp;
			$.each(resp, (i, e) => {
				console.log(e.followers[0].memberId);
				console.log(e.picture);
				let tr= `
				<tr>
					<td>
						<img style="width:50px; height:50px; border-radius:50%" src="${pageContext.request.contextPath}/resources/upload/member/profile/\${e.picture}" alt=""/>
						<a id = "a" href="${pageContext.request.contextPath}/member/memberView/\${e.followers[0].memberId}">\${e.followers[0].memberId}</a>
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
						<img style="width:50px; height:50px; border-radius:50%" src="${pageContext.request.contextPath}/resources/upload/member/profile/\${e.picture}" alt=""/>
						<a id = "a" href="${pageContext.request.contextPath}/member/memberView/\${e.followingId}">\${e.followingId}</a>
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


//글 작성시 이미지 바로 나오게
function readMultipleImage(input) {
    const multipleContainer = document.getElementById("multiple-container")
    
    // 인풋 태그에 파일들이 있는 경우
    if(input.files) {
        console.log(input.files)
        // 유사배열을 배열로 변환 -forEach문으로 처리
        const fileArr = Array.from(input.files)
        const $colDiv1 = document.createElement("div")
        const $colDiv2 = document.createElement("div")
        $colDiv1.classList.add("column")
        $colDiv2.classList.add("column")
        fileArr.forEach((file, index) => {
            const reader = new FileReader()
            const $imgDiv = document.createElement("div")   
            const $img = document.createElement("img")
            $img.classList.add("image")
            $imgDiv.appendChild($img)
          
            reader.onload = e => {
                $img.src = e.target.result
            }
            
            console.log(file.name)
            if(index % 2 == 0) {
                $colDiv1.appendChild($imgDiv)
            } else {
                $colDiv2.appendChild($imgDiv)
            }
            
            reader.readAsDataURL(file)
        })
        multipleContainer.appendChild($colDiv1)
        multipleContainer.appendChild($colDiv2)
    }
}
const inputMultipleImage = document.getElementById("input-multiple-image")
inputMultipleImage.addEventListener("change", e => {
    readMultipleImage(e.target)
    $imgDiv.style.width = ($img.naturalWidth)  * 0.3 + "px"
    $imgDiv.style.height = ($img.naturalHeight) * 0.3 + "px"
 
})
 
 
</script>
        
<style>
	#multiple-container {
	    display: grid;
	    grid-template-columns: 1fr 1fr  ;
	}
	.image {
	    display: block;
	    width: 100%;
	}
	.image-label {
	    position: relative;
	    bottom: 22px;
	    left: 5px;
	    color: white;
	    text-shadow: 2px 2px 2px black;
	}
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
	
	#a {
    color: black;
    text-decoration: none;
}
.btn-secondary.save {
    color: #fff;
    background-color: black;
    border-color: #6c757d;
    width: 90px;
    font-size: 15px;
    margin-left : 450px;
}
.btn-secondary {
    color: #fff;
    background-color: black;
    border-color: #6c757d;
    width: 90px;
    font-size: 15px;
    margin-left : 20px;
}
.tableKey {
    width: 17%;
    font-size: 16px;
    padding-bottom: 1px;
    font-weight: 700;
    margin-left: 10px;
}
.tableValue {
    width: 80%;
    font-size: 20px;
    padding-bottom: 6px;
}
.followTitle {
    font-size: 15px;
}
#settingBtn img {
    width: 130%;
   	margin-top: -120px;
}
.thumbnail {
    height: 300px;
    border: 1px solid white;
    padding: 5px;
}
</style>
        
        

<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>