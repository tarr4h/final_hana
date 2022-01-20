<%@page import="com.kh.hana.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메인화면" name="main"/>
</jsp:include>
<!-- 인증객체의 principal속성을 pageContext 속성으로 저장 heaer에 선언되면 삭제하기-->
<%-- <sec:authentication property="principal" var="loginMember" /> --%>
<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/chat.css" />
<sec:authorize access="isAuthenticated()">
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>
</sec:authorize>
<span>친구검색 x</span><br />
<span>오류있으면 제보좀요</span><br />
<span>채팅시 회원 이미지 나오게</span><br />
<span>기존 채팅에서 친구 초대 (단체)</span><br />
<span>소모임 회원 가입시 채팅방 추가 / 소모임 탈퇴시 채팅방 나가기</span><br />
<script>

let id;

<sec:authorize access="isAuthenticated()">
	id = '<sec:authentication property="principal.id"/>';
</sec:authorize>

$().ready(function(){ 
	roomList();
});

const roomList = () => {
	console.log(id);
	$.ajax({
		url:`${pageContext.request.contextPath}/chat/roomList.do`,
		data:{
			id : id,
		},
		method: "GET",
		success(resp){
			console.log(resp);
			displayRoom("#chatList", resp);
		},
		error:console.log
	});
};
<!-- <span class="online_icon"></span> -->
const displayRoom = (selector, data) => {
	const $target = $(selector);
	let chatroom = ``
		
		if(data.length){
			$(data).each((i, room) => {
				console.log(i, room);
				const {roomNo, roomName, roomType, members, groupImg} = room;
				chatroom += `<div class="card-body contacts_body">
					<ui class="contacts">
					<li class="active">
						<div class="d-flex bd-highlight" id="chatroom">
							<div class="img_cont">
								<img src="\${groupImg == null ? '#' : '../resources/upload/group/profile/'}\${groupImg == null ? "":groupImg}" class="rounded-circle user_img">
							</div>
							<div class="user_info">
								<span>\${roomType != 1 ? members : roomName}방</span>
								<button onclick="roomchat(this.value)" value="\${roomNo}">버튼</button>
							</div>
						</div>
					</li>

					</ui>
				</div>`;
				
			});
		}
		else{
			chatroom += `<span>ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ</span>`;
		}
		
		$target.html(chatroom);
};

</script>
	<div class="container-fluid h-100">
			<div class="row justify-content-center h-100">
				<div class="col-md-4 col-xl-4 chat"><div class="card mb-sm-3 mb-md-0 contacts_card">
					<div class="card-header">
						<div class="input-group">
							<input type="text" placeholder="Search..." id="findMemberInput" class="form-control search">
							<button id="findMember">검색</button>
							<button id="allMember">친구목록</button>
						</div>
					</div>
					<div id="chatList">
					
					</div>
				</div></div>
				<div class="col-md-8 col-xl-6 chat">
					<div class="card">
						<div class="card-header msg_head" id="msgHeader">
						</div> 
						
						<!-- 채팅내용 -->
						<div class="card-body msg_card_body" id="roomchat1">

						</div>
 						<div class="card-footer" id="sendMsgBtn"></div>
								
						
					</div>
				</div>
				
			</div>
		</div>
	<!-- Modal시작 -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="loginModalLabel">회원목록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div id="modaldiv"></div>
			</div>
		</div>
	</div>
	<!-- Modal 끝-->
	
<form 
	action="${pageContext.request.contextPath}/chat/sendchat.do"
	name="sendchatFrm"
	method="GET">
	<input type="hidden" name="memberId"/>
	<input type="hidden" name="loginId"/>
</form>
<script>
<!-- roomNo 전역변수 -->
let roomNo;

function roomchat(no){
	console.log("No = ", no);
	$("#roomchat1").html("");
	roomNo = no;
if(websocket !== undefined){
		console.log("기존 연결 제거")
		websocket.close();
	}
	
	<!-- 채팅 헤더 -->
 	$.ajax({
		url:`${pageContext.request.contextPath}/chat/roomheader.do`,
		data:{
			id : id,
			no : no,
		},
		method: "GET",
		success(resp){
			console.log(resp);
			let header =``;
				$(resp).each((i, chatroom) => {
					const {roomNo, roomName, roomType, members, groupImg} = chatroom;
					
					header += `<div class="card-header msg_head">
						<div class="d-flex bd-highlight">
						<div class="img_cont">
							<img src="\${groupImg == null ? '#' : '../resources/upload/group/profile/'}\${groupImg == null ? "":groupImg}" class="rounded-circle user_img">
							<span class="online_icon"></span>
						</div>
						<div class="user_info">
							<span>\${roomType == 1 ? roomName : "Chat with "+members}</span>
						</div>
						<span id="action_menu_btn"><button type="button" class="btn-close" onclick="closeBtn();" aria-label="Close"></button></span>
					</div>
				</div>`;
					
				});
				$("#msgHeader").html(header);
		},
		error:console.log
	});
 	
	$.ajax({
		url : `${pageContext.request.contextPath}/chat/roomchat.do`,
		data : {
			no : no,
		},
		method: "GET",
		success(resp){
			console.log(resp);
			for(var i = 0; i < resp.length; i++){
				msgCheck(resp[i]);
			}
		},
		error:console.log
	});
		
	sendBtn();
	
	connect();
};

