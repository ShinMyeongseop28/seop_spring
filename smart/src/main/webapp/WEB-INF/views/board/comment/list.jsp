<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 댓글이 없는 경우 -->
<c:if test="${ empty list }">
<div class="text-center">
	<div>댓글이 없습니다</div>
	<div class="fs-5">첫번째 댓글을 남겨주세요</div>
</div>
</c:if>
 
<!-- 댓글이 있는 경우 -->
<c:forEach items="${ list }" var="vo">
	<div class="comment py-3 border-bottom">
		<div class="d-flex gap-2 align-items-center mb-2">
			<label class="profile px40">
				<c:choose>
					<c:when test="${ empty vo.profile }">
						<i class="font-profile fa-solid fa-user-secret"></i>
					</c:when>
					<c:otherwise><img src="${vo.profile }"></c:otherwise>
				</c:choose>
			</label>
			<span>${ vo.name } [ ${ vo.writedate }]</span>
		</div>
		<div class="content">${fn: replace ( fn:replace(vo.content, lf, "<br>"), crlf, "<br>")} 
		</div>
	</div>
</c:forEach>

<!-- <div class="comment py-3 border-bottom"> -->
<!-- 	<div class="d-flex gap-2 align-items-center mb-2"> -->
<!-- 		<label class="profile px40"> -->
<!-- 			<i class="font-profile fa-solid fa-user-secret"></i> -->
<!-- 		</label> -->
<!-- 		<span>홍길동 [ 2024-09-23 17:11:50 ]</span> -->
<!-- 	</div> -->
<!-- 	<div class="content">외교부에 따르면 이번 회의에서 한미일 3국은 작년 8월 캠프 데이비드 정상회의 합의사항 이행 현황을 점검하고  -->
<!-- 						 북한 문제 지역 및 글로벌 현안 등에 대해 논의한다. -->
<!-- 	</div> -->
<!-- </div> -->