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
	<jsp:param value="소그룹페이지" name="title" />
</jsp:include>

<script src="https://kit.fontawesome.com/0748f32490.js"
	crossorigin="anonymous">
	
</script>
<sec:authentication property="principal" var="loginMember" />
<script>
	// 리더만 수정할 수 있는 버튼 (만 있음)
	function goGroupSetting() {
		location.href = "${pageContext.request.contextPath}/group/groupSetting";
	}
</script>
<script src="https://kit.fontawesome.com/0748f32490.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <!-- 회원가입 확인 Modal-->
	<div class="modal fade" id="groupPageDetail" tabindex="-1">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
				<table>
					<tr>
						<td rowspan="2" id="member-profile"><img src="" style="height:50px; border-radius:50%"/></td>
						<th><a href="#" id="member-id" style="color:black; text-decoration:none;"></a></th>
					</tr>
					<tr>
						<td><span id="reg-date"></span><a href="#" id="tag-place" style="color:black; text-decoration:none;"></a></td>
					</tr>
				</table>
					<!-- <h5 class="modal-title" id="exampleModalLabel"></h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">X</span>
					</button> -->
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
								        	<table>
								        	
								        	</table>
								        </div>
								        <div class="col-sm-12" id="group-board-content" style="border-bottom:solid #80808040 1px; height:300px; overflow:auto; padding:20px;"></div>
								        <div class="col-sm-12" id="group-board-comment-list" style="border-bottom:solid #80808040 1px; height:500px; overflow:auto; padding:20px;">
										</div>
								        <div class="col-sm-12" id="group-board-comment-submit"style="height:150px; padding:20px;">
								        	<form action="" name="groupBoardCommentSubmitFrm">
								        		<input type="hidden" name="writer" value="<sec:authentication property='principal.username'/>">
								        		<input type="hidden" name="boardNo" id="boardNo" value=""/>
								        		<input type="hidden" name="commentLevel" value="1"/>
								        		<input type="hidden" name="commentRef" value="0"/>
									        	<textarea name="content" id="" cols="30" rows="10" placeholder="댓글입력..." ></textarea>
									        	<div><input type="submit" value="게시"/></div>								        	
								        	</form>
								        </div>
								    </div>
								</div>
					        </div>
					    </div>
					</div>
				</div>
				<div class="modal-footer">
					
				</div>
			</div>
		</div>
	</div>
	
	

<style>
#myInfo {
	border: 1px solid black;
}

#profileImg {
	height: 400px;
}

#profileStatus {
	height: 400px;
}
/* 세팅 버튼 */
#settingBtn {
	float: right;
	height: 50px;
	width: 50px;
	border-radius: 100%;
	border: none;
}

#settingBtn img {
	width: 130%;
}

/* 프로필이미지 */
.profileImg.d-flex {
	width: 230px;
	height: 230px;
	border-radius: 100%;
}

.profileImg img {
	width: 80%;
	height: 80%;
	border-radius: 100%;
	display: inline-block;
	position: relative;
	top: 10%;
	left: 60%;
}

.profileBtn {
	border: 1px solid black;
	width: 50px;
	height: 50px;
	border-radius: 100%;
	transform: translateX(200px) translateY(-80px);
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

.followCount {
	display: inline-block;
	width: 100px;
	height: 30px;
	border: 1px solid black;
}

#profileTable {
	width: 100%;
	table-layout: fixed;
	margin: 13%;
}

.tableKey {
	width: 20%;
}

.tableValue {
	width: 80%;
}

pre {
	margin: 0;
}

#textArea {
	width: 100%;
	height: 150px;
	border: none;
	resize: none;
	background-color: white;
	padding-top: 30px;
	font-size: 16px;
}
</style>

