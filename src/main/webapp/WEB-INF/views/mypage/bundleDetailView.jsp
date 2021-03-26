<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/headerfooter/header.jsp" %>

<style>
#themeAndGenre li{width:100px; list-style-type: none; margin:10px; float:left;}
th{height:80; width:895px;}
th{padding-left:20px; text-align: left; white-space: nowrap; height: 39px; font-size: 13px; color: #a0a0a0;
	font-weight: 400; border-top: 1px solid #ebebeb;  border-bottom: 1px solid #ebebeb;}
td{padding-left:20px; text-align: left; white-space: nowrap; height: 39px; font-size: 15px; color: #5D5D5D;
	font-weight: 450; }
#bundleDetailView{width:100%; height:auto; padding-top:50px;}
#bundled-inner{width:845px; height:245px; padding-left:50px; position: relative;}
#bundled-mainImg{width:240px; height:240px; position: relative; float:left; margin:0px;}

#bundled-area {
	float:right;
    width: 550px;
    padding-top: 12px;
    padding-right: 30px;
    margin-left:10px;
}
.bd-title {
    overflow: inherit;
    white-space: normal;
    padding-top: 20px;
    font-size: 28px;
    word-break: break-all;
    webkit-box-orient: vertical;
    webkit-line-clamp: 2;
    line-height: 41px;
    margin-bottom:10px;
}
#bundled-area dl{
	overflow: hidden;
    padding-top: 10px;
    margin:0px;
}
#bundled-area dd{
	padding-left: 0;
	font-size: 15px;
    padding: 0 9px 0 0px;
    margin:0px;
}
#bundled-area dl dd.date {
	    display: block;
	    padding: 7px 0 0 0;
	    clear: both;
	    color: #969696;
	}
.photo1 {
	    width:240px; height:240px
	    object-fit: cover;
	    object-position: top;
	    border-radius: 6px;
	}
	
	.photo1:hover {
		background:rgba(0, 0, 0, 0.3);
	}
	#bundled-util{
		margin-top:15px;
	}
	#bundled-mainImg > img:hover {
	    color: #3f3fff;
	}
.hidden{display:none;}

