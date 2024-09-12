<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<body>
<h3>질문글 정보 수정</h3>

<form method="post" action="update">
<input type="hidden" name="id" value="${ vo.id }">
<table>
<colgroup>
	<col width="100px">
</colgroup>
<tr><th>질문</th>
	<td><input type="text" name="question" value="${ vo.question }"></td>
</tr>
<tr><th>답변</th>
	<td><input type="text" name="answer" value="${ vo.answer }"></td>
</tr>
</table>

<button>저장</button>
<button onclick="location='info?id=${vo.id}}'">취소</button>
</form>

</body>
</html>