<div class="container mt-2">
	<div class="row" id="myInfo">
		<!-- 프로필이미지 영역 -->
		<div
			class="col-sm-5 d-flex justify-content-center align-items-center flex-column"
			id="profileImg">
			<div class="profileImg d-flex">
				<!-- 이미지를 넣으세요 -->
				<c:if test="${empty group.image}">
					<img
						src="${pageContext.request.contextPath}/resources/images/user.png"
						alt="" />
				</c:if>
				<c:if test="${not empty group.image}">
					<img
						src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}"
						alt="" />
				</c:if>
			</div>
			<div class="profileBtn">
				<!-- (+)버튼을 이미지로 넣고, 클릭 시 변경 이벤트 걸기 -->
				<img
					src="${pageContext.request.contextPath}/resources/images/icons/plusIcon.png"
					alt="" />
			</div>
		</div>

		<!-- 프로필 세부정보 영역 -->
		<div class="col-sm-7" id="profileStatus">
			<!-- 설정버튼 : 본인계정일땐 설정, 아닐땐 친구추가 버튼 -->
			<button type="button" class="btn btn-outline-dark" id="settingBtn"
				onclick="goGroupSetting();">
				<img
					src="${pageContext.request.contextPath }/resources/images/icons/setting.png"
					alt="" />
			</button>
			<button type="button" class="btn btn-outline-dark" id="settingBtn"
				onclick="">
				<img
					src="${pageContext.request.contextPath }/resources/images/icons/man.png"
					alt="" />
			</button>

			<br />

			<div class="profileTableArea">
				<table id="profileTable">
					<tbody>
						<tr>
							<th class="tableKey">그룹명</th>
							<td class="tableValue">${group.groupName}</td>
						</tr>
						<tr>
							<th><span class="tableKey">그룹 아이디</span></th>
							<td>${group.groupId}</td>
							<td rowspan="2">						<a
							href="${pageContext.request.contextPath}/group/enrollGroupForm?groupId=${group.groupId}"
							class="enroll-button">가입신청</a></td>
						</tr>
						<tr>
							<th><span class="tableKey">리더</span></th>
							<td>${group.leaderId}</td>
						</tr>
						<tr>
							<th><span class="tableKey">멤버수</span></th>
							<td>${group.memberCount}명</td>
						</tr>
					</tbody>
				</table>
				<div class="group-page-enroll-button">
					<br>
					<%-- <c:if test="${empty groupMember || empty loginMember}"> --%>
					<%-- <c:remove var="enrolled"/> --%>
					<c:if test="${!enrolled}">
						<a
							href="${pageContext.request.contextPath}/group/enrollGroupForm?groupId=${group.groupId}"
							class="enroll-button">가입신청</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="icon">
	<a href="#"><i class="fas fa-pencil-alt"></i></a>
	<a href="#"><i class="fas fa-calendar-alt"></i></a>
	<a href="#"><i class="far fa-comments"></i></a>
</div>

<div class="container">
	<c:forEach items="${groupBoardList}" var="board" varStatus="vs">
		${vs.index%3 == 0? "<div style='margin-bottom:30px;' class='row'>" : ""}
	        <div class="col-sm-4" >
	        	<input type="hidden" value="${board.no}" id="group-board-no"/>
				<img class="board-main-image" style="width:100%; height:100%; margin-bottom: 10%"
					src="${pageContext.request.contextPath}/resources/upload/group/board/${board.image[0]}"
					alt="" />
	        </div>
		${vs.index%3 == 2? "</div>" : ""}
	</c:forEach>
</div>

<c:if test="${loginMember.id eq group.leaderId}">
	<button id="myBtn" onclick="test();">승인</button>
</c:if>

<script>
$("#myBtn").on( "click", function() {
    $("#test_modal").modal();
});
</script>

<div class="modal fade" id="test_modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">가입 승인 리스트</h4>
			</div>
			<div class="modal-body">
				<table class="table" style="text-align: center;" name="modalTable">
					<thead class="table-light">
						<tr>
							<th>번호</th>
							<th>아이디</th>
							<th>가입신청내용</th>
							<th>날짜</th>
							<th>승인여부</th>
						</tr>
					</thead>
					<tbody id="modalTbody">
						<%-- <tr>
							<td>${no}</td>
							<td>member_id</td>
							<td>content</td>
							<td>regDate</td>
							<td><button type="button"
									class="btn btn-default btn-sm btn-success"
									style="margin-right: 1%;">승인</button>
								<button type="button" class="btn btn-default btn-sm btn-danger">거절</button></td>
						</tr> --%>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary">Save changes</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<style>
	.board-main-image:hover {
	 cursor:pointer;
	}
</style>

<script>
//ajax POST 요청 csrf
    var csrfToken = $("meta[name='_csrf']").attr("content");
    $.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	  });
