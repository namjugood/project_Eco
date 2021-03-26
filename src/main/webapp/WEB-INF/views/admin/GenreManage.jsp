<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
function go_search_genre() {
	var theForm = document.frm;
	if( theForm.key.value=="") return;
	theForm.action =  "GenreManage";
	theForm.submit();
}
function go_total_genre() {
	var theForm = document.frm;
	theForm.key.value="";
	theForm.action =  "GenreManage";
	theForm.submit();
}
function go_detail(gseq){
	document.frm.action = "adminGenreDetail?gseq=" + gseq;
	document.frm.submit();
}
function insertGenre(){
	document.frm.action = "genreInsertForm";
	document.frm.submit();
}
</script>
<article>
<br>
<br>
<br>
<h1>장르리스트</h1>  
<form name="frm" method="post">
<table style="margin-left: auto; margin-right: auto;">
  <tr>
  <td> 
  장르 제목
  <input type="text" name="key" value="${key}">
  <input class="btn" type="button" value="검색" 
  													onclick="go_search_genre()">
  <input class="btn" type="button" name="btn_total" value="전체보기 "
													onClick="go_total_genre()">
	<input type="hidden" name="all_view" value="y">
  <input class="btn" type="button" value="장르추가"
													onClick="insertGenre()">
  </td>
  </tr>
</table>
<br>
<table border="1" style="width:500px;margin: 0 auto;">
  <tr><th>장르번호</th><th>장르제목</th><th>장르이미지</th>
  <c:forEach items="${genreList}" var="GenreVO">  
  <tr>
    <td align="center">${GenreVO.gseq}</td>
    <td style="text-align:left; padding-left:50px; padding-right:0px;">
	<a href="#" onClick="go_detail('${GenreVO.gseq}')">${GenreVO.title}</td>
	<td align="center" valign="top">
				<c:choose>
					<c:when test="${empty GenreVO.img}">
						<img src="/upload/noimage.jpg" width="20">
					</c:when>
					<c:otherwise>
						<img src="/upload/${GenreVO.img}" width="20">
					</c:otherwise>
				</c:choose>
			</td>
  </tr>
  </c:forEach>
</table>



</form>
<jsp:include page="paging/paging.jsp">
    <jsp:param value="${paging.page}" name="page"/>
    <jsp:param value="${paging.beginPage}" name="beginPage"/>
    <jsp:param value="${paging.endPage}" name="endPage"/>
    <jsp:param value="${paging.prev}" name="prev"/>
    <jsp:param value="${paging.next}" name="next"/>
    <jsp:param value="GenreManage" name="command"/>
</jsp:include>
</article>