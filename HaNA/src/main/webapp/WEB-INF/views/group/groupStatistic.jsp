<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.kh.hana.group.model.vo.Group, java.util.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="소모임 회원 통계" name="title" />
</jsp:include>

<style>
.statistic-page-label{
text-align:center;
margin-top:7vh;
height:10vh;
}
.statistic-container {
border-top:1px solid gray;
width:55%;
min-height:1000px;
margin:auto;
margin-bottom:10%;
}
.select-box-container {
padding:50px;
}
.statistic-select-box {
	width:100px;
	height:35px;
	text-align:center;
}
.graph-memberId {
text-align:right;
font-weight:bold;
}
.graph-bar {
margin-top:10px;display:inline-block; background-color:#607d8b; height:50%;
}
.graph-bar-container {
width:80%; height:40px; color:gray; font-weight:400;
}
</style>
<div class="statistic-page-label">
	<h3>[${groupId}] &nbsp;멤버 활동 통계</h3>
</div>
<div class="statistic-container">
	<div class="select-box-container">
		<select class="statistic-select-box" name="category" id="category">
			<option value="visit">방문 수</option>
			<option value="comment">댓글 수</option>
			<option value="like">좋아요 수</option>
		</select>
		<select class="statistic-select-box" name="day" id="day">
			<option value="0">전체</option>
			<option value="30">한 달</option>
			<option value="7">일주일</option>
		</select>
	</div>
	<div class="graph-container">
		<table style="width:100%;">
			<tbody>

			</tbody>
		</table>
	</div>
</div>

<script>
	$(document).ready(getVisitStatistic);

	$("#category, #day").change((e)=>{
		if($("#category").val() == 'visit'){
			getVisitStatistic();
		}
		else if($("#category").val() == 'comment') {
			getCommentStatistic();
		}
		else if($("#category").val() == 'like') {
			getLikeStatistic();
		}
	})
	
	function getVisitStatistic(){
		$.ajax({
			url:"${pageContext.request.contextPath}/group/getVisitGraph/${groupId}",
			data:{
				day:$("#day").val()
			},
			success(data){
				console.log(data);
				makeGraph(data);
			},
			error:console.log
		})
	}
	
	function getCommentStatistic(){
		$.ajax({
			url:"${pageContext.request.contextPath}/group/getCommentGraph/${groupId}",
			data:{
				day:$("#day").val()
			},
			success(data){
				console.log(data);
				makeGraph(data);
			},
			error:console.log
		})
	}
	
	function getLikeStatistic(){
		$.ajax({
			url:"${pageContext.request.contextPath}/group/getLikeGraph/${groupId}",
			data:{
				day:$("#day").val()
			},
			success(data){
				console.log(data);
				makeGraph(data);
			},
			error:console.log
		})
	}
	
	function makeGraph(data){
		$(".graph-container table tbody").empty();
		let max = data[0].count;

		$.each(data,function(i,e){
			let width = (e.count/max)*80;
			let count = "";
			if(e.count != 0){
				count = e.count; // e.count가 0이 아닐 때만 표기
			}
			let tr = `<tr>
				<td class='graph-memberId'>\${e.memberId}&nbsp;</td>
				<td class='graph-bar-container'><div class='graph-bar' style="width:\${width}%;"></div>&nbsp;\${count}</td>
			</tr>`
			$(".graph-container table tbody").append(tr);
		});
		
		
	}
</script>

    
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>