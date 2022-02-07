<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<title>${param.title }</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/29546d6ff0.js" crossorigin="anonymous"></script>

<script src="https://cdn.lordicon.com/libs/mssddfmo/lord-icon-2.1.0.js"></script>
<style>
	.section-over-div {min-height : 100vh;}
	.navbar-expand-lg { height : 10em;}
	.navbar-brand head { height : 10em;}
	.img-thumbnail { height : 8em;}
	div#headerAlert{display: none; text-align: center;}
	span.badge{color:red;}
</style>
<c:if test="${param.error != null }">
	<script>
		alert("아이디 또는 비밀번호가 잘못 입력되었습니다.");
		location.href = '${pageContext.request.contextPath}/member/login';
	</script>
</c:if>
<script>
//ajax POST 요청 csrf
    var csrfToken = $("meta[name='_csrf']").attr("content");
    $.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post" || options['type'].toLowerCase() === "delete" || options['type'].toLowerCase() === "put") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	  });
</script>
</head>
<body>
	<sec:authentication property="principal" var="loginMember"/>	
	
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-dark pr-3">
			<div class="title-image-box" style="margin-left:20px;">
			  <a class="navbar-brand head" href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath }/resources/images/duck.png" alt="..." class="img-thumbnail" style="width:130px;height:130px;border-radius:100%;"></a>
			</div>
			<span class="navbar-brand text-white" style="font-size:40px;">DNHBQ</span>			 
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="collapse navbar-collapse flex-row-reverse" id="navbarNavDropdown">
		    <ul class="navbar-nav">
		      <li class="nav-item active">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath}/">Home</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath }/shop/shopMain">AroundMe</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath}/mbti/mbti.do">MBTI</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath}/group/groupList">소모임</a>
		      </li>
		      <sec:authorize access="isAuthenticated()">
		      <li class="nav-item">
		        <a class="nav-link text-light" href="${pageContext.request.contextPath}/chat/chat.do">DM<span class="badge" id="dmAlarm"></span></a>
		      </li>
		      </sec:authorize>
		      <li class="nav-item">
		      	<sec:authorize access="isAnonymous()">
			        <a class="nav-link text-light" href="${pageContext.request.contextPath }/member/login">로그인(임시)</a>		      	
		      	</sec:authorize>					
		      </li>
		      <sec:authorize access="isAuthenticated()">
				    <li class="nav-item dropdown">
				    	<c:if test="${loginMember.accountType eq 1}">
			        	<a id="linkd" class="nav-link dropdown-toggle text-light" href="${pageContext.request.contextPath}/member/memberView/${loginMember.id}" >
				          <span><sec:authentication property="principal.username"/></span>
				        </a>				    	
				    	</c:if>
				    	<c:if test="${loginMember.accountType eq 0}">
			        	<a id="linkd" class="nav-link dropdown-toggle text-light" href="${pageContext.request.contextPath}/member/shopView/${loginMember.id}" >
				          <span><sec:authentication property="principal.username"/></span>
				        </a>				    	
				    	</c:if>
				        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				          <a class="dropdown-item" href="#">게시글 작성</a>
				          <a class="dropdown-item" href="#">예약 목록</a>
				          <a class="dropdown-item" href="#">계정 설정</a>
				        </div>
				    </li>
			    <li class="nav-item">
		      		<form:form method="POST" action="${pageContext.request.contextPath }/member/logout">
						<input type="submit" value="로그아웃" />
					</form:form>
				</li>
		      </sec:authorize>
		   			
		    </ul>
		  </div>
		</nav>
		<div id="headerAlert" class="alert alert-success" role="alert"></div>
	</header>
	<audio id="audio_play">
		<source src="${pageContext.request.contextPath }/resources/upload/chat/mp3/kakao2.mp3">
	</audio>
	<audio id="audio_play2">
		<source src="${pageContext.request.contextPath }/resources/upload/chat/mp3/kakao3.mp3">
	</audio>
	<sec:authorize access="isAuthenticated()">
		<script>
		$(document).ready( function() {
			connect(1);
			//dmAlarm();
		});
		let memberId;
		let websocketws;
		
		<!-- roomNo 전역변수 -->
		let roomNo;
		
		<sec:authorize access="isAuthenticated()">
			memberId = '<sec:authentication property="principal.id"/>';
		</sec:authorize>
		let websocket;
		//입장 버튼을 눌렀을 때 호출되는 함수

		//ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chat
		function connect(type) {
		    // 웹소켓 주소
		    var wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chat";
		    // 소켓 객체 생성
		    websocket = new WebSocket(wsUri);
		    //웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
		    if(type == 1){
		    websocket.onopen = onOpenws;
		    }
		    else if(type ==2){
		    	 websocket.onopen = onOpenShare;
		    }	    	
		    else{
			websocket.onopen = onOpen;
		    //websocket.onmessage = onMessage;
		    }
		    websocket.onmessage = onMessagews;
		    	
		    	
		    
		}
		//웹 소켓에 연결되었을 때 호출될 함수
 		function onOpenws() {
 		     const data = {
		         "memberId" : memberId,
 		         "message" : "ENTER22" 
		    };
			
		    let jsonData = JSON.stringify(data);
		    websocket.send(jsonData);
		    console.log("opOpenws"); 
		}
		
 		function onOpen() {
 		     const data = {
 		            "roomNo" : roomNo,
 		            "memberId" : id,
 		         "message" : "ENTER"
 		    };
 		    let jsonData = JSON.stringify(data);
 		    websocket.send(jsonData);
 		    console.log("opOpen");
 		}
 		

 		
		
		<!-- 메세지 알림 -->
		function onMessagews(e){
 			let eSplit = e.data.split(",");
			let ShareMessage = eSplit[1].split("@");
				
			if(ShareMessage[0] === 'share115'){
				if(eSplit[0]!==memberId){
					if(eSplit[4] !== roomNo){
					 	beep2();
						$("div#headerAlert").html(`<a href="${pageContext.request.contextPath}/chat/chat.do">\${ShareMessage[1]}</a>`);
						$("div#headerAlert").css('display','block');
						setTimeout(function(){
							$("div#headerAlert").css('display','none');
						},5000);
					}
					else{
						const data = {
								"memberId" : eSplit[0],
								"message" : eSplit[1],
								"picture" : eSplit[2],
								"messageRegDate" : today,
								"fileImg" : eSplit[5]
							};
							if(data.memberId != id){
								msgCheck(data);
							} 
					}
				};

				websocket.close();
				connect(1);
				return
			}
			else{
				
			if(eSplit[4] === roomNo){
					console.log("보낸 메세지 roomNo랑 입장한 roomNo가 같음");
	 
					const data = {
						"memberId" : eSplit[0],
						"message" : eSplit[1],
						"picture" : eSplit[2],
						"messageRegDate" : today,
						"fileImg" : eSplit[5]
					};
					console.log(data);
					if(data.memberId != id){
						msgCheck(data);
					} 
					
					unreadCheck(e);
				}
				else{
					
			 	beep();
				let msg = (eSplit[1] != 'null' ? '메세지를' : '사진을');
				$("div#headerAlert").html(`<a href="${pageContext.request.contextPath}/chat/chat.do">\${eSplit[0]}님이 \${msg} 보냈습니다</a>`);
				$("div#headerAlert").css('display','block');
				setTimeout(function(){
					$("div#headerAlert").css('display','none');
				},5000);
				} 
			}


		};	
		
		<!-- 채팅 메세지 수신오면 확인 -->
		const unreadCheck = (e) => {
			let eSplit = e.data.split(",");
			$.ajax({
				url:`${pageContext.request.contextPath}/chat/updateunreadcount.do`,
				method:'GET',
				data : {
					roomNo : eSplit[4],
					memberId : eSplit[0]
				},
				success(resp){
					console.log("unreadcheck");
						
				},
				error:console.log
			});
			
		}
		
		<!-- 카톡음 -->
		function beep() { 
			var audio = document.getElementById('audio_play');
			audio.play();
			audio.loop = false;
			}; 
			function beep2() { 
				var audio = document.getElementById('audio_play2');
				audio.play();
				audio.loop = false;
				}; 	
		const dmAlarm = () => {
			$.ajax({
				url:`${pageContext.request.contextPath}/chat/dmalarm.do`,
				method:'GET',
				data:{id : memberId},
				success(resp){
					if(resp != 0)
						$("#dmAlarm").text(resp);
				},
				/* error:console.log */
			});
			
			<!-- 3초마다 -->
			setTimeout(function() {
				dmAlarm();	
			}, 3000);
		};
		

			
		</script>
	</sec:authorize>

	<div class="section-over-div">
