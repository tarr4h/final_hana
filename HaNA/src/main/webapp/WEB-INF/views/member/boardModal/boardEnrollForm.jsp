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
<sec:authentication property="principal" var="loginMember"/>

<!-- 글쓰기모달 -->
    <div class="modal fade" id="boardFormModal" tabindex="-1"  >
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">게시글 작성</h4>
			</div>
			<div class="modal-body">
				<table class="table" style="text-align: center;" name="modalTable">
					<thead class="table-light">
					</thead>
					<tbody id="modalTbody">
						 <form:form
        action="${pageContext.request.contextPath}/member/memberBoardEnroll?${_csrf.parameterName}=${_csrf.token}"
        method="POST"
        enctype="multipart/form-data">
        <table>
            <tr>
            <td><input type="hidden" value="<sec:authentication property='principal.username'/>" name="writer"/></td>
            <td><input type="hidden" value="${id}" name="id"/></td>
            </tr>
            <tr>
            <td>
                <label for="file1">첨부파일 1</label>
                <input type="file" name="file" id="file1" onchange="setThumbnail(event);"/>
                <div id="image_container"></div>
            </td>
            </tr>
            <tr>
            <td>
                <label for="file1">첨부파일 2</label>
                <input type="file" name="file" id="file2"/>
            </td>
            </tr> 
            <tr>
            <td>
                <label for="file1">첨부파일 3</label>
                <input type="file" name="file" id="file3"/>
            </td>
            </tr> 
            <tr>
            <td><textarea  name="content" id="summernote"/></textarea></td>
            </tr>
 
            <tr><td><input type="submit" /></td></tr>
        </table>
    </form:form>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
			<!-- <button type="button" class="btn btn-primary">Save changes</button> -->	
			</div>
		</div>      
        </div>
</div>
<script>
//글쓰기
$("#btn-add").click(()=> {
	console.log("ddd");
  $("#boardFormModal").modal();
});

//글 작성시 이미지 바로 나오게
function readMultipleImage(input) {
    const multipleContainer = document.getElementById("multiple-container")
    
    // 인풋 태그에 파일들이 있는 경우
    if(input.files) {
        console.log(input.files)
        // 유사배열을 배열로 변환 -forEach문으로 처리
        const fileArr = Array.from(input.files)
        const $colDiv1 = document.createElement("div")
        const $colDiv2 = document.createElement("div")
        $colDiv1.classList.add("column")
        $colDiv2.classList.add("column")
        fileArr.forEach((file, index) => {
            const reader = new FileReader()
            const $imgDiv = document.createElement("div")   
            const $img = document.createElement("img")
            $img.classList.add("image")
            $imgDiv.appendChild($img)
          
            reader.onload = e => {
                $img.src = e.target.result
            }
            
            console.log(file.name)
            if(index % 2 == 0) {
                $colDiv1.appendChild($imgDiv)
            } else {
                $colDiv2.appendChild($imgDiv)
            }
            
            reader.readAsDataURL(file)
        })
        multipleContainer.appendChild($colDiv1)
        multipleContainer.appendChild($colDiv2)
    }
}
const inputMultipleImage = document.getElementById("input-multiple-image")
inputMultipleImage.addEventListener("change", e => {
    readMultipleImage(e.target)
    $imgDiv.style.width = ($img.naturalWidth)  * 0.3 + "px"
    $imgDiv.style.height = ($img.naturalHeight) * 0.3 + "px"
 
})

 
$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
          
	});
});
</script>