// 모달창
$('.board-main-image').click((e)=>{
	let boardNo = $(e.target).siblings("#group-board-no").val();
	
	$.ajax({
/* 		url:`<c:out value='${pageContext.request.contextPath}'></c:out>/group/groupBoardDetail/\${boardNo}`
 */		url:`<%=request.getContextPath()%>/group/groupBoardDetail/\${boardNo}`,
		success(data){
	 
	 		const {groupBoard, tagMembers} = data;
 			console.log(groupBoard.content);
 			
 			// modal의 header부분
 			const date = moment(groupBoard.regDate).format("YYYY년 MM월 DD일");
			let src = `<%=request.getContextPath()%>/resources/upload/member/profile/\${groupBoard.writerProfile}`;
	 		$("#member-profile").children("img").attr("src",src); // 글쓴이 프로필 이미지
 	 		$("#member-id").html(`&nbsp;&nbsp;\${groupBoard.writer}`); // 글쓴이 아이디
	 		$("#reg-date").html(`&nbsp;&nbsp;\${date}`) // 날짜, 태그 장소
	 		$("#tag-place").html(`,&nbsp;&nbsp;\${groupBoard.placeName}`) // 날짜, 태그 장소
	 		
	 		// 이미지
	 		$("#group-board-img-container").empty();
 			$.each(groupBoard.image, (i,e)=>{
 				console.log(i);
 				console.log(e);
 				
 				let img = `<img src='<%=request.getContextPath()%>/resources/upload/group/board/\${e}' alt="" class="group-board-img"/>`
 				$("#group-board-img-container").append(img); // 이미지 추가
 				
 			})
 			$(".group-board-img").css("width","100%");
 			$(".group-board-img").css("position","absolute");
  			$(".group-board-img").css("left","0");
			
 			//modal의 body부분
 			//태그 멤버 목록
 			
  			$("#group-board-tag-member-list table").empty();
 			$.each(tagMembers, (i,e)=>{
 				let tr = `<tr style="padding-bottom:10px;">
 					<td><a href="#" ><img style="width:50px; height:50px; border-radius:50%" src="<%=request.getContextPath()%>/resources/upload/member/profile/\${e.picture}" alt="" /></a></td>
 					<th><a href="#" style="color:black; text-decoration:none;">&nbsp;&nbsp;&nbsp;&nbsp;\${e.id}</a></th>
 				</tr>`;	
  				$("#group-board-tag-member-list table").append(tr);
 			})
			
 			//content
 			console.log($("#group-board-content"));
 			$("#group-board-content").html(`\${groupBoard.content}`);
 			
 			//댓글 입력창
 			$("#group-board-comment-submit #boardNo").val(groupBoard.no);
 			
 		},
 		error:console.log
	})
	
	$('#groupPageDetail').modal("show");
});

function test() {
	$.ajax({
		url: "${pageContext.request.contextPath}/group/getGroupApplyRequest",
		data: {
			groupId : '${groupId}'
		},
		success(res){
			console.log(res);
			$.each(res, function(i, e) {
				console.log(e.NO);
				let tr = `
					<tr>
						<td>
							\${e.NO}
						</td>
						<td>
							\${e.MEMBER_ID}
						</td>
						<td>
							\${e.CONTENT}
						</td>
						<td>
							\${e.REGDATE}						
						</td>
						<td>
							<button type="button"
								class="btn btn-default btn-sm btn-success"
								style="margin-right: 1%;">승인</button>
							<button type="button" class="btn btn-default btn-sm btn-danger">거절</button>
						</td>
					</tr>
				`;
				
				$("#modalTbody").append(tr);
			})
		},
		error: console.log
	})
};



//댓글 입력
$(document.groupBoardCommentSubmitFrm).submit((e)=>{
	e.preventDefault();
	
	let o = {
		boardNo:$("[name=boardNo]",e.target).val(),
		writer:$("[name=writer]",e.target).val(),
		commentLevel:$("[name=commentLevel]",e.target).val(),			
		commentRef:$("[name=commentRef]",e.target).val(),			
		content:$("[name=content]",e.target).val(),	
	}
	console.log(o);
	const jsonStr = JSON.stringify(o);
	console.log(jsonStr);

	$.ajax({
		url:"<%=request.getContextPath()%>/group/enrollGroupBoardComment",
		method:"POST",
		dataType:"json",
		data:jsonStr,
		contentType:"application/json; charset=utf-8",
		success(data){
			console.log(data);
			$("[name=content]",e.target).val("");
		},
		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			console.log
		}
	})
})

</script>

<style>
table {
  border-collapse: separate;
  border-spacing: 0 5px;
}
textarea { height:100px;border:none;width:100%;resize:none; }
textarea:focus { outline:none; }
input[type="submit"] {
	font-weight:bold;
	color:#384fc5c4;
	background-color:white;
	border:none;
	float:right;
}
textarea::placeholder {
color:gray;
  font-size: 1.1em;
}
</style>

<a href="/" class="badge badge-dark">Dark</a>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>