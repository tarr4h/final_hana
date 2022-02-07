<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메인화면" name="title"/>
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css" />
<sec:authentication property="principal" var="loginMember" />
<style id="mainCss"></style>
<script>
let today = Date.now()-(9 * 60 * 60 * 1000);
//댓글리스트 가져오기
//css넣어주기
const forEachCss = (index)=>{
	let css=``;
	css=`/* 보여줄 구간의 높이와 넓이 설정 */ 
		#slideShow\${index}{ 
		width: 614px; 
	height: 402px; 
	position: relative; 
	margin: auto; 
	overflow: hidden; 

	/*리스트 형식으로 이미지를 일렬로 정렬할 것이기 때문에, 500px 밖으로 튀어 나간 이미지들은 hidden으로 숨겨줘야됨*/ } 
	.slides\${index}{ 
		position: absolute; 
		left: 0; 
		top: 0;
		 width: 614px; 
		 /* 슬라이드할 사진과 마진 총 넓이 */ 
		 transition: left 0.5s ease-out; 
		 /*ease-out: 처음에는 느렸다가 점점 빨라짐*/ 
		 } 
	/* 첫 번째 슬라이드 가운데에 정렬하기위해 첫번째 슬라이드만 margin-left조정 */ 
	/* .slides li:first-child{ margin-left: 100px; }  */
	/* 슬라이드들 옆으로 정렬 */ 
	.slides\${index} li:not(:last-child){ float: left; margin-right: 100px; } 
	.slides\${index} li{ float: left; } 
	.controller\${index} span{ position:absolute; background-color: transparent; color: black; text-align: center; border-radius: 50%; padding: 10px 20px; top: 50%; font-size: 1.3em; cursor: pointer; }


	.controller\${index} span{ 
		position:absolute; 
		background-color: 
		transparent; 
		color: black; 
		text-align: center; 
		border-radius: 50%; 
		padding: 10px 20px; 
		top: 50%; 
		font-size: 1.3em; 
		cursor: pointer; 
		} 
		

	/* 이전, 다음 화살표에 마우스 커서가 올라가 있을때 */ 
	.controller\${index} span:hover{ 
		background-color: rgba(128, 128, 128, 0.11); } 
		.prev{ left: 10px; 
		} 
	/* 이전 화살표에 마우스 커서가 올라가 있을때 이전 화살표가 살짝 왼쪽으로 이동하는 효과*/ 
	.prev\${index}:hover{ 
		transform: translateX(-10px); 
		} 
	.next\${index}{ 
		right: 10px; 
		} 
	/* 다음 화살표에 마우스 커서가 올라가 있을때 이전 화살표가 살짝 오른쪽으로 이동하는 효과*/ 
	.next\${index}:hover{ 
		transform: translateX(10px); 
		}`;
	$("#mainCss").append(css);
};
const slideWidth = 800; //한개의 슬라이드 넓이 
const slideMargin = 0; //슬라이드간의 margin 값 
</script>
    
    <!-- 다시만든 main -->
    <main>
    <div class="feeds">
    <span>맴버 그룹 좋아요 불러오기</span><br />
    <span>맴버 그룹 좋아요 누르기</span><br />
    <span>그룹 게시판 대댓글 작성가능하게</span><br />
    <span>추천 친구 팔로우신청</span><br />
    <span>게시글에서 작성자한테 dm보내기</span><br />
    <span>로그인맴버 프로필사진</span>
    <span></span>
	    <c:if test="${not empty groupboard}">
        <c:forEach items="${groupboard}" var="groupboard" varStatus="vss">
    <article>
    <table>
    <tr>
    <td>
              <img class="img-profile pic" src="${pageContext.request.contextPath }/resources/upload/member/profile/${groupboard.writerProfile}">
              <span class="userID main-id point-span">${groupboard.writer}</span>
    </td>
    </tr>
    <tr>
    <td>     	
           <div class="main-image" id="slideShow${vss.index }">
          	<ul class="slides${vss.index }">
				<c:forEach items="${groupboard.image}" var="images" varStatus="vs">
	          	<li><img width="610px" height="400px" src="${pageContext.request.contextPath }/resources/upload/group/board/${images}"></li>
	          	</c:forEach>
          	</ul>
            <p class="controller${vss.index }">
	            <span class="prev${vss.index }">&lang;</span> 
	            <span class="next${vss.index }">&rang;</span>
            </p>
          </div>
    </td>
    </tr>
    <tr>
    <td>
              <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/heart.svg" alt="하트"/>
              <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/chat.svg" alt="말풍선">
              <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/send.svg" alt="DM">  
    </td>
    </tr>
    <tr>
    <td>
              <span>asdfsadfasf님 외 123123명이 좋아합니다.</span>
    </td>
    </tr>
    <tr>
    <td width="550px" style="word-break:break-all">
              <span class="main-header-comment">
              <img class="img-profile pic" src="${pageContext.request.contextPath }/resources/upload/member/profile/${groupboard.writerProfile}">${groupboard.writer} ${groupboard.content}
              </span>
    </td>
    </tr>
    <tr>
    <td>
              <span class="at-tag">
				<c:forEach items="${groupboard.tagMembers}" var="tagmembers" varStatus="vs">
              	@${tagmembers}
              	</c:forEach>
              </span>
    </td>
    </tr>
    <tr>
    <td class="commentTd${vss.index }">
				<div class="comment-section">
			         <ul class="comments${vss.index }">
		              </ul>
		            </div>
                          
    </td>
    </tr> 
    <tr>
    <td>
    		<div class="hl"></div>
          <div class="comment">
            <input id="input-comment${vss.index }" class="input-comment" type="text" placeholder="댓글 달기..." >
            <button type="button" class="submit-comment" onclick="commetWrite${vss.index}();">게시</button>
          </div>
    </td>
    </tr>  
    </table>
    </article>
        <script>
        <!-- mainCss에 append해주기 -->
       forEachCss(${vss.index });
