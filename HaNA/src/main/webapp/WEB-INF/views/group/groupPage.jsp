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
	<div class="modal fade" id="testModal" tabindex="-1">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
				<table>
					<tr>
						<td rowspan="2" id="member-profile"><img src="" style="height:50px; border-radius:50%"/></td>
						<th id="member-id"></th>
					</tr>
					<tr>
						<td id="tag-place"></td>
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
					        <div id="group-board-img-container" class="col-sm-7" style="position:relative; background-color:black;">
					 			
					        </div>
					        <div class="col-sm-5" style="">
					        	<div class="container">
								    <div class="row">
								        <div class="col-sm-12" style="border:solid black 1px; height:200px;"></div>
								        <div class="col-sm-12" style="border:solid black 1px; height:500px;"></div>
								        <div class="col-sm-12" style="border:solid black 1px; height:200px;"></div>
								    </div>
								</div>
					        </div>
					    </div>
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn" id="modalY" href="#">예</a>
					<button class="btn" type="button" data-dismiss="modal">아니요</button>
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
$('.board-main-image').click((e)=>{
	let boardNo = $(e.target).siblings("#group-board-no").val();
	
	$.ajax({
/* 		url:`<c:out value='${pageContext.request.contextPath}'></c:out>/group/groupBoardDetail/\${boardNo}`
 */		url:`<%=request.getContextPath()%>/group/groupBoardDetail/\${boardNo}`,
		success(data){
	 
	 		const {groupBoard, tagMembers} = data;
 			console.log(groupBoard.regDate);
 			const date = moment(groupBoard.regDate).format("YYYY년 MM월 DD일");
			let src = `<%=request.getContextPath()%>/resources/upload/member/profile/\${groupBoard.writerProfile}`;
	 		$("#member-profile").children("img").attr("src",src); // 글쓴이 프로필 이미지
 	 		$("#member-id").html(`&nbsp;&nbsp;\${groupBoard.writer}`); // 글쓴이 아이디
	 		$("#tag-place").html(`&nbsp;&nbsp;\${date}&nbsp;&nbsp;\${groupBoard.placeName}`) // 태그 장소
		
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
 			$(".group-board-img").css("margin-top","70px");
 

 		},
 		error:console.log
	})
	
	$('#testModal').modal("show");
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>