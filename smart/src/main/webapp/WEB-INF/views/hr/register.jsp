<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3 class="my-4">사원정보</h3>

<form method="post" action="register">
<%-- <input type="hidden" name="employee_id" value="${ vo.employee_id }"> --%>
<table class="table tb-row">
<colgroup>
	<col width="200px">
	
</colgroup>
<tr><th>사원명</th>
	<td><div class="row">
			<div class="col-auto">
				<input type="text" required placeholder="성" class="form-control" name="last_name" value="${ vo.last_name }">
			</div>
			<div class="col-auto">
				<input type="text" placeholder="명" class="form-control" name="first_name" value="${ vo.first_name }">
			</div>
		</div>
	</td>
</tr>
<tr><th>이메일</th>
	<td><div class="row">
			<div class="col-auto">
				<input type="text" name="email" value="${ vo.email }" class="form-control" required>
			</div>
		</div> 
	</td>
</tr>
<tr><th>전화번호</th>
	<td><div class="row">
			<div class="col-auto">
				<input type="text" name="phone_number" value="${ vo.phone_number }" class="form-control" required>
			</div>
		</div> 
	</td>
</tr>
<tr><th>입사일자</th>
	<td><div class="row">
			<div class="col-auto">
				<input type="text" name="hire_date" value="${ vo.hire_date }" class="form-control date" required>
			</div>
		</div>
	</td>
</tr>
<tr><th>급여</th>
	<td><div class="row">
			<div class="col-auto">
				<input type="text" name="salary" value="3000" class="form-control" required >
			</div>
		</div>
	</td>
</tr>
<tr><th>부서</th>
	<td><div class="row">
			<div class="col-auto">
				<select name="department_id" class="form-select">
					<option value="-1">소속없음</option>
					<c:forEach items="${ departments }" var="d">
					<option value="${ d.department_id }">${ d.department_name } </option> 
					</c:forEach>
				</select>
			</div>
		</div>
	</td>
</tr>
<tr><th>업무</th>
	<td><div class="row">
			<div class="col-auto">
				<select name="job_id" class="form-select">
					<c:forEach items="${ jobs }" var="j">
					<option value="${ j.job_id }">${ j.job_title }</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</td>
</tr>
<tr><th>매니저</th>
	<td><div class="row">
			<div class="col-auto">
				<select name="manager_id" class="form-select">
					<option value="-1">매니저없음</option>
					<c:forEach items="${ managers }" var="m">
					<option value="${ m.manager_id }">${ m.manager_name }</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</td>
</tr>
</table>
</form>

<div class="btn-toolbar gap-3 justify-content-center">
	<button class="btn btn-primary px-4" id="btn-save">저장</button>
	<button class="btn btn-outline-primary px-4" id="btn-cancel">취소</button>
</div>

<script>
// $( function() {
//     $( ".date" ).datepicker();
//   } );

$(function(){
	//신규사원 입사일자의 기본: 오늘 날짜로 지정
	$(".date").datepicker("setDate", new Date());
})

$("#btn-save").on("click", function(){
	$("form").submit();
})

$("#btn-cancel").on("click", function(){
	location='list';
})
// document.getElementById("btn-cancel").addEventListener("click", function(){
// 	location='info?id=${vo.employee_id}';
// })
</script>
</body>
</html>