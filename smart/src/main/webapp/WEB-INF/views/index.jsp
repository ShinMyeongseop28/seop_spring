<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3 class="mt-4">스마트 IoT 홈</h3>
<img src="<c:url value='/images/IoT.jfif'/>" class="w-50" onclick="test()">

<script>
function test(){
	alert("아이디나 이메일이 맞지 않습니다."); location='member/findPassword';
}
</script>
</body>
</html>