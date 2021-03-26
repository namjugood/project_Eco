<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<ul style="margin:0; padding:0;">
    <c:choose>
        <c:when test="${albumList.size() eq 0}">
            <h3 style="font-size: 20px;width: 100%;height: 300px;color: #969696;font-weight: 100;text-align: center;line-height: 300px;">
                등록된 앨범이 없습니다.
            </h3>
        </c:when>
        <c:otherwise>
            <c:forEach var="album" items="${albumList}" varStatus="status">
                <li class="albumItem">
                    <c:forEach var="music" items="${album.musicList}" varStatus="status">
                        <form class="musicInfoByAlbum">
                            <input type="hidden" name="mseq" value="${music.mseq}">
                            <input type="hidden" name="abseq" value="${music.abseq}">
                            <input type="hidden" name="atseq" value="${music.atseq}">
                            <input type="hidden" name="title" value="${music.title}">
                            <input type="hidden" name="src" value="${music.src}">
                            <input type="hidden" name="abimg" value="${music.abimg}">
                            <input type="hidden" name="name" value="${music.name}">
                        </form>
                    </c:forEach>
                    <c:forEach var="likeAbseq" items="${likeAlbumList}">
                        <c:if test="${likeAbseq eq album.abseq}">
                            <input type="hidden" name="albumlikeyn" value="y">
                        </c:if>
                    </c:forEach>
                    <div class="album">
                        <div class="thumbnail">
                            <a href="albumView?abseq=${album.abseq}">
                                <img src="${album.img}" style="width: 100%;height: 100%;">
                            </a>
                            <div id="thumbnail_dim"></div>
                            <span onclick="$(this).closest('.album').find('.playListAdd').trigger('click');" style="cursor:pointer;">
                                <i class="fas fa-play"></i>
                            </span>
                        </div>
                        <div class="info">
                            <ul>
                                <li style="font-size: 15px;height: max-content;" class="singleline-ellipsis">
                                    <a href="albumView?abseq=${album.abseq}">
                                        ${album.title}
                                    </a>
                                </li>
                                <li style="font-size: 14px;font-weight:100;height: max-content;color:#333333;">
                                    <a style="color:#333333;cursor: pointer;">
                                        ${album.name}
                                    </a>
                                </li>
                                <li style="font-size: 13px;font-weight:100;margin-top: 12px;height: max-content;">
                                    ${album.abtype}
                                </li>
                                <li style="font-size: 13px; color: #969696;font-weight:100;"><fmt:formatDate value="${album.pdate}" pattern="yyyy.MM.dd"></fmt:formatDate></li>
                            </ul>
                            <ul class="iconList">
                                <li>
                                    <a class="iconButton playListAdd">
                                        <span style="font-size: 16px; color: #333333;"><i class="fas fa-outdent"></i></span>
                                    </a>
                                </li>
                                <li>
                                    <a class="iconButton myListAdd">
                                        <span style="font-size: 16px; color: #333333;"><i class="fas fa-folder-plus"></i></span>
                                    </a>
                                </li>
                                <li>
                                    <a class="iconButton unlike" onclick="$music.method.unlike(null, '${album.abseq}', null);">
                                        <span style="font-size: 16px; color: red;">
                                            <i class="fas fa-heart"></i>
                                        </span>
                                    </a>
                                    <a class="iconButton like" onclick="$music.method.like(null, '${album.abseq}', null);">
                                        <span style="font-size: 16px; color: #333333;">
                                            <i class="far fa-heart"></i>
                                        </span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</ul>