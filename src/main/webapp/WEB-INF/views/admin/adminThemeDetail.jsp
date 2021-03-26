<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
function go_mod(tseq){
	document.frm.action = "themeUpdateForm?tseq=" + tseq;
	document.frm.submit();
}
function go_mov(){
	location.href = "ThemeManage";
}
function go_del(tseq){
	document.frm.action = "themeDelete?tseq=" + tseq;
	document.frm.submit();
}
</script>
<article>
<br>
<br>
<br>
<h1>테마 상세 보기</h1> 
<form name="frm" method="post">
<table width="500" cellpadding="0" cellspacing="0" border="1">
    <tr><th>테마번호</th><td>${ThemeVO.tseq}</td></tr>
    <tr><th>테마명</th><td>${ThemeVO.title}</td></tr>
    <tr><th>테마이미지</th> <td>${ThemeVO.img}</td></tr>
</table>
<input id="login" type="button" value="수정" onClick="go_mod('${ThemeVO.tseq}')">
<input id="login"  type="button" value="목록" onClick="go_mov()">   
<input id="login" type="button" value="삭제" onClick="go_del('${ThemeVO.tseq}')">        
</form>


</article>