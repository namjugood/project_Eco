<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminhf/header.jsp" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
function go_search_music() {
	var theForm = document.frm;
	if( theForm.key.value=="") return;
	theForm.action =  "MusicManage";
	theForm.submit();
}
function go_total_music() {
	var theForm = document.frm;
	theForm.key.value="";
	theForm.action =  "MusicManage";
	theForm.submit();
}
function go_detail(mseq){
	document.frm.action = "adminMusicDetail?mseq=" + mseq;
	document.frm.submit();
}
function ThemeManage(){
	var url = "ThemeManage";
	var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=800, ";
	opt = opt + "height=700, top=300, left=300";
	window.open(url, "ThemeManage", opt);
}
function ChartManage(){
	var url = "ChartManage?first=yes";
	var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=800, ";
	opt = opt + "height=700, top=300, left=300";
	window.open(url, "ChartManage", opt);
}
function GenreManage(){
	var url = "GenreManage";
	var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=800, ";
	opt = opt + "height=700, top=300, left=300";
	window.open(url, "GenreManage", opt);
}
</script>
<article>
<br>
<br>
<br>
<h1>음악리스트</h1>  
<form name="frm" method="post">
<table style="margin-left: auto; margin-right: auto;">
  <tr>
  <td> 
  타이틀 제목
  <input type="text" name="key" value="${key}">
  <input class="btn" type="button" value="검색" 
  													onclick="go_search_music()">
  <input class="btn" type="button" name="btn_total" value="전체보기 "
													onClick="go_total_music()">
	<input type="hidden" name="all_view" value="y">
	<input class="btn" type="button" value="테마관리" class="submit"
				onclick="ThemeManage()">
	<input class="btn" type="button" value="차트관리" class="submit"
				onclick="ChartManage()">
	<input class="btn" type="button" value="장르관리" class="submit"
				onclick="GenreManage()">
  </td>
  </tr>
</table>
<br>
<table style="margin-left: auto; margin-right: auto;" width="500" cellpadding="0" cellspacing="0" border="1">
  <tr><th>곡명</th><th>아티스트</th><th>앨범</th><th>장르</th></tr>
  <c:forEach items="${musicList}" var="Music">  
  <tr>
    <td style="text-align:left; padding-left:50px; padding-right:0px;">
	<a href="#" onClick="go_detail('${Music.mseq}')">${Music.title}</td>
    <td> ${Music.name}</td>
    <td> ${Music.abtitle}</td>
    <td> ${Music.gtitle}</td>
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
    <jsp:param value="MusicManage" name="command"/>
</jsp:include>
</article>