<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kh.hana.member.model.vo.Member"%>
<%@page import="java.util.List"%>
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
 
<sec:authentication property="principal" var="loginMember"/>
<%
	List<Map<String,String>> memberList = (List<Map<String,String>>)request.getAttribute("groupMembers");
	List<String> memberIdList = new ArrayList<>();
	for(Map<String,String> m : memberList){
		memberIdList.add(m.get("memberId"));
	};
	pageContext.setAttribute("memberIdList",memberIdList);
%>
<!-- 프로필 -->
<div class="container mt-2">
	<div class="row" id="myInfo">
		<!-- 프로필이미지 영역 -->
		<div
			class="col-sm-6 d-flex justify-content-center align-items-center flex-column"
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
		<div class="col-sm-6" id="profileStatus">
		<div class="profileTableAreaContainer">
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
			    <div class="row">
			        <div class="col-sm-8">
			       		<table id="profileTable">
							<tbody>
								<tr>
									<th class="tableKey">그룹명</th>
									<td class="tableValue">${group.groupName}</td>
								</tr>
								<tr>
									<th><span class="tableKey">그룹 아이디</span></th>
									<td>${group.groupId}</td>
								</tr>
								<tr>
									<th><span class="tableKey">리더</span></th>
									<td>${group.leaderId}</td>
								</tr>
								<tr class="memberCountTr" onclick="$('#groupMemberList').modal('show');">
									<th><span class="tableKey" style="color:#673ab7c9;">멤버</span></th>
									<td>${group.memberCount}명</td>
								</tr>
							</tbody>
						</table>
			        </div>
			        <div class="col-sm-4 buttonArea">
			        	<c:if test="${!memberIdList.contains(loginMember.id)}">
							<div>
								<a
								href="${pageContext.request.contextPath}/group/enrollGroupForm?groupId=${group.groupId}"
								class="enroll-button">가입신청</a>
							</div>
						</c:if>
<% 
	Member loginMember = (Member)pageContext.getAttribute("loginMember");
	if(memberIdList.contains(loginMember.getId())){
		for(Map<String,String> m : memberList){
			if(m.get("memberId").equals(loginMember.getId())){
				if(m.get("memberLevelCode").equals("ld") || m.get("memberLevelCode").equals("mg")){	
%>
						<div style="margin-top:18%;">
							<div>
								<a href="#" class="enroll-button">회원관리</a>
							</div>
							<div style="margin-top:10px;">
								<a href="javascript:void(0);" onclick="enrollList();" class="enroll-button">가입승인</a>
							</div>
						</div>
<% }}}};%>
			        </div>
			    </div>
			</div>
		</div>	
		</div>
	</div>
</div>

<div class="icon">
	<a href="#"><i class="fas fa-pencil-alt"></i></a>
	<a href="${pageContext.request.contextPath}/group/groupCalendar"><i class="fas fa-calendar-alt"></i></a>
	<a href="#"><i class="far fa-comments"></i></a>
</div>

<!-- 게시물 목록 -->
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

