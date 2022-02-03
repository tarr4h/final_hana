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

    <!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css" />
<sec:authentication property="principal" var="loginMember" />
   
    <!-- main -->
    <main>
      <div class="feeds">
	${groupboard}
        <c:if test="${not empty groupboard}">
        <c:forEach items="${groupboard}" var="groupboard" varStatus="vs">
        <article>


          <header id="mainheader">
            <div class="profile-of-article">
              <img class="img-profile pic" src="${pageContext.request.contextPath }/resources/upload/member/profile/${groupboard.writerProfile}" alt="writerProfile">
              <span class="userID main-id point-span">${groupboard.writer}</span>
            </div>
            <img class="icon-react icon-more" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="more">
          </header>
          <div class="main-image" id="slideShow">
          	<ul class="slide">
          	<c:forEach items="${groupboard.image}" var="images" varStatus="vs">
          	<li><img src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" class="mainPic"></li>
          	</c:forEach>
          	</ul>
            <p class="controller">
	            <span class="prev">&lang;</span> 
	            <span class="next">&rang;</span>
            </p>
          </div>




          <div class="icons-react">
            <div class="icons-left">
              <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/heart.svg" alt="하트"/>
              <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/chat.svg" alt="말풍선">
              <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/send.svg" alt="DM">  
            </div>
            <%-- <img class="icon-react" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="북마크"> --%>
          </div>




          <!-- article text data -->
          <div class="reaction">
			<table>
			
<tr>
<td>
      
			<div class="liked-people">
              <%-- <img class="pic" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="johnnyjsuh님의 프로필 사진"> --%>
              <p><span class="point-span">좋아요 부분</span>님 <span class="point-span">외 2,412,751명</span>이 좋아합니다</p>
            </div>

              <!-- <span>asdddddddddddddddddddddd</span> -->

