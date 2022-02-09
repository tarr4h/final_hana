<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<sec:authentication property="principal" var="loginMember"/>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<div class="modal fade" id="resPurchaseModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<!-- header -->
			<div class="modal-header">
				<h3 class="modal-title">예약 상세보기</h3>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						닫기
					</button>
			</div>
			<!-- 내용 -->
			<div class="modal-body">
				<h3>금액 결제 완료 시 예약이 확정됩니다.</h3>
				<div class="purchaseAll">
					<span>전체금액 한번에 결제하기</span>
					<input type="button" value="선택" id="req-pay-All" onclick="resAll();"/>
				</div>
				<div class="dutchpay">
					<span>공유인원에게 더치페이 요청하기</span>
					<input type="button" value="선택" id="req-pay-Each" onclick="requestDutchpay();"/>
				</div>
				<input type="hidden" name="req-pay-rs-no" />
			</div>
			<!-- footer -->
			<div class="modal-footer">

			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="resPurchaseModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<!-- header -->
			<div class="modal-header">
				<h3 class="modal-title">결제하기</h3>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						닫기
					</button>
			</div>
			<!-- 내용 -->
			<div class="modal-body">
				<h3>더치페이 요청입니다.</h3>								
				<input type="button" value="결제하기" onclick="resDutchpay();"/>
			</div>
			<!-- footer -->
			<div class="modal-footer">

			</div>
		</div>
	</div>
</div>


<script>
function purchaseModal(reservationNo, reservationUser, reqDutchpay){
	if('${loginMember.id}' == reservationUser && reqDutchpay == 'N'){
		$("[name=req-pay-rs-no]").val(reservationNo);
		$('#resPurchaseModal1').modal({backdrop:'static', keyboard:false});
	} else if(reqDutchpay == 'Y'){
		$("[name=req-pay-rs-no]").val(reservationNo);
		$('#resPurchaseModal2').modal({backdrop:'static', keyboard:false});
	};
};

/* 더치페이 요청보내기 */
function requestDutchpay(){
	let resNo = $("[name=req-pay-rs-no]").val();
	$.ajax({
		url: '${pageContext.request.contextPath}/shop/updateReqDutchpay',
		method: 'POST',
		data:{
			reservationNo: resNo,
			status: 'Y'
		},
		success(res){
			console.log(res);			
		},
		error: console.log
	});
};

/* 더치페이 결제*/
function resDutchpay(){
	console.log($("[name=req-pay-rs-no]").val());
	$.ajax({
		url: '${pageContext.request.contextPath}/shop/selectPriceAndVisitors',
		data:{
			reservationNo : $("[name=req-pay-rs-no]").val()
		},
		success(res){
			console.log(res);
			let myPrice;
 			let name;
			let id;
			let address;
			let reservationNo = $("[name=req-pay-rs-no]").val();
			let purchaseType = 'dutch';
			$.each(res, (i, e) => {
				if('${loginMember.id}' == e.ATTEND_USER){
					name = e.NAME;
					id = e.ID;
					address = e.ADDRESS_ALL;
					myPrice = e.ORIGINALPRICE / res.length;
				};
			});
			requestPay(myPrice, name, id, address, reservationNo, purchaseType);
		},
		error:console.log
	})
};

/* 단일 결제 */
function resAll(){
	$.ajax({
		url: '${pageContext.request.contextPath}/shop/selectPriceAndMember',
		data:{
			reservationNo : $("[name=req-pay-rs-no]").val(),
			id : '${loginMember.id}'
		},
		success(res){
			console.log(res);
			let myPrice = res.ORIGINALPRICE;
 			let name = res.NAME;
			let id = res.ID;
			let address = res.ADDRESS_ALL;
			let reservationNo = $("[name=req-pay-rs-no]").val();
			let purchaseType = 'all';
			
			requestPay(myPrice, name, id, address, reservationNo, purchaseType);
		},
		error:console.log
	})
};

//카카오페이 연동
var IMP = window.IMP; 
IMP.init("imp00307901");

function requestPay(price, name, id, address, reservationNo, purchaseType) {
	const date = new Date();
	let day = String(date.getDate());
	let hours = String(date.getHours());
	let minute = String(date.getMinutes());
	let second = String(date.getSeconds());
	
	const totalPrice = price;
	
    // IMP.request_pay(param, callback) 결제창 호출
    IMP.request_pay({ // param
        pg: "kakaopay",
        pay_method: "kakaopay",
        merchant_uid: reservationNo + day+hours+minute+second,
        name: "예약금 결제",
        amount: totalPrice,
        buyer_email: id,
        buyer_name: name,
        buyer_tel: "abcd",
        buyer_addr: address,
        buyer_postcode: "010101"
    }, function (rsp) { // callback
        if (rsp.success) {
        	const impUid = rsp.imp_uid;
        	const merchantUid = rsp.merchant_uid;
        	let amount = totalPrice;
        	$.ajax({
        		url: "${pageContext.request.contextPath}/purchase/payments",
        		method: "POST",
        		dataType: "json",
        		data: {
        			impUid,
            		merchantUid,
            		amountToBePaid: amount
        		},
        		success(data){
        			alert(data.msg);
        			addPurchaseHistory(id, impUid, merchantUid, amount);
        			/* 결제후 처리 */
        			if(purchaseType == 'dutch'){
        				purchaseAsDutchpay(reservationNo, id, amount);
        			} else if(purchaseType == 'all'){
        				purchaseAll(reservationNo, amount);
        			}
        		},
        		error : console.log
        	});
        } else {
            alert("결제 실패")
            // 결제 실패 시 로직, 
        }
    });
  }
  
function addPurchaseHistory(id, impUid, merchantUid, amount){
	let dataObj = {
			"id" : id,
			"uid" : impUid,
			"merchantUid" : merchantUid,
			"amount" : amount
	};	
	let dataStr = JSON.stringify(dataObj);

	
	$.ajax({
		url: '${pageContext.request.contextPath}/shop/insertPurchaseHistory?${_csrf.parameterName}=${_csrf.token}',
		method: 'POST',
		data: dataStr,
		contentType: "application/json; charset=utf-8",
		success(res){
			console.log(res);
			if(res == 1){
				console.log("결제 내역 등록됨");
			}
		},
		error:console.log
	});
};

function purchaseAsDutchpay(reservationNo, id, amount){
	let dataObj = {
			"reservationNo" : reservationNo,
			"id" : id,
			"amount" : amount
	};
	let dataStr = JSON.stringify(dataObj);
	
	$.ajax({
		url: '${pageContext.request.contextPath}/shop/purchaseAsDutchpay?${_csrf.parameterName}=${_csrf.token}',
		method: 'POST',
		data: dataStr,
		contentType: "application/json; charset=utf-8",
		success(res){
			console.log(res);
		},
		error:console.log,
		complete: function(){
			location.reload();
		}
	})
};

function purchaseAll(reservationNo, amount){
	let dataObj = {
			"reservationNo" : reservationNo,
			"amount" : amount
	};
	let dataStr = JSON.stringify(dataObj);
	
	$.ajax({
		url: '${pageContext.request.contextPath}/shop/purchaseAll?${_csrf.parameterName}=${_csrf.token}',
		method: 'POST',
		data: dataStr,
		contentType: "application/json; charset=utf-8",
		success(res){
			console.log(res);
		},
		error:console.log,
		complete: function(){
			location.reload();
		}
	})
}
</script>