const slides${vss.index } = document.querySelector('.slides${vss.index }'); //전체 슬라이드 컨테이너 
const slideImg${vss.index } = document.querySelectorAll('.slides${vss.index } li'); //모든 슬라이드들
let currentIdx${vss.index } = 0; //현재 슬라이드 index 
const slideindex${vss.index } = slideImg${vss.index }.length; // 슬라이드 개수 


//전체 슬라이드 컨테이너 넓이 설정  (slideWidth + slideMargin) * slideindex + 'px';
/* console.log("sdfsdf",${vss.index });
console.log("slides${vss.index } = ",slides${vss.index });
console.log("slideImg${vss.index } = ",slideImg${vss.index });
console.log("slideindex${vss.index } = ",slideindex${vss.index }); */
slides${vss.index }.style.width = (slideWidth + slideMargin) * slideindex${vss.index } + 'px';


function moveSlide${vss.index }(num${vss.index }) { 
	slides${vss.index }.style.left = -num${vss.index } * 715 + 'px'; 
	currentIdx${vss.index } = num${vss.index }; 
	} 


$(`.prev${vss.index }`).on('click', function () { 
	/*첫 번째 슬라이드로 표시 됐을때는 이전 버튼 눌러도 아무런 반응 없게 하기 위해 currentIdx !==0일때만 moveSlide 함수 불러옴 */ 
	if (currentIdx${vss.index } !== 0) moveSlide${vss.index }(currentIdx${vss.index } - 1); 

	}); 
$(`.next${vss.index }`).on('click', function () { 
		/* 마지막 슬라이드로 표시 됐을때는 다음 버튼 눌러도 아무런 반응 없게 하기 위해 currentIdx !==slideindex - 1 일때만 moveSlide 함수 불러옴 */ 
		if (currentIdx${vss.index } !== slideindex${vss.index } - 1) { 
			moveSlide${vss.index }(currentIdx${vss.index } + 1); 

			} 
		});

//forEach문에서 댓글 불러오기
	$.ajax({
		url : `${pageContext.request.contextPath}/chat/boardcommentList.do`,
		data : {
			boardNo : ${groupboard.no}
		},
		method: "GET",
		success(resp){
			
			/* console.log("${vss.index } =",resp); */
			let commentList =``;
				$(resp).each((i, comment) => {
					const {boardNo, commentLevel, commentRef, content, no, regDate, writer} = comment;
					const date = moment(regDate).format("YYYY년 MM월 DD일");
					commentList += `<li>
		                  <span class="\${commentLevel === 1 ?  '' : 'commentLevel2'}"><span class="point-span userID">\${writer}</span>\${content}</span>
		                </li>
		                <li>
			              <div class="time-log">
			                <span class="\${commentLevel === 1 ?  '' : 'commentLevel2'}">\${date}</span>
			              </div>
		                </li>  `;
					
				});
				$(".commentTd${vss.index} .comments${vss.index }").html(commentList);

		},
		error:console.log
	});
	
