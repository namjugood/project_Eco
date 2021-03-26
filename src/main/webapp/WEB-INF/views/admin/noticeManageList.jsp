<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminhf/header.jsp" %>
	<article style="min-height:500px;margin-top:100px;">
	<div>
		<h1>공지사항 리스트</h1>
	</div>
	    	<div style="position: relative; width: 950px; height: 30px; margin: 0 auto;">
	    		<div style="position: relative; width: 100%; height: 30px;">
			    	<div style="float: left;">
				    	<form action="searchOn" method="get">
				    		<input type="hidden" value="notice" name="tablename">
				    		<input type="hidden" value="nseq" name="ordername">
				    		<input type="hidden" value="title" name="fieldname">
				    		<input type="hidden" value="noticeManageList" name="url">
					    	<label for="name">
					            검색어 : 
					            <input type="text" name="key" value="${key}">
					        </label>
					        <input type="submit" value="검색">
					        <input type="button" value="전체 보기" onclick="location.href='noticeManageList?first=yes'">
					    </form>
			         </div>
			         <div style="float: right;">
			   			<input type="button" value="공지사항 작성" onclick="location.href='noticeInsertForm'">
			        </div>
		        </div>
	        </div>
	        <div style="position: relative; width:950px; margin: 0 auto;">
	        <table border="1" style="width:950px;" style="table-layout: fixed">
	            <thead>
	                <tr>
	                    <th width="20px">번호</th>
	                    <th width="140px">제목</th>
	                    <th width="30px">담당자</th>
	                    <th width="30px">게시일자</th>
	                    <th width="30px">삭제</th> 
	                </tr>
	            </thead>
	            <tbody>
	                <c:choose>
	                    <c:when test="${boardList.size() ne 0}">
	                        <c:forEach var="notice" items="${boardList}" varStatus="status">
	                            <tr>
	                                <td>${notice.nseq}</td>
	                                <td>
		                                <form action="updateForm" method="get">
			                                <input type="hidden" name="key" value="${notice.nseq }">
			                                <input type="hidden" name="tablename" value="notice">
			                                <input type="hidden" name="fieldname" value="nseq">
			                                <input type="hidden" name="url" value="noticeUpdateForm">
			                                <input type="submit" style="cursor: pointer; border-style: none; background: none;"
			                                			 value="${notice.title}">
		                                </form>
	                                </td>
	                                <td>
	                                    Eco
	                                </td>
	                                <td>
	                                    <fmt:formatDate value="${notice.notice_date }" 
												type="date" pattern="yy.MM.dd HH:mm"/>
	                                </td>
	                                <td>
											<form action="boardDelete" method="post">
												<input type="hidden" name="key" value="${notice.nseq }">
												<input type="hidden" name="tablename" value="notice">
			                                	<input type="hidden" name="fieldname" value="nseq">
			                                	<input type="hidden" name="url" value="noticeManageList">
												<input type="submit" class="QnaButtonUD" value="삭제">
											</form>
	                                </td>
	                            </tr>
	                        </c:forEach>
	                    </c:when>
	                    <c:otherwise>
	                        <tr><td colspan="10"><h1 style="margin: 0 auto;font-size: 150%;color: black;min-height: 400px;line-height: 400px;">데이터가 없습니다.</h1></td></tr>
	                    </c:otherwise>
	                </c:choose>
	            </tbody>
	        </table>
	        </div>
		<jsp:include page="paging/paging.jsp">
		
		    <jsp:param value="${paging.page}" name="page"/>
		    <jsp:param value="${paging.beginPage}" name="beginPage"/>
		    <jsp:param value="${paging.endPage}" name="endPage"/>
		    <jsp:param value="${paging.prev}" name="prev"/>
		    <jsp:param value="${paging.next}" name="next"/>
		    <jsp:param value="noticeManageList" name="command"/>
		</jsp:include>
</article>
<script type="text/javascript">
</script>
</body>
</html>