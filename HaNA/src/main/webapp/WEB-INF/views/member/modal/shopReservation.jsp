<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>

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
					<select name="table-select" id="table-select">

					</select>
				</div>
				<!-- footer -->
				<div class="modal-footer">
					<a class="btn prevBtn" data-num="3" href="#">이전</a>
					<a class="btn nextBtn" data-num="3" href="#">다음</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal4 : 세부설정 -->
	<div class="modal fade" id="modal4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<h3 class="modal-title">세부예약 설정</h3>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">닫기</button>
				</div>
				<!-- 내용 -->
				<div class="modal-body">
					<%-- <form:form name="testFrm" action="${pageContext.request.contextPath }/member/testModal" method="POST" enctype="multipart/form-data">
						<input type="text" name="username" id="" />
						<input type="file" name="upFile" id="" />
						<input type="submit" id="testBtn" value="제출" />
					</form:form> --%>
				</div>
				<!-- footer -->
				<div class="modal-footer">
					<a class="btn prevBtn" data-num="4" href="#">이전</a>
					<a class="btn submitBtn" data-num="4" href="#">완료</a>
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
			e.preventDefault();
			$(curModal).css('display', 'none');
			$(curModal).modal('hide');
			$(nextModal).modal({backdrop:'static', keyboard:false});
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
			$(".modal.fade").modal("hide");
		});
		
		/* 예약 등록하기 클릭 */
		$(".submitBtn").click((e) => {
			$(".modal.fade").modal("hide");
			console.log($("[name=table-select]").val(''));
		});
		
		/* 모달 이동 시 제어 onload  */
		$(() => {
			/* show modal on event */
			$(".modal").on('show.bs.modal', function(e){
				console.log($(e.target).prop('id'), '열림');
				
				let modalId = $(e.target).prop('id');
				if(modalId == 'modal3'){
					tableModal();
				}
			});
			
			/* hide modal on event */
			$(".modal").on('hidden.bs.modal', function(e){
				console.log($(e.target).prop('id'), '닫힘');
				/* console.log($(e.target).find('h3').text()); */
			})
		});
		
		function tableModal(){
			$.ajax({
				url: '${pageContext.request.contextPath}/shop/loadShopTable',
				data: {
					id: '${shopInfo.id}'
				},
				success(res){					
					let tableSelect = $("[name=table-select]");
					let defaultOption = `<option value="" disabled selected>테이블 선택</option>`;
					
					tableSelect.empty();					
					tableSelect.append(defaultOption);
					
					$.each(res, (i, e) => {				
						let option = `
							<option value="\${e.tableId}">\${e.tableName}</option>
						`;
						$tableSelect.append(option);
					});
					
				},
				error:console.log
			});
		}
	</script>