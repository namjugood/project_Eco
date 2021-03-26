<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
function go_mod(cseq){
	document.frm.action = "chartUpdateForm?cseq=" + cseq;
	document.frm.submit();
}
function go_mov(){
	location.href = "ChartManage";
}
function go_del(cseq){
	document.frm.action = "chartDelete?cseq=" + cseq;
	document.frm.submit();
}
</script>
<article>
<br>
<br>
<br>
<h1>차트 상세 보기</h1> 
<form name="frm" method="post">
<table width="500" cellpadding="0" cellspacing="0" border="1">
    <tr><th>차트번호</th><td>${ChartVO.cseq}</td></tr>
    <tr><th>차트명</th><td>${ChartVO.title}</td></tr>
</table>
<input id="login" type="button" value="수정" onClick="go_mod('${ChartVO.cseq}')">
<input id="login"  type="button" value="목록" onClick="go_mov()">
<input id="login" type="button" value="삭제" onClick="go_del('${ChartVO.cseq}')">           
</form>


</article>