<!-- 메세지 전송 -->
$("#btnSend").on("click", function(e){
	e.preventDefault();
	console.log("버튼클릭 roomNo = ",roomNo);
	if(websocket === undefined) {
		alert("채팅방을 선택하세요");
		$("textarea#msg").val('');
		return;
	}
	let msg = $("textarea#msg").val();
	if(msg == ''){
		alert("메세지를 입력하세요");
		return;		
	}
	
    const data = {
            "roomNo" : roomNo,
            "memberId" : id,
            "message"   : msg 
        };
    msgCheck(data);
    let jsonData = JSON.stringify(data);
    websocket.send(jsonData);
	
	//채팅메세지창 비우기
	$("textarea#msg").val('');
});

// 웹소켓
let websocket;


//입장 버튼을 눌렀을 때 호출되는 함수
function connect() {
    // 웹소켓 주소
    var wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chat";
    // 소켓 객체 생성
    websocket = new WebSocket(wsUri);

    //웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
    websocket.onopen = onOpen;
    websocket.onmessage = onMessage;
    
}

//웹 소켓에 연결되었을 때 호출될 함수
function onOpen() {
	console.log("onOpen roomNo = ", roomNo);
     const data = {
            "roomNo" : roomNo,
            "memberId" : id,
         "message" : "ENTER"
    };
    let jsonData = JSON.stringify(data);
    websocket.send(jsonData);
    console.log("opOpen");
}

<!-- 메세지 수신 -->
function onMessage(e){
	let eSplit = e.data.split(",");
	
	const data = {
		"memberId" : eSplit[0],
		"message" : eSplit[1]
	};
	console.log(data);
	if(data.memberId != id){
		msgCheck(data);
	}
}
		
function msgCheck(e){
	const check = (e.memberId != id) ? "left" : "right";
	displaychat(check, e.memberId, e.message);
}
 

const displaychat = (check, memberId, message) =>{
	let chat = ``
	
	if(message === 'ROOMENTER'){
		
		chat += `<div class="d-flex justify-content-center mb-2">
			<div class="msg_cotainer_send">
			\${memberId}가 입장하셨습니다.
			</div>
			</div>`
	}
	
	else{
		
		if(check === 'right'){
				chat += `<div class="d-flex justify-content-end mb-4">
<div class="msg_cotainer_send">
\${check} \${memberId}, \${message}
<span class="msg_time_send">8:55 AM, Today</span>
</div>
<div class="img_cont_msg">
<img src="#" class="rounded-circle user_img_msg">
</div>
</div>`;
		}
		else{
			chat += `<div class="d-flex justify-content-start mb-4">
				<div class="img_cont_msg">
				<img src="#" class="rounded-circle user_img_msg">
			</div>
			<div class="msg_cotainer">
			\${check} \${memberId}, \${message}
				<span class="msg_time">8:40 AM, Today</span>
			</div>
		</div>`;
		}
	}
		
		$("#roomchat1").append(chat);
		$("div#roomchat1").scrollTop($("div#roomchat1").prop("scrollHeight"));
};


$("#findMember").on("click", function(e){

 	let msg = $("#findMemberInput").val();
	
	console.log("친구찾기 msg = ", msg);

	$("#findMemberInput").val('');
	
	$(loginModal)
	.modal()
	.on("hide.bs.modal", (e) => {
		
	});
});
$("#allMember").on("click", function(e){
	
	console.log("회원목록");
	console.log("내 아이디 = " , id);
	
	
 	$.ajax({
		url:`${pageContext.request.contextPath}/chat/memberList.do`,
		method: "GET",
		data: {loginId : id},
		success(resp){
			console.log(resp);
			let modal =``;
				$(resp).each((i, member) => {
					const {id, name, picture} = member;
					console.log(id,name,picture);
					modal += `<div><span>picture: \${picture} 아이디 : \${id} 이름: \${name}</span><button onclick="chatsend(this.value)" value="\${id}">채팅</button></div>`;
					
				});
				$("#modaldiv").html(modal);
		},
		error:console.log
	});
	
	$(loginModal)
	.modal();
});

const chatsend = (e)=> {
	console.log("memberId = ", e);
	console.log("loginId = ", id);
	
	$("[name=sendchatFrm] input[name=memberId]").val(e);
	$("[name=sendchatFrm] input[name=loginId]").val(id);
	$(document.sendchatFrm).submit();
	
  	 $(loginModal)
	.modal('hide');  
	
};

const sendBtn = () => {
 	let sendHTML = ``;
 	sendHTML = `<div class="input-group">
<div class="input-group-append">
<span class="input-group-text attach_btn"><i class="fas fa-paperclip"></i></span>
</div>							
<textarea id="msg" class="form-control type_msg" placeholder="Type your message..."></textarea>
<div class="input-group-append">
<button id="btnSend" class="input-group-text send_btn"><i class="fas fa-location-arrow"></i></button>
</div>
</div>`; 

	$("#sendMsgBtn").html(sendHTML);
};

const closeBtn = () => {
	$("#msgHeader").html('');
	$("#roomchat1").html('');
	$("#sendMsgBtn").html('');
	websocket.close();
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>