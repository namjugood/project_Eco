<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp"%>
<body>
<article class="memberForm" style="text-align:left">
	<form id="wrap" method="post" action="pwRechecking" name="checkingFrm">
		<div>
		<h1 style="text-align: center">비밀번호를 입력하세요</h1>
		<br>
			<h4 style="font-size:140%;">아이디 : <a id="id" name="id">${loginUser.id}</a></h4>
			<input class="textbox" type="password" id="pw" name="pw" size="30" placeholder="비밀번호" style="padding-left: 0px; height: 60px; align-content: center;border:none;border-bottom: 2px solid silver;font-size:20px;font-weight:bold">
			<br><label style="color:red;font-weight:bold;">${message}</label>
			<br><br><br><input type="submit" id="pwCheckingSubmit" value="확인">
		</div>
	</form>
</article>   
</body>

<%@ include file="../include/headerfooter/footer.jsp" %>