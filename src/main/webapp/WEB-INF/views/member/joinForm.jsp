<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>
 
<article>
<form class="joinForm" action="join" method="post" name="formm" >
	<div class="infoBox">
		<label><input class="textbox" name="id" id="id"
				placeholder="아이디(이메일)" type="text" size="40"
				style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid silver;"
				value="${dto.id}"></label><br>
		<label style="color:red;font-size:80%;">${message1}</label>
		
		<input type="hidden" name="reid" value="${reid}">
		    <br><a style="font-size:12pt;">*(반드시 이메일 형식으로 작성해주세요)
		    <input id="recheck" type="button" value="중복 체크" class="dup" onclick="idCheck()"></a><br>
	    <label style="color:red;font-size:80%;">${message5}</label>
	</div>
	<div class="infoBox">    
	    <br><label><input class="textbox" name="pw"
			placeholder="비밀번호" type="password" size="40"
			style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid silver;"></label><br>
			<label style="color:red;font-size:80%;">${message2}</label> 
	 </div>
	 <div class="infoBox">   
	    <br><label><input class="textbox" name="pwCheck"
			placeholder="비밀번호확인" type="password" size="40"
			style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid silver;"></label><br>
		<label style="color:red;font-size:80%;">${message6}</label>
	 </div>
	 <div class="infoBox">		
	    <br><label><input class="textbox" name="name"
			placeholder="이름(성명)" type="text" size="40"
			value="${dto.name}"
			style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid silver;"></label><br>
		<label style="color:red;font-size:80%;">${message3}</label>
	  </div>
	  <div class="infoBox">  
	    <br><label style="font-size:100%;">성별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
		    <input type="radio" name="gender" value="M"
			<c:choose>
				<c:when test="${empty dto.gender}">checked</c:when>
				<c:otherwise>
					<c:if test="${dto.gender eq '1'}">checked</c:if>
				</c:otherwise>
			</c:choose>
			> 남성 &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="gender" value="F"
			<c:choose>
				<c:when test="${empty dto.gender}"></c:when>
				<c:otherwise>
					<c:if test="${dto.gender eq '2'}">checked</c:if>
				</c:otherwise>
			</c:choose>
			> 여성
		</label><br>
		</div>
		<div class="infoBox">
			<br><label><input class="textbox" name="phone"
				placeholder="전화번호('-'포함 13자리)" type="text" size="40"
				value="${dto.phone}"
				style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid silver;"></label><br>
		    <label style="color:red;font-size:80%;">${message4}</label><br>
		</div>
		<div class="other_buttons">
		    <input class="btn" style="height:60px;" type="submit" value="회원가입" class="submit"> 
		    <input class="btn" style="margin-left:44px;height:60px;" type="reset" value="취소" class="cancel">
		</div>
		<div class="clear"></div>
</form>
</article>
<%@ include file="../include/headerfooter/footer.jsp" %>