<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp"%>

<c:if test="${message==10}">
	<script>
	alert("이용권을 구입하시려면 로그인을 해 주셔야 합니다");
	</script>
</c:if>
<c:if test="${message==4}">
	<script>
		alert("ID를 입력하세요");
	</script>
</c:if>
<c:if test="${message==5}">
	<script>
		alert("비밀번호를 입력하세요");
	</script>
</c:if>

<c:if test="${message==3}">
	<script>
		alert("ID가 없습니다");
	</script>
</c:if>
<c:if test="${message==2}">
	<script>
		alert("비밀번호 오류. 관리자에게 문의하세요");
	</script>
</c:if>
<c:if test="${message==1}">
	<script>
		alert("비밀번호가 맞지 않습니다");
	</script>
</c:if>
<article class="memberForm">
	<form method="get" action="login" name="loginFrm">
		<div style="margin-left: 80px">
			<label><input class="textbox" name="id"
				placeholder="아이디(이메일)" type="text" size="34"
				style="padding-left: 0px; height: 60px; align-content: center;border:none;border-bottom: 2px solid silver;font-size:20px;font-weight:bold"
				value="${dto.id}"></label><br>
			<br> <label><input class="textbox" name="pw"
				placeholder="비밀번호" type="password" size="34" autocomplete="off"
				style="padding-left: 0px; height: 60px; align-content: center;border:none;border-bottom: 2px solid silver;font-size:20px;font-weight:bold"></label><br>
			<br><br>
			<input class="submit" type="submit" value="로그인" class="submit">
			<br>
			<input class="btn" type="button" value="회원가입" class="join"
				onclick="location.href='contract'"><input class="btn"
				type="button" value="아이디 비밀번호 찾기" style="margin-left:20px;" class="submit"
				onclick="find_id_pw()">
		</div>
	</form>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>