<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminhf/header.jsp" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    * {
        font-size: 95%;
    }
</style>
<script type="text/javascript">
function go_search_member() {
	var theForm = document.frm;
	if( theForm.key.value=="") return;
	theForm.action =  "MemberManage?first=yes";
	theForm.submit();
}
function go_total_member() {
	var theForm = document.frm;
	theForm.key.value="";
	theForm.action =  "MemberManage?first=yes";
	theForm.submit();
}
function go_detail(useq){
	document.frm.action = "adminMemberDetail?useq=" + useq;
	document.frm.submit();
}
</script>
<article>
<br>
<br>
<br>
<h1>회원리스트</h1>  
<form name="frm" method="post">
<table style="margin-left: auto; margin-right: auto;">
  <tr>
  <td> 
  회원 아이디
  <input type="text" name="key" value="${key}">
  <input type="button" value="검색" 
  													onclick="go_search_member()">
  <input type="button" name="btn_total" value="전체보기 "
													onClick="go_total_member()">
	<input type="hidden" name="all_view" value="y">
  </td>
  </tr>
</table>
<br>
<table border="1" style="width:950px;margin: 0 auto;">
  <tr><th>아이디</th><th>이름</th><th>전화</th><th>가입일</th><th>멤버쉽</th></tr>
  <c:forEach items="${memberList}" var="memberVO">
  <tr>
    <td>
	<a href="#" onClick="go_detail('${memberVO.useq}')">${memberVO.id}</td>
    <td> ${memberVO.name}</td>
    <td> ${memberVO.phone}</td> 
    <td> <fmt:formatDate value="${memberVO.indate}"/></td>
    <td> ${memberVO.membership }</td>
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
    <jsp:param value="MemberManage" name="action"/>
</jsp:include>
</article>