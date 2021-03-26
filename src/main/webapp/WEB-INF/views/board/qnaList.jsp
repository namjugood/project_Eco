<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>
	<article class="qna">
		<h1>Eco 자주 묻는 질문</h1>
		<a href="myQnaList?page=1" class="QnaButton">
			<div>
				1:1 문의
			</div>
		</a>
		<table id="listBox" style="width: 950px; color: black">
			<tr>
				<th width="10%">번호</th>
				<th width="65%">제목</th>
				<th width="10%">작성자</th>
				<th style="width: 15%;">작성일</th>
			</tr>
			<c:forEach var="qna" items="${qnaList}" varStatus="status">
				<tr>
					<td>${qna.adqseq }</td>
					<td class="dropTitle">
						<details>
    						<summary>${qna.title }</summary>
    						<p>${qna.content }</p>
						</details>
					</td>
					<td>Eco 관리자</td>
					<td>
						<fmt:formatDate value="${qna.adQna_date }" 
									type="date" pattern="yy.MM.dd"/>
					</td>	
				</tr>
			</c:forEach>
		</table>
		
		<jsp:include page="../admin/paging/paging.jsp">
		    <jsp:param value="${paging.page}" name="page"/>
		    <jsp:param value="${paging.beginPage}" name="beginPage"/>
		    <jsp:param value="${paging.endPage}" name="endPage"/>
		    <jsp:param value="${paging.prev}" name="prev"/>
		    <jsp:param value="${paging.next}" name="next"/>
		    <jsp:param value="qnaList" name="command"/>
		</jsp:include>
	</article>
<%@ include file="../include/headerfooter/footer.jsp" %>