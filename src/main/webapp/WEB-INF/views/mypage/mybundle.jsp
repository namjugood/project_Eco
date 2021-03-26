<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<style>
	#themeAndGenre li{width:100px; list-style-type: none; margin:10px; float:left;}
	ul, li, dl{list-style: none;}
	html, article{min-height:1000px;}
	#nop{
		padding: 264px 0;
	    text-align: center;
	    color: #bebebe;
	    font-size: 17px;
	}
	#nop h5{
	    font-weight: bold;
	}
	#nop p{
		padding-top: 12px;
	    padding-bottom: 30px;
	    color: #bebebe;
	    font-size: 15px;
	}
	#nop .btn_plus{
		height: 32px;
	    padding: 0 15px;
	    font-size: 14px;
	    line-height: 32px;
	    text-align: center;
	    border-radius: 16px;
	    border: 1px solid rgba(0,0,0,.2);
	    vertical-align: top;
	    display: inline-block;
	}

	#bundleView{
		width:100%;
		margin-top: -20px;
	    padding-top: 57px;
	}
	#bundlelist{
		width:417px;
		height:189px;
		margin-top:27px;
		margin-left:22px;
		padding-right:12px;
		position:relative;
		float:left;
	}
	#bundle-img{
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
	#bundle-info{
		width:217px;
		height:175px;
		padding-top:14px;
		padding-left:20px;
		position:relative;
		float:left;
		vertical-align: middle;
	}
	#bundle-title{
		width:204px;
		height:18px;
		position: relative;
	}
	
	#bundle-title .bundle{
		font-weight: 700;
		font-size: 15px;
		display: block;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}
	.hidden{
		display:none;
	}
	#bundle-info dl {
	    padding-top: 7px;
	    overflow: hidden;
	}
	#bundle-info dl dd {
	    display: inline;
	    padding: 0 4px 0 5px;
	    font-size: 13px;
	}
	
	#bundle-info dl dd.date {
	    display: block;
	    padding: 7px 0 0 0;
	    clear: both;
	    color: #969696;
	}
	
	#bundle-info dd{
		margin:0px;
	}
	
</style>

<div id="themeAndGenre">
	<ul>
		<li class="selected"><a href='storage'>mybundle</a></li>
		<li ><a href='likemusic'>mymusic</a></li>
		<li><a href='likealbum'>myalbum</a></li>
		<li><a href='likeartist'>myartist</a></li>
	</ul>
</div>
<br><br><br>
<article id="bundleView">
	<c:choose>
		<c:when  test="${bundleList.size() > 0}">
			<c:forEach var="bl" items="${bundleList}" varStatus="status">
			<input type="hidden" name="mseq" value="${bl.bmseq}">
				<div id="bundlelist">
					<div id="bundle-img">
                    	<c:choose>
                        	<c:when test="${bl.musicList.size() eq 0}">
                            	<span style="color: white;">
                                	<i class="fas fa-music"></i>
                                </span>
                            </c:when>
                            <c:otherwise>
                            	<a href="bundleDetailView?bmseq=${bl.bmseq}">
                                	<img class="photo1" src="${bl.musicList.get(0).abimg}">
                                </a>
                        	</c:otherwise>
                        </c:choose>
					</div>
					<div id="bundle-info">
						<div id="bundle-title">
							<p class="bundle"><a href="bundleDetailView?bmseq=${bl.bmseq}">${bl.title}</a>
						</div>
						<dl>
							<dt class="hidden">번들리스트 정보</dt>
							<dd>총 ${bl.musicList.size()}곡</dd>
							<dd class="date"><fmt:formatDate value="${bl.cdate }" type="date" pattern="yyyy.MM.dd"/></dd>
						</dl>
						<div id="bundle-util">
							<a class="iconButton playListAdd" onclick="$music.method.musicList.playListAddAll($('#listBox .musicTr'));">
			            		<span style="font-size: 12px;color: rgb(51, 51, 51);opacity: 1; margin-left:8px;"><i class="fas fa-outdent"></i></span>
			            	</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div id = "nop">
			 	<h5>내 리스트가 없습니다.</h5>
			 	<p>새로운 리스트를 추가해주세요</p>
			 	<button type="button" class="btn_plus"><a href="browse">+ 새로운 리스트 만들기</a></button>
            </div>
		</c:otherwise>
	</c:choose>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>