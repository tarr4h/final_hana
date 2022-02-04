<%@page import="com.kh.hana.member.model.vo.Member"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script>
// 리더만 수정할 수 있는 버튼 (만 있음)
	function goGroupSetting() {
		location.href = "${pageContext.request.contextPath}/group/groupSetting";
	}
//ajax POST 요청 csrf
    var csrfToken = $("meta[name='_csrf']").attr("content");
    $.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post" || options['type'].toLowerCase() === "delete" || options['type'].toLowerCase() === "put") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	  });

</script>
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
		<c:if test="${loginMember.id.equals(group.leaderId) }">
			<div class="profileBtn">
				<!-- (+)버튼을 이미지로 넣고, 클릭 시 변경 이벤트 걸기 -->
				<form:form action="${pageContext.request.contextPath}/group/profileImage?${_csrf.parameterName}=${_csrf.token}" id="upFileForm" accept="image/*" method="post" enctype="multipart/form-data">
					<input type="hidden" name=groupId value="${group.groupId}"/>
					<input type="hidden" name=image value="${group.image}"/>
					<input type="file" name="upFile" id="file" style="display:none"/>
				<div class="changeImage" onclick="onclick=document.all.file.click()" style="cursor: pointer;">
				<img 
					src="${pageContext.request.contextPath}/resources/images/icons/plusIcon.png"
					alt=""/>
				<button type="submit" class="btn btn-outline-dark" style="border: white;"></button>
				</div>
				</form:form>
			</div>
		</c:if>
				
		</div>
<!-- 		<div class="col-sm-2"></div>
 -->		<!-- 프로필 세부정보 영역 -->
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
<div>
<div class="icon">
	<a href="${pageContext.request.contextPath}/group/groupPage/${group.groupId}"><i class="fas fa-pencil-alt"></i></a>
	<a href="${pageContext.request.contextPath}/group/groupCalendar/${group.groupId}"><i class="fas fa-calendar-alt"></i></a>
	<a href="#"><i class="far fa-comments"></i></a>
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