</td>
</tr>




            <!-- 태그 -->
            <tr>
            <td>
            <div class="description">
              <p>
              <span class="point-span userID">${groupboard.writer}</span>
              <span class="main-header-comment">${groupboard.content.length() >= 35 ? groupboard.content.substring(0, 35) : groupboard.content} ${groupboard.content.length() >= 35 ? '더보기...' : ''}</span>
              <span class="at-tag">
              <c:forEach items="${groupboard.tagMembers}" var="tagmembers" varStatus="vs">
              @${tagmembers}
              </c:forEach>
              </span>
              </p>
            </div>
            </td>
            <tr>
            <td>
            <div class="comment-section">
              <ul class="comments">
                <li>
                  <span><span class="point-span userID">postmalone</span>내가 입으면 더 잘어울릴 것 같아</span>
                  <img class="comment-heart" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="하트">
                </li>
                <!-- input 값 여기에 추가 -->
              </ul>
              <div class="time-log">
                <span>32분 전</span>
              </div>
            </div>
            </td>
            </tr>
			</table>


          </div>
          <div class="hl"></div>
          <div class="comment">
            <input id="input-comment" class="input-comment" type="text" placeholder="댓글 달기..." >
            <button type="submit" class="submit-comment" disabled>게시</button>
          </div>
        </article>
        </c:forEach>
        </c:if>


      </div>
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
            <span class="find-more">모두 보기</span>
          </div>
          <ul class="recommend-list">
            <li>
              <div class="recommend-friend-profile">
                <img class="img-profile" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="renebaebae님의 프로필 사진">
                <div class="profile-text">
                  <span class="userID point-span">renebaebae</span>
                  <span class="sub-span">hi_sseulgi님 외 2명이 팔로우합니다</span>
                </div>
              </div>
              <span class="btn-follow">팔로우</span>
            </li>
            <li>
              <div class="recommend-friend-profile">
                <img class="img-profile" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="_jeongjaehyun님의 프로필 사진">
                <div class="profile-text">
                  <span class="userID point-span">_jeongjaehyun</span>
                  <span class="sub-span">johnnyjsuh님이 팔로우합니다</span>  
                </div>
              </div>
              <span class="btn-follow">팔로우</span>
            </li>
            <li>
              <div class="recommend-friend-profile">
                <img class="img-profile" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="leehi_hi님의 프로필 사진">
                <div class="profile-text">
                  <span class="userID point-span">leehi_hi</span>
                  <span class="sub-span">jennierubyjane님 외 5명이 팔로우합...</span>  
                </div>
              </div>
              <span class="btn-follow">팔로우</span>
            </li>
          </ul>
        </div>


      </div>
    </main>
    
    <main>
    <div class="feeds">
    <article>
    <table>
    <tr>
    <td>
              <img class="img-profile pic" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="writerProfile">
              <span class="userID main-id point-span">asdfasdfasdfasdf</span>
    </td>
    </tr>
    <tr>
    <td>
          <div class="main-image" id="slideShow">
          	<ul class="slide">
          	<li><img src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" class="mainPic"></li>
          	<li><img src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" class="mainPic"></li>
          	<li><img src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" class="mainPic"></li>
          	</ul>
            <p class="controller">
	            <span class="prev">&lang;</span> 
	            <span class="next">&rang;</span>
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
              <span>asdfsadfasf님 외 123123가 좋아합니다.</span>
    </td>
    </tr>
    <tr>
    <td width="550px" style="word-break:break-all">
              <span class="main-header-comment">
              dfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafddfasdfadfafsdadfafdadfadfadfafd
              </span>
    </td>
    </tr>
    <tr>
    <td>
              <span class="at-tag">
				@asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf @asdfasdf 
              </span>
    </td>
    </tr>
    <tr>
    <td>
            <div class="comment-section">
              <ul class="comments">
                <li>
                  <span><span class="point-span userID">postmalone</span>내가 입으면 더 잘어울릴 것 같아</span>
                  <img class="comment-heart" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="하트">
                </li>
                <!-- input 값 여기에 추가 -->
              </ul>
              <div class="time-log">
                <span>32분 전</span>
              </div>
            </div>
            <div class="comment-section">
              <ul class="comments">
                <li>
                  <span><span class="point-span userID">postmalone</span>내가 입으면 더 잘어울릴 것 같아</span>
                  <img class="comment-heart" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="하트">
                </li>
                <!-- input 값 여기에 추가 -->
              </ul>
              <div class="time-log">
                <span>32분 전</span>
              </div>
            </div>
            <div class="comment-section">
              <ul class="comments">
                <li>
                  <span><span class="point-span userID">postmalone</span>내가 입으면 더 잘어울릴 것 같아</span>
                  <img class="comment-heart" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="하트">
                </li>
                <!-- input 값 여기에 추가 -->
              </ul>
              <div class="time-log">
                <span>32분 전</span>
              </div>
            </div>            
    </td>
    </tr>   
    </table>
    </article>
    </div>
    </main>
<script>
const slides = document.querySelector('.slides'); //전체 슬라이드 컨테이너 
const slideImg = document.querySelectorAll('.slides li'); //모든 슬라이드들 
let currentIdx = 0; //현재 슬라이드 index 
const slideCount = slideImg.length; // 슬라이드 개수 
const prev = document.querySelector('.prev'); //이전 버튼 
const next = document.querySelector('.next'); //다음 버튼 
const slideWidth = 300; //한개의 슬라이드 넓이 
const slideMargin = 100; //슬라이드간의 margin 값 

//전체 슬라이드 컨테이너 넓이 설정 
slides.style.width = (slideWidth + slideMargin) * slideCount + 'px'; 

function moveSlide(num) { slides.style.left = -num * 400 + 'px'; currentIdx = num; } 

prev.addEventListener('click', function () { 
	/*첫 번째 슬라이드로 표시 됐을때는 이전 버튼 눌러도 아무런 반응 없게 하기 위해 currentIdx !==0일때만 moveSlide 함수 불러옴 */ 
	if (currentIdx !== 0) moveSlide(currentIdx - 1); 
	}); 
next.addEventListener('click', function () { 
		/* 마지막 슬라이드로 표시 됐을때는 다음 버튼 눌러도 아무런 반응 없게 하기 위해 currentIdx !==slideCount - 1 일때만 moveSlide 함수 불러옴 */ 
		if (currentIdx !== slideCount - 1) { 
			moveSlide(currentIdx + 1); 
			} 
		});

</script>
<style>
table {    
	width: 614px;
    margin-right: 34px;
    display: inline-block;}
table tr th{width: 614px;}
</style>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
