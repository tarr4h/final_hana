<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<sec:authentication property="principal" var="loginMember"/>

	<!-- Modal1-->
	<div class="modal fade" id="modal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<h3 class="modal-title">예약하기</h3>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">
							닫기
						</button>
				</div>
				<!-- 내용 -->
				<div class="modal-body">
					${shopInfo.shopIntroduce }
				</div>
				<!-- footer -->
				<div class="modal-footer">
					<a class="btn nextBtn" data-num="1" href="#">다음</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal2 : 예약일시 선택 -->
	<div class="modal fade" id="modal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<h3 class="modal-title">예약일 선택</h3>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">닫기</button>
				</div>
				<!-- 내용 -->
				<div class="modal-body">
					<input type="date" name="reservationDate" id="" />

				</div>
				<!-- footer -->
				<div class="modal-footer">
					<a class="btn prevBtn" data-num="2" href="#">이전</a>
					<a class="btn nextBtn" data-num="2" href="#">다음</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal3 : 예약테이블 선택 -->
	<div class="modal fade" id="modal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<h3 class="modal-title">테이블 선택</h3>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">닫기</button>
				</div>
				<!-- 내용 -->
				<div class="modal-body">
					<table id="table-select">
						<tbody></tbody>
					</table>
				</div>
				<!-- footer -->
				<div class="modal-footer">
					<a class="btn prevBtn" data-num="3" href="#">이전</a>
					<a class="btn nextBtn" data-num="3" href="#">다음</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal4 : 예약시간 선택 -->
	<div class="modal fade" id="modal4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<h3 class="modal-title">예약시간 설정</h3>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">닫기</button>
				</div>
				<!-- 내용 -->
				<div class="modal-body">
					<table id="time-select">
						<thead>
							<tr>
								<th>선택</th>
								<th>시작시간</th>
								<th>종료시간</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<!-- footer -->
				<div class="modal-footer">
					<a class="btn prevBtn" data-num="4" href="#">이전</a>
					<a class="btn nextBtn" data-num="4" href="#">다음</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal5 : 방문자 수, 예약 요청 입력 -->
	<div class="modal fade" id="modal5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<h3 class="modal-title">방문자 수, 요청사항 입력</h3>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">닫기</button>
				</div>
				<!-- 내용 -->
				<div class="modal-body">
					<label for="visitors">방문 인원 수</label>
					<input type="number" name="visitors" id="" min="1" max="10" />
					<br />
					<label for="req_order">요청사항 입력</label>
					<textarea name="req_order" id="" cols="30" rows="5" placeholder="예약 시 필요한 내용을 적어주세요."></textarea>
				</div>
				<!-- footer -->
				<div class="modal-footer">
					<a class="btn prevBtn" data-num="5" href="#">이전</a>
					<a class="btn submitBtn" data-num="5" href="#">완료</a>
				</div>
			</div>
		</div>
	</div>
	
	

	<!-- 관련 스크립트 -->
	<script>	
		/* 예약버튼 클릭 */
		$('#reservationBtn').click(function(e){
			e.preventDefault();
			$('#modal1').modal({backdrop:'static', keyboard:false});
			
		});									
		/* 다음 버튼 */
		$(".nextBtn").click((e) => {			
			let curModal = `#modal\${$(e.target).data('num')}`;										
			let nextModal = `#modal\${$(e.target).data('num')+1}`;
			if(curModal == '#modal1'){
				e.preventDefault();
				$(curModal).css('display', 'none');
				$(curModal).modal('hide');
				$(nextModal).modal({backdrop:'static', keyboard:false});
			}
			
			if(curModal == '#modal2'){
				let selectDate = $(curModal).find("[name=reservationDate]").val();
				let selDate = new Date(selectDate);
				let nowDate = new Date();
				
				let bool = selDate.getMonth() == nowDate.getMonth() && selDate.getDate() == nowDate.getDate();
				
				if($(curModal).find("[name=reservationDate]").val() == ''){
					alert("날짜를 선택해주세요");
					$(curModal).find("[name=reservationDate]").focus();
				} else if(selDate < nowDate && !bool) {
					alert("오늘 이전은 선택할 수 없습니다.");
					$(curModal).find("[name=reservationDate]").focus();
				} else{
					e.preventDefault();
					$(curModal).css('display', 'none');
					$(curModal).modal('hide');
					$(nextModal).modal({backdrop:'static', keyboard:false});		
				}
				
			} else if(curModal == '#modal3'){
				if($('[name=tb-select]:checked').val() == null){
					alert('테이블을 선택해주세요');
				} else{
					e.preventDefault();
					$(curModal).css('display', 'none');
					$(curModal).modal('hide');
					$(nextModal).modal({backdrop:'static', keyboard:false});
				}
			} else if(curModal == '#modal4'){
				if($('[name=time-select]:checked').val() == null){
					alert('예약시간을 선택해주세요');
				} else{
					e.preventDefault();
					$(curModal).css('display', 'none');
					$(curModal).modal('hide');
					$(nextModal).modal({backdrop:'static', keyboard:false});
				}
			}
			
			
		});
		/* 이전 버튼 */
		$(".prevBtn").click((e) => {
			let curModal = `#modal\${$(e.target).data('num')}`;
			let prevModal = `#modal\${$(e.target).data('num')-1}`;
			e.preventDefault();
			$(prevModal).css('display', 'block');
			$(prevModal).modal('show');
			$(curModal).modal('hide');
		})
		/* x버튼 클릭 시에만 모달 닫히게 */
		$(".close").click((e) => {
			/* $(".modal.fade").modal("hide"); */
			window.location.reload();
		});
		
		/* 예약 등록하기 클릭 */
		$(".submitBtn").click((e) => {
			let tableId = $("[name=tb-select]:checked").data('table-id');
			let allowVisitor = `#allowVisitor\${tableId}`;
			let allowValue = $(`\${allowVisitor}`).val();			
			
			let intAllowValue = allowValue * 1;
			let intAllowVisitors = $("[name=visitors]").val() * 1;
			
			if(confirm("예약 등록하시겠습니까?")){
				if(intAllowValue < intAllowVisitors){
					alert(`최대 예약 가능 인원은 \${intAllowValue}명 입니다.`);
					$("[name=visitors]").focus();
				} else{
					submitRequest();
				}
			}
			/* $(".modal.fade").modal("hide"); */
		});
		
		/* 모달 이동 시 제어 onload  */
		$(() => {
			/* show modal on event */
			$(".modal").on('show.bs.modal', function(e){				
				let modalId = $(e.target).prop('id');
				if(modalId == 'modal3'){
					tableModal();
				}
				if(modalId == 'modal4'){
					timeModal();						
				}
			});
			
			/* hide modal on event */
			$(".modal").on('hidden.bs.modal', function(e){
				/* console.log($(e.target).find('h3').text()); */
			})
		});
		
		/* 테이블 선택 func */
		function tableModal(){
			$.ajax({
				url: '${pageContext.request.contextPath}/shop/loadShopTable',
				data: {
					id: '${shopInfo.id}'
				},
				success(res){					
					let tbody = $("#table-select tbody");
					let th = `
						<tr>
							<th>선택</th>
							<th>테이블명</th>
							<th>최대인원</th>
							<th>운영시간</th>
							<th>특이사항</th>
						</tr>
					`;
					
					/* if(tbody.text() == ""){ */
						tbody.empty();
						tbody.append(th);
						$.each(res, (i, e) => {
							if(e.enable == 'Y'){
								let tr = `
									<tr>
										<td>
											<input type="radio" name="tb-select" data-table-id="\${e.tableId}"/>
										</td>
										<td>
											\${e.tableName}
										</td>
										<td>
											\${e.allowVisitor}
											<input type="hidden" id="allowVisitor\${e.tableId}" value="\${e.allowVisitor}"/>
										</td>
										<td>
											\${e.allowStart} ~ \${e.allowEnd}
										</td>
										<td>
											\${e.memo}
										</td>
									</tr>
								`;
								tbody.append(tr);								
							}
						});
					/* } */
				},
				error:console.log
			});
		};
		
		/* 시간선택 Modal  */
		function timeModal(){
			let tableId = $("[name=tb-select]:checked").data('table-id');
			let resDate = $("[name=reservationDate]").val();
			console.log(resDate);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/shop/selectOneTable/getReservationTime',
				data:{
					tableId: tableId,
					date: resDate
				},
				success(res){				
					$("#time-select tbody").empty();
/* 					if($("#time-select tbody").text() == ""){ */
						$.each(res, (i, e) => {
							let status = e.status;
							let disabled = 'disabled';
							if(e.status == null){
								status = '';
								disabled = '';
							}
							let tr = `
								<tr>
									<td>
										<input type="radio" name="time-select" \${disabled}/>
									</td>
									<td>\${e.startTime}</td>
									<td>\${e.endTime}</td>
									<td>\${status}</td>
								</tr>
							`;
							$("#time-select tbody").append(tr);
						})						
/* 					} */
				},
				error:console.log
			});
		};
		
		function submitRequest(){
			let userId_ = '${loginMember.id}';
			
			let reservationDate_ = $("[name=reservationDate]").val();
			
			let tableId_ = $("[name=tb-select]:checked").data('table-id');
			
			let startTime_ = $("[name=time-select]:checked").parent().next().text();
			let endTime_ = $("[name=time-select]:checked").parent().next().next().text();
			
			let visitors_ = $("[name=visitors]").val();
			let reqOrder_ = $("[name=req_order]").val();
			
			let allowVisitor = $(`#allowVisitor\${tableId_}`).val();
			
			let data = {
					reservationUser: userId_,
					reservationTableId: tableId_,
					reservationDate: reservationDate_,
					shopId: '${shopInfo.id}',
					timeStart: startTime_,
					timeEnd: endTime_,
					visitorCount: visitors_,
					reqOrder: reqOrder_
			};
			
			let jsonData = JSON.stringify(data);
			console.log(jsonData);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/shop/reservation/insert?${_csrf.parameterName}=${_csrf.token}',
				method: 'POST',
				data: jsonData,
				contentType: "application/json; charset=utf-8",
				success(res){
					alert(res);
				},
				complete(){
					window.location.reload();
				},
				error: console.log
			})
		}
	</script>