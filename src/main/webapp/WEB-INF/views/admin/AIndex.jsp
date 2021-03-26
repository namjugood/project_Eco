<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/aeb6e503f2.js" crossorigin="anonymous"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap');
    
	body{widht:100%;  background:#593BA0; font-family: 'Noto Sans KR', sans-serif;}
	#index{width:1030px; height:300px; margin:0 auto; margin-top:50px;}
	.box{width:300px; height:300px; margin-right:60px; position:relative;
		 float:left; border-radius:40px; cursor: pointer; background:#311851;}
	.box:hover{background:pink;}
	.icon{margin:0 auto;width:225px; height:225px;}
	li{text-align:center; color:white; list-style-type: none; margin-top:10px; font-size:25px;}
</style>

</head>
<body>

<article>
	<p style="text-align:center; color:white; font-weight: 500; padding-top:240px; font-size: xx-large;">
		Admin 방문을 환영합니다.</p>
	<div id="index">
		<div class="box">
			<div class="icon">
				<span style="font-size: 180px; white; text-align:center;">
					<a href="MemberManage?first=yes" style="text-decoration:none;color: white;">
		            	<i class="fas fa-users"></i>
		            </a>
	            </span>
			</div>
			<li>USER</li>
		</div>
		<div class="box">
			<div class="icon">
				<span style="font-size: 160px; color: white; text-align:center; padding-left:20px;">
					<a href="musicManageList" style="text-decoration:none;color: white;">
	            		<i class="fas fa-music"></i>
	            	</a>
	            </span>
			</div>
			<li>MUSIC</li>
		</div>
		<div class="box" style="margin-right:0px;">
			<div class="icon">
				<span style="font-size: 160px; color: white; text-align:center; padding-left:30px;">
					<a href="noticeManageList?first=yes" style="text-decoration:none;color: white;">
	            		<i class="far fa-comment-alt"></i>
	            	</a>
	            </span>
			</div>
			<li>NOTICE</li>
		</div>
	</div>
</article>

</body>
</html>
