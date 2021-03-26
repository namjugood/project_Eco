<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<style>
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
	
	#albumView{
		width:100%;
		height:100%;
		margin-top: -20px;
	    padding-top: 57px;
	}
	#album-list{
		width:417px;
		height:189px;
		margin-top:27px;
		margin-left:22px;
		padding-right:12px;
		position:relative;
		float:left;
	}
	#album-img{
		width:175px;
		height:175px;
		padding-top:14px;
		position:relative;
		float:left;
	}
	
	.photo1 {
	    width: 175px; height: 175px;
	    object-fit: cover;
	    object-position: top;
	    border-radius: 6px;
	}
	
	.photo1:hover {
		background:rgba(0, 0, 0, 0.3);
	}
	
	#album-info{
	    z-index: 10;
	    padding-top: 14px;
	    padding-left: 20px;
		width:217px;
		height:175px;
		position:relative;
		float:left;
		vertical-align: top;
		display: table-cell;
	}
	#album-title{
		position:relative;
		width:204px;
		display: block;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}
	#album-title p{
		margin:0px auto;
	}
	#album-title .title{
	    font-size: 15px;
	    font-weight: 700;
	}
	#album-title .artist{
	    padding-top: 8px;
    	font-size: 14px;
	} 
	#album-info dl{
		padding-top: 15px;
		overflow: hidden;
		margin:0px auto;
	}
	#album-info dl dd{
		position: relative;
	    display: inline;
	    padding: 0 4px 0 5px;
	    font-size: 13px;
	}

	#album-info dl dd.date {
	    display: block;
	    padding: 7px 0 0 0;
	    clear: both;
	    color: #969696;
	}
	
	#album-info dl dd:first-of-type {
	    padding-left: 0;
	}
	
	#album-info dl dd::after {
	    position: absolute;
	    top: 4px;
	    left: 0;
	    display: block;
	    width: 1px;
	    height: 8px;
	    background-color: #dcdcdc;
	    content: "";
	}
	#album-info dd{
		margin:0px;
	}
	.hidden{display:none;}
	
	#album-util{
		width:217px;
		height:23px;
		padding-top:15px;
	    position: absolute;
	    bottom: 16px;
		float:left;
	}
	#album-util a{
		vertical-align: middle;
		margin-right: 14px;
		width:23px;
		height:23px;
	}
	
	#album-img .playbtn {
	    position: absolute;
	    font-weight: 100;
	    font-size: 30px;
	    color: white;
	    right: 12px;
	    bottom: 12px;
	    width: 30px;
	    height: 30px;
	    z-index: 2;
	}
	
	#album-img .playbtn:hover {
	    color: #3f3fff;
	}
</style>

<div id="themeAndGenre">
	<ul>
		<li ><a href='storage'>mybundle</a></li>
		<li ><a href='likemusic'>mymusic</a></li>
		<li class="selected"><a href='likealbum'>myalbum</a></li>
		<li><a href='likeartist'>myartist</a></li>
	</ul>
</div>

<br><br><br>

<article id="albumView">

	<c:choose>
		<c:when test="${albumList.size() > 0}">
			<c:forEach var="ab" items="${albumList}" varStatus="status">
			<div id="trackBox">
				<ul class="filterList">
			    	<!-- <li >
			        	<a class="editMusic" style="cursor: pointer;font-size: 12px;margin-bottom:20px;font-weight: 100; float:right;">
			            	편집
			            </a>
			        </li> -->
			    </ul>
			</div>
            <input type="hidden" name="abseq" value="${ab.abseq}">
            <input type="hidden" name="atseq" value="${ab.atseq}">
            <input type="hidden" name="title" value="${ab.title}">
            <input type="hidden" name="abimg" value="${ab.img}">
            <input type="hidden" name="name" value="${ab.name}">
			<div id="album-list">
				<div id="album-img">
					<a href="albumView?abseq=${ab.abseq}">
						<img class="photo1" src="${ab.img}">
						<span class = "playbtn"onclick="$('#playListAddAll').trigger('click');">
		                    <i class="fas fa-play"></i>
		                </span>
					</a>
				</div>
				<div id="album-info">
					<div id="album-title">
						<p class="title"><a href="albumView?abseq=${ab.abseq}">${ab.title}</a></p>
						<p class="artist"><a href="artistView?atseq=${ab.atseq}">${ab.name}</a></p>
					</div>
					<dl>
						<dt class="hidden">앨범 정보</dt>
						<dd>${ab.abtype}</dd>
						<dd>${ab.abgenre}</dd>
						<dd class="date"><fmt:formatDate value="${ab.pdate}" type="date" pattern="yyyy.MM.dd"/></dd>
					</dl>
					<div id="album-util">
						<a class="iconButton playListAdd" onclick="$music.method.musicList.playListAddAll($('#listBox .musicTr'));">
			            	<span style="font-size: 12px;color: rgb(51, 51, 51);opacity: 1; margin-left:8px;"><i class="fas fa-outdent"></i></span>
			            </a>
			            <a class="iconButton myListAdd" onclick="$music.method.myList.on_listByDetail();">
                            <span style="font-size: 20px; color: #333333;"><i class="fas fa-folder-plus"></i></span>
                        </a>
			            <a class="iconButton unlike" onclick="$music.method.unlike(null, '${ab.abseq}', null);">
                            <span style="font-size: 20px; color: red;">
                                <i class="fas fa-heart"></i>
                            </span>
                        </a>
					</div>
				</div>
			</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			 <div id = "nop">
			 	<h5>좋아하는 앨범을 추가해주세요</h5>
            </div>
		</c:otherwise>
	</c:choose>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>