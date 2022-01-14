<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/group/createGroup" method="post">
		<table>
			<tr><td>
				<input type="text" name="groupId" id="groupId"/>
				<label for="groupId">아이디</label>
			</td></tr>
			<tr><td>
				<input type="text" name="groupName" id="groupName"/>
				<label for="groupName">이름</label>
			</td></tr>
			<tr><td>
				<input type="hidden" name="leaderId" id="leaderId" value="hyungzin0309"/>
			</td></tr>
			<tr>
			<td>
				<input type="checkbox" name="hashtag" value="운동" id="hashtag-ex"/>
				<label for="hashtag-ex">운동</label>
				<input type="checkbox" name="hashtag" value="독서" id="hashtag-re"/>
				<label for="hashtag-re">독서</label>
				<input type="checkbox" name="hashtag" value="등산" id="hashtag-mu"/>
				<label for="hashtag-mu">운동</label>
			</td>
			</tr>
			<tr><td>
				<label for="profileImage">프로필사진</label>
				<input type="file" name="profileImage" id="profileImage"/>
			</td></tr>
			<tr>
			<td><input type="submit" /></td>
			</tr>
		</table>

	</form>

</body>
</html>