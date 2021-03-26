<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table id="listBox" width="100%;">
    <tr>
        <th align="center"><input type="checkbox" name="allCheck"></th>
        <c:if test="${
            fn:contains(pageContext.request.requestURI,'music/browse')
            or fn:contains(pageContext.request.requestURI,'music/albumView')
        }">
            <th align="center">
                <c:choose>
                    <c:when test="${fn:contains(pageContext.request.requestURI,'music/albumView')}">번호</c:when>
                    <c:otherwise>순위</c:otherwise>
                </c:choose>
            </th>
        </c:if>
        <th>곡/앨범</th>
        <th>아티스트</th>
        <th>듣기</th>
        <th>재생목록</th>
        <th>내 리스트</th>
        <th>더보기</th>
    </tr>
    <c:choose>
        <c:when test="${musicList.size() > 0}">
            <c:forEach var="music" items="${musicList}" varStatus="status">
                <tr height="84" class="musicTr">
                    <input type="hidden" name="mseq" value="${music.mseq}">
                    <input type="hidden" name="abseq" value="${music.abseq}">
                    <input type="hidden" name="atseq" value="${music.atseq}">
                    <input type="hidden" name="title" value="${music.title}">
                    <input type="hidden" name="src" value="${music.src}">
                    <input type="hidden" name="abimg" value="${music.abimg}">
                    <input type="hidden" name="name" value="${music.name}">

                    <!-- 좋아하는 음악 시퀀스 목록중 동일하면 isLike 출력 -->
                    <c:forEach var="likeMseq" items="${likeMusicList}">
                        <c:if test="${likeMseq eq music.mseq}">
                            <input type="hidden" name="likeyn" value="y">
                        </c:if>
                    </c:forEach>

                    <td><input type="checkbox" name="mseq_checkbox" value="${music.mseq}"></td>
                    <c:if test="${
                        fn:contains(pageContext.request.requestURI,'music/browse')
                        or fn:contains(pageContext.request.requestURI,'music/albumView')
                    }">
                        <td>${music.rn}</td>
                    </c:if>
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
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="8" style="text-align: center;font-size: 16px;font-weight: 100;height: 200px;">곡이 없습니다.</td>
            </tr>
        </c:otherwise>
    </c:choose>
</table>