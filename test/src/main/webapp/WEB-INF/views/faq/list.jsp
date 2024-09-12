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
<h3>질문글 목록</h3>

<button onclick="location='register'">질문글등록</button>

<table>
<colgroup>
	<col width="80px">	
	<col width="">	
	<col width="150px">
</colgroup>
<tr><th>번호</th><th>질문</th><th>등록일시</th>

<c:if test="${ empty list }">
<tr><td colspan="3" class="text-center">공지글이 없습니다</td></tr>
</c:if>

<c:forEach items="${ list }" var="vo">
<tr>
	<td>${ vo.id  }</td>
	<td><a href="info?id=${ vo.id }">${ vo.question }</a></td>
	<td>${ vo.writedate }</td>
</tr>
</c:forEach>
</table>
</body>
</html>