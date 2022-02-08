<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<sec:authentication property="principal" var="loginMember"/>
<script>
let ShareroomNo;
let Sharetoday = Date.now()-(9 * 60 * 60 * 1000);
</script>

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
				<table id="acceptedFriendListTable">
					<tbody>
					</tbody>
				</table>
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
	$("[name=shareReservationNo]").val(reservationNo);
	$("[name=friendId]").val('');
	$("#friendListTable tbody").empty();
	selectAcceptedFriends(reservationNo);
	$('#shareModal').modal({backdrop:'static', keyboard:false});
};

function selectAcceptedFriends(reservationNo){
	$.ajax({
		url: '${pageContext.request.contextPath}/shop/selectAcceptedFriends',
		data:{
			reservationNo
		},
		success(res){
			console.log(res);
			$("#acceptedFriendListTable tbody").empty();		
			$.each(res, (i, e) => {
				if(e.id != '${loginMember.id}'){
					let tr = `
						<tr>
							<td>
								<img src="${pageContext.request.contextPath}/resources/upload/member/profile/\${e.picture}" alt="" style="width:50px;height:50px;border-radius:100%"/>
							</td>
							<td>
								<span class="sharedFr">\${e.id}</span>
							</td>
							<td>
								공유완료
							</td>
						</tr>
					`;					
					$("#acceptedFriendListTable tbody").append(tr);				
				}
			});
		},
		error:console.log
	});	
};

function onOpenShare() {
		console.log("onOpenShare");
		console.log("123 =",ShareroomNo);
		console.log("123 =",`${loginMember.id}`);
	    const data = {
	    	"roomNo" : ShareroomNo,
	        "memberId" : `${loginMember.id}`,
	        "message" : "ENTER" 
	    };
	    let jsonData = JSON.stringify(data);
	    websocket.send(jsonData);
	}
function shareReservation(reservationNo, targetUser){
	/* 요청 필요 데이터 */
	console.log(reservationNo);
	console.log(targetUser);
	console.log('${loginMember.id}');
	console.log('${loginMember.picture}');
	const testtest=()=>{
		$.ajax({
			url:`${pageContext.request.contextPath}/chat/shareReservation.do`,
			data:{
				id : `${loginMember.id}`,
				reservationNo : reservationNo,
				targetUser : targetUser
			},
			method: "GET",
			success(resp){
				console.log("resp =", resp);
				//채팅방 번호를 전역변수에 넣음
				ShareroomNo = resp;
				connect(2);
				//웹소켓 접속을 하고 websocket.send를 보내야하는데 비동기라 send가 먼저 작동돼서 1초뒤 send되게
				 setTimeout(function() {
					    const data = {
					            "roomNo" : ShareroomNo,
					            "memberId" : `${loginMember.id}`,
					            "message"   : `share115@${loginMember.id}님이 예약을 공유했습니다.@\${reservationNo}`,
					            "picture" : `${loginMember.picture}`,
					            "messageRegDate" : Sharetoday
					        }; 
					    console.log("gdgd = ",data);
					    console.log("data.message=",data.message);
					    let messageSplit = data.message.split("@");
					    console.log("messageSplit[0] = ",messageSplit[0]);
					    console.log("messageSplit[1] = ",messageSplit[1]);
					    console.log("messageSplit[2] = ",messageSplit[2]);
					    
					    let jsonData = JSON.stringify(data);
					    websocket.send(jsonData);
					    console.log(jsonData);
					    $('#shareModal').modal('hide');
					    alert("공유 완료");
				 },1000);

			},
			error: console.log
		}); 

	};
	testtest();
};

function selectAcceptedFriendsForCheck(reservationNo){
	let testVal;
	$.ajax({
		url: '${pageContext.request.contextPath}/shop/selectAcceptedFriends',
		data:{
			reservationNo
		},
		async: false,
		success(res){
			testVal = res;
		},
		error:console.log
	});
	return testVal;
}

$("[name=friendId]").keyup((e) => {
 	$.ajax({
		url: '${pageContext.request.contextPath}/member/followingListById',
		data:{
			inputText: $(e.target).val()
		},
		success(res){
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
				
				let reservationNo = $("[name=shareReservationNo]").val();
				
				let frList = selectAcceptedFriendsForCheck(reservationNo);
				let bool = true;
				$.each(frList, (a, b) => {
					if(e.id == b.id){
						bool = false;
					}
				});
				if(bool){
					$("#friendListTable tbody").append(tr);
				};
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