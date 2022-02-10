<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/search.css" />

<div class="search-box-container">
	<div class="search-box-container-row row">
		<div class="col-sm-4 select-box-container">
			<select name="search-category" id="select-box">
				<option value="member" >계정</option>
				<option value="group" >소모임</option>
				<option value="shop" >비즈니스</option>
				<option value="board" >게시물</option>
				<option value="location" >장소</option>
			</select>
		</div>
		<div class="col-sm-8">
			<input id="search-box" type="text"  placeholder="검색어 입력.."/>
		</div>
	</div>
</div>

<div id="searchResultBox">

</div>

<script>
	// 검색창 활성시 결과창 on
	$("#search-box").focus((e)=>{
		$("#searchResultBox").css('display','inline');
	})
	
	// 검색창 비활성시 결과창 off
	$("#search-box").blur((e)=>{
		$("#searchResultBox").css('display','none');
	})
	
	$("#search-box").keyup((e)=>{
		let category = $("#select-box").val();
		let keyword = $(e.target).val();
		console.log(category);
		console.log(keyword);
		$.ajax({
			url:`${pageContext.request.contextPath}/search/\${category}`,
			data:{
				keyword
			},
			success(data){
			},
			error:console.log
		})
	})
	
	
	
	
	/* if(category == 'member'){
			getMemberList($(e.target).val());			
		}
		else if(category == 'group'){
			getGroupList($(e.target).val());						
		}
		else if(category == 'shop'){
			getShopList($(e.target).val());						
		}
		else if(category == 'board'){
			getBoardList($(e.target).val());						
		}
		else if(category == 'location'){
			getLocationBoardList($(e.target).val());						
		} */
	
</script>