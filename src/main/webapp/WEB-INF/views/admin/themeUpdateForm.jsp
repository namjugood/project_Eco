<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
function go_save(){
	document.frm.action = "themeUpdate";
	document.frm.submit();
}
function go_mov(){
	location.href = "ThemeManage";
}
</script>
<article>
<h1>테마등록</h1>
<form name="frm" method="post" enctype="multipart/form-data">
<input type="hidden" name="tseq" value="${theme.tseq}">
<table>
	<tr><th>테마이름</th><td width="343" colspan="5">
		<input type="text" name="title" size="47" maxlength="100" value="${theme.title}"></td></tr>
	<tr><th>테마이미지</th>
		<td>
			<input type="file" name="filename">
			<input type="hidden" name="oldimage" value="${theme.img}"><br />
				<c:choose>
					<c:when test="${empty theme.img}">
						<img src="/upload/noimage.jpg" width="20">
					</c:when>
					<c:otherwise>
						<img src="/upload/${theme.img}" width="20">						
					</c:otherwise>
				</c:choose>
			</td></tr>
		${message }
</table>
<input class="btn" type="button" value="등록" onClick="go_save()">
<input class="btn" type="button" value="목록" onClick="go_mov()">
</form>
</article>