<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<style type="text/css">
	#themeAndGenre li{width:100px; list-style-type: none; margin:10px; float:left;}
	ul li {list-style:none;}
	th{height:80; width:895px;}
	th{padding-left:20px; text-align: left; white-space: nowrap; height: 39px; font-size: 13px; color: #a0a0a0;
		font-weight: 400; border-top: 1px solid #ebebeb;  border-bottom: 1px solid #ebebeb;}
	td{padding-left:20px; text-align: left; white-space: nowrap; height: 39px; font-size: 15px; color: #5D5D5D;
		font-weight: 450; }
	#nop h5{
		padding: 264px 0;
	    text-align: center;
	    color: #bebebe;
	    font-size: 17px;
	    font-weight: bold;
	}
	
</style>

<div id="themeAndGenre">
	<ul>
		<li ><a href='storage'>mybundle</a></li>
		<li class="selected"><a href='likemusic'>mymusic</a></li>
		<li><a href='likealbum'>myalbum</a></li>
		<li><a href='likeartist'>myartist</a></li>
	</ul>
</div>
<br>
<article id="likemusicview" style="margin-top:30px;">
	<c:choose>
		<c:when test="${musicList.size() > 0}">
			<div id="trackBox">
			    <ul class="filterList">
			    	<li >
			            <!-- 전체듣기 -->
			            <a class="allListen iconButton" id="playListAddAll" style="cursor: pointer;font-size: 12px;margin-bottom:20px;font-weight: 100;margin-left:20px">
			            	<span style="font-weight: 100; font-size: 10px; color: #333333;">
			                	<i class="fas fa-play"></i>
			                </span>전체듣기
			            </a>
			            <a class="editMusic" style="cursor: pointer;font-size: 12px;margin-bottom:20px;font-weight: 100; float:right;">
			            	편집
			        	</a>
			        </li>
				</ul>
			</div>
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
			    <c:forEach var="music" items="${musicList}" varStatus="status">
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
				                                            <span style="width:40px;height:16px;border-radius: 2px; color:white; font-weight: bold; background:#3f3fff;font-size:2px;font-weight:600;padding:2px;">TITLE</span>
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
	    </c:when>
	    <c:otherwise>
	    	<div id = "nop">
				<h5>좋아하는 음악을 추가해주세요</h5>
	        </div>
		</c:otherwise>
	</c:choose>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>