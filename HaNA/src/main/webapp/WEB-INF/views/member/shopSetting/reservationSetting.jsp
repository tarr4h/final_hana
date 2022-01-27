<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<style>
/* ===== Horizontal Rule ===== */
.rule {
  border: none;
  height: 1.5px;
  background-image: linear-gradient(left, #f0f0f0, #c9bbae, #f0f0f0);
}

/* ===== Select Box ===== */
.sel {
  font-size: 15px;
  display: inline-block;
  width: 100px;
  height: 30px;
  background-color: transparent;
  position: relative;
  cursor: pointer;
}

.sel::before {
  position: absolute;
  content: '\f063';
  font-family: 'FontAwesome';
  font-size: 1em;
  color: powderblue;
  right: 20px;
  top: calc(50% - 0.5em);
  transform: translateX(15px);
  margin-left:5px;
}

.sel.active::before {
  transform: rotateX(-180deg) translateX(15px);
}

.sel__placeholder {
  display: block;
  font-family: 'Quicksand';
  font-size: 15px;
  color: #838e95;
  padding: 0.2em 0.5em;
  text-align: left;
  pointer-events: none;
  user-select: none;
  visibility: visible;
}

.sel.active .sel__placeholder {
  visibility: hidden;
}

.sel__placeholder::before {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 0.2em 0.5em;
  content: attr(data-placeholder);
  visibility: hidden;
}

.sel.active .sel__placeholder::before {
  visibility: visible;
}

.sel__box {
  position: absolute;
  top: calc(100% + 4px);
  left: -4px;
  display: none;
  list-style-type: none;
  text-align: left;
  font-size: 15px;
  background-color: #FFF;
  width: calc(100% + 8px);
  box-sizing: border-box;
}

.sel.active .sel__box {
  display: block;
  animation: fadeInUp 500ms;
}

.sel__box__options {
  display: list-item;
  font-family: 'Quicksand';
  font-size: 15px;
  color: #838e95;
  padding: 0.5em 1em;
  user-select: none;
}

.sel__box__options::after {
  content: '\f00c';
  font-family: 'FontAwesome';
  font-size: 0.5em;
  margin-left: 5px;
  display: none;
}

.sel__box__options.selected::after {
  display: inline;
}

.sel__box__options:hover {
  background-color: #ebedef;
}

/* ----- Select Box Black Panther ----- */
.sel {
  border-bottom: 4px solid rgba(0, 0, 0, 0.3);
  width:90px;
}

.sel--black-panther {
  z-index: 3;
}

/* ----- Select Box Superman ----- */
.sel--superman {
/*   display: none; */
  z-index: 2;
}

/* ===== Keyframes ===== */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translate3d(0, 20px, 0);
  }

  to {
    opacity: 1;
    transform: none;
  }
}

@keyframes fadeOut {
  from {
    opacity: 1;
  }

  to {
    opacity: 0;
  }
}


/* table */
/* body {
    background: linear-gradient(45deg, #49a09d, #5f2c82);
} */

