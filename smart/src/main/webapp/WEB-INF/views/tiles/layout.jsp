<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.user" var="auth"/>
</sec:authorize>

<c:choose>
	<c:when test="${ category eq 'cu' }"> <c:set var="title" value="- 고객관리"/> </c:when>
	<c:when test="${ category eq 'hr' }"> <c:set var="title" value="- 사원관리"/> </c:when>
	<c:when test="${ category eq 'no' }"> <c:set var="title" value="- 공지사항"/> </c:when>
	<c:when test="${ category eq 'bo' }"> <c:set var="title" value="- 방명록"/> </c:when>
	<c:when test="${ category eq 'da' }"> <c:set var="title" value="- 공공데이터"/> </c:when>
	<c:when test="${ category eq 'vi' }"> <c:set var="title" value="- 시각화"/> </c:when>
	<c:when test="${ category eq 'login' }"> <c:set var="title" value="- 로그인"/> </c:when>
	<c:when test="${ category eq 'change' }"> <c:set var="title" value="- 비밀번호변경"/> </c:when>
	<c:when test="${ category eq 'my' }"> <c:set var="title" value="- 내 정보"/> </c:when>
</c:choose>

<!DOCTYPE html>
<html>
	<head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>스마트 IoT ${ title }</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="<c:url value='/assets/favicon.ico'/>" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="<c:url value='/css/styles.css'/>" rel="stylesheet" />
        <link href="<c:url value='/css/common.css'/>" rel="stylesheet" />
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"/>
        
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/js/all.min.js"></script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <script src="<c:url value='/js/common.js'/>"></script>
        <script>
    	var socketURL = `ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/notify-websocket`
    	var authID = `${auth.userid}`
    	var context = `${pageContext.request.contextPath}`
    	var notifyURL = "<c:url value='/board/comment/notify'/>"
    	</script>
        
    </head>
    
    <body>
	<!-- <input type="text" id="name" class="form-control" placeholder="Your name here..."> -->
   	
        <div class="d-flex" id="wrapper">
            <!-- Sidebar -->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light">
                <a href="<c:url value='/'/>"><img src="<c:url value='/images/logo.png'/>" class="w-75"></a>
                </div>
                <div class="list-group list-group-flush">
                    <a class="${ category == 'cu' ? 'active' : ''} list-group-item list-group-item-action list-group-item-light p-3 ps-4" href="<c:url value='/customer/list'/>">고객관리</a>
                    <a class="${ category == 'hr' ? 'active' : ''} list-group-item list-group-item-action list-group-item-light p-3 ps-4" href="<c:url value='/hr/list'/>">사원관리</a>
                    <a class="${ category eq 'no' ? 'active' : ''} list-group-item list-group-item-action list-group-item-light p-3 ps-4" href="<c:url value='/notice/list'/>">공지사항</a>
                    <a class="${ category == 'bo' ? 'active' : ''} list-group-item list-group-item-action list-group-item-light p-3 ps-4" href="<c:url value='/board/list'/>">방명록</a>
                    <a class="${ category eq 'da' ? 'active' : ''} list-group-item list-group-item-action list-group-item-light p-3 ps-4" href="<c:url value='/data/list'/>">공공데이터</a>
                    <a class="${ category == 'vi' ? 'active' : ''} list-group-item list-group-item-action list-group-item-light p-3 ps-4" href="<c:url value='/visual/list'/>">시각화</a>
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-primary" id="sidebarToggle">Toggle Menu</button>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                            
                            	<c:if test="${empty auth }">
                                <li class="nav-item"><a class="nav-link" href="<c:url value='/member/login'/>">로그인</a></li>
                                <li class="nav-item"><a class="nav-link" href="<c:url value='/member/join'/>">회원가입</a></li>
                            	</c:if>
                            	
                            	<c:if test="${not empty auth}">
                            	
                            	<li class="nav-item dropdown me-5">
                            		<a id="notify" class="nav-link" data-bs-toggle="dropdown" aria-expanded="false">
                            			<span><i class="fs-2 fa-solid fa-bell"></i></span>
                            			<span id="notify-count" class="notify-on"></span>
                            		</a>
								  <div id="dropdown-list" class="w-px300 dropdown-menu dropdown-menu-end">
								  
								  </div>
								</li>
                            	
                            	<li class="nav-item">
                            		<div class="profile px40">
                            		<c:choose>
                            			<c:when test="${ empty auth.profile }"><i class="font-profile fa-solid fa-user-secret"></i></c:when>
                            			<c:otherwise><img src="${ auth.profile }"></c:otherwise>
                            		</c:choose>
                            		</div>
                           		</li>
                            	
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${ auth.name }</a>
                                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                    	<c:if test="${ empty auth.social }">
                                        <a class="dropdown-item" href="#!">아이디: ${ auth.userid }</a>
                                        <a class="dropdown-item" href="<c:url value='/member/user/myPage'/>">My page</a>
                                        <a class="dropdown-item" href="<c:url value='/member/user/changePassword'/>">비밀번호 변경</a>
                                        <div class="dropdown-divider"></div>
                                        </c:if>
                                        <a class="dropdown-item" href="<c:url value='/member/logout'/>">로그아웃</a>
                                    </div>
                                </li>
                            	</c:if>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Page content-->
                <div class="container-fluid my-4">
                	<tiles:insertAttribute name="container"/>
                </div>
                
                <footer class="text-center py-4 border-top">
                	<div>Copyright &copy; My Website 2024</div>
                </footer>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="<c:url value='/js/scripts.js'/>"></script>
        <script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>
    	<script src="<c:url value='/js/notify.js'/>"></script>
    	
    </body>
</html>