<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminhf/header.jsp" %>
<article style="min-height:500px;margin-top:100px;">
	<h1 style="text-align: center">1:1 문의 답변</h1>
	<div class="qnaWriteBox" style="border: 1px solid black; margin: 0 auto;
			width: 750px;">
			<form action="myqnaA" method="post" name="myqnaA">
			<input type="hidden" value="${bvoList.useq }" name="useq"/>
			<input type="hidden" value="${bvoList.qseq }" name="qseq"/>
			<table>
				<tr>
					<td style="width: 200px; height: 50px; text-align: center;">
						제목
					</td>
					<td style="width: 550px; text-align: center;">
						<input type="hidden" value="${bvoList.title }" name="title"/>
						${bvoList.title }
					</td>
				</tr>
				<tr>
					<td style="width: 25%; height: 200px; text-align: center;">
						내용
					</td>
					<td style="width: 75%; text-align: center;">
						<input type="hidden" value="${bvoList.content }" name="content"/>
						${bvoList.content }
					</td>
				</tr>
				<tr>
						<td style="width: 25%; text-align: center;">
							답변 내용
						</td>
						<td style="width: 75%; text-align: center;">
							<textarea style="resize: none; width: 97%; height: 100px;" value="${bvo.replycontent }"
								name="replycontent"></textarea>
						</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="submit" class="QnaButton" value="작성하기"
							style="cursor: pointer;">
						<input type="button" class="QnaButton" value="돌아가기" onclick="location.href='qnaManageList?first=yes'"
							style="cursor: pointer;">
					</td>
				</tr>
			</table>
			</form>
	</div>
	<div class="popupMessageBox" style="text-align: center">
		메세지 박스 ${message }
	</div>
</article>