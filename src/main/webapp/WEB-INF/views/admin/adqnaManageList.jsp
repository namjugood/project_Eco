<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminhf/header.jsp" %>
	<style type="text/css">
		#btnBox {width: 350px;
					    height: 30px;
					    margin: 0px auto;}
	    .adbtnOn {line-height: 30px;
					    float: left;
					    border: 1px solid black;
					    background: blue;
					    color: white;
					    height: 30px;
					    width: 150px;
					    border-radius: 10px 10px 10px 10px;
					    cursor: pointer;}
		.adbtnOn:hover { background: black;	color: white;}
		.adbtn {line-height: 30px;
				    float: left;
				    border: 1px solid black;
				    height: 30px;
				    width: 150px;
				    border-radius: 10px 10px 10px 10px;
				    cursor: pointer;}
		.adbtn:hover { background: black;	color: white;}
	</style>
	<article style="min-height:500px;margin-top:100px;">
	<div>
		<h1>자주 묻는 질문 관리</h1>
	</div>
	<div id="btnBox">
		<div class="adbtn" style="margin-right: 20px;" onclick="location.href='qnaManageList?first=yes'">1:1 상담</div>
		<div class="adbtnOn" onclick="location.href='adqnaManageList?first=yes'">자주 묻는 질문</div>
	</div><br>
	    	<div style="position: relative; width: 950px; height: 30px; margin: 0 auto;">
	    		<div style="position: relative; width: 100%; height: 30px;">
			    	<div style="float: left;">
				    	<form action="searchOn" method="get">
				    		<input type="hidden" name="key" value="${qna.adqseq }">
                            <input type="hidden" name="tablename" value="adminQna">
                            <input type="hidden" name="fieldname" value="adqseq">
                            <input type="hidden" name="url" value="adqnaManageList">
				    		<input type="hidden" value="adqnaUpdateForm" name="url">
					    	<label for="name">
					            검색어 : 
					            <input type="text" name="key" value="${key}">
					        </label>
					        <input type="submit" value="검색">
					    </form>
			         </div>
			         <div style="float: right;">
			   			<input type="button" value="Q&amp;A 작성" onclick="location.href='adqnaInsertForm'">
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
	                        <c:forEach var="qna" items="${boardList}" varStatus="status">
	                            <tr>
	                                <td>${qna.adqseq}</td>
	                                <td>
		                                <form action="updateForm" method="get">
			                                <input type="hidden" name="key" value="${qna.adqseq }">
				                            <input type="hidden" name="tablename" value="adminQna">
				                            <input type="hidden" name="fieldname" value="adqseq">
				                            <input type="hidden" name="url" value="adqnaUpdateForm">
								    		<input type="hidden" value="adqnaUpdateForm" name="url">
			                                <input type="submit" style="cursor: pointer; border-style: none; background: none;"
			                                			 value="${qna.title}">
		                                </form>
	                                </td>
	                                <td>
	                                   Eco
	                                </td>
	                                <td>
	                                    <fmt:formatDate value="${qna.adQna_date }" 
												type="date" pattern="yy.MM.dd HH:mm"/>
	                                </td>
	                                <td>
											<form action="boardDelete" method="post">
												<input type="hidden" name="key" value="${qna.adqseq }">
					                            <input type="hidden" name="tablename" value="adminQna">
					                            <input type="hidden" name="fieldname" value="adqseq">
									    		<input type="hidden" value="adqnaManageList" name="url">
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
		    <jsp:param value="adqnaManageList" name="command"/>
		</jsp:include>
</article>
<script type="text/javascript">
</script>
</body>
</html>