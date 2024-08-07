<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3 class="my-4">비밀번호 변경</h3>

<table class="table tb-row">
<colgroup>
	<col width="200px">
</colgroup>
<tr><th>현재 비밀번호</th>
	<td><div class="row">
			<div class="col-auto">
				<input type="password" name="current" class="form-control">
			</div>
		</div>
	</td>
</tr>
<tr><th>새 비밀번호</th>
	<td><div class="row input-check">
			<div class="col-auto">
				<input type="password" name="userpw" class="form-control check-item">
			</div>
			<div class="col-auto fw-bold desc">사용가능한 비번입니다.</div>
			<div class="mt-2">비밀번호는 영문 대/소문자, 숫자 조합 5자~10자</div>
		</div>
	</td>
	<td></td>
</tr>
<tr><th>새 비밀번호 확인</th>
	<td><div class="row input-check">
			<div class="col-auto">
				<input type="password" name="userpw_ck" class="form-control check-item">
			</div>
			<div class="col-auto fw-bold desc"></div>
		</div>
	</td>
	<td></td>
</tr>
</table>

<div class="btn-toolbar justify-content-center">
	<button class="btn btn-primary px-4" id="btn-save">변경</button>
</div>
<script>
$("#btn-save").on("click", function(){
	if( $("[name=current]").val()==""){
		alert("현재 비밀번호를 입력하세요!");
		$("[name=current]").focus();
	}else{
		//입력체크할 항목들
		
	}
})
</script>
</body>
</html>