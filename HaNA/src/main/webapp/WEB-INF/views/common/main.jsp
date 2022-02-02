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
   <main>
      <div class="feeds">
<span>임시 메인 화면</span>
${groupboard}
        <!-- article -->
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
          <div class="main-image">
          	<c:forEach items="${groupboard.image}" var="images" varStatus="vs">
            <img src="${pageContext.request.contextPath }/resources/upload/group/board/${images}" class="mainPic">
          	</c:forEach>
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
            <div class="liked-people">
              <%-- <img class="pic" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="johnnyjsuh님의 프로필 사진"> --%>
              <p><span class="point-span">좋아요 부분</span>님 <span class="point-span">외 2,412,751명</span>이 좋아합니다</p>
            </div>
            
            <!-- 태그 -->
            <div class="description">
              <p>
              <span class="point-span userID">${groupboard.writer}</span>
              <span class="at-tag">
              <c:forEach items="${groupboard.tagMembers}" var="tagmembers" varStatus="vs">
              @${tagmembers}
              </c:forEach>
              </span>
              </p>
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
          </div>
          <div class="hl"></div>
          <div class="comment">
            <input id="input-comment" class="input-comment" type="text" placeholder="댓글 달기..." >
            <button type="submit" class="submit-comment" disabled>게시</button>
          </div>
        </article>
        </c:forEach>
        </c:if>
        
        <!-- 여기 게시글 반복문 추가 -->

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
        <!-- story section -->
<%--         <div class="section-story">
          <div class="menu-title">
            <span class="sub-title">스토리</span>
            <span class="find-more">모두 보기</span>
          </div>
          <ul class="story-list">
            <li>
              <div class="gradient-wrap">
                <img class="img-profile story" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="wecode_bootcamp님의 프로필 사진">
              </div>
              <div class="profile-text">
                <span class="userID point-span">wecode_bootcamp</span>
                <span class="sub-span">12분 전</span>  
              </div>
            </li>
            <li>
              <div class="gradient-wrap">
                <img class="img-profile story" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="han_ye_seul님의 프로필 사진">
              </div>
              <div class="profile-text">
                <span class="userID point-span">han_ye_seul</span>
                <span class="sub-span">28분 전</span>  
              </div>
            </li>
            <li>
              <div class="gradient-wrap">
                <img class="img-profile story" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="dntlrdl님의 프로필 사진">
              </div>
              <div class="profile-text">
                <span class="userID point-span">dntlrdl</span>
                <span class="sub-span">40분 전</span>  
              </div>
            </li>
            <li>
              <div class="gradient-wrap">
                <img class="img-profile story" src="${pageContext.request.contextPath }/resources/images/icons/eb13.jpg" alt="i_icaruswalks님의 프로필 사진">
              </div>
              <div class="profile-text">
                <span class="userID point-span">i_icaruswalks</span>
                <span class="sub-span">56분 전</span>  
              </div>
            </li>
          </ul>
        </div> --%>
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
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
