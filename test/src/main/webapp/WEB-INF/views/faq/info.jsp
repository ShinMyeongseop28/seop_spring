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
<h3>질문글 정보</h3>

<table>
<colgroup>
	<col width="100px">
</colgroup>
<tr><th>질문</th>
	<td>${ vo.question }</td>
</tr>
<tr><th>답변</th>
	<td>${ vo.answer }</td>
</tr>
<tr><th>등록일시</th>
	<td>${ vo.writedate }</td>
</tr>
</table>

<button onclick="location='list'">질문글 목록</button>
<button onclick="location='modify?id=${vo.id}'">수정</button>
<button onclick="fnDelete()">삭제</button>
</body>

<script>
function fnDelete(){
	if (confirm("[${vo.question}]을 정말 삭제하시겠습니까?")){
		location = "delete?id=${vo.id}"
	}
}
</script>
</html>