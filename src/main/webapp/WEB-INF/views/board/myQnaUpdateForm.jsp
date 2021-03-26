<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>
<article>
	<h1>1:1 문의 수정</h1>
	<div class="qnaWriteBox" style="border: 1px solid black; margin: 0 auto;
			width: 750px;">
		<form action="myQnaUpdate" method="post" name="qnaUpdateform">
			<input type="hidden" value="${bvoList.qseq }" name="qseq"/>
			<input type="hidden" value="${bvoList.useq }" name="useq"/>
			<table>
				<tr>
					<td style="text-align: center;">아이디</td>
					<td>&nbsp;${loginUser.id }</td>
					
				</tr>
				<tr>
					<td style="width: 200px; text-align: center;">
						제목
					</td>
					<td style="width: 550px; text-align: center;">
						<input type="text" style="width: 97%;" value="${bvoList.title }"
							name="title">
					</td>
				</tr>
				<tr>
					<td style="width: 25%; text-align: center;">
						내용
					</td>
					<td style="width: 75%; text-align: center;">
						<textarea style="resize: none; width: 97%; height: 450px;"
							name="content">${bvoList.qnacontent }</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="submit" class="QnaButton" value="수정하기"
							style="cursor: pointer;">
						<input type="button" class="QnaButton" value="돌아가기" onclick="location.href='myQnaList'"
							style="cursor: pointer;">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="popupMessageBox">
		메세지 박스 ${message }
	</div>
</article>
<%@ include file="../include/headerfooter/footer.jsp" %>