<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp"%>
<style type="text/css">
.searchCategory {
	width: 660px;
	margin: 0 auto;
	height: 30px;
}

.selectedSearch {
	float: left;
	background: none;
	border: 2px solid black;
	margin: 5px;
	width: 100px;
	text-align: center;
	height: 30px;
	line-height: 30px;
	border-radius: 15px 15px;
	cursor: pointer;
}

.selectedSearch:hover {
	background: black;
	color: white;
}

.searchNull {
	width: 100%;
	margin: 0 auto;
}

.searchNull h1 {
	text-align: center;
	line-height: 300px;
}

.boardTable {
	width: 100%;
	border-top: 1px solid #444444;
	border-collapse: collapse;
}

.boardTable td, th {
	border-bottom: 1px solid #CCCCCC;
	padding: 10px;
}
</style>
<article>
	<h1>'${keyward }' 검색 결과</h1>
	<hr>
	<div class="searchCategory">
		<input type="button" class="selectedSearch" value="전체" name="allStd" onclick="selectedCategory(0)">
		<input type="button" class="selectedSearch" value="곡" name="titleStd" onclick="selectedCategory(1)">
		<input type="button" class="selectedSearch" value="앨범" name="albumStd" onclick="selectedCategory(2)">
		<input type="button" class="selectedSearch" value="아티스트" name="artistStd" onclick="selectedCategory(3)">
		<input type="button" class="selectedSearch" value="가사" name="lyricsStd" onclick="selectedCategory(4)">
		<input type="button" class="selectedSearch" value="공지 / FAQ" name="boardStd" onclick="selectedCategory(5)">
	</div>
	<input type="hidden" id="selectedStatus" value="0">
	<div id="searchBox">
		
		<!-- -------------------------------------------------곡 검색 시작--------------------------------------------------- -->
		
		<div id="titleStd">
			<h3>곡으로 검색</h3>
			<c:choose>
				<c:when test="${empty musicList }">
						<div class="searchNull"><h1>검색값이 없습니다.</h1></div>
				</c:when>
				<c:otherwise>
					<table id ="listBox" width="100%">
					<tr>
						<th>곡/앨범</th>
						<th>아티스트</th>
					</tr>
						<c:forEach items="${musicList }" var="musicList" varStatus="status">
							<tr height="84" class="musicTr">
								<input type="hidden" name="mseq" value="${musicList.mseq}">
								<input type="hidden" name="abseq" value="${musicList.abseq}">
								<input type="hidden" name="atseq" value="${musicList.atseq}">
								<input type="hidden" name="title" value="${musicList.title}">
								<input type="hidden" name="src" value="${musicList.src}">
								<input type="hidden" name="abimg" value="${musicList.abimg}">
								<input type="hidden" name="name" value="${musicList.name}">
								<td>
									<div class="justWrap">
										<div class="contentWrap">
											<img src="${musicList.abimg}" alt="" width="60" height="60">
											<a href="musicView?mseq=${musicList.mseq}">
												<c:if test="${fn:contains(pageContext.request.requestURI,'music/albumView')}">
													<c:if test="${musicList.titleyn eq 'Y'}">
														<span style="width:40px;height:16px;border-radius: 2px; color:white; font-weight: bold; background:#3f3fff;font-size:2px;font-weight:600;padding:2px;">TITLE</span>
													</c:if>
												</c:if>
												${musicList.title}
											</a>
											<a href="albumView?abseq=${musicList.abseq}">${musicList.abtitle}</a>
										</div>
									</div>
								</td>
								<td><a href="artistView?atseq=${musicList.atseq}">${musicList.name}</a></td>
							</tr>
						</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>
			<hr>
		</div>	
		
		<!-- -------------------------------------------------곡 검색 끝--------------------------------------------------- -->
		
		<!-- -------------------------------------------------앨범 검색 시작--------------------------------------------------- -->
		<div id="albumStd">
			<h3>앨범으로 검색</h3>
			<c:choose>
				<c:when test="${empty albumList }">
						<div class="searchNull"><h1>검색값이 없습니다.</h1></div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${albumList }" var="albumList" varStatus="status">
						<div id="music_albumView" style="margin-top: 0px;">
							<div class="contentBox">
						        <div class="album">
							            <div class="thumbnail" onclick="return location.href='albumView?abseq=${albumList.abseq}'">
							                <img src="${albumList.img}" alt="">
							                <div id="thumbnail_dim"></div>
							            </div>
						            <div class="info">
						                <ul>
						                    <li style="font-size: 28px;margin-bottom: 10px;height: 40px;">
						                        <a href="albumView?abseq=${albumList.abseq}">
						                            ${albumList.title}
						                        </a>
						                    </li>
						                    <li style="font-size: 16px;margin-bottom: 25px;font-weight:400;">
						                        <a href="artistView?atseq=${albumList.atseq}">
						                            ${albumList.name}
						                        </a>
						                    </li>
						                    <li style="font-size: 15px;margin-bottom: 5px;font-weight:400;">
						                        ${albumList.abtype}
						                        <span style="display:inline;font-size: 8px;font-weight: 100;color:#969696;">l</span>
						                        ${albumList.abgenre}
						                    </li>
						                    <li style="font-size: 15px; color: #969696;font-weight:100;"><fmt:formatDate value="${albumList.pdate}" pattern="yyyy.MM.dd"></fmt:formatDate></li>
						                </ul>
						                <ul class="iconList">
						                    <li>
						                        <a class="iconButton playListAdd">
						                            <span style="font-size: 20px; color: #333333;"><i class="fas fa-outdent"></i></span>
						                        </a>
						                    </li>
						                    <li>
						                        <a class="iconButton myListAdd">
						                            <span style="font-size: 20px; color: #333333;"><i class="fas fa-folder-plus"></i></span>
						                        </a>
						                    </li>
						                    <li>
						                        <a class="iconButton like">
						                            <span style="font-size: 20px; color: #333333;">
						                                <i class="far fa-heart"></i>
						                            </span>
						                        </a>
						                    </li>
						                </ul>
						            </div>
						        </div>
						    </div>
					    </div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<hr>
			</div>
			
			<!-- -------------------------------------------------앨범 검색 끝--------------------------------------------------- -->		
			<!-- -----------------------------------------------아티스트 검색 시작------------------------------------------------- -->
			
			<div id="artistStd">
			<h3>아티스트로 검색</h3>
			<c:choose>
				<c:when test="${empty artistList }">
						<div class="searchNull"><h1>검색값이 없습니다.</h1></div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${artistList }" var="artistList" varStatus="status">
						<div id="music_artistView" style="margin-top: 0px;">
							<div class="contentBox">
						        <div class="artist">
						            <div class="thumbnail">
						                <img src="${artistList.img}" alt="">
						                <div id="thumbnail_dim"></div>
						            </div>
						            <span class="thumbnailPlayBtn" onclick="$('#playListAddAll').trigger('click');">
						                <i class="fas fa-play"></i>
						            </span>
						            <div class="info">
						                <ul>
						                    <li style="font-size: 28px;margin-bottom: 20px;height: 40px;">
						                        <a href="artistView?atseq=${artistList.atseq }">
						                            ${artistList.name}
						                        </a>
						                    </li>
						                    <li style="font-size: 13px;margin-bottom: 5px;font-weight:400;">
						                        <c:choose>
						                            <c:when test="${artistList.groupyn eq 'Y'}">그룹</c:when>
						                            <c:otherwise>솔로</c:otherwise>
						                        </c:choose>
						                        <span style="display:inline;font-size: 8px;font-weight: 100;color:#969696;">l</span>
						                        <c:choose>
						                            <c:when test="${artistList.gender eq 'M'}">남성</c:when>
						                            <c:when test="${artistList.gender eq 'F'}">여성</c:when>
						                            <c:when test="${artistList.gender eq 'A'}">혼성</c:when>
						                            <c:otherwise></c:otherwise>
						                        </c:choose>
						                        <span style="display:inline;font-size: 8px;font-weight: 100;color:#969696;">l</span>
						                        ${artistList.atgenre}
						                    </li>
						                </ul>
						                <ul class="iconList">
						                    <li>
						                        <a class="iconButton unlike" onclick="$music.method.unlike('${artistList.atseq}', null, null);">
						                            <span style="font-size: 24px;color: red;opacity: 1;">
						                                <i class="fas fa-heart"></i>
						                            </span>
						                        </a>
						                        <a class="iconButton like" onclick="$music.method.like('${artistList.atseq}', null, null);">
						                            <span style="font-size: 24px;color: rgb(51, 51, 51);opacity: 1;">
						                                <i class="far fa-heart"></i>
						                            </span>
						                        </a>
						                    </li>
						                    <li style="padding-top: 6px;padding-left: 2px;">
						                        <a class="iconButton playListAdd" onclick="$music.method.musicList.playListAddAll($('#listBox .musicTr'));">
						                            <span style="font-size: 12px;color: rgb(51, 51, 51);opacity: 1;"><i class="fas fa-outdent"></i></span>
						                            <span style="font-size: 11px;font-weight: 500;color: rgb(51, 51, 51);opacity: 1;position: absolute;top: -3px;left: 16px;width: max-content;">인기곡 듣기</span>
						                        </a>
						                    </li>
						                </ul>
						            </div>
						        </div>
						    </div>
					    </div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<hr>
			</div>
			
			<!-- -----------------------------------------------아티스트 검색 끝------------------------------------------------- -->		
			<!-- -----------------------------------------------가사 검색 시작------------------------------------------------- -->
			
			<div id="lyricsStd">
			<h3>가사로 검색</h3>
			<c:choose>
				<c:when test="${empty lyricsList }">
						<div class="searchNull"><h1>검색값이 없습니다.</h1></div>
				</c:when>
				<c:otherwise>
					<table id ="listBox" width="100%" style="table-layout: fixed;">
						<colgroup>
							<col width="250">
							<col width="100">
							<col width="300">
						</colgroup>

						<tr>
							<th>곡/앨범</th>
							<th>아티스트</th>
							<th style="text-align: center;">가사</th>
						</tr>
						<c:forEach items="${lyricsList }" var="lyricsList" varStatus="status">
							<tr height="84" class="musicTr">
								<input type="hidden" name="mseq" value="${lyricsList.mseq}">
								<input type="hidden" name="abseq" value="${lyricsList.abseq}">
								<input type="hidden" name="atseq" value="${lyricsList.atseq}">
								<input type="hidden" name="title" value="${lyricsList.title}">
								<input type="hidden" name="src" value="${lyricsList.src}">
								<input type="hidden" name="abimg" value="${lyricsList.abimg}">
								<input type="hidden" name="name" value="${lyricsList.name}">
								<td class="singleline-ellipsis">
									<div class="justWrap">
										<div class="contentWrap">
											<img src="${lyricsList.abimg}" alt="" width="60" height="60">
											<a href="musicView?mseq=${lyricsList.mseq}">
												<c:if test="${fn:contains(pageContext.request.requestURI,'music/albumView')}">
													<c:if test="${lyricsList.titleyn eq 'Y'}">
														<span style="width:40px;height:16px;border-radius: 2px; color:white; font-weight: bold; background:#3f3fff;font-size:2px;font-weight:600;padding:2px;">TITLE</span>
													</c:if>
												</c:if>
												${lyricsList.title}
											</a>
											<a href="albumView?abseq=${lyricsList.abseq}">${lyricsList.abtitle}</a>
										</div>
									</div>
								</td>
								<td><a href="artistView?atseq=${lyricsList.atseq}">${lyricsList.name}</a></td>
								<td style="text-align: center; padding: 0; margin: 0">
									<div	style="max-height: 80px; text-overflow: ellipsis; overflow: scroll;">
										${lyricsList.content }
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>
			<hr>
			</div>
			
			<!-- -----------------------------------------------가사 검색 끝------------------------------------------------- -->		
			<!-- -----------------------------------------------보드 검색 시작------------------------------------------------- -->
			
			<div id="boardStd">
			<h3>공지사항 찾기</h3>
			<c:choose>
				<c:when test="${empty noticeList }">
						<div class="searchNull"><h1>검색값이 없습니다.</h1></div>
				</c:when>
				<c:otherwise>
					<table class="boardTable">
						<tr><col width="100"><col width="550"><col width="100"><col width="200">
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						<tr>
						<c:forEach items="${noticeList }" var="noticeList" varStatus="status">
						<tr>
							<td style="text-align: center;">${noticeList.nseq }</td>
							<td style="text-align: center;">
								<details>
									<summary>${noticeList.title }</summary>
		    						<p>${noticeList.content }</p>
								</details>
							</td>
							<td style="text-align: center;">ECO</td>
							<td style="text-align: center;"><fmt:formatDate value="${noticeList.notice_date }" 
									type="date" pattern="yy.MM.dd"/></td>
						</tr>
						</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>
			<hr>
			
			<h3>FAQ 찾기</h3>
			<c:choose>
				<c:when test="${empty adqnaList }">
						<div class="searchNull"><h1>검색값이 없습니다.</h1></div>
				</c:when>
				<c:otherwise>
					<table class="boardTable">
						<tr><col width="100"><col width="550"><col width="100"><col width="200">
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						<tr>
						<c:forEach items="${adqnaList }" var="adqnaList" varStatus="status">
						<tr>
							<td style="text-align: center;">${adqnaList.adqseq }</td>
							<td style="text-align: center;">
								<details>
									<summary>${adqnaList.title }</summary>
		    						<p>${adqnaList.content }</p>
								</details>
							</td>
							<td style="text-align: center;">ECO</td>
							<td style="text-align: center;"><fmt:formatDate value="${adqnaList.adqna_date }" 
									type="date" pattern="yy.MM.dd"/></td>
						</tr>
						</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>
			</div>
			<!-- -----------------------------------------------보드 검색 끝------------------------------------------------- -->				
	</div>

	<script type="text/javascript">
	window.onload = function startPage() {
		selectedCategory(0);
	}
	function selectedCategory(x) {
		document.getElementById('selectedStatus').value = x;
		if (document.getElementById('selectedStatus').value == 0) {
			document.getElementById('titleStd').style.display = "";
			document.getElementById('albumStd').style.display = "";
			document.getElementById('artistStd').style.display = "";
			document.getElementById('lyricsStd').style.display = "";
			document.getElementById('boardStd').style.display = "";
		}else if (document.getElementById('selectedStatus').value == 1) {
			document.getElementById('titleStd').style.display = "";
			document.getElementById('albumStd').style.display = "none";
			document.getElementById('artistStd').style.display = "none";
			document.getElementById('lyricsStd').style.display = "none";
			document.getElementById('boardStd').style.display = "none";
		}else if (document.getElementById('selectedStatus').value == 2) {
			document.getElementById('titleStd').style.display = "none";
			document.getElementById('albumStd').style.display = "";
			document.getElementById('artistStd').style.display = "none";
			document.getElementById('lyricsStd').style.display = "none";
			document.getElementById('boardStd').style.display = "none";
		}else if (document.getElementById('selectedStatus').value == 3) {
			document.getElementById('titleStd').style.display = "none";
			document.getElementById('albumStd').style.display = "none";
			document.getElementById('artistStd').style.display = "";
			document.getElementById('lyricsStd').style.display = "none";
			document.getElementById('boardStd').style.display = "none";
		}else if (document.getElementById('selectedStatus').value == 4) {
			document.getElementById('titleStd').style.display = "none";
			document.getElementById('albumStd').style.display = "none";
			document.getElementById('artistStd').style.display = "none";
			document.getElementById('lyricsStd').style.display = "";
			document.getElementById('boardStd').style.display = "none";
		}else if (document.getElementById('selectedStatus').value == 5) {
			document.getElementById('titleStd').style.display = "none";
			document.getElementById('albumStd').style.display = "none";
			document.getElementById('artistStd').style.display = "none";
			document.getElementById('lyricsStd').style.display = "none";
			document.getElementById('boardStd').style.display = "";
		}
	}
</script>
</article>
<%@ include file="../include/headerfooter/footer.jsp"%>