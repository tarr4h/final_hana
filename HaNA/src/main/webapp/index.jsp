<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<body>
	<button id="test">안녕하세요</button>
	<h1>안 녕 하 세 요 - 김형진</h1>
	<script>
		$("#test").click((e) => {
			location.href="${pageContext.request.contextPath}/common/main.do";
		});
	</script>
</body>

</html>