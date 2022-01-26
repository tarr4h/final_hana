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
  width: 150px;
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
}

.sel.active::before {
  transform: rotateX(-180deg);
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
}

table {
    width: 800px;
    border-collapse: collapse;
    /* overflow: hidden; */
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
}

th,
td {
    padding: 15px;
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
        <div class="col-sm-4">
        	<ul class="list-group">
        	  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/personal'">개인정보 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/shopInfo'">업체정보 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/password'">비밀번호 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/hashtag'">해시태그 설정</li>
			  <li class="list-group-item active" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/reservationSetting'">예약 관리</li>
			</ul>
        </div>
        <!-- 설정 영역 -->
        <div class="col-sm-8">	        
	        <div class="rsTableContaier">
				<table id="rsTable">
					<thead>
						<tr>
							<th>Column 1</th>
							<th>Column 2</th>
							<th>Column 3</th>
							<th>Column 4</th>
							<th>Column 5</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Cell 1</td>
							<td>Cell 2</td>
							<td>Cell 3</td>
							<td>Cell 4</td>
							<td><div class="sel sel--black-panther">
			  <select name="select-profession" id="select-profession">
			    <option value="" disabled>Profession</option>
			    <option value="hacker">Hacker</option>
			    <option value="gamer">Gamer</option>
			    <option value="developer">Developer</option>
			    <option value="programmer">Programmer</option>
			    <option value="designer">Designer</option>
			  </select>
			</div></td>
						</tr>
						<tr>
							<td>Cell 1</td>
							<td>Cell 2</td>
							<td>Cell 3</td>
							<td>Cell 4</td>
							<td>Cell 5</td>
						</tr>
						<tr>
							<td>Cell 1</td>
							<td>Cell 2</td>
							<td>Cell 3</td>
							<td>Cell 4</td>
							<td>Cell 5</td>
						</tr>
					</tbody>
				</table>
			</div>
        </div>
    </div>
</div>


<div class="sel sel--black-panther">
  <select name="select-profession" id="select-profession">
    <option value="" disabled>Profession</option>
    <option value="hacker">Hacker</option>
    <option value="gamer">Gamer</option>
    <option value="developer">Developer</option>
    <option value="programmer">Programmer</option>
    <option value="designer">Designer</option>
  </select>
</div>

<script>
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
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>>