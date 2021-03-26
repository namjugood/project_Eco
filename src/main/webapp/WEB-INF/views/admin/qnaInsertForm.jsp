<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminhf/header.jsp" %>
<link rel="stylesheet" href="css/board.css">
	<article style="min-height:500px;margin-top:100px;">
	<h1 style="text-align: center;">자주 묻는 질문 작성</h1>
	<div class="qnaWriteBox" style="border: 1px solid black; margin: 0 auto;
			width: 750px;">
		<form id="adqnaInsert" action="adqnaInsert" method="post" name="adqnaInsertform">
			<table border="1px solid red;">
				<tr>
					<td style="width: 200px; text-align: center;">
						제목
					</td>
					<td style="width: 550px; text-align: center;">
						<input type="text" style="width: 97%;" value="${bvo.title }"
							name="title">
					</td>
				</tr>
				<tr>
					<td style="width: 25%; text-align: center;">
						내용
					</td>
					<td style="width: 75%; text-align: center;">
						<textarea style="resize: none; width: 97%; height: 450px;" value="${bvo.content }"
							name="content"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="submit" class="QnaButton" value="작성하기"
							style="cursor: pointer;">
						<input type="button" class="QnaButton" value="돌아가기" onclick="location.href='qnaManageList'"
							style="cursor: pointer;">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="popupMessageBox" style="text-align: center;">
		메세지 박스 ${message }
	</div>
</article>