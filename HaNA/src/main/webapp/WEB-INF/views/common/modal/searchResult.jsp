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
				<option value="location" >장소</option>
			</select>
		</div>
		<div class="col-sm-8">
			<input id="search-box" type="text"  placeholder="검색어 입력.."/>
		</div>
	</div>
</div>

<div id="searchResultBox">
	<div id="content-box">
		<table></table>
	</div>
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
				if(category == 'member'){
					getMemberList(data);			
				}
				else if(category == 'group'){
					getGroupList(data);						
				}
				else if(category == 'shop'){
					getMemberList(data);						
				}
				else if(category == 'location'){
					getLocationList(data);						
				} 
			},
			error:console.log
		})
	})
	
	function getMemberList(data){
		let tr = `<tr>
			<td rowspan=2>aksldf</td>
			<td>alksdjf</td>
		</tr>
		<tr>
			<td>alskdjf</td>
		</tr>`
		$("#content-box table").append(tr);
	}
	function getGroupList(data){
		
	}
	function getLocationList(data){
		
	}
	
	
	
	
		
	
</script>