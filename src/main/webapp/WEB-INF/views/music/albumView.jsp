<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article id="music_albumView">
    <!-- 좋아하는 앨범 시퀀스 목록중 동일하면 isLike 출력 -->
    <c:forEach var="likeAbseq" items="${likeAlbumList}">
        <c:if test="${likeAbseq eq album.abseq}">
            <input type="hidden" name="albumlikeyn" value="y">
        </c:if>
    </c:forEach>

    <div class="contentBox">
        <div class="album">
            <div class="thumbnail">
                <img src="${album.img}" alt="">
                <div id="thumbnail_dim"></div>
                <span onclick="$('#playListAddAll').trigger('click');">
                    <i class="fas fa-play"></i>
                </span>
            </div>
            <div class="info">
                <ul>
                    <li style="font-size: 28px;margin-bottom: 10px;height: 40px;">
                        <a href="albumView?abseq=${album.abseq}">
                            ${album.title}
                        </a>
                    </li>
                    <li style="font-size: 16px;margin-bottom: 25px;font-weight:400;">
                        <a href="artistView?atseq=${album.atseq}">
                            ${album.name}
                        </a>
                    </li>
                    <li style="font-size: 15px;margin-bottom: 5px;font-weight:400;">
                        ${album.abtype}
                        <span style="display:inline;font-size: 8px;font-weight: 100;color:#969696;">l</span>
                        ${album.abgenre}
                    </li>
                    <li style="font-size: 15px; color: #969696;font-weight:100;"><fmt:formatDate value="${album.pdate}" pattern="yyyy.MM.dd"></fmt:formatDate></li>
                </ul>
                <ul class="iconList">
                    <li>
                        <a class="iconButton playListAdd" onclick="$music.method.musicList.playListAddAll($('#listBox .musicTr'));">
                            <span style="font-size: 20px; color: #333333;"><i class="fas fa-outdent"></i></span>
                        </a>
                    </li>
                    <li>
                        <a class="iconButton myListAdd" onclick="$music.method.myList.on_listByDetail();">
                            <span style="font-size: 20px; color: #333333;"><i class="fas fa-folder-plus"></i></span>
                        </a>
                    </li>
                    <li>
                        <a class="iconButton unlike" onclick="$music.method.unlike(null, '${album.abseq}', null);">
                            <span style="font-size: 20px; color: red;">
                                <i class="fas fa-heart"></i>
                            </span>
                        </a>
                        <a class="iconButton like" onclick="$music.method.like(null, '${album.abseq}', null);">
                            <span style="font-size: 20px; color: #333333;">
                                <i class="far fa-heart"></i>
                            </span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <ul id="infoAndTrack">
        <li>
            <a>상세정보</a>
        </li> 
        <li class="selectTab">
            <a>수록곡</a>
        </li>
    </ul>

    <div id="infoBox" style="display:none;">
        <ul>
            <li class="title">앨범명</li>
            <li class="value">${album.title}</li>
            <li class="title">아티스트</li>
            <li class="value">${album.name}</li>
        </ul>
        <h3>앨범 소개</h3>
        <c:choose>
            <c:when test="${empty album.content}">
                <h3 style="font-size: 20px;width: 100%;height: 300px;color: #969696;font-weight: 100;text-align: center;line-height: 300px;">
                    등록된 앨범소개가 없습니다.
                </h3>
            </c:when>
            <c:otherwise>
                <pre>${album.content}</pre>
            </c:otherwise>
        </c:choose>
    </div>

    <div id="trackBox">
        <!-- 전체듣기 -->
        <a class="allListen iconButton" id="playListAddAll" style="cursor: pointer;font-size: 12px;margin-bottom:20px;font-weight: 100;margin-left:20px">
            <span style="font-weight: 100; font-size: 10px; color: #333333;">
                <i class="fas fa-play"></i>
            </span>
            전체듣기
        </a>

        <%@ include file="../include/musicList.jsp" %>
    </div>
    
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>
