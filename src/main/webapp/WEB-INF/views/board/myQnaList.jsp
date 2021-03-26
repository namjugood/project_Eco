<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>
<style type="text/css">
	#boardListBox { width: 950px; color: black; table-layout: fixed;
				white-space: none; border-collapse: collapse; padding: 5px;
				border-bottom: 5px solid black;}
	#boardListBox tr {height: 50px;}
	#boardListBox th td {border-bottom: 1px solid black;}
</style>
<article class="qna">
	<h1>문의 내역</h1>
	<a href="qnaWrite" class="QnaButton">
			<div>
				문의 작성
			</div>
	</a>
	<a href="qnaList" class="QnaButton" style="margin-right: 5px;">
			<div>
				돌아가기
			</div>
	</a>
		<table id="boardListBox">
			<colgroup>
				<col width="80px">
				<col width="530px">
				<col width="100px">
				<col width="100px">
				<col width="140px">
			</colgroup>
			<tr>
				<th>문의 번호</th>
				<th style="text-align: center;">제목</th>
				<th>답변 여부</th>
				<th>작성일</th>
				<th>기능</th>
			</tr>
			<c:forEach var="qna" items="${myboardList}" varStatus="status">
				<tr style="border-top: 3px solid black;">
					<td>${qna.qseq }</td>
					<td class="dropTitle">
						<details>
    						<summary>${qna.title }</summary>
    						<hr>
    							<div style="text-align: center;">
    								<table>
    									<colgroup>
											<col width="150px">
											<col width="370px">
										</colgroup>
    									<tr>
	    									<td style="border-right: 1px solid black;">문의 내용</td>
	    									<td>${qna.qnacontent }</td>
    									</tr>
    								</table>
    							</div>
   								<c:choose>
  									<c:when test="${empty qna.replycontent}">
  									</c:when>
  									<c:otherwise>
  										<div style="text-align: center;">
    								<table>
    									<colgroup>
											<col width="150px">
											<col width="370px">
										</colgroup>
    									<tr>
    									<hr>
	    									<td style="border-right: 1px solid black;">답변</td>
	    									<td>${qna.replycontent }</td>
    									</tr>
    								</table>
    							</div>
  									</c:otherwise>
   								</c:choose>
						</details>
					</td>
					<td>
						<c:choose>
							<c:when test="${empty qna.replycontent}">
								답변 중
							</c:when>
							<c:otherwise>
	    							답변완료
							</c:otherwise> 
						</c:choose>
					</td>
					<td>
						<fmt:formatDate value="${qna.qna_date }" type="date" pattern="yy.MM.dd"/>
					</td>
					<td style="text-align: center;">
						<div style="margin: 0 auto;">
						<form action="myQnaUpdateForm2" method="get">
							<input type="hidden" name="qseq" value="${qna.qseq }">
							<input type="submit" class="QnaButtonUD"	value="수정">
						</form>
						<form action="myQnaDelete" method="post">
							<input type="hidden" name="qseq" value="${qna.qseq }">
							<input type="submit" class="QnaButtonUD"	value="삭제">
						</form>
						</div>
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
		    <jsp:param value="myQnaList" name="command"/>
		</jsp:include>
</article>
<%@ include file="../include/headerfooter/footer.jsp" %>