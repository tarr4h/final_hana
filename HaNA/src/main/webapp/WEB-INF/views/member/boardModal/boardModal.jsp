<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<sec:authentication property="principal" var="loginMember"/>
<script src="${pageContext.request.contextPath }/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/summernote/summernote-lite.css" />

<div class="modal fade" id="boardModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<form:form name="boardEnrollFrm" action="${pageContext.request.contextPath }/member/insertBoard?${_csrf.parameterName}=${_csrf.token}" method="POST" enctype="multipart/form-data">
			<!-- header -->
			<div class="modal-header">
				<h3 class="modal-title">게시글 등록</h3>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						닫기
					</button>
			</div>
			<!-- 내용 -->
			<div class="modal-body">
					<input type="hidden" name="writer" value="${loginMember.id }" />
					<label for="boardTitle">제목</label>
					<input type="text" name="title" />
					<br />
					<div class="boardAttachArea">
						<input type="button" value="이미지 추가" class="appendAttachArea"/>
						<input type="file" name="upFile" required/>
					</div>
					<textarea name="content" id="summernote"></textarea>
			</div>
			<!-- footer -->
			<div class="modal-footer">
				<input type="submit" class="btn" value="등록하기" />
			</div>
			</form:form>
		</div>
	</div>
</div>

<script>
// boardModal
$("#boardModalBtn").click((e) => {
	$('#boardModal').modal({backdrop:'static', keyboard:false});
});

/* 이미지업로드영역 추가 */
$(".appendAttachArea").click((e) => {
	let inputFile = `
		<input type="file" name="upFile" required/>
	`;
	$(".boardAttachArea").append(inputFile);
});

$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 150,                 // 에디터 높이
		  minHeight: 150,             // 최소 높이
		  maxHeight: 300,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
		  toolbar: [],
		  disableResizeEditor: true
	});
	$(".note-resizebar").css('display', 'none');
});
</script>