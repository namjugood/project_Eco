<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/headerfooter/header.jsp" %>
<%
	pageContext.setAttribute("cn", "\n");
%>
<div class="mainTitle"><h1>ECO 추천</h1></div>
	
	<!-- --------------------------------------Top----------------------------------------------- -->
	<!-- <a href="test">
		<div style="width: 100px; height: 100px; background: red; float: left;">
			테스트 이동
		</div>
	</a> -->
	<!-- recommend 화면 모습 -->
        <div class="recommendBox">
			<input type="hidden" value="0" id="bannerNow">
        <!-- 롤링박스 전체 크기 -->
        		<div id="re_Lbtn" onclick="move(1)" style="z-index: 2;">
               		<i class="fas fa-chevron-left fa-4x" ></i>
               </div>
               <div id="re_Rbtn" onclick="move(2)" style="z-index: 2;">
               		<i class="fas fa-chevron-right fa-4x"></i>
               </div> 
               <div id="recommendBoxRo">
               <!-- 롤링 박스 시작 -->
               <input type="hidden" value="${fn:length(bundleList)}" id="bannerSize">
               <c:forEach items="${bundleList }" var="bundleListALL" varStatus="status">
                   <div class="recommend">
                       <div class="recommendThemaBox">
                           <div class="recommendTitle">
                               <c:forEach items="${bundleList }" var="bundle" begin="${status.index}" end="${status.index}">
                                   <h1>${fn:replace(bundle.title, cn, "<br>")}</h1>
                               </c:forEach>
                           </div>
                           <div class="recommendContent">
                               <c:forEach items="${bundleList }" var="bundle" begin="${status.index}" end="${status.index}">
                                   총
                                   ${fn:length(bundle.musicList)}
                                   곡 |
                                   <fmt:formatDate value="${bundle.cdate }" type="date" pattern="yyyy.MM.dd" />
                               </c:forEach>
                           </div>
                           <c:forEach items="${bundleList }" var="bundle" begin="${status.index}" end="${status.index}">
                               <div class="recommendPlayBox">
                                   <i class="fas fa-play-circle fa-4x" onclick="$music.method.musicList.playListAddAllMain($(this).closest('.recommend').find('.mainTr'));"></i>
                               </div>
                           </c:forEach>
                       </div>
                       <div class="recommendThemaListBox">
                           <ul id="recommendChart">
                               <c:forEach items="${bundleList }" var="bundle" begin="${status.index}" end="${status.index}">
                                   <c:forEach var="music" items="${bundle.musicList}" varStatus="status">
                                       <li class="mainTr">
                                           <input type="hidden" name="mseq" value="${music.mseq}">
                                           <input type="hidden" name="abseq" value="${music.abseq}">
                                           <input type="hidden" name="atseq" value="${music.atseq}">
                                           <input type="hidden" name="title" value="${music.title}">
                                           <input type="hidden" name="src" value="${music.src}">
                                           <input type="hidden" name="abimg" value="${music.abimg}">
                                           <input type="hidden" name="name" value="${music.name}">
                                           <div class="albumS">
                                               <a href="musicView?mseq=${music.mseq}">
                                                   <div class="albumImg">
                                                       <img src="${music.abimg}">
                                                   </div>
                                               </a>
                                           </div>
                                           <div class="MusicT">
                                               <a href="musicView?mseq=${music.mseq}">
                                                   ${music.title }
                                               </a>
                                           </div>
                                           <div class="MusicA">
                                               <a href="artistView?atseq=${music.atseq}">
                                                   ${music.name }
                                               </a>
                                           </div>
                                       </li>
                                   </c:forEach>
                               </c:forEach>
                           </ul>
                       </div>
                   </div>
               </c:forEach>
        </div>
       </div>
       <!-- 롤링박스 끝 -->
       
        <div class="rotateButtonBox">
            <div class="rotateButtonAlign">
	            <c:forEach items="${bundleList }" var="bundleListALL" varStatus="status">
	                <div id="rotateButton" style="cursor:pointer;" onclick="rotateBtn(${status.index})"></div>
				</c:forEach>
        	</div>
        </div>
        
