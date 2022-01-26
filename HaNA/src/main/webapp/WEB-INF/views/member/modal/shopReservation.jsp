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
					<br />
					<span>다음을 클릭해주세요</span>
					<br />
					<span>다음을 클릭해주세요</span>
					<br />
					<span>다음을 클릭해주세요</span>
					<br />
					<span>다음을 클릭해주세요</span>
					<br />
					<span>다음을 클릭해주세요</span>
					<br />
					<span>다음을 클릭해주세요</span>
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
					<h3 class="modal-title">예약일시 선택</h3>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">닫기</button>
				</div>
				<!-- 내용 -->
				<div class="modal-body">
					<input type="date" name="" id="" />
					<select name="time-hour" id="time-hour">
						<option value="" disabled selected>시간 선택</option>
						
					</select>
					<select name="time-minutes" id="time-minutes">
						<option value="" disabled selected>분 선택</option>
					</select>
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
						<option value="" disabled selected>테이블 선택</option>
						
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
					<input type="text" name="" id="" />
					<input type="text" name="" id="" />
					<input type="text" name="" id="" />
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
			$(nextModal).modal({backdrop:'static', keyboard:false});
		});
		/* 이전 버튼 */
		$(".prevBtn").click((e) => {
			let curModal = `#modal\${$(e.target).data('num')}`;
			let prevModal = `#modal\${$(e.target).data('num')-1}`;
			
			e.preventDefault();
			$(prevModal).css('display', 'block');
			$(curModal).modal('hide');
		})
		/* x버튼 클릭 시에만 모달 닫히게 */
		$(".close").click((e) => {
			$(".modal.fade").modal("hide");
		});
		
		/* 예약 등록하기 */
		$(".submitBtn").click((e) => {
			$(".modal.fade").modal("hide");
		});
	</script>