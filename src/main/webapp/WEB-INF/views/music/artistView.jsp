<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article id="music_artistView">
    <!-- 좋아하는 아티스트 시퀀스 목록중 동일하면 isLike 출력 -->
    <c:forEach var="likeAtseq" items="${likeArtistList}">
        <c:if test="${likeAtseq eq artist.atseq}">
            <input type="hidden" name="artistlikeyn" value="y">
        </c:if>
    </c:forEach>

    <div class="contentBox">
        <div class="artist">
            <div class="thumbnail">
                <img src="${artist.img}" alt="">
                <div id="thumbnail_dim"></div>
            </div>
            <span class="thumbnailPlayBtn" onclick="$('#playListAddAll').trigger('click');">
                <i class="fas fa-play"></i>
            </span>
            <div class="info">
                <ul>
                    <li style="font-size: 28px;margin-bottom: 20px;height: 40px;">
                        <a>
                            ${artist.name}
                        </a>
                    </li>
                    <li style="font-size: 13px;margin-bottom: 5px;font-weight:400;">
                        <c:choose>
                            <c:when test="${artist.groupyn eq 'Y'}">그룹</c:when>
                            <c:otherwise>솔로</c:otherwise>
                        </c:choose>
                        <span style="display:inline;font-size: 8px;font-weight: 100;color:#969696;">l</span>
                        <c:choose>
                            <c:when test="${artist.gender eq 'M'}">남성</c:when>
                            <c:when test="${artist.gender eq 'F'}">여성</c:when>
                            <c:when test="${artist.gender eq 'A'}">혼성</c:when>
                            <c:otherwise></c:otherwise>
                        </c:choose>
                        <span style="display:inline;font-size: 8px;font-weight: 100;color:#969696;">l</span>
                        ${artist.atgenre}
                    </li>
                    <li style="font-size: 13px; color: #969696;font-weight:100;"><fmt:formatDate value="${album.pdate}" pattern="yyyy.MM.dd"></fmt:formatDate></li>
                </ul>
                <ul class="iconList">
                    <li>
                        <a class="iconButton unlike" onclick="$music.method.unlike('${artist.atseq}', null, null);">
                            <span style="font-size: 24px;color: red;opacity: 1;">
                                <i class="fas fa-heart"></i>
                            </span>
                        </a>
                        <a class="iconButton like" onclick="$music.method.like('${artist.atseq}', null, null);">
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

    <ul id="trackAndAlbum">
        <li <c:if test="${search.selectedTab eq 'track'}"> class="selectTab"</c:if>>
            <a href="artistView?atseq=${artist.atseq}&selectedTab=track">곡</a>
        </li>
        <li <c:if test="${search.selectedTab eq 'album'}"> class="selectTab"</c:if>>
            <a href="artistView?atseq=${artist.atseq}&selectedTab=album">앨범</a>
        </li>
    </ul>

    <c:if test="${search.selectedTab eq 'track'}">
        <div id="trackBox">
            <ul class="filterList">
                <li style="float:left;">
                    <!-- 전체듣기 -->
                    <a class="allListen iconButton" id="playListAddAll" style="cursor: pointer;font-size: 12px;margin-bottom:20px;font-weight: 100;margin-left:20px">
                        <span style="font-weight: 100; font-size: 10px; color: #333333;">
                            <i class="fas fa-play"></i>
                        </span>
                        전체듣기
                    </a>
                </li>
                <li>
                    <a href="artistView?atseq=${artist.atseq}&selectedTab=track&searchFilter=titleAsc"<c:if test="${search.searchFilter eq 'titleAsc'}">class="selectedFilter"</c:if>>
                        가나다순
                    </a>
                </li>
                <li>
                    <a href="artistView?atseq=${artist.atseq}&selectedTab=track&searchFilter=pdateDesc"<c:if test="${search.searchFilter eq 'pdateDesc'}">class="selectedFilter"</c:if>>
                        최신순
                    </a>
                </li>
                <li>
                    <a href="artistView?atseq=${artist.atseq}&selectedTab=track&searchFilter=rankAsc"<c:if test="${search.searchFilter eq 'rankAsc'}">class="selectedFilter"</c:if>>
                        인기순
                    </a>
                </li>
                <li>
                    <a href="artistView?atseq=${artist.atseq}&selectedTab=track"<c:if test="${empty search.searchFilter}">class="selectedFilter"</c:if>>
                        전체
                    </a>
                </li>
            </ul>
    
            <%@ include file="../include/musicList.jsp" %>
        </div>
    </c:if>

    <c:if test="${search.selectedTab eq 'album'}">
        <div id="albumBox">
            <ul class="filterList">
                <li>
                    <a href="artistView?atseq=${artist.atseq}&selectedTab=album&searchFilter=titleAsc" <c:if test="${search.searchFilter eq 'titleAsc'}">class="selectedFilter"</c:if>>
                        가나다순
                    </a>
                </li>
                <li>
                    <a href="artistView?atseq=${artist.atseq}&selectedTab=album&searchFilter=pdateDesc" <c:if test="${search.searchFilter eq 'pdateDesc'}">class="selectedFilter"</c:if>>
                        최신순
                    </a>
                </li>
                <li>
                    <a href="artistView?atseq=${artist.atseq}&selectedTab=album&searchFilter=rankAsc" <c:if test="${search.searchFilter eq 'rankAsc'}">class="selectedFilter"</c:if>>
                        인기순
                    </a>
                </li>
                <li>
                    <a href="artistView?atseq=${artist.atseq}&selectedTab=album" <c:if test="${empty search.searchFilter}">class="selectedFilter"</c:if>>
                        전체
                    </a>
                </li>
            </ul>
    
            <%@ include file="../include/albumList.jsp" %>
        </div>
    </c:if>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>