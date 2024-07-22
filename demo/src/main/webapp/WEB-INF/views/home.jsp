<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <jsp:include page="/views/index">홈</jsp:include> --%>
<a href="./">홈으로</a>
<hr>
<h3>${ title } 테스트</h3>
<div>오늘: ${ today }</div>
<div>현재: ${ now }</div>
</body>
</html>