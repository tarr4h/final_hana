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

let gb; // 스크립트에서 사용할 게시물 정보 

//계정페이지로 이동
function goMemberView(memberId){
	location.href=`${pageContext.request.contextPath}/member/memberView/\${memberId}`;
}
//ajax POST 요청 csrf
    var csrfToken = $("meta[name='_csrf']").attr("content");
    $.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post" || options['type'].toLowerCase() === "delete" || options['type'].toLowerCase() === "put") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	  });

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
<jsp:include page="/WEB-INF/views/group/modal/groupApplyList.jsp"/>

<!-- 게시물 상세보기 모달 -->
<jsp:include page="/WEB-INF/views/group/modal/groupBoardDetail.jsp"/>


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
.board-main-image:hover {cursor:pointer;}
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
.memberCountTr:hover{cursor:pointer;}
.tableKey {width: 40%;}
.tableValue {width: 60%;}
pre {margin: 0;}
#textArea {width: 100%;height: 150px;border: none;resize: none;background-color: white;padding-top: 30px;font-size: 16px;}
.buttonArea {}

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