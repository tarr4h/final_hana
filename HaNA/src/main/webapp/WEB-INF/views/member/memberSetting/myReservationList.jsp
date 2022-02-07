<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="설정화면" name="memberSetting/"/>
</jsp:include>
<style>
	#myReservationTable {
		border: 1px solid black;
		border-collapse: collapse;
	}	
	#myReservationTable th{
		border: 1px solid black;
	}	
	#myReservationTable td{
		border: 1px solid black;
	}	
</style>
<section>
<sec:authentication property="principal" var="loginMember"/>

<c:if test="${not empty msg}">
	<script>
		$(() => {
			alert("${msg}");
		})
	</script>	
</c:if>



<br><br><br> 
<div class="container">
    <div class="row">
    	<!-- 메뉴 영역 -->
        <div class="col-sm-4">
        	<ul class="list-group">
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/memberSetting/memberSetting'">프로필 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/memberSetting/updatePassword'">비밀번호 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/ '">계정 공개</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/ ">정보 공개</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/myReservationList'">내 예약내역</li>
			</ul>
        </div>
        <div class="col-sm-8">
        	<div class="myResHeader">
				<h1>나의 예약내역</h1>
			</div>
			<div class="myResCalendarArea">
				<input type="button" value="캘린더" id="myResCalendarBtn"/>
				<div class="myResCalendar" style="display:none;position:absolute;z-index:1;background-color:#f3f3f3;">
					<jsp:include page="/WEB-INF/views/member/calendar/calendar.jsp"></jsp:include>
				</div>
			</div>
			
		    <div class="row">   
		        <!-- 탭 영역 -->
		        <div class="col-sm-12 nav nav-pills nav-fill" id="tab">   	
				  <div class="col-sm-6 nav-item d-flex justify-content-center align-items-center">
				    <a class="nav-link active" href="#" id="presentList">예약 내역</a>
				  </div>
				  <div class="col-sm-6 nav-item d-flex justify-content-center align-items-center">
				    <a class="nav-link" href="#" id="pastList">지난 내역</a>
				  </div>
		        </div>
		    </div>
			
			<div class="myResListArea">
				<table id="myReservationTable">
					<thead>
						<tr>
							<th></th>
						</tr>
						<tr>
							<th>예약일</th>
							<th>업체</th>
							<th>시간</th>
							<th>인원</th>
							<th>공유하기</th>
							<th>취소하기</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<jsp:include page="/WEB-INF/views/member/modal/reservationShare.jsp"></jsp:include>
				<div class="pageBar"></div>
			</div>
        </div>
    </div>
</div>

<script>
	$(() => {
		myPresentReservation(1);
	});
	/* calendar 노출 event */
	$("#myResCalendarBtn").click((e) => {
		$(".myResCalendar").toggle();
	});
	
	/* 일자별 list 불러오기 func */
	function setDate(e){
		console.log($("#resYear").val(), $("#resMonth").val(), e);
		$("#selectDate").val(e);
		$(".dateBtn").css('background-color', '#ffffff');
		$(`#dateBtn\${e}`).css('background-color', 'green');
	}
	
	/* 예약내역/지난내역 tab별 노출 list func */
	$("#presentList").click((e) => {
		myPresentReservation(1);
		$(e.target).addClass("active");
		$("#pastList").removeClass("active");
	});
	$("#pastList").click((e) => {
		myPastReservation(1);
		$(e.target).addClass("active");
		$("#presentList").removeClass("active");
	});
	
	/* 현재 이후 일자별 예약 내역 ajax */
	function myPresentReservation(cPage){
		$.ajax({
			url: '${pageContext.request.contextPath}/shop/myReservation',
 			data:{
 				state: '1',
				func: 'myPresentReservation',
				cPage
			},
			success(res){
				$("#myReservationTable tbody").empty();
				$(".pageBar").text('');
				$.each(res.myList, (i, e) => {
					let resDate = new Date(e.reservationDate);
					let tr = `
						<tr>
							<td>\${resDate.getFullYear()}-\${resDate.getMonth()+1}-\${resDate.getDate()}</td>
							<td>\${e.shopId}</td>
							<td>\${e.timeStart} ~ \${e.timeEnd}</td>
							<td>\${e.visitorCount}명</td>
							<td>
								<input type="button" value="공유하기" class="shareResBtn" data-rs-no="\${e.reservationNo}" onclick="shareReservationModal('\${e.reservationNo}');"/>
							</td>
							<td>
								<input type="button" value="취소하기" class="cancleResBtn" data-rs-no="\${e.reservationNo}" onclick="cancleReservationModal('\${e.reservationNo}');"/>
							</td>
						</tr>
					`;
					$("#myReservationTable tbody").append(tr);
					if(e.reservationUser != '${loginMember.id}'){
						$("#myReservationTable tbody").find(".cancleResBtn:last").prop('disabled', 'true');
						$("#myReservationTable tbody").find(".shareResBtn:last").prop('disabled', 'true');
					};
				});
				
				$(".pageBar").append(res.pageBar);
			},
			error: console.log
		});

	};
	
	/* 과거내역 */
	function myPastReservation(cPage){
		$.ajax({
			url: '${pageContext.request.contextPath}/shop/myReservation',
 			data:{
 				state: '0',
				func: 'myPastReservation',
				cPage
			},
			success(res){
				$("#myReservationTable tbody").empty();
				$(".pageBar").text('');
				$.each(res.myList, (i, e) => {
					let resDate = new Date(e.reservationDate);
					let tr = `
						<tr>
							<td>\${resDate.getFullYear()}-\${resDate.getMonth()+1}-\${resDate.getDate()}</td>
							<td>\${e.shopId}</td>
							<td>\${e.timeStart} ~ \${e.timeEnd}</td>
							<td>\${e.visitorCount}명</td>
							<td>
								<input type="button" value="공유하기" class="shareResBtn" data-rs-no="\${e.reservationNo}" disabled/>
							</td>
							<td>
								<input type="button" value="취소하기" class="cancleResBtn" data-rs-no="\${e.reservationNo}" disabled/>
							</td>
						</tr>
					`;
					$("#myReservationTable tbody").append(tr);
				});
				$(".pageBar").append(res.pageBar);
			},
			error: console.log
		});
	};
	
	/* 예약 취소 : 본인에게만 취소 활성화 */
	function cancleReservation(reservationNo){
		console.log(reservationNo);
		if(!confirm('해당 예약을 삭제하시겠습니까?')){
			return false;
		}
		$.ajax({
			url: '${pageContext.request.contextPath}/shop/cancleReservation?${_csrf.parameterName}=${_csrf.token}',
			method: 'DELETE',
			data: reservationNo,
			success(res){
				console.log(res);
				if(res == 1){
					$(`.cancleResBtn[data-rs-no=\${reservationNo}]`).parent().parent().remove();
					alert("삭제되었습니다.");
				} else {
					alert("삭제에 실패했습니다.");
				}
			},
			error: console.log
		});
	};
	

</script>

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>