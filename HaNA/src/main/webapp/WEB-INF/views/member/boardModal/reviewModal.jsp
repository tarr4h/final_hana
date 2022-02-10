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
<style>
@charset "UTF-8";
.rating {
    /* margin: 50px auto; */
    width: 200px;
}

.rating > * {
    float: right;
}

@keyframes pulse {
    50% {
        color: #5e5e5e;
        text-shadow: 0 0 15px #777777;
    }
}

.rating label {
    height: 20px;
    width: 15%;
    display: block;
    position: relative;
    cursor: pointer;
}

.rating label:nth-of-type(5):after {
    animation-delay: 0.25s;
}

.rating label:nth-of-type(4):after {
    animation-delay: 0.2s;
}

.rating label:nth-of-type(3):after {
    animation-delay: 0.15s;
}

.rating label:nth-of-type(2):after {
    animation-delay: 0.1s;
}

.rating label:nth-of-type(1):after {
    animation-delay: 0.05s;
}

.rating label:after {
    transition: all 0.4s ease-out;
    -webkit-font-smoothing: antialiased;
    position: absolute;
    content: "☆";
    color: #444;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    text-align: center;
    font-size: 40px;
    animation: 1s pulse ease;
}

.rating label:hover:after {
    color: #5e5e5e;
    text-shadow: 0 0 15px #5e5e5e;
}

.rating input {
    display: none;
}

.rating input:checked + label:after,
.rating input:checked ~ label:after {
    content: "★";
    color: #F9BF3B;
    text-shadow: 0 0 20px #F9BF3B;
}



</style>


<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<form:form name="reviewEnrollFrm" action="${pageContext.request.contextPath }/member/insertReview?${_csrf.parameterName}=${_csrf.token}" method="POST" enctype="multipart/form-data">
			<!-- header -->
			<div class="modal-header">
				<h3 class="modal-title">리뷰 등록</h3>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						닫기
					</button>
			</div>
			<!-- 내용 -->
			<div class="modal-body">
					<input type="hidden" name="writer" value="${loginMember.id }" />
					<br />
					<div class="boardAttachArea">
						<input type="button" value="이미지 추가" class="appendAttachArea"/>
						<input type="file" name="upFile" required/>
					</div>
					<textarea name="content" id="summernote"></textarea>
					
					<!-- 별점매기기 -->
					<div id="starArea" style="display:block;float:left">
						<label for="rating">평점</label>
						<div class="rating">
							 <input type="radio" name="rating" id="r1" value="5">
							 <label for="r1"></label>
							
							 <input type="radio" name="rating" id="r2" value="4">
							 <label for="r2"></label>
							
							 <input type="radio" name="rating" id="r3" value="3">
							 <label for="r3"></label>
							
							 <input type="radio" name="rating" id="r4" value="2">
							 <label for="r4"></label>
							
							 <input type="radio" name="rating" id="r5" value="1">
							 <label for="r5"></label>
						</div>
						<input type="hidden" name="checkedVal" id="" />
					</div>
					<br /><br />
			</div>
			<!-- footer -->
			<div class="modal-footer">
				<input type="submit" class="btn" value="등록하기" />
			</div>
			<input type="hidden" name="reservationNo" id="review-rs-no"/>
			</form:form>
		</div>
	</div>
</div>

<script>
// reviewModal
function enrollReview(reservationNo){
	$("#review-rs-no").val(reservationNo);
	$('#reviewModal').modal({backdrop:'static', keyboard:false});	
};

$("[name=rating]").change((e) => {
	$("[name=checkedVal]").val($(e.target).val());
});

$(document.reviewEnrollFrm).submit((e) => {
	console.log($("[name=checkedVal]").val());
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