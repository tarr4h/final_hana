<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kh.hana.member.model.vo.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<!-- 가입신청리스트 모달 -->
<div class="modal fade" id="applyListModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 60%; width: auto;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">가입 승인 리스트</h4>
			</div>
			<div class="modal-body">
				<div class="applyListTableContainer">
					<table class="table" style="text-align: center;" name="modalTable">
						<thead class="table-light">
							<tr>
								<th>번호</th>
								<th>아이디</th>
								<th>가입신청내용</th>
								<th>날짜</th>
								<th>승인여부</th>
							</tr>
						</thead>
						<tbody id="modalTbody">
							<tr>
								<th colspan="5">가입신청이 없습니다.</th>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary">Save changes</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script>
function groupApplyHandlingFunc(e){
    console.log(e); // button객체    
    const $form = $(e).siblings("[name=groupApplyHandlingFrm]"); // 승인 및 거절 폼
    $form.children("[name=approvalYn]").val($(e).val()); // 승인/거절 폼 내 input:hidden("[name = approvalYn]")에 value값 넣어주기
    
/*     console.log($(e).siblings("[name=groupApplyHandlingFrm]").children("[name=no]").val());
    console.log($(e).siblings("[name=groupApplyHandlingFrm]").children("[name=approvalYn]").val()); */
    
 	 $.ajax({
		url:"${pageContext.request.contextPath}/group/groupApplyProccess",
		method:"POST",
		data: {
			no:$form.children("[name=no]").val(),
			groupId:$form.children("[name=groupId]").val(),
			memberId:$form.children("[name=memberId]").val(),
			approvalYn:$form.children("[name=approvalYn]").val()
		},
		success(data){
			console.log(data);
		},
		error(xhr, statusText, err){
			switch(xhr.status){
			default: console.log(xhr, statusText, err);
			}
			console.log
		}
	 })
     
}
//가입신청리스트
function enrollList(){
	 $.ajax({
	        url: "${pageContext.request.contextPath}/group/getGroupApplyRequest",
	        data: {
	            groupId : '${groupId}'
	        },
	        success(res){
	            console.log(res);
	            if(res.length!==0){
		            $("#modalTbody").empty();	            	
	            }
	            $.each(res, function(i, e) {	
	            	console.log(e.REG_DATE);
	            	const date = moment(e.REG_DATE).format("YYYY년 MM월 DD일");
	            	console.log(date);
	                let tr = `
	                    <tr>
	                        <td>
	                            \${e.NO}
	                        </td>
	                        <td>
	                            \${e.MEMBER_ID}
	                        </td>
	                        <td style="width:600px; padding-left:50px;padding-right:50px;">
	                            \${e.CONTENT}
	                        </td>
	                        <td>
	                            \${date}              
	                        </td>
	                        <td>
	                            <form:form name="groupApplyHandlingFrm">
	                                <input type="hidden" name="no" value="\${e.NO}"/>
	                                <input type="hidden" name="groupId" value="${group.groupId}"/>
	                                <input type="hidden" name="memberId" value="\${e.MEMBER_ID}"/>
	                                <input type="hidden" name="approvalYn" value=""/>
	                            </form:form>
	                            <button type="button" onclick="groupApplyHandlingFunc(this);"
	                                class="btn btn-default btn-sm btn-success"
	                                style="margin-right: 1%;" value="y">승인</button>
	                            <button type="button" onclick="groupApplyHandlingFunc(this);" class="btn btn-default btn-sm btn-danger" value="n">거절</button>
	                        </td>
	                    </tr>
	                `;
	                $("#modalTbody").append(tr);
	            })
				$("#applyListModal").modal();
	        },
	        error(xhr, statusText, err){
				switch(xhr.status){
				default: console.log(xhr, statusText, err);
				}
				console.log
			}
	    })
};

</script>