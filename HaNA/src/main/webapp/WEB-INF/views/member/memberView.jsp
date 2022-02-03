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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberView.css" />

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
	<div class="modal fade" id="pageDetail" tabindex="-1">
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
					        <div class="col-sm-7" id="board-img-container" style="background-color:black; display: flex; align-items: center; position:relative;">
 					        </div>
					        <div class="col-sm-5" style="">
					        	<div class="container">
								    <div class="row">
								        <div class="col-sm-12" id="board-tag-member-list" style="border-bottom:solid #80808040 1px; height:60px; overflow:auto; padding:0px 20px 20px 20px;">
								        	<p style="color:gray;"></p>
								        	<table id="tagMemberListTable">
								        	
								        	</table>
								        </div>
								        <div class="col-sm-12" id="board-content" style="border-bottom:solid #80808040 1px; height:300px; overflow:auto; padding:20px;"></div>
								        <div class="col-sm-12" id="board-comment-list" style="border-bottom:solid #80808040 1px; height:500px; overflow-x:hidden; overflow-y:auto; padding:20px;">
										<table style="width:100%;">
										
										</table>
										</div>
								        <div class="col-sm-12" id="board-comment-submit"style="height:150px; padding:20px;">
								        	<form:form action="" name="boardCommentSubmitFrm">
								        		<input type="hidden" name="writer" value="<sec:authentication property='principal.username'/>">
								        		<input type="hidden" name="boardNo" id="boardNo" value=""/> 
								        		<input type="hidden" name="commentLevel" value="1"/>
								        		<input type="hidden" name="commentRef" value="0"/>
									        	<textarea name="content" id="textareaComment" cols="30" rows="10" placeholder="댓글입력..." ></textarea>									        	   
									        	<div><input type="submit" value="게시"/></div>	
				 						        	
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
						<form:form name="boardDeleteFrm" action="${pageContext.request.contextPath}/member/deleteBoard?${_csrf.parameterName}=${_csrf.token}" method="POST">
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
let newContent;
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
//친구추가하기
function addFollowing(){
	if(confirm("친구추가를 하시겠습니까?")){
		$(document.addFollowingFrm).submit();
	}
}
//게시물 목록
$('.board-main-image').click((e)=>{
	let boardNo = $(e.target).siblings("#boardNo").val();
	console.log("boardNo1",boardNo);
	getPageDetail(boardNo);
	
	$('#pageDetail').modal("show");
});
//게시물 상세보기
function getPageDetail(boardNo){
	console.log("boardNo2",boardNo);
	 $.ajax({
			url : "${pageContext.request.contextPath}/member/memberBoardDetail/"+boardNo,
			success(resp){
				console.log("확인", resp);
				const data = resp;
				boardDetail = data;
				console.log("확인", boardDetail);
			 
	 			const date = moment(boardDetail.boardDetail.regDate).format("YYYY년 MM월 DD일");
				let src = `<%=request.getContextPath()%>/resources/upload/member/profile/\${boardDetail.boardDetail.writerProfile}`;
		 		$("#member-profile").children("img").attr("src",src); // 글쓴이 프로필 이미지
	 	 		$("#member-id").html(`<a href="javascript:void(0);" onclick="goMemberView('\${boardDetail.writer}');" style="color:black; text-decoration:none;">&nbsp;&nbsp;\${boardDetail.boardDetail.writer}</a>`); // 글쓴이 아이디
		 		$("#reg-date").html(`&nbsp;&nbsp;\${date}`) // 날짜 
		 		
		 		// 좋아요 버튼
		 		if(isLiked){
		 			$(".unlike").css("display","none");
		 			$(".like").css("display","inline");
		 		}else{
		 			$(".like").css("display","none");			 			
		 			$(".unlike").css("display","inline");			 			
		 		}
	 	 		
		 		//좋아요 개수
		 		getLikeCount();
		 		
		 		// modal footer부분 - 게시물 삭제 버튼
	 	 		if("<sec:authentication property='principal.username'/>" != groupBoard.writer && "<sec:authentication property='principal.username'/>" != "${member.id}"){
		 			$(".btn-deleteBoard").css("display","none");
		 		}else{
		 			$(".btn-deleteBoard").css("display","block");
		 			$(document.groupBoardDeleteFrm)
		 				.children("[name=no]").val(boardNo);
		 		}
				
		 		
		 		// 이미지
		 		$("#board-img-container").empty();
	 			$.each(boardDetail.boardDetail.picture, (i,e)=>{
	 				console.log("e", e);
	 				let img = `<img src='<%=request.getContextPath()%>/resources/upload/member/board/\${e}' alt="" class="board-img"/>`
	 				$("#board-img-container").append(img); // 이미지 추가
	 				
	 			})
	 			$(".board-img").css("width","100%");
	 			$(".board-img").css("position","absolute");
	  			$(".board-img").css("left","0");
		 		
	 			//내용
	 			let content = `\${boardDetail.boardDetail.content}</br>`
	  			$("#board-content").html(content);
	 			
	 			//content
	 			getContent();
	 			
	 			//댓글 리스트
	 			getCommentList(board.no);
	 			
	 			
	 			//댓글 입력창
	 			$("#board-comment-submit #boardNo").val(board.no);
	 			
			},
			error(xhr, statusText, err){
				switch(xhr.status){
				default: console.log(xhr, statusText, err);
				}
				console.log
			}
		})
}
function modifiedBoardSubmitFunc(){
	if(confirm("수정하시겠습니까?")){
		$(document.modifyContentFrm).submit();
	}
}
//게시물 삭제 함수
function deleteBoardFunc(){
	if(confirm("게시물을 삭제하시겠습니까?")){
		$(document.boardDeleteFrm).submit();
	}
};
//게시물 불러오기 함수
function getContent(){
	let boardContent = `\${boardDetail.boardDetail.content}</br>`
	if(boardDetail.writer == "<sec:authentication property='principal.username'/>" || "<sec:authentication property='principal.username'/>" == "${member.id}"){
		boardContent += `<button class='btn-boardModify' onclick="boardContentModifyFunc();">수정</button></br>`
	}
	$("#board-content").html(boardContent);
}
//게시물 수정 폼 나오기
function boardContentModifyFunc(){
	$("#board-content").empty();
	let form = `
		<div style="height:90%;">
			<input type="hidden" name="no" value="\${boardDetail.boardDetail.no}"/>
			<textarea style="height:100%;" name="content">\${boardDetail.boardDetail.content}</textarea>
		</div>
		<button class="btn-submitContent" onclick="submitModifiedContent(this);">등록</button>
	`;
	$("#board-content").append(form);
	
	// textarea의 변경값 실시간 감지
	$("textarea[name=content]").on("propertychange change keyup paste input", function() {
	   // 현재 변경된 데이터 셋팅
	   newContent = $(this).val();
	});
	
}
//게시물 수정 제출 함수
function submitModifiedContent(e){
	const no = $(e).siblings("div").children("[name=no]").val();
	console.log("newContent",newContent);
	$.ajax({
		url:`${pageContext.request.contextPath}/member/boardModifying?${_csrf.parameterName}=${_csrf.token}`,
		method:"POST",
		data:{
			"no":no,
			"content":newContent
		},
		success(data){
			console.log(data);
			getPageDetail(boardDetail.boardDetail.no);
		},
		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			
		}
	}) 
}
$(document.modifyContentFrm).submit((e)=>{
	e.preventDefault();
});
function modifiedBoardSubmitFunc(){
	if(confirm("수정하시겠습니까?")){
		$(document.modifyContentFrm).submit();
	}
}
//계정페이지로 이동
function goMemberView(memberId){
	location.href=`${pageContext.request.contextPath}/member/memberView/\${memberId}`;
}
//설정페이지로 이동
function goSetting(){
	location.href = "${pageContext.request.contextPath}/member/memberSetting/memberSetting";
}
//좋아요 개수
function getLikeCount(){
	$.ajax({
		url:`${pageContext.request.contextPath}/member/getLikeCount/\${boardDetail.boardDetail.no}`,
		success(data){
			$(".like_count").html(data.likeCount);
		},
		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			console.log
		}
	})
}
//좋아요 취소
function unlike(){
	$.ajax({
		url:`${pageContext.request.contextPath}/member/unlike/\${boardDetail.boardDetail.no}`,
		method:"DELETE",
		success(data){
			console.log(data);
			$(".like").css("display","none");			 			
 			$(".unlike").css("display","inline");
 			getLikeCount();
		},
		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			console.log
		}
	})
}
//좋아요
function like(){
	$.ajax({
		url:`${pageContext.request.contextPath}/member/like`,
		method:"POST",
		data:{
			"no":boardDetail.boardDetail.no
		},
		success(data){
			console.log(data);
			$(".like").css("display","inline");			 			
 			$(".unlike").css("display","none");
 			getLikeCount();
		},
		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			console.log
		}
	})
}

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
//답글 버튼 눌렀을 때 답글창 나오기
function showReplyForm(e){
	// 답글 달고자 하는 댓글의 번호
	const commentRef = $(e).val(); // 댓글번호 가져오기
	console.log($(e).siblings("#reply-board-no"));
	const boardNo = $(e).siblings("#reply-board-no").val();
	console.log(commentRef);
	console.log(boardNo);
	
	const tr = `<tr>
				<td></td>
				<td colspan="3" style="text-align:left padding-left:50px;">
					<form>
				    <input type="hidden" name="boardNo" value="\${boardNo}" />
				    <input type="hidden" name="writer" value="<sec:authentication property='principal.username'/>" />
				    <input type="hidden" name="commentLevel" value="2" />
				    <input type="hidden" name="commentRef" value="\${commentRef}" />    
					<textarea style="height:45px;" placeholder="답글입력..." name="content" cols="60" rows="2"></textarea>
				    <button type="submit" class="btn-comment-enroll2 btn-reply">등록</button>
				</form>
				</td>
			</tr>`;
	
	// e.target인 버튼태그의 부모tr을 찾고, 다음 형제요소로 추가
	const $baseTr = $(e).parent().parent(); // 답글 다려는 댓글의 tr
	const $tr = $(tr); //HTML담긴 제이쿼리 변수
	$(e).removeAttr("onclick");
	$tr.insertAfter($baseTr)
		.find("form")
		.submit((e) => { // submit시 실행될 콜백함수를 지정해줄 수도 있음
			e.preventDefault();	
			submitCommentFunc(e);
	});
}
//댓글 입력
$(document.boardCommentSubmitFrm).submit((e)=>{
	e.preventDefault();
	submitCommentFunc(e);
	console.log("eee!!!",e)
})
//댓글 리스트 불러오기
function getCommentList(boardNo){
	console.log("보드넘버 확인!!!!!!!!!!!!!!!!!!!!!!",boardNo)
  	$.ajax({
  		url:`${pageContext.request.contextPath}/member/getCommentList/\${boardNo}`,
  		success(data){
  			$("#board-comment-list>table").empty();
  			$.each(data,(i,e)=>{
  				
 				const date = moment(e.regDate).format("YYYY년 MM월 DD일");
 				
	  			let tr = `
	  				<tr class="level\${e.commentLevel}">
	  				<td style="width:50px;">
	  					<img style="height:40px; border-radius:50%;" src="/hana/resources/upload/member/profile/${member.picture}" alt="" />
	  				</td>
					<td >
						<sub class="comment-writer"><a href="javascript:void(0);" onclick="goMemberView('\${e.writer}');" style="color:black; text-decoration:none; font-weight:bold;">\${e.writer}</a></sub>
						<sub class="comment-date">\${date}</sub>
						<br />
						<!-- 댓글내용 -->
						&nbsp;&nbsp;&nbsp;\${e.content}
					</td>`;
				if(e.commentLevel == 1){
					if(e.writer == "<sec:authentication property='principal.username'/>" || "<sec:authentication property='principal.username'/>" == "${member.id}"){ //댓글 레벨 1 && 내가 작성자일 때 (삭제, 답글 버튼 모두)
						tr+=`<td>
								<span href='' class='btn-boardCommentDelete' onclick='deleteCommentFunc(\${e.no},\${e.boardNo})'>삭제</span>
							</td>
							<td>
								<button class="btn-reply" onclick="showReplyForm(this);" value="\${e.no}">답글</button>
								<input type="hidden" id="reply-board-no" value="\${boardNo}"/>
							</td>`;	
					}
					else{ // 댓글레벨 1 && 내가 작성자가 아닐 때 (답글 버튼만)
						tr+=`<td></td>
						<td>
							<button class="btn-reply" onclick="showReplyForm(this);" value="\${e.no}">답글</button>
							<input type="hidden" id="reply-board-no" value="\${boardNo}"/>
						</td>`;	
					}
				}	
				else{ // 댓글레벨 2 && 내가 작성자 혹은 그룹 리더일 때 (삭제버튼만)
					if(e.writer == "<sec:authentication property='principal.username'/>" || "<sec:authentication property='principal.username'/>" == "${member.id}"){
						tr+=`<td></td><td style='padding-left:5px;'><span class='btn-boardCommentDelete' onclick='deleteCommentFunc(\${e.no},\${e.boardNo})'>삭제</span></td>`;	
					}
					else{ // 댓글레벨 2 && 내가 작성자가 아닐 때 (아무버튼도 없음)
						tr+="<td></td><td></td>";	
					}
				}
	  			tr += "</tr>"
	  			$("#board-comment-list>table").append(tr);
  			})
  		},
  		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			
		}
  	})
};
//댓글 제출 함수
function submitCommentFunc(e){
	console.log("eeee???", e.target);
	console.log("boardDetail", boardDetail);
 	let boardNo = boardDetail.boardDetail.no;
 	console.log("boardNo = ",boardDetail.boardDetail.no);
 	 
	let o = {
		boardNo:boardNo,
		commentLevel:$("[name=commentLevel]",e.target).val(),			
		writer:$("[name=writer]",e.target).val(),
		content:$("[name=content]",e.target).val(),	
		commentRef:$("[name=commentRef]",e.target).val(),			
	}
	console.log(o);
	const jsonStr = JSON.stringify(o);
	console.log("가져온 값",jsonStr);
	$.ajax({
		url:"${pageContext.request.contextPath}/member/enrollBoardComment?${_csrf.parameterName}=${_csrf.token}",
		method:"POST",
		dataType:"json",
		data:jsonStr,
		contentType:"application/json; charset=utf-8",
		success(data){
			console.log("넘어온 값!!",data);
			$("[name=content]",e.target).val("");
			getCommentList(boardNo);
		},
		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			console.log
		}
	})
}; 
//댓글 삭제 함수
function deleteCommentFunc(no,boardNo){
	console.log("댓글삭제 no!!!",no);
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			url:`${pageContext.request.contextPath}/member/boardCommentDelete/\${no}?${_csrf.parameterName}=${_csrf.token}`,
			method:"DELETE",
			success(data){
				console.log(data);
				getCommentList(boardNo);
			},
			error(xhr, statusText, err){
				switch(xhr.status){
				default: console.log(xhr, statusText, err);
				}
				console.log
			}
		})
	}
}
</script>
        

        

<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>