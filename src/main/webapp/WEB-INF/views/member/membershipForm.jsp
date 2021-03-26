<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<c:if test="${message==12}">
	<script>
		alert("이용권을 구매하시면 무제한 스트리밍을 즐기실 수 있습니다");
	</script>
</c:if>


<article>
<form class="joinForm" action="buying" method="post" name="formm" style="padding:0px;padding-top:0px;">
	<h2 id="buying">&nbsp;&nbsp;&nbsp;&nbsp;ECO 이용권 구매</h2>
	<div class="product" style="margin-top:30px;">
		<label for="select1">
		<input id="select1" type="radio" name="membership" value="1" checked>
		<img src="images/30days.jpg" style="position:relative; float:right;margin:0px;width:430px;height:120px;">
		</label>
	</div>
	<div class="product">
		<label for="select2">
		<input id="select2" type="radio" name="membership" value="2">
		<img src="images/10days.jpg" style="position:relative; float:right;margin:0px;width:430px;height:120px;">
		</label>
	</div>
	<div class="product">
		<label for="select3">
		<input id="select3" type="radio" name="membership" value="3">
		<img src="images/1day.jpg" style="position:relative; float:right;margin:0px;width:430px;height:120px;">
		</label>
	</div>
	<div class="other_buttons" style="margin-top:40px;">
		<input class="btn" type="submit" value="구매하기" >
		<input class="btn" type="button" style="margin-left:44px;" value="메인으로" onclick="location.href='/'">
	</div>			
</form>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>