//forEach에서 일반 댓글쓰기
const commetWrite${vss.index}=()=>{
	/* console.log("vvsindex = ", ${vss.index}); */
	let msg = $("input#input-comment${vss.index}").val();
	if(msg == ''){
		alert("메세지를 입력하세요");
		return;		
	}
		
	$.ajax({
		url:`${pageContext.request.contextPath}/chat/insertgroupBoardcomment.do`,
		method:"GET",
		data:{
			writer : memberId,
			boardNo : ${groupboard.no},
			content : msg,
			commentLevel : 1,
			commentRef : 0,
		},
		success(resp){
			console.log('댓글작성');
		},
		error:console.log
	});
	console.log("msg = ",msg);
	const date = moment(today).format("YYYY년 MM월 DD일");
	let commentList =`<li>
        <span><span class="point-span userID">${loginMember.id}</span>\${msg}</span>
        </li>
        <li>
          <div class="time-log">
            <span>\${date}</span>
          </div>
        </li>  `;
	$(".commentTd${vss.index} .comments${vss.index }").append(commentList);
	$("input#input-comment${vss.index}").val('');
};
</script>

        </c:forEach>
        </c:if>
        
        
        <!-- 맴버게시판@@@@@@@@@@@@@@@@@@ -->
	    <c:if test="${not empty board}">
        <c:forEach items="${board}" var="board" varStatus="vss">
    <article>
    <table>
    <tr>
    <td>
              <img class="img-profile pic" src="${pageContext.request.contextPath }/resources/upload/member/profile/${board.writerProfile}">
              <span class="userID main-id point-span">${board.writer}</span>
    </td>
    </tr>
    <tr>
    <td>     	
           <div class="main-image" id="slideShow0${vss.index }">
          	<ul class="slides0${vss.index }">
				<c:forEach items="${board.picture}" var="images" varStatus="vs">
	          	<li><img width="610px" height="400px" src="${pageContext.request.contextPath }/resources/upload/member/board/${images}"></li>
	          	</c:forEach>
          	</ul>
            <p class="controller0${vss.index }">
	            <span class="prev0${vss.index }">&lang;</span> 
	            <span class="next0${vss.index }">&rang;</span>
            </p>
          </div>
    </td>
    </tr>
    <tr>
    <td>
              <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/heart.svg" alt="하트"/>
              <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/chat.svg" alt="말풍선">
              <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/send.svg" alt="DM">  
    </td>
    </tr>
    <tr>
    <td>
              <span>asdfsadfasf님 외 123123명이 좋아합니다.</span>
    </td>
    </tr>
    <tr>
    <td width="550px" style="word-break:break-all">
              <span class="main-header-comment">
              <img class="img-profile pic" src="${pageContext.request.contextPath }/resources/upload/member/profile/${board.writerProfile}">${board.writer} ${board.content}
              </span>
    </td>
    </tr>
<%--     <tr>
    <td>
              <span class="at-tag">
				<c:forEach items="${groupboard.tagMembers}" var="tagmembers" varStatus="vs">
              	@${tagmembers}
              	</c:forEach>
              </span>
    </td>
    </tr> --%>
    <tr>
    <td class="commentTd0${vss.index }">
				<div class="comment-section">
			         <ul class="comments0${vss.index }">
		              </ul>
		            </div>
                          
    </td>
    </tr> 
    <tr>
    <td>
    		<div class="hl"></div>
          <div class="comment">
            <input id="input-comment0${vss.index }" class="input-comment" type="text" placeholder="댓글 달기..." >
            <button type="button" class="submit-comment" onclick="commetWrite0${vss.index}();">게시</button>
          </div>
    </td>
    </tr>  
    </table>
    </article>

        <script>
        <!-- mainCss에 append해주기 -->
       forEachCss('0'+${vss.index });
const slides0${vss.index } = document.querySelector('.slides0${vss.index }'); //전체 슬라이드 컨테이너 
const slideImg0${vss.index } = document.querySelectorAll('.slides0${vss.index } li'); //모든 슬라이드들
let currentIdx0${vss.index } = 0; //현재 슬라이드 index 
const slideindex0${vss.index } = slideImg0${vss.index }.length; // 슬라이드 개수 


//전체 슬라이드 컨테이너 넓이 설정  (slideWidth + slideMargin) * slideindex + 'px';
/* console.log("sdfsdf",'0'+${vss.index });
console.log("slides0${vss.index } = ",slides0${vss.index });
console.log("slideImg0${vss.index } = ",slideImg0${vss.index });
console.log("slideindex0${vss.index } = ",slideindex0${vss.index }); */
slides0${vss.index }.style.width = (slideWidth + slideMargin) * slideindex0${vss.index } + 'px';