<!-- --------------------------------------Middle----------------------------------------------- -->
        
		<h1>최신곡</h1> <!-- 링크 태그 필요 -->
		<div class="mainRecommedBox">
			<c:forEach items="${newMusicList }" var="nlist" begin="0" end="3">
				<div class="MainAlbum">
					<div class="MainAlbumImg">
						<a href="musicView?mseq=${nlist.mseq}">	
					    	<img src="${nlist.abimg}">
					   	</a>
						   <div class="abPlayBtn">
					    		<i class="fas fa-play"></i>
					    </div>
					</div>
					<div class="MainMusicContentBox">
						<a href="musicView?mseq=${nlist.mseq}">
							${nlist.title }
						</a>
					</div>
					<div class="MainMusicContentBox">
						<a href="artistView?atseq=${nlist.atseq}">
							${nlist.name }
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<h1>아티스트 추천</h1>
		<div class="mainRecommedBox">
			<c:forEach items="${recommendArtistList }" var="nlist" begin="0" end="3">
			<div class="MainAlbum">
				<div class="MainAlbumImg" style="border-radius: 50%">
					<a href="artistView?atseq=${nlist.atseq}">	
					    	<img src="${nlist.img}">
					</a>
				</div>
				<div class="MainMusicContentBox">
					<a href="artistView?atseq=${nlist.atseq}">
						${nlist.name }
					</a>
				</div>
				<div class="MainMusicContentBox">
					<a href="/browse?selectedType=genre&selectedSeq=${nlist.gseq}">
						${nlist.atgenre }
					</a>
				</div>
			</div>
			</c:forEach>
		</div>
		
<!-- --------------------------------------botton----------------------------------------------- -->
<c:if test="${message==12}">
	<script>
			alert("이용권 구매가 완료되었습니다. \n즐거운 시간 보내세요");
	</script>
</c:if>
<c:if test="${message==13}">
	<script>
		alert("이용권이 만료되었습니다. \n이용권을 구매하시면 무제한 스트리밍을 계속 즐기실 수 있습니다");
	</script>
</c:if>
<c:if test="${message==11}">
	<script>
		alert("이미 이용권이 구매되어 있습니다. \n 이용권이 만료되면 다시 구매해주세요");
	</script>
</c:if>
<c:if test="${message==10}">
	<script>
		alert("오늘도 ECO와 함께 즐거운 시간 보내세요");
	</script>
</c:if>
 <script type="text/javascript">
		window.onload = function() {
			recommendBoxRo.style.width = "950" * document.getElementById("bannerSize").value + "px";
		}
		function move(x) {
			/* 왼쪽 이동 */
			if (x == 1) {
				if (document.getElementById("bannerNow").value != 0 ) {
					document.getElementById("bannerNow").value = parseInt(document.getElementById("bannerNow").value) - 1
					document.getElementById("recommendBoxRo").style.transform = "translateX(" + (-950)*document.getElementById("bannerNow").value + "px)";
				}
			/* 오른쪽 이동 */
			} else if (x == 2) {
				if (document.getElementById("bannerNow").value != (parseInt(document.getElementById("bannerSize").value)-1) ) {
					document.getElementById("bannerNow").value = parseInt(document.getElementById("bannerNow").value) + 1
					document.getElementById("recommendBoxRo").style.transform = "translateX(" + (-950)*document.getElementById("bannerNow").value + "px)";
				}
			}
		}
		function rotateBtn(n) {
			document.getElementById("recommendBoxRo").style.transform = "translateX(" + (-950)*n + "px)";
			document.getElementById("bannerNow").value = n;
		}
</script>
<%@ include file="include/headerfooter/footer.jsp" %>