<!-- 가입신청리스트 모달 -->
<div class="modal fade" id="applyListModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 60%; width: auto;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">가입 승인 리스트</h4>
			</div>
			<div class="modal-body">
				<div class="applyListTableContainer">
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
							<tr>
								<th colspan="5">가입신청이 없습니다.</th>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary">Save changes</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
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
								        	<form:form action="" name="groupBoardCommentSubmitFrm">
								        		<input type="hidden" name="writer" value="<sec:authentication property='principal.username'/>">
								        		<input type="hidden" name="boardNo" id="boardNo" value=""/>
								        		<input type="hidden" name="commentLevel" value="1"/>
								        		<input type="hidden" name="commentRef" value="0"/>
									        	<textarea name="content" id="" cols="30" rows="10" placeholder="댓글입력..." ></textarea>
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
						<form:form name="groupBoardDeleteFrm" action="${pageContext.request.contextPath}/group/deleteGroupBoard" method="POST">
 							<input type="hidden" name="groupId" value="${group.groupId}"/>
							<input type="hidden" name="no" value="" />
						</form:form>
						<button type="submit" class="btn-deleteBoard" onclick="deleteGroupBoardFunc();">게시물 삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 회원목록보기 modal -->
	<div class="modal fade" id="groupMemberList" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-body">
					<div id="groupMemberListTableContainer">
						<table id="groupMemberListTable">
							<c:forEach items="${groupMembers}" var="member">
								<tr>
				 					<td>
				 						<a href="javascript:void(0);" onclick="goMemberView('${member.memberId}');" >
				 						</a> 
				 						<img style="width:50px; height:50px; border-radius:50%" src="<%=request.getContextPath()%>/resources/upload/member/profile/${member.profile}" alt="" />
				 					</td>
				 					<th>
				 						<a href="javascript:void(0);" onclick="goMemberView('${member.memberId}');" style="color:black; text-decoration:none;">
				 							&nbsp;&nbsp;&nbsp;&nbsp;${member.memberId}
				 						</a>
				 					</th> 
				 				</tr>
							</c:forEach>
						</table>
					</div>
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
let gb; // 스크립트에서 사용할 게시물 정보 
let newContent;
//ajax POST 요청 csrf
    var csrfToken = $("meta[name='_csrf']").attr("content");
    $.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post" || options['type'].toLowerCase() === "delete" || options['type'].toLowerCase() === "put") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	  });
// 회원수 tr 클릭
    
