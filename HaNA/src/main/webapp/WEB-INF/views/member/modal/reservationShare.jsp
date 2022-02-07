<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<sec:authentication property="principal" var="loginMember"/>


<div class="modal fade" id="shareModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<!-- header -->
			<div class="modal-header">
				<h3 class="modal-title">공유하기</h3>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						닫기
					</button>
			</div>
			<!-- 내용 -->
			<div class="modal-body">
				<h4>친구를 선택하세요</h4>
				<input type="text" name="friendId" id="" />
				<input type="button" value="검색" id="searchFriend"/>
				<table id="friendListTable">
					<tbody></tbody>
				</table>
				<input type="hidden" name="shareReservationNo" />
			</div>
			<!-- footer -->
			<div class="modal-footer">
				<a class="btn nextBtn" data-num="1" href="#">완료</a>
			</div>
		</div>
	</div>
</div>

<script>
function shareReservationModal(reservationNo){
	$('#shareModal').modal({backdrop:'static', keyboard:false});
	$("[name=shareReservationNo]").val(reservationNo);
	console.log($("[name=shareReservationNo]").val());
};

function shareReservation(reservationNo, targetUser){
	/* 요청 필요 데이터 */
	console.log(reservationNo);
	console.log(targetUser);
	console.log('${loginMember.id}');
	
	
};

$("[name=friendId]").keyup((e) => {
	console.log($(e.target).val());
 	$.ajax({
		url: '${pageContext.request.contextPath}/member/followingListById',
		data:{
			inputText: $(e.target).val()
		},
		success(res){
			console.log(res);
			let resNo = $("[name=shareReservationNo]").val();
			$("#friendListTable tbody").empty();
			$.each(res, (i, e) => {
				let tr = `
					<tr>
						<td>
							<img src="${pageContext.request.contextPath}/resources/upload/member/profile/\${e.pic}" alt="" style="width:50px;height:50px;border-radius:100%"/>
						</td>
						<td>\${e.id}</td>
						<td>
							<input type="button" value="공유하기" onclick="shareReservation('\${resNo}', '\${e.id}');"/>
						</td>
					</tr>
				`;
				$("#friendListTable tbody").append(tr);
			});
			if($(e.target).val() == ''){
				$("#friendListTable tbody").empty();
			}
		},
		error: console.log
	});
})

$("#searchFriend").click((e) => {
	console.log($("[name=friendId]").val());
})
</script>