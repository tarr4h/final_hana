<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="마이페이지" name="title"/>
</jsp:include>
 
<sec:authentication property="principal" var="loginMember"/>
<script>
function goSetting(){
	location.href = "${pageContext.request.contextPath}/member/memberSetting/memberSetting";
}
</script>
			

<style>
	#myInfo{
		border: 1px solid black;
	}
	#profileImg{
		height: 400px;
	}
	#profileStatus{
		height: 400px;
	}
	#settingBtn {
		float: right;
		height:50px;
		width: 50px;
		border-radius: 100%;
	}
	
	/* 프로필이미지 */
	.profileImg.d-flex{
		width:230px;
		height:230px;
		border:1px solid black;
		border-radius:100%;
		background-color: red;
	}
	.profileImg img {
		width: 100%;
		border-radius: 100%;
	}
	.profileBtn{
		border: 1px solid black;
		width: 50px;
		height: 50px;
		border-radius:100%;
		transform: translateX(80px) translateY(-50px);
		z-index: 1;
		background-color: yellow;
	}

	/* 프로필정보 */
	.follow {
		display: inline-block;
		width: 100px;
		height: 30px;
		border: 1px solid black;
	}
	.followCount{
		display: inline-block;
		width: 100px;
		height: 30px;
		border: 1px solid black;
	}
	#profileTable{
		width: 100%;
		table-layout:fixed;
	}
	.tableKey{
		width: 20%;
	}
	.tableValue{
		width: 80%;
	}
	pre{
		margin:0;
	}
	#textArea{
		width: 100%;
		height: 150px;
		border: none;
		resize: none;
		background-color: white;
		padding-top: 30px;
		font-size:16px;
	}
	
	/* thumbnail list */
	.thumbnail{
		height: 300px;
		border: 1px solid black;
		padding: 5px;
	}
	.thumbnail img{
		width: 100%;
	}

</style>

<div class="container mt-2">
    <div class="row" id="myInfo">
    	<!-- 프로필이미지 영역 -->
        <div class="col-sm-5 d-flex justify-content-center align-items-center flex-column" id="profileImg">
        	<div class="profileImg d-flex">
        		<!-- 이미지를 넣으세요 -->
        		<img src="${pageContext.request.contextPath}/resources/images/duck.png" alt=""/>
        	</div>
        	<div class="profileBtn">
        		<!-- (+)버튼을 이미지로 넣고, 클릭 시 변경 이벤트 걸기 -->
        		<img src="" alt="" />
        	</div>
        </div>

        <!-- 프로필 세부정보 영역 -->
        <div class="col-sm-7" id="profileStatus">
        	<div class="follow">팔로잉 :</div>
        	<div class="followCount">1234명</div>
        	<div class="follow">팔로워 :</div>
        	<div class="followCount">389명</div>
        	<!-- 설정버튼 : 본인계정일땐 설정, 아닐땐 친구추가 버튼 -->
        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="goSetting();">설정</button>
        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="">친구추가</button>
        	
            <br />
            
            <div class="profileTableArea">
				<table id="profileTable">
					<tbody>
						<tr>
							<td class="tableKey">아이디</td>
							<td class="tableValue">${loginMember.id }</td>
						</tr>
						<tr>
							<td><span class="tableKey">성격</span></td>
							<td>${loginMember.personality }</td>
						</tr>
						<tr>
							<td><span class="tableKey">관심</span></td>
							<td>${loginMember.interest }</td>
						</tr>
						<tr>
							<td><span class="tableKey">지역</span></td>
							<td>asdfsdlif</td>
						</tr>
						<tr>
							<td><span class="tableKey">취미</span></td>
							<td>낚시</td>
						</tr>
						<tr>
							<td rowspan=2><span class="tableKey">소개</span></td>
							<td class="tableValue" rowspan=2>
								<pre><textarea id="textArea" readonly disabled>가나다라마바사 asdfsadf\\nabcdefg
									123456</textarea></pre>
							</td>
						</tr>
						<tr>
							
						</tr>
					</tbody>
				</table>
			</div>
        	<button style="float:right;">글쓰기버튼</button>
        </div>
	</div> 
       
    <div class="row">   
        <!-- 탭 영역 -->
        <div class="col-sm-12 d-flex justify-content-center align-items-center" id="tab">
        	<input type="button" class="m-3" value="버튼1" />
        	<input type="button" class="m-3" value="버튼2" />
        	<input type="button" class="m-3" value="버튼3" />
        </div>
    </div>
        
    <div class="row">    
        <!-- thumbnail 1st line -->
        <div class="thumbnail col-sm-4 ">
        	<img src="${pageContext.request.contextPath}/resources/images/duck.png" alt=""/>
        </div>
        <div class="thumbnail col-sm-4">
        	<img src="${pageContext.request.contextPath}/resources/images/duck.png" alt=""/>
        </div>
        <div class="thumbnail col-sm-4">
        </div>
        
        <!-- thumbnail 2nd line  -->
        <div class="thumbnail col-sm-4">
        </div>
        <div class="thumbnail col-sm-4">
        </div>
        <div class="thumbnail col-sm-4">
        </div>
        
        <!-- thumbnail 3rd line -->
        <div class="thumbnail col-sm-4">
        </div>
        <div class="thumbnail col-sm-4">
        </div>
        <div class="thumbnail col-sm-4">
        </div>
    </div>
</div>
        
        
        
        
        

<a href="/" class="badge badge-dark">Dark</a>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>