// 게시물 목록 이미지 클릭
$('.board-main-image').click((e)=>{
	let boardNo = $(e.target).siblings("#group-board-no").val();
	console.log("alksjdflkajsdlf",boardNo);
	getPageDetail(boardNo);
	
	$('#groupPageDetail').modal("show");
});
// 게시물 상세보기 페이지 불러오기 함수
function getPageDetail(boardNo){
	console.log("aaa",boardNo);
	$.ajax({
				url:`<%=request.getContextPath()%>/group/groupBoardDetail/\${boardNo}`,
				success(data){
			 
			 		const {groupBoard, tagMembers, isLiked} = data;
			 		console.log(groupBoard);
			 		console.log(tagMembers);
			 		console.log(isLiked);
		 			gb = groupBoard;
		 			
		 			// modal의 header부분
		 			const date = moment(groupBoard.regDate).format("YYYY년 MM월 DD일");
					let src = `<%=request.getContextPath()%>/resources/upload/member/profile/\${groupBoard.writerProfile}`;
			 		$("#member-profile").children("img").attr("src",src); // 글쓴이 프로필 이미지
		 	 		$("#member-id").html(`<a href="javascript:void(0);" onclick="goMemberView('\${groupBoard.writer}');" style="color:black; text-decoration:none;">&nbsp;&nbsp;\${groupBoard.writer}</a>`); // 글쓴이 아이디
			 		$("#reg-date").html(`&nbsp;&nbsp;\${date}`) // 날짜, 태그 장소
			 		$("#tag-place").html(`,&nbsp;&nbsp;\${groupBoard.placeName}`) // 날짜, 태그 장소
			 		
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
		 	 		if("<sec:authentication property='principal.username'/>" != groupBoard.writer && "<sec:authentication property='principal.username'/>" != "${group.leaderId}"){
			 			$(".btn-deleteBoard").css("display","none");
			 		}else{
			 			$(".btn-deleteBoard").css("display","block");
			 			$(document.groupBoardDeleteFrm)
			 				.children("[name=no]").val(boardNo);
			 		}
					
		 	 		
			 		// 이미지
			 		$("#group-board-img-container").empty();
		 			$.each(groupBoard.image, (i,e)=>{
		 				
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
		 				let tr = `<tr>
		 					<td><a href="javascript:void(0);" onclick="goMemberView('\${e.id}');" ><img style="width:50px; height:50px; border-radius:50%" src="<%=request.getContextPath()%>/resources/upload/member/profile/\${e.picture}" alt="" /></a></td>
		 					<th><a href="javascript:void(0);" onclick="goMemberView('\${e.id}');" style="color:black; text-decoration:none;">&nbsp;&nbsp;&nbsp;&nbsp;\${e.id}</a></th>
		 				</tr>`;	
		  				$("#group-board-tag-member-list table").append(tr);
		 			})
					
		 			//content
		 			getContent();
		 			
		 			//댓글 리스트
		 			getCommentList(groupBoard.no);
		 			
		 			//댓글 입력창
		 			$("#group-board-comment-submit #boardNo").val(groupBoard.no);
		 			
		 		},
		 		error(xhr, statusText, err){
					switch(xhr.status){
					default: console.log(xhr, statusText, err);
					}
					console.log
				}
			})
}
//계정페이지로 이동
function goMemberView(memberId){
	location.href=`${pageContext.request.contextPath}/member/memberView/\${memberId}`;
}
//좋아요 개수
function getLikeCount(){
	$.ajax({
		url:`${pageContext.request.contextPath}/group/getLikeCount/\${gb.no}`,
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
		url:`${pageContext.request.contextPath}/group/unlike/\${gb.no}`,
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
// 좋아요
function like(){
	$.ajax({
		url:`${pageContext.request.contextPath}/group/like`,
		method:"POST",
		data:{
			"no":gb.no
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
// 게시물 불러오기 함수
function getContent(){
	let boardContent = `\${gb.content}</br>`
	if(gb.writer == "<sec:authentication property='principal.username'/>" || "<sec:authentication property='principal.username'/>" == "${group.leaderId}"){
		boardContent += `<button class='btn-boardModify' onclick="boardContentModifyFunc();">수정</button></br>`
	}
	$("#group-board-content").html(boardContent);
}
//게시물 수정 폼 나오기
function boardContentModifyFunc(){
	$("#group-board-content").empty();
	let form = `
		<div style="height:90%;">
			<input type="hidden" name="no" value="\${gb.no}"/>
			<textarea style="height:100%;" name="content">\${gb.content}</textarea>
		</div>
		<button class="btn-submitContent" onclick="submitModifiedContent(this);">등록</button>
	`;
	$("#group-board-content").append(form);
	
	// textarea의 변경값 실시간 감지
	$("textarea[name=content]").on("propertychange change keyup paste input", function() {
	   // 현재 변경된 데이터 셋팅
	   newContent = $(this).val();
	});
	
}
//게시물 수정 제출 함수
function submitModifiedContent(e){
	const no = $(e).siblings("div").children("[name=no]").val();
	console.log(newContent);
	$.ajax({
		url:`${pageContext.request.contextPath}/group/groupBoardModifying`,
		method:"POST",
		data:{
			"no":no,
			"content":newContent
		},
		success(data){
			console.log(data);
			getPageDetail(gb.no);
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
//게시물 삭제 함수
function deleteGroupBoardFunc(){
	if(confirm("게시물을 삭제하시겠습니까?")){
		$(document.groupBoardDeleteFrm).submit();
	}
};
//댓글 리스트 불러오기
function getCommentList(boardNo){
  	$.ajax({
  		url:`${pageContext.request.contextPath}/group/getCommentList/\${boardNo}`,
  		success(data){
  			$("#group-board-comment-list>table").empty();
  			$.each(data,(i,e)=>{
  				
 				const date = moment(e.regDate).format("YYYY년 MM월 DD일");
 				
	  			let tr = `
	  				<tr class="level\${e.commentLevel}">
	  				<td style="width:50px;">
	  					<img style="height:40px; border-radius:50%;" src="/hana/resources/upload/group/board/20220119_031942278_446.png" alt="" />
	  				</td>
					<td >
						<sub class="comment-writer"><a href="javascript:void(0);" onclick="goMemberView('\${e.writer}');" style="color:black; text-decoration:none; font-weight:bold;">\${e.writer}</a></sub>
						<sub class="comment-date">\${date}</sub>
						<br />
						<!-- 댓글내용 -->
						&nbsp;&nbsp;&nbsp;\${e.content}
					</td>`;
				if(e.commentLevel == 1){
					if(e.writer == "<sec:authentication property='principal.username'/>" || "<sec:authentication property='principal.username'/>" == "${group.leaderId}"){ //댓글 레벨 1 && 내가 작성자일 때 (삭제, 답글 버튼 모두)
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
					if(e.writer == "<sec:authentication property='principal.username'/>" || "<sec:authentication property='principal.username'/>" == "${group.leaderId}"){
						tr+=`<td></td><td style='padding-left:5px;'><span class='btn-boardCommentDelete' onclick='deleteCommentFunc(\${e.no},\${e.boardNo})'>삭제</span></td>`;	
					}
					else{ // 댓글레벨 2 && 내가 작성자가 아닐 때 (아무버튼도 없음)
						tr+="<td></td><td></td>";	
					}
				}
	  			tr += "</tr>"
	  			$("#group-board-comment-list>table").append(tr);
  			})
  		},
  		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			
		}
  	})
};
// 댓글 삭제 함수
function deleteCommentFunc(no,boardNo){
	console.log(no);
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			url:`${pageContext.request.contextPath}/group/groupBoardCommentDelete/\${no}`,
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
	// 클릭이벤트핸들러 제거!
	// 답글 다는 동안 답글버튼 또 눌렀을 때 새로운 html생성되는 것 방지
//댓글 입력
$(document.groupBoardCommentSubmitFrm).submit((e)=>{
	e.preventDefault();
	submitCommentFunc(e);
})
//댓글 제출 함수
function submitCommentFunc(e){
	let boardNo = $("[name=boardNo]",e.target).val(); 
	let o = {
		boardNo:boardNo,
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
	
function groupApplyHandlingFunc(e){
    console.log(e); // button객체    
    const $form = $(e).siblings("[name=groupApplyHandlingFrm]"); // 승인 및 거절 폼
    $form.children("[name=approvalYn]").val($(e).val()); // 승인/거절 폼 내 input:hidden("[name = approvalYn]")에 value값 넣어주기
    
/*     console.log($(e).siblings("[name=groupApplyHandlingFrm]").children("[name=no]").val());
    console.log($(e).siblings("[name=groupApplyHandlingFrm]").children("[name=approvalYn]").val()); */
    
 	 $.ajax({
		url:"${pageContext.request.contextPath}/group/groupApplyProccess",
		method:"POST",
		data: {
			no:$form.children("[name=no]").val(),
			groupId:$form.children("[name=groupId]").val(),
			memberId:$form.children("[name=memberId]").val(),
			approvalYn:$form.children("[name=approvalYn]").val()
		},
		success(data){
			console.log(data);
		},
		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			console.log
		}
	 })
     
}
//가입신청리스트
function enrollList(){
	 $.ajax({
	        url: "${pageContext.request.contextPath}/group/getGroupApplyRequest",
	        data: {
	            groupId : '${groupId}'
	        },
	        success(res){
	            console.log(res);
	            if(res.length!==0){
		            $("#modalTbody").empty();	            	
	            }
	            $.each(res, function(i, e) {	
	            	console.log(e.REG_DATE);
	            	const date = moment(e.REG_DATE).format("YYYY년 MM월 DD일");
	            	console.log(date);
	                let tr = `
	                    <tr>
	                        <td>
	                            \${e.NO}
	                        </td>
	                        <td>
	                            \${e.MEMBER_ID}
	                        </td>
	                        <td style="width:600px; padding-left:50px;padding-right:50px;">
	                            \${e.CONTENT}
	                        </td>
	                        <td>
	                            \${date}              
	                        </td>
	                        <td>
	                            <form:form name="groupApplyHandlingFrm">
	                                <input type="hidden" name="no" value="\${e.NO}"/>
	                                <input type="hidden" name="groupId" value="${group.groupId}"/>
	                                <input type="hidden" name="memberId" value="\${e.MEMBER_ID}"/>
	                                <input type="hidden" name="approvalYn" value=""/>
	                            </form:form>
	                            <button type="button" onclick="groupApplyHandlingFunc(this);"
	                                class="btn btn-default btn-sm btn-success"
	                                style="margin-right: 1%;" value="y">승인</button>
	                            <button type="button" onclick="groupApplyHandlingFunc(this);" class="btn btn-default btn-sm btn-danger" value="n">거절</button>
	                        </td>
	                    </tr>
	                `;
	                $("#modalTbody").append(tr);
	            })
				$("#applyListModal").modal();
	        },
	        error(xhr, statusText, err){
				switch(xhr.status){
				default: console.log(xhr, statusText, err);
				}
				console.log
			}
	    })
};
function groupApplyHandlingFunc(e, YN){
    console.log(e); // button객체    
    const $form = $(e).siblings("[name=groupApplyHandlingFrm]"); // 승인 및 거절 폼
    //$form.children("[name=approvalYn]").val(YN); // 승인/거절 폼 내 input:hidden("[name = approvalYn]")에 value값 넣어주기
    $("[name=groupApplyHandlingFrm] input[name=approvalYn]").val(YN);
    console.log("YN = ",YN);
/*     console.log($(e).siblings("[name=groupApplyHandlingFrm]").children("[name=no]").val());
    console.log($(e).siblings("[name=groupApplyHandlingFrm]").children("[name=approvalYn]").val()); */
    const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
    
    $.ajax({
		url:`${pageContext.request.contextPath}/group/groupApplyProccess`,
		method:"POST",
		headers: headers,
		data: {
			no:$form.children("[name=no]").val(),
			groupId:$form.children("[name=groupId]").val(),
			memberId:$form.children("[name=memberId]").val(),
			approvalYn:$form.children("[name=approvalYn]").val()
		},
		success(data){
			console.log(data);
		},
		error:console.log
	 });
     
}
</script>

<style>
.memberCountTr:hover{cursor:pointer;}
#myInfo {border: 1px solid black;}
#profileImg {height: 400px; padding-top:50px;}
#profileStatus {height: 400px;}
/* 세팅 버튼 */
#settingBtn {float: right;height: 50px;width: 50px;border-radius: 100%;border: none;}
#settingBtn img {width: 130%;}
/* 프로필이미지 */
.profileImg.d-flex {width: 230px;height: 230px;border-radius: 100%;}
.profileImg img {width: 80%;height: 80%;border-radius: 100%;display: inline-block;position: relative;top: 10%;left: 60%;}
.profileBtn {border: 1px solid black;width: 50px;height: 50px;border-radius: 100%;transform: translateX(200px) translateY(-80px);z-index: 1;background-color: white;}
.profileBtn img {width: 100%;border-radius: 100%;}
/* 프로필정보 */
.follow {display: inline-block;width: 100px;height: 30px;border: 1px solid black;}
.followCount {display: inline-block;width: 100px;height: 30px;border: 1px solid black;}
.profileTableAreaContainer {width:100%;height:100%;display: flex;align-items: center;}
.profileTableArea {margin-left:0;}
#profileTable {width: 100%;table-layout: fixed; border-collapse: separate;border-spacing: 0 10px;}
#tagMemberListTable {border-collapse: separate;border-spacing: 0 5px;}
#groupMemberListTable {border-collapse: separate;border-spacing: 0 30px; margin-left:20%;}
#groupMemberListTableContainer {height:50vh;overflow:auto;}
.tableKey {width: 40%;}
.tableValue {width: 60%;}
pre {margin: 0;}
#textArea {width: 100%;height: 150px;border: none;resize: none;background-color: white;padding-top: 30px;font-size: 16px;}
.buttonArea {}
</style>

<style>
.table-light th {min-width:70px;}
.applyListTableContainer{overflow:auto; height:70vh;}
.icon
table {border-collapse: separate;border-spacing: 0 5px;}
textarea { height:100px;border:none;width:100%;resize:none; }
textarea:focus { outline:none; }
.btn-submitContent{font-weight:bold;color:#384fc5c4;background-color:white;border:none;float:right;}
.btn-boardModify{font-weight:bold;color:#8080808a;background-color:white;border:none;float:right;}
.btn-reply{font-weight:bold;color:#8080808a;background-color:white;border:none;float:right;}
input[type="submit"] {font-weight:bold;color:#384fc5c4;background-color:white;border:none;float:right;}
.btn-deleteBoard {font-weight:bold;color:#f44336bd;background-color:white;border:none;}
textarea::placeholder {color:gray; font-size: 1.1em;}
.level2 td:nth-child(1),.level2 td:nth-child(2){padding-left:13px;}
.btn-boardCommentDelete {padding-left:5px;color:#8080808a;font-weight:bold;}
.btn-boardCommentDelete:hover {cursor:pointer;}
</style>

<a href="/" class="badge badge-dark">Dark</a>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>