.rsTableContainer {
background: linear-gradient(45deg, #49a09d, #5f2c82);
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width:100%;
}

table {
    width: 100%;
    border-collapse: collapse;
    /* overflow: hidden; */
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    table-layout:fixed;
    word-break:break-all;
}

th,
td {
    padding: 10px;
    background-color: rgba(255, 255, 255, 0.2);
    color: black;
}

th {
    text-align: left;
}

thead th {
    background-color: #55608f;
}

tbody tr:hover {
    background-color: #dddfe7;
}

tbody td {
    position: relative;
}

tbody td:hover:before {
    content: "";
    position: absolute;
    left: 0;
    right: 0;
    top: -9999px;
    bottom: -9999px;
    z-index: -1;
}
tbody td:hover {
	background-color:#c7cfef;
}



</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="예약 설정" name="title"/>
</jsp:include>
<section>
<sec:authentication property="principal" var="loginMember"/>


<h1>shop프로필설정</h1>
<div class="container">
    <div class="row">
    	<!-- 메뉴 영역 -->
        <div class="col-sm-3">
        	<ul class="list-group">
        	  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/personal'">개인정보 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/shopInfo'">업체정보 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/password'">비밀번호 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/hashtag'">해시태그 설정</li>
			  <li class="list-group-item active" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/reservationSetting'">예약 관리</li>
			</ul>
        </div>
        <!-- 설정 영역 -->
        <div class="col-sm-9">	        
	        <div class="rsTableContaier">
	        	<h3>예약 테이블 설정</h3>
				<table id="rsTable">
					<colgroup>
						<col width="15%">
						<col width="10%">
						<col width="15%">
						<col width="15%">
						<col width="17%">
						<col width="25%">
						<col width="15%">
						<col width="10%">
					</colgroup>
				
					<thead>
						<tr>
							<th>이름</th>
							<th>인원</th>
							<th>시작시간</th>
							<th>종료시간</th>
							<th>시간단위(분)<br/>/최대시간(분)</th>
							<th>특이사항</th>
							<th>사용여부</th>
							<th>저장/삭제</th>
						</tr>
					</thead>
					<tbody>
						<tr id="table1" data-table-no="1">
							<td>크고넓은방</td>
							<td>
								<input type="number" name="" id="" min="1" step="1" value="1" style="width:50px;"/>
							</td>
							<td>
								<div class="sel sel--black-panther">
								  <select name="select-time" id="select-time">
								    <option value="" disabled>시작시간</option>
								    <option value="09:00">09:00</option>
								    <option value="10:00">10:00</option>
								    <option value="11:00">11:00</option>
								  </select>
								</div>
							</td>
							<td>
								<div class="sel sel--black-panther">
								  <select name="select-time" id="select-time">
								    <option value="" disabled>종료시간</option>
								    <option value="09:00">09:00</option>
								    <option value="10:00">10:00</option>
								    <option value="11:00">11:00</option>
								  </select>
								</div>
							</td>
							<td>
								<input type="number" name="" id="" min="10" max="60" step="10" value="10" style="width:100px;"/>
								<input type="number" name="" id="" min="10" step="10" value="60" style="width:100px;"/>
							</td>
							<td>ㅎasdfasdfasdfasdfasdfasdfasdfasdfasdfafasdfsadfasdfasdf6</td>
							<td>
								<div class="sel sel--black-panther">
								  <select name="select-enable" id="select-enable">
								    <option value="" disabled>사용여부</option>
								    <option value="true">true</option>
								    <option value="false">false</option>
								  </select>
								</div>
							</td>
							<td>
								<input type="button" value="저장" />
								<input type="button" value="삭제" />
							</td>
						</tr>
						<tr id="table2" data-table-no="2">
							<td>Cell 1</td>
							<td>Cell 2</td>
							<td>Cell 3</td>
							<td>Cell 4</td>
							<td>Cell 5</td>
							<td>Cell 6</td>
							<td>Cell 7</td>
						</tr>
						
					</tbody>
					<tfoot>
						<tr>
							<td colspan=7 style="text-align:center;">
								<input type="button" id="tableAppendBtn" value="추가" />
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
        </div>
    </div>
</div>


<script>
$("#tableAppendBtn").click((e) => {
	const columnForm = `
		<tr id="table2" data-table-no="2">
		<td>Cell 1</td>
		<td>Cell 2</td>
		<td>Cell 3</td>
		<td>Cell 4</td>
		<td>Cell 5</td>
		<td>Cell 6</td>
		<td>Cell 7</td>
	</tr>
	`;
	$("#rsTable").append(columnForm);
});

$(() => {
	console.log($("#table1").data('table-no'));
	console.log($("#table1").next().data('table-no'));
	console.log($("#table2").prev().data('table-no'));
})
	
$('.sel').each(function() {
	  $(this).children('select').css('display', 'none');
	  
	  var $current = $(this);
	  
	  $(this).find('option').each(function(i) {
	    if (i == 0) {
	      $current.prepend($('<div>', {
	        class: $current.attr('class').replace(/sel/g, 'sel__box')
	      }));
	      
	      var placeholder = $(this).text();
	      $current.prepend($('<span>', {
	        class: $current.attr('class').replace(/sel/g, 'sel__placeholder'),
	        text: placeholder,
	        'data-placeholder': placeholder
	      }));
	      
	      return;
	    }
	    
	    $current.children('div').append($('<span>', {
	      class: $current.attr('class').replace(/sel/g, 'sel__box__options'),
	      text: $(this).text()
	    }));
	  });
	});

	// Toggling the `.active` state on the `.sel`.
	$('.sel').click(function() {
	  $(this).toggleClass('active');
	});

	// Toggling the `.selected` state on the options.
	$('.sel__box__options').click(function() {
	  var txt = $(this).text();
	  var index = $(this).index();
	  
	  $(this).siblings('.sel__box__options').removeClass('selected');
	  $(this).addClass('selected');
	  
	  var $currentSel = $(this).closest('.sel');
	  $currentSel.children('.sel__placeholder').text(txt);
	  $currentSel.children('select').prop('selectedIndex', index + 1);
	});

</script>

<!-- input -->
<!-- <div class="sel sel--black-panther">
  <select name="select-profession" id="select-profession">
    <option value="" disabled>Profession</option>
    <option value="hacker">Hacker</option>
    <option value="gamer">Gamer</option>
    <option value="developer">Developer</option>
    <option value="programmer">Programmer</option>
    <option value="designer">Designer</option>
  </select>
</div> -->

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>>