<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<script>
    $(function() {
        $music.data.myList.items = [];
        $music.data.myList.items.push({
            mseq : $("#music_musicView .contentBox").find("input[name=mseq]").val() * 1,
            abseq : $("#music_musicView .contentBox").find("input[name=abseq]").val() * 1,
            atseq : $("#music_musicView .contentBox").find("input[name=atseq]").val() * 1,
            title : $("#music_musicView .contentBox").find("input[name=title]").val(),
            src : $("#music_musicView .contentBox").find("input[name=src]").val(),
            abimg : $("#music_musicView .contentBox").find("input[name=abimg]").val(),
            name : $("#music_musicView .contentBox").find("input[name=name]").val(),
        });
    })
</script>

<article id="music_musicView">
    <div class="contentBox">
        <form style="position: absolute;width:0px;height:0px;">
            <input type="hidden" name="mseq" value="${music.mseq}">
            <input type="hidden" name="abseq" value="${music.abseq}">
            <input type="hidden" name="atseq" value="${music.atseq}">
            <input type="hidden" name="title" value="${music.title}">
            <input type="hidden" name="src" value="${music.src}">
            <input type="hidden" name="abimg" value="${music.abimg}">
            <input type="hidden" name="name" value="${music.name}">
        </form>

        <!-- 좋아하는 음악 시퀀스 목록중 동일하면 isLike 출력 -->
        <c:forEach var="likeMseq" items="${likeMusicList}">
            <c:if test="${likeMseq eq music.mseq}">
                <input type="hidden" name="musiclikeyn" value="y">
            </c:if>
        </c:forEach>

        <!-- 무시한 음악 시퀀스 목록중 동일하면 isBan 출력 -->
        <c:forEach var="banMseq" items="${banMusicList}" varStatus="status">
            <c:if test="${banMseq eq music.mseq}">
                <input type="hidden" name="musicbanyn" value="y">
            </c:if>
        </c:forEach>
        
        <div class="music">
            <div class="thumbnail">
                <img src="${music.abimg}" alt="">
                <div id="thumbnail_dim"></div>
                <span onclick="$music.method.musicList.playListAddMusic($('#music_musicView').find('form'));">
                    <i class="fas fa-play"></i>
                </span>
            </div>
            <div class="info">
                <ul>
                    <li style="font-size: 28px;margin-bottom: 10px;height: 40px;">
                        <a href="albumView?abseq=${music.abseq}" style="color:#333333;">
                            ${music.title}
                        </a>
                    </li>
                    <li style="font-size: 16px;margin-bottom: 25px;font-weight:400;">
                        <a href="artistView?atseq=${music.atseq}" style="color:#333333;">
                            ${music.name}
                        </a>
                    </li>
                    <li style="font-size: 15px;margin-bottom: 5px;font-weight:400;">
                        ${music.abtitle}
                    </li>
                </ul>
                <ul class="iconList">
                    <li>
                        <a class="iconButton playListAdd" onclick="$music.method.musicList.playListAddForm($('#music_musicView').find('form'));">
                            <span style="font-size: 20px; color: #333333;"><i class="fas fa-outdent"></i></span>
                        </a>
                    </li>
                    <li>
                        <a class="iconButton myListAdd" onclick="$music.method.myList.on_listByDetail();">
                            <span style="font-size: 20px; color: #333333;"><i class="fas fa-folder-plus"></i></span>
                        </a>
                    </li>
                    <li>
                        <a class="iconButton unlike" onclick="$music.method.unlike(null, null, '${music.mseq}');">
                            <span style="font-size: 20px; color: red;">
                                <i class="fas fa-heart"></i>
                            </span>
                        </a>
                        <a class="iconButton like" onclick="$music.method.like(null, null, '${music.mseq}');">
                            <span style="font-size: 20px; color: #333333;">
                                <i class="far fa-heart"></i>
                            </span>
                        </a>
                    </li>
                    <li>
                        <a class="iconButton unban" onclick="$music.method.unban('${music.mseq}');">
                            <span style="font-size: 20px; color: red;"><i class="fas fa-ban"></i></span>
                        </a>
                        <a class="iconButton ban" onclick="$music.method.ban('${music.mseq}');">
                            <span style="font-size: 20px; color: #333333;"><i class="fas fa-ban"></i></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <ul id="infoAndTrack">
        <li class="selectTab">
            <a>상세정보</a>
        </li> 
        <li>
            <a>유사곡</a>
        </li>
    </ul>

    <div id="infoBox">
        <ul>
            <li class="title">곡명</li>
            <li class="value">${music.title}</li>
            <c:if test="${not empty music.musicby}">
                <li class="title">작곡</li>
                <li class="value">${music.musicby}</li>
            </c:if>
            <c:if test="${not empty music.lyricsby}">
                <li class="title">작사</li>
                <li class="value">${music.lyricsby}</li>
            </c:if>
            <c:if test="${not empty music.producingby}">
                <li class="title">편곡</li>
                <li class="value">${music.producingby}</li>
            </c:if>
        </ul>
        <c:choose>
            <c:when test="${empty music.content}">
                <h3 style="font-size: 20px;width: 100%;height: 300px;color: #969696;font-weight: 100;text-align: center;line-height: 300px;">
                    등록된 가사가 없습니다.
                </h3>
            </c:when>
            <c:otherwise>
                <pre><c:out value="${music.content}" escapeXml="false" /></pre>
            </c:otherwise>
        </c:choose>
    </div>

    <div id="trackBox" style="display: none;">
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
