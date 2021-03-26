<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>
	<article>
		<h1>Eco 고객센터</h1>
		<table id="listBox" style="width: 950px; color: black">
			<tr>
				<th width="10%">번호</th>
				<th width="65%">제목</th>
				<th width="10%">작성자</th>
				<th style="width: 15%;">작성일</th>
			</tr>
			<c:forEach var="notice" items="${noticeList}" varStatus="status">
				<tr>
					<td>${notice.nseq }</td>
					<td class="dropTitle">
						<details>
    						<summary>${notice.title }</summary>
    						<p>${notice.content }</p>
						</details>
					</td>
					<td>Eco 관리자</td>
					<td>
						<fmt:formatDate value="${notice.notice_date }" 
									type="date" pattern="yy.MM.dd"/>
					</td>	
				</tr>
			</c:forEach>
		</table>
		
		<%-- <jsp:include page="../../../../static/paging/paging.jsp">
		    <jsp:param value="${paging.page}" name="page"/>
		    <jsp:param value="${paging.beginPage}" name="beginPage"/>
		    <jsp:param value="${paging.endPage}" name="endPage"/>
		    <jsp:param value="${paging.prev}" name="prev"/>
		    <jsp:param value="${paging.next}" name="next"/>
		    <jsp:param value="notice" name="command"/>
		</jsp:include> --%>
	</article>
<%@ include file="../include/headerfooter/footer.jsp" %>