<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	function allSearch(f) {
		allSearchform.submit();
	}
	
</script>

	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<%-- 모든페이지 --%>
	<script src="https://kit.fontawesome.com/aeb6e503f2.js" crossorigin="anonymous"></script><!-- fontawesome: image대신 아이콘을 활용할 수 있음. + 색깔변경 가능 -->
	<script src="js/jquery-3.5.1-min.js"></script>
	<script src="js/music.js"></script> <!--공통적으로 포함(이유: 오디오)-->
	<link rel="stylesheet" href="css/main.css">
	<link rel="shortcut icon" href="pageimages/logo.png">
	<%-- 모든페이지 --%>
	
	<%-- member --%>
	<c:if test="${fn:contains(pageContext.request.requestURI, 'member/')}">
		<link rel="stylesheet" href="css/member.css"> <!-- 멤버 -->
		<script src="js/member.js"></script>
	</c:if>
	<%-- member --%>
	
	<%-- music --%>
	<c:if test="${fn:contains(pageContext.request.requestURI,'music/')}">
		<link rel="stylesheet" href="css/music.css"> <!-- 둘러보기 및 음악관련 -->
	</c:if>
	<%-- music --%>
	
	<%-- mypage --%>
	<c:if test="${fn:contains(pageContext.request.requestURI,'mypage/')}">
		<link rel="stylesheet" href="css/music.css">
		<link rel="stylesheet" href="css/mypage.css"> <!-- 내보관함 -->
	</c:if>
	<%-- mypage --%>
	
	<%-- board --%>
	<c:if test="${fn:contains(pageContext.request.requestURI,'board/')}">
		<link rel="stylesheet" href="css/board.css"> <!-- 공지사항, qna, 게시판 -->
		<link rel="stylesheet" href="css/music.css"> <!-- 전체 검색용 -->
	</c:if>
	<%-- board --%>

</head>
<body>
	<!-- 화면단 로그인 여부 체크용 -->
	<input type="hidden" name="useq" value="${loginUser.useq}">
	<input type="hidden" name="membership" value="${membership}">
	<header>
		<div class="headerBox">
			<div class="header">
				<a href="/"><div class="logo"></div></a>
				<ul class="headerTextL">
					<li><a class="headerFont" href="browse">둘러보기</a></li>
					<li><a class="headerFont"  href="storage">보관함</a></li>
					<li><a class="headerFont"  href="membership">이용권</a></li>
				</ul>
				<div class="searchBox">
					<form id="allSearch" action="allSearch" method="post" name="allSearchform" onsubmit="return false">
						<input type="hidden" name="selected" value="title">
						<input type="hidden" name="table" value="music_view">
						<div class ="searchI" onclick="allSearch(0)">
							<i class="fas fa-search fa-lg"></i>
						</div>
						<input class="searchText" type="text" onkeypress="if(event.keyCode == 13){allSearch(1)}"
							name="keyward" id ="keyward" value="${keyward}">
					</form>
				</div>
				<c:choose>
					<c:when test="${empty loginUser}">
						<ul class="headerTextR">
						<li><a class="headerFont"  href="loginForm">로그인</a></li>
						<li><a class="headerFont"  href="contract">회원가입</a></li>
					</ul>	
					</c:when>
					<c:otherwise>
						<ul class="headerTextR">
						   <li>
							   <a class="headerFont" id="userNameBox"  href="pwChecking">
									   ${loginUser.name} 님
							   </a>
						   </li>
						<li><a class="headerFont"  href="logout">로그아웃</a></li>
					</ul>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<script type="text/javascript">
			function allSearch(x) {
				var val = document.getElementById("keyward").value;
				val = val.trim();
				if (val === "") {
					alert("검색어를 입력하세요.")
					return false;
				}else if (x == 0){
					document.getElementById("allSearch").submit();
				}else if (x == 1) {
					document.getElementById("allSearch").submit();
				}else return false;
			}	
		</script>
	</header>

	<div id="viewBox">