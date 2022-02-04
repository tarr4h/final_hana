<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<sec:authentication property="principal" var="loginMember"/>

<style>
	#reservationTable{
		border-collapse: collapse;
	}
	#reservationTable th{
		text-align: center;
		border: 1px solid black;
	}
	#reservationTable td{
		border: 1px solid black;
	}

</style>

	<div class="modal fade" id="listModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<h3 class="modal-title">예약 확인</h3>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">
							닫기
						</button>
				</div>
				<!-- 내용 -->
				<div class="modal-body">
					<!-- 총 예약건수 -->
					<div id="reservation-count-all">
						<span>총 예약 건 수 : </span>
						<span id="resCount"></span>
					</div>
					<!-- 일자별 예약리스트 -->
					<div id="reservation-list" style="max-height:300px;overflow:scroll">
						<table id="reservationTable">
							<thead>
								<tr>
									<th colspan="2">
										<input type="button" value="&lt;" class="res-dateBtn" id="res-prevDate" data-res-date="a"/>
									</th>
									<th colspan="4" id="res-today"></th>
									<th colspan="2">
										<input type="button" value="&gt;" class="res-dateBtn" id="res-nextDate" data-res-date="b"/>
									</th>
								</tr>
								<tr>
									<th>예약일</th>
									<th>예약자</th>
									<th>예약테이블</th>
									<th>예약시작</th>
									<th>예약종료</th>
									<th>방문자 수</th>
									<th>예약요청</th>
									<th>예약상태</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
					
				</div>
				<!-- footer -->
				<div class="modal-footer">
					<a class="btn nextBtn" data-num="1" href="#">다음</a>
				</div>
			</div>
		</div>
	</div>
	

<script>
	
	$(() => {
		shopReservationCount();
		setDate();
		console.log($("#res-today").text());
		shopReservationListByDate($("#res-today").text());
	});
	
	/* 예약확인 클릭 시 modal 노출 */
	$("#reservationListBtn").click((e) => {
		$("#listModal1").modal({backdrop:'static', keyboard:false});
	});
	
	$(".res-dateBtn").click((e) => {
		let targetDate = $(e.target).data('res-date');
		console.log(targetDate);
		shopReservationListByDate(targetDate);
		$("#res-today").text(targetDate);
	});
	
	function setDate(){
		const today = new Date();
		let year = today.getFullYear();
		let month = today.getMonth()+1;
		let date = today.getDate();
		
		$("#res-today").text(`\${year}-\${month}-\${date}`);
		$("#res-prevDate").data('res-date', `\${year}-\${month}-\${date-1}`);
		$("#res-nextDate").data('res-date', `\${year}-\${month}-\${date+1}`);
	}
	
	function shopReservationCount(){
		$.ajax({
			url: '${pageContext.request.contextPath}/shop/shopReservationCount',
			data:{
				shopId: '${loginMember.id}'
			},
			success(res){
				$("#resCount").text(res);
			},
			error: console.log
		})
	};
	
	function shopReservationListByDate(date){
		$.ajax({
			url: '${pageContext.request.contextPath}/shop/selectShopReservationListByDate',
			data:{
				shopId: '${loginMember.id}',
				date
			},
			success(res){
				$("#reservationTable tbody").empty();
				console.log(res);
				$.each(res, (i, e) => {
					let convertDate = new Date(e.reservationDate);
					let tr = `
						<tr>
							<td>
								\${convertDate.getFullYear()}년 \${convertDate.getMonth()}월 \${convertDate.getDate()}일
							</td>
							<td>
								\${e.reservationUser}
							</td>
							<td>
								\${e.reservationTableId}
							</td>
							<td>
								\${e.timeStart}
							</td>
							<td>
								\${e.timeEnd}
							</td>
							<td>
								\${e.visitorCount}
							</td>
							<td>
								\${e.reqOrder}
							</td>
							<td>
								\${e.reservationStatus}
							</td>
						</tr>
					`;
					$("#reservationTable tbody").append(tr);
				});
			},
			error: console.log
		});
	};
</script>



