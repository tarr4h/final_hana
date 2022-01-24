<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메인화면" name="main" />
</jsp:include>
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
	
	

<div class="group-page">
	<section class="group-page-section">
		<div class="group-page-image">
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
			<!-- <img style="position: absolute; top:0; left: 0; width: 100%; height: 100%; border-radius: 50%;" src="${pageContext.request.contextPath}/resources/upload/group/profile/${group.image}" alt="" /> -->
		</div>
		<div class="group-page-table">
			<table>
				<tr>
					<td class="td">아이디&nbsp</td>
					<td colspan="3">${group.groupId}</td>
				</tr>
				<tr>
					<td class="td">게시물&nbsp</td>
					<td style="padding-right: 30px;">${group.boardCount}&nbsp&nbsp&nbsp&nbsp</td>
					<td class="td" style="padding-right: 10px;">회원수&nbsp</td>
					<td>${group.memberCount}</td>
				</tr>
				<tr>
					<td style="padding-right: 10px;" class="td">소모임이름</td>
					<td colspan="3">${group.groupName}</td>
				</tr>
			</table>

		</div>
		<div class="group-page-enroll-button">
			<br>
			<%-- <c:if test="${empty groupMember || empty loginMember}"> --%>
			<%-- <c:remove var="enrolled"/> --%>
			<c:if test="${!enrolled}">
				<a href="#" class="enroll-button">가입신청</a>
			</c:if>
		</div>
	</section>
	<div class="icon">
		<a href="#"><i class="fas fa-pencil-alt"></i></a> <a href="#"><i
			class="fas fa-calendar-alt"></i></a> <a href="#"><i
			class="far fa-comments"></i></a>
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

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>