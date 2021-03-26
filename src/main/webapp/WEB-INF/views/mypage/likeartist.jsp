<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<style type="text/css">
	#themeAndGenre li{width:100px; list-style-type: none; margin:10px; float:left;}
	ul, li, dl{list-style: none;}
	#viewBox{height: 100%;}
	html, body{height:100%;}
	#nop h5{
		padding: 264px 0;
	    text-align: center;
	    color: #bebebe;
	    font-size: 17px;
	    font-weight: bold;
	}

	#artistView{
		width:100%;
		margin-top: -20px;
	    padding-top: 57px;
	}
	#artist-list{
		width:417px;
		height:189px;
		margin-top:27px;
		margin-left:22px;
		padding-right:12px;
		position:relative;
		float:left;
	}
	#artist-img{
		width:175px;
		height:175px;
		padding-top:14px;
		position:relative;
		float:left;
	}
	
	.photo {
	    width: 175px; height: 175px;
	    object-fit: cover;
	    object-position: top;
	    border-radius: 50%;
	}
	
	#artist-info{
		width:217px;
		height:175px;
		padding-top:14px;
		padding-left:20px;
		position:relative;
		float:left;
		vertical-align: middle;
	}
	
	#artist-name{
		width:204px;
		height:18px;
		position: relative;
	}
	#artist-name .artist{
		font-weight: 700;
		font-size: 15px;
		display: block;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}
	.hidden{display:none;}
	
	#artist-info dl {
	    padding-top: 7px;
	    overflow: hidden;
	}
	#artist-info dl dd:first-of-type {
	    padding-left: 0;
	}
	#artist-info dl dd {
	    position: relative;
	    display: inline;
	    padding: 0 4px 0 5px;
	    font-size: 13px;
	}
	#artist-info dl dd::after {
	    position: absolute;
	    top: 4px;
	    left: 0;
	    display: block;
	    width: 1px;
	    height: 8px;
	    background-color: #dcdcdc;
	    content: "";
	}
	#artist-info dd{
		margin:0px;
	}
	
	#artist-util{
		width:217px;
		height:23px;
		padding-top:15px;
		position: relative;
	}
	
	#artist-img .thumbnailPlayBtn {
	   position: absolute;
	    bottom: 1px;
	    left: 120px;
	    width: 60px;
	    height: 60px;
	    background: white;
	    box-shadow: 0px 0px 8px 1px rgb(0 0 0 / 30%);
	    border-radius: 60px;
	    z-index: 1;
	    cursor: pointer;
	}
	
	#artist-img .thumbnailPlayBtn > i {
	    position: absolute;
	    top: 19px;
	    left: 23px;
	    font-size: 24px;
	    width: 24px;
	    height: 24px;
	}
	#artist-util a{
		vertical-align: middle;
	}
	
</style>

<div id="themeAndGenre">
	<ul>
		<li ><a href='storage'>mybundle</a></li>
		<li ><a href='likemusic'>mymusic</a></li>
		<li ><a href='likealbum'>myalbum</a></li>
		<li class="selected"><a href='likeartist'>myartist</a></li>
	</ul>
</div>

<br><br><br>

<article id="artistView">
	
	<c:choose>
		<c:when  test="${artistList.size() > 0}">
			<c:forEach var="at" items="${artistList}" varStatus="status">
			<div id="trackBox">
				<ul class="filterList">
			    	<!-- <li >
			        	<a class="editMusic" style="cursor: pointer;font-size: 12px;margin-bottom:20px;font-weight: 100; float:right;">
			            	편집
			            </a>
			        </li> -->
			    </ul>
			</div>
			<input type="hidden" name="atseq" value="${at.atseq}">
            <input type="hidden" name="atimg" value="${at.img}">
            <input type="hidden" name="name" value="${at.name}">
            <input type="hidden" name="groupyn" value="${at.groupyn}">
            <input type="hidden" name="gender" value="${at.gender}">
				<div id="artist-list">
					<div id="artist-img">
						<a href="artistView?atseq=${at.atseq}">
							<img class="photo" src="${at.img}">
						</a>
						<span class="thumbnailPlayBtn" onclick="$('#playListAddAll').trigger('click');">
			                <i class="fas fa-play"></i>
			            </span>
					</div>
					
					<div id="artist-info">
						<div id="artist-name">
							<p class="artist"><a href="artistView?atseq=${at.atseq}">${at.name}</a>
						</div>
						<dl>
							<dt class="hidden">아티스트 정보</dt>
							<dd>
								<c:if test="${at.groupyn eq 'Y'}">
	                             	그룹
	                            </c:if>
	                            <c:if test="${at.groupyn eq 'N'}">
	                             	솔로
	                            </c:if>
							</dd>
							<dd>
								<c:if test="${at.gender eq 'F'}">여성</c:if>
								<c:if test="${at.gender eq 'M'}">남성</c:if>
								<c:if test="${at.gender eq 'A'}">혼성</c:if>
							</dd>
							<dd>
								${at.atgenre}
							</dd>
						</dl>
						<div id="artist-util">
							<a class="iconButton unlike" onclick="$music.method.unlike('${at.atseq}', null, null);">
			                	<span style="font-size: 20px;color: red;opacity: 1;">
			                    	<i class="fas fa-heart"></i>
			                    </span>
			                </a>
			                <a class="iconButton playListAdd" onclick="$music.method.musicList.playListAddAll($('#listBox .musicTr'));">
			                	<span style="font-size: 12px;color: rgb(51, 51, 51);opacity: 1; margin-left:8px;"><i class="fas fa-outdent">   인기곡 듣기</i></span>
			                </a>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
	        <div id = "nop">
			 	<h5>좋아하는 아티스트를 추가해주세요</h5>
            </div>
		</c:otherwise>
	</c:choose>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>