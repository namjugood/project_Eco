<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/admin.css">
<style>
	body{widht:100%;  background:#311851;}
</style>
</head>
<body>
<div class="adminViewBox">
<form id="adminForm" method="post" action="adminLogin" name="adminLogin">
		<div id="inputLogo" >
		    <a href="/"><div id="login_logo"></div></a><br>
		    <div id="adtitle">Administrator<br>관리자모드</div>
		</div>
		<div id="infobox" >
			<div id="inputInfo">
				<label><input class="textbox" name="adminId" autocomplete="off"
					placeholder="아이디" type="text" size="33"
					style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid pink;">
	            </label><br>
	            <br>
				<label><input class="textbox" name="adminPw" autocomplete="off"
					placeholder="비밀번호" type="password" size="33"
					style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid pink;">
	            </label><br>${message}<br>
				<input id="login" type="submit" value="로그인" class="submit">
			</div>
		</div>
	</form>
	</div>
</body>
</html>

