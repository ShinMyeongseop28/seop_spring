<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row justify-content-center">
		<div class="col-lg-5">
			<div class="card shadow-lg border-0 rounded-lg my-5">
				<div class="card-body p-5">
					<div class="d-flex justify-content-between">
						<a href="<c:url value='/'/>"><img src="<c:url value='/images/logo.png'/>"></a>
						<h3 class="my-4">회원가입</h3>
					</div>
					
					<div class="mb-2 text-danger fw-bold">*는 필수 입력항목입니다</div>
					<form method="post" action="register">
					<table class="table tb-row">
					<colgroup>
						<col width="200px">
						<col>
					</colgroup>
					<tr><th><span>*</span>성명</th>
						<td>
							<div class="row">
								<div class="col-auto">
									<input type="text" name="name" class="form-control">
								</div>
							</div>
						</td>
					</tr>
					<tr><th><span>*</span>아이디</th>
						<td>
							<div class="row">
								<div class="col-auto">
									<input type="text" name="userid" class="form-control">
								</div>
							</div>
						</td>
					</tr>
					<tr><th><span>*</span>비밀번호</th>
						<td>
							<div class="row">
								<div class="col-auto">
									<input type="password" name="userpw" class="form-control">
								</div>
							</div>
						</td>
					</tr>
					<tr><th><span>*</span>비밀번호 확인</th>
						<td>
							<div class="row">
								<div class="col-auto">
									<input type="password" name="userpw_ck" class="form-control">
								</div>
							</div>
						</td>
					</tr>
					<tr><th><span>*</span>이메일</th>
						<td>
							<div class="row">
								<div class="col-auto">
									<input type="text" name="email" class="form-control">
								</div>
							</div>
						</td>
					</tr>
					<tr><th><span>*</span>성별</th>
						<td><div class="form-check form-check-inline">
							<label class="form-check-label"> 
								<input class="form-check-input" type="radio" name="gender" value="남">남
							</label>
							</div>
							<div class="form-check form-check-inline">
										<label class="form-check-label"> <input
											class="form-check-input" type="radio" name="gender" value="여"
											checked>여
										</label>
									</div></td>
							</tr>
					<tr><th>프로필 이미지</th>
						<td>
							<div class="row">
								<div class="d-flex align-items-center gap-2 file-info">
									<!-- 기본이미지 지정 -->
									<div class="file-preview profile px80">
										<i class="font-profile fa-solid fa-user-secret"></i>
									</div>
									<label>
										<a class="btn btn-outline-primary">프로필선택</a>
										<input type="file" name="file" class="d-none form-control image-only file-single" accept="image/*">
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr><th>생년월일</th>
						<td>
							<div class="row">
								<div class="col-auto d-flex align-items-center">
									<input type="text" name="birth" class="date form-control">
									<i role="button" class="fs-3 fa-solid fa-trash-can text-danger date-remove d-none"></i>
								</div>
							</div>
						</td>
					</tr>
					<tr><th>전화번호</th>
						<td>
							<div class="row">
								<div class="col-auto">
									<input type="text" name="phone" class="form-control">
								</div>
							</div>
						</td>
					</tr>
					<tr><th>주소</th>
						<td><div class="row">
								<div class="col-auto d-flex gap-3">
									<a class="btn btn-primary" id="btn-post">주소찾기</a>
									<input type="text" name="post" class="w-px80 form-control" readonly="readonly">
								</div>
							</div>
							<div class="mt-3">
								<input type="text" name="address1" class="form-control mb-2" readonly="readonly">
								<input type="text" name="address2" class="form-control">
							</div>
						</td>
					</tr>
					</table>
					</form>
					
					<div class="btn-toolbar justify-content-center gap-2">
						<button class="btn btn-primary" id="btn-join">회원가입</button>
						<button class="btn btn-outline-primary px-4" id="btn-cancel">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="<c:url value='/js/member.js'/>"></script>
<script>
$(function(){
	//생년월일자를 13세 이상으로 선택가능하게 제한하기
	var endDay = new Date()
	endDay.setFullYear( endDay.getFullYear() - 13 );
	$("[name=birth]").datepicker( "option", "maxDate", endDay );
})

$("table th span").addClass("text-danger fw-bold me-2")

$("#btn-cancel").on("click", function(){
	location = "<c:url value='/'/>"
})
</script>
</html>