</style>
<script>
function deleteAction(){
	var count=0;
	if( document.formm.mseq.length==undefined )
		if( document.formm.mseq.checked == true )
			count++;
	for( var i=0; i<document.formm.mseq.length; i++ )
		if( document.formm.mseq[i].checked == true )
			count++;
	if ( count==0 )
		alert("삭제할 항목을 선택하세요");
	else {
		document.formm.action = "BDMDelete";
		document.formm.submit();
	} 
}
</script>
<article id="bundleDetailView">
<c:choose>
	<c:when test="${bundleList.size() > 0}">
		<c:forEach var="bundle" items="${bundleList}" varStatus="status">
		<input type="hidden" name="title" value="${bundle.title}">
		<input type="hidden" name="cdate" value="${bundle.cdate}">
		<!-- 전체적인 번들 마스트 -->
			<div id="bundled-inner">
				<div id="bundled-mainImg">
					<div class="bundled-img">
					<!-- 번들마스터 이미지 가져오기 -->
						<div class="main-img">
                            <img class="photo1" src="${bundle.musicList.get(0).abimg}">
						</div>
					<!--  -->
					<div id="bundled-util"></div>
					</div>
				</div>
				<div id="bundled-area">
					<div id="bundled-title">
						<p class="bd-title" >${bundle.title}
							<a class="iconButton editPen">&nbsp;
					        	<span style="font-size: 20px; color: #333333;"><i class="fas fa-pen"></i></span>
					        </a>
				        </p>
					</div>
					<dl>
						<dt class="hidden">테마리스트 정보</dt>
						<dd>총 ${bundle.musicList.size()}곡</dd>
						<dd class="date"><fmt:formatDate value="${bundle.cdate}" type="date" pattern="yyyy.MM.dd"/></dd>
					</dl>
					<div id="bundled-util">
						<a class="iconButton playListAdd" onclick="$music.method.musicList.playListAddAll($('#listBox .musicTr'));">
			            	<span style="size: 15px;color: rgb(51, 51, 51);opacity: 1; "><i class="fas fa-outdent"></i></span>
			            </a>
					</div>
				</div>
			</div>
			<br><br>
			<div id="trackBox">
            <ul class="filterList">
                <li >
                    <!-- 전체듣기 -->
                    <a class="allListen iconButton" id="playListAddAll" style="cursor: pointer;font-size: 12px;margin-bottom:20px;font-weight: 100;margin-left:20px">
                        <span style="font-weight: 100; font-size: 10px; color: #333333;">
                            <i class="fas fa-play"></i>
                        </span>
                        전체듣기
                    </a>
                    <a href="#" class="delMusic" style="cursor: pointer;font-size: 12px;margin-bottom:20px;font-weight: 100; float:right;" onclick="deleteAction()">
                        삭제
                    </a>
                </li>
            </ul>
   			</div>
			<!-- 번들 안의 음악 리스트 -->
			<div id="bundled-musicList">
				<table id="listBox">
			       <tr>
			           <th align="center"><input type="checkbox" name="allCheck"></th>
			           <th>곡/앨범</th>
			           <th>아티스트</th>
			           <th>듣기</th>
			           <th>재생목록</th>
			           <th>내 리스트</th>
			           <th>더보기</th>
			       </tr>
			       	<c:forEach var="music" items="${bundle.musicList }" >
						<tr height="84" class="musicTr">
			            	<input type="hidden" name="mseq" value="${music.mseq}">
			                <input type="hidden" name="abseq" value="${music.abseq}">
			                <input type="hidden" name="atseq" value="${music.atseq}">
			                <input type="hidden" name="title" value="${music.title}">
			                <input type="hidden" name="abimg" value="${music.abimg}">
			                <input type="hidden" name="name" value="${music.name}">
			                <!-- 좋아하는 음악 시퀀스 목록중 동일하면 isLike 출력 -->
				            <c:forEach var="likeMseq" items="${likeMusicList}">
				            	<c:if test="${likeMseq eq music.mseq}">
				                	<input type="hidden" name="likeyn" value="y">
				                </c:if>
				            </c:forEach>
			                        
			                <td><input type="checkbox" name="mseq_checkbox" value="${music.mseq}"></td>
			                <td>
			                	<div class="justWrap">
			                    	<div class="contentWrap">
			                            <img src="${music.abimg}" alt="" width="60" height="60">
			                            <a href="musicView?mseq=${music.mseq}">
				                        	<c:if test="${fn:contains(pageContext.request.requestURI,'music/albumView')}">
					                            <c:if test="${music.titleyn eq 'Y'}">
					                            	<span style="width:40px;height:16px;border-radius: 2px; color:white; font-weight: bold;
					                            		 background:#3f3fff;font-size:2px;font-weight:600;padding:2px;">TITLE</span>
					                            </c:if>
				                            </c:if>
				                            ${music.title}
			                            </a>
			                        	<a href="albumView?abseq=${music.abseq}">${music.abtitle}</a>
			                        </div>
			                	</div>
			                </td>
			                <td><a href="artistView?atseq=${music.atseq}">${music.name}</a></td>
			                <!-- 듣기 -->
				            <td style="text-align: center; padding: 0; margin: 0">
					        	<a class="iconButton listen">&nbsp;
					            	<span style="font-size: 20px; color: #333333;"><i class="fas fa-play"></i></span>
					            </a>
				            </td>
				            <!-- 재생목록 -->
				            <td style="text-align: center; padding: 0; margin: 0">
				            	<a class="iconButton playListAdd">&nbsp;
				                	<span style="font-size: 20px; color: #333333;"><i class="fas fa-outdent"></i></span>
				                </a>
				            </td>
				            <!-- 내 리스트 -->
				            <td style="text-align: center; padding: 0; margin: 0">
				            	<a class="iconButton myListAdd">&nbsp;
				                	<span style="font-size: 20px; color: #333333;"><i class="fas fa-folder-plus"></i></span>
				                </a>
				            </td>
				            <!-- 더보기 -->
				            <td style="text-align: center; padding: 0; margin: 0">
				            	<a class="iconButton moreDiv">&nbsp;
				                	<span style="font-size: 20px; color: #333333;"><i class="fas fa-ellipsis-v"></i></span>
				                </a>
				            </td>
			        	</tr>
					</c:forEach>
				</table>
			</div>
			</c:forEach>
		</c:when>
	<c:otherwise>
		<tr colspan="7" style="text-align: center;">곡이 없습니다. 리스트에 곡을 추가해주세요</tr>
	</c:otherwise>
</c:choose>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>