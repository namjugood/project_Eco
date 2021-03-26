<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
function go_mod(gseq){
	document.frm.action = "genreUpdateForm?gseq=" + gseq;
	document.frm.submit();
}
function go_mov(){
	location.href = "GenreManage";
}
function go_del(form, gseq){
	document.frm.action = "genreDelete?gseq=" + gseq;
	document.frm.submit();
}
</script>
<article>
<br>
<br>
<br>
<h1>장르 상세 보기</h1> 
<form name="frm" method="post">
<table width="500" cellpadding="0" cellspacing="0" border="1">
    <tr><th>장르번호</th><td>${GenreVO.gseq}</td></tr>
    <tr><th>장르명</th><td>${GenreVO.title}</td></tr>
</table>
<input id="login" type="button" value="수정" onClick="go_mod('${GenreVO.gseq}')">
<input id="login"  type="button" value="목록" onClick="go_mov()">
<input id="login" type="button" value="삭제" onClick="go_del(this.form, '${GenreVO.gseq}')">
<br>
${message }
</form>


</article>