function moveSlide0${vss.index }(num0${vss.index }) { 
	slides0${vss.index }.style.left = -num0${vss.index } * 715 + 'px'; 
	currentIdx0${vss.index } = num0${vss.index }; 
	} 


$(`.prev0${vss.index }`).on('click', function () { 
	/*첫 번째 슬라이드로 표시 됐을때는 이전 버튼 눌러도 아무런 반응 없게 하기 위해 currentIdx !==0일때만 moveSlide 함수 불러옴 */ 
	if (currentIdx0${vss.index } !== 0) moveSlide0${vss.index }(currentIdx0${vss.index } - 1); 

	}); 
$(`.next0${vss.index }`).on('click', function () { 
		/* 마지막 슬라이드로 표시 됐을때는 다음 버튼 눌러도 아무런 반응 없게 하기 위해 currentIdx !==slideindex - 1 일때만 moveSlide 함수 불러옴 */ 
		if (currentIdx0${vss.index } !== slideindex0${vss.index } - 1) { 
			moveSlide0${vss.index }(currentIdx0${vss.index } + 1); 

			} 
		});

//forEach문에서 댓글 불러오기
 	$.ajax({
		url : `${pageContext.request.contextPath}/chat/memberboardcommentList.do`,
		data : {
			boardNo : ${board.no}
		},
		method: "GET",
		success(resp){
			
			/* console.log("0${vss.index } =",resp); */
			let commentList =``;
				$(resp).each((i, comment) => {
					const {boardNo, commentLevel, commentRef, content, no, regDate, writer} = comment;
					const date = moment(regDate).format("YYYY년 MM월 DD일");
					commentList += `<li>
		                  <span class="\${commentLevel === 1 ?  '' : 'commentLevel2'}"><span class="point-span userID">\${writer}</span>\${content}</span>
		                </li>
		                <li>
			              <div class="time-log">
			                <span class="\${commentLevel === 1 ?  '' : 'commentLevel2'}">\${date}</span>
			              </div>
		                </li>  `;
					
				});
				$(".commentTd0${vss.index} .comments0${vss.index }").html(commentList);

		},
		error:console.log
	});
	
//forEach에서 일반 댓글쓰기
const commetWrite0${vss.index}=()=>{
	/* console.log("0vvsindex = ", '0'+${vss.index}); */
	let msg = $("input#input-comment0${vss.index}").val();
	if(msg == ''){
		alert("메세지를 입력하세요");
		return;		
	}
		
	$.ajax({
		url:`${pageContext.request.contextPath}/chat/insertmemberBoardcomment.do`,
		method:"GET",
		data:{
			writer : memberId,
			boardNo : ${board.no},
			content : msg,
			commentLevel : 1,
			commentRef : 0,
		},
		success(resp){
			console.log('댓글작성');
		},
		error:console.log
	});
	console.log("msg = ",msg);
	const date = moment(today).format("YYYY년 MM월 DD일");
	let commentList =`<li>
        <span><span class="point-span userID">${loginMember.id}</span>\${msg}</span>
        </li>
        <li>
          <div class="time-log">
            <span>\${date}</span>
          </div>
        </li>  `;
	$(".commentTd0${vss.index} .comments0${vss.index }").append(commentList);
	$("input#input-comment0${vss.index}").val('');
};
</script>
        </c:forEach>
        </c:if>


        
    </div>
    <!-- 여기까지 feed div -->
    
          <!-- main-right -->
      <div class="main-right">
        <div class="myProfile">
          <img class="pic" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="thisisyourhyung님의 프로필 사진">
          <div>
            <span class="userID point-span">${loginMember.id}</span>
            <span class="sub-span">${loginMember.name}</span>  
          </div>
        </div>

        
        <!-- recommendation section -->
        <div class="section-recommend">
          <div class="menu-title">
            <span class="sub-title">회원님을 위한 추천</span>
            <!-- <span class="find-more">모두 보기</span> -->
          </div>
<ul class="recommend-list">
          <c:if test="${not empty memberList}">
          <c:forEach items="${memberList}" var="member">
            <li>
              <div class="recommend-friend-profile">
                <img class="img-profile" src="${pageContext.request.contextPath }/resources/upload/member/profile/${member.picture}">
                <div class="profile-text">
                  <span class="userID point-span">${member.id}</span>
                  <span class="sub-span">${member.name != null ? '나를 팔로잉한 친구' : '같은 소모임에 있는 친구'}</span>
                </div>
              </div>
              <span class="btn-follow">팔로우</span>
            </li>
          </c:forEach>
          </c:if>
</ul>
        </div>


      </div>
    </main>
	


    <style>
    .commentLevel2{margin-left: 50px}
    </style>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
