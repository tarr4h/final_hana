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

<div class="modal fade" id="resPurchaseModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
				</div>
				<div class="dutchpay">
					<span>공유인원에게 더치페이 요청하기</span>
				</div>
				<input type="button" value="결제하기" onclick="requestPay();"/>
			</div>
			<!-- footer -->
			<div class="modal-footer">

			</div>
		</div>
	</div>
</div>



<script>
function purchaseModal(){
	$('#resPurchaseModal').modal({backdrop:'static', keyboard:false});
}

//카카오페이 연동
var IMP = window.IMP; 
IMP.init("imp00307901");

function requestPay() {
	const date = new Date();
	let day = String(date.getDate());
	let hours = String(date.getHours());
	let minute = String(date.getMinutes());
	let second = String(date.getSeconds());
	
	const totalPrice = 50000;
	
    // IMP.request_pay(param, callback) 결제창 호출
    IMP.request_pay({ // param
        pg: "kakaopay",
        pay_method: "card",
        merchant_uid: "abcd" + day+hours+minute+second,
        name: "geverytime결제",
        amount: totalPrice,
        buyer_email: "abcd",
        buyer_name: "abcd",
        buyer_tel: "abcd",
        buyer_addr: "abcd",
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
        			console.log(data.msg);
        			alert("결제 성공");
        			var msg = data.msg;
                	msg += "\n구매자 : " + "abcd";
                	msg += "고유ID : " + rsp.imp_uid;
                	msg += "상점 거래 ID : " + rsp.merchant_uid;
                	msg += "결제 금액 : " + rsp.paid_amount;

        		},
        		error : console.log
        	});
        } else {
            alert("결제 실패")
            // 결제 실패 시 로직, 
        }
    });
  }
</script>