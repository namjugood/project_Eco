<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminhf/header.jsp" %>    
<style>
    article * {
        font-size: 95%;
    }
</style>
<script>
    $(function() {
        if ("${message}" !== "") {
            alert("${message}");
        }
    });

    function ThemeManage(){
        var url = "ThemeManage?first=yes";
        var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=800, ";
        opt = opt + "height=700, top=300, left=300";
        window.open(url, "ThemeManage", opt);
    }
    function ChartManage(){
        var url = "ChartManage?first=yes";
        var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=800, ";
        opt = opt + "height=700, top=300, left=300";
        window.open(url, "ChartManage", opt);
    }
    function GenreManage(){
        var url = "GenreManage?first=yes";
        var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=800, ";
        opt = opt + "height=700, top=300, left=300";
        window.open(url, "GenreManage", opt);
    }
</script>
<article style="min-height:500px;margin-top:100px;">
    <form action="musicManageList" method="GET">
        <input type="hidden" name="searchFilter" value="${search.searchFilter}">
        <input type="button" value="theme" class="submit" onclick="ThemeManage()">
        <input type="button" value="chart" class="submit" onclick="ChartManage()">
        <input type="button" value="genre" class="submit" onclick="GenreManage()">
        <br>
        <label for="selectedTheme">
            theme
            <select id="selectedTheme" name="selectedTheme" onchange="this.form.submit();">
                <option value="">선택안함</option>
                <c:forEach var="item" items="${themeListIncludedMusic}" varStatus="status">
                    <option value="${item.tseq}"
                        <c:if test="${search.selectedTheme eq item.tseq}">selected</c:if>
                    >${item.title}</option>
                </c:forEach>
            </select>
        </label>
        <label for="selectedChart">
            chart
            <select id="selectedChart" name="selectedChart" onchange="this.form.submit();">
                <option value="">선택안함</option>
                <c:forEach var="item" items="${chartListIncludedMusic}" varStatus="status">
                    <option value="${item.cseq}"
                        <c:if test="${search.selectedChart eq item.cseq}">selected</c:if>
                    >${item.title}</option>
                </c:forEach>
            </select>
        </label>
        <label for="selectedGenre">
            genre
            <select id="selectedGenre" name="selectedGenre" onchange="this.form.submit();">
                <option value="">선택안함</option>
                <c:forEach var="item" items="${genreListIncludedMusic}" varStatus="status">
                    <option value="${item.gseq}"
                        <c:if test="${search.selectedGenre eq item.gseq}">selected</c:if>
                    >${item.title}</option>
                </c:forEach>
            </select>
        </label>
        <select name="displayRow" onchange="this.form.submit();">
            <option value="5" <c:if test="${search.paging.displayRow eq 5}">selected</c:if>>5개씩 보기</option>
            <option value="10" <c:if test="${search.paging.displayRow eq 10}">selected</c:if>>10개씩 보기</option>
            <option value="15" <c:if test="${search.paging.displayRow eq 15}">selected</c:if>>15개씩 보기</option>
            <option value="20" <c:if test="${search.paging.displayRow eq 20}">selected</c:if>>20개씩 보기</option>
            <option value="30" <c:if test="${search.paging.displayRow eq 30}">selected</c:if>>30개씩 보기</option>
        </select>
        (${search.paging.totalCount})
        <br>
        <label for="name">
            <select name="searchkeywordTarget">
                <option value="title" <c:if test="${empty search.searchkeywordTarget or search.searchkeywordTarget eq 'title'}">selected</c:if>>곡제목</option>
                <option value="abtitle" <c:if test="${search.searchkeywordTarget eq 'abtitle'}">selected</c:if>>앨범제목</option>
                <option value="name" <c:if test="${search.searchkeywordTarget eq 'name'}">selected</c:if>>아티스트이름</option>
            </select>
            검색어 : 
            <input type="text" name="searchKeyword" value="${search.searchKeyword}">
        </label>
        <input type="submit" value="search">
        <table border="1" style="width:950px;margin: 0 auto;" style="table-layout: fixed">
            <thead>
                <tr>
                    <th width="20px">번호</th>
                    <th width="100px"><a href="#"
                        onclick="
                            <c:choose>
                                <c:when test="${search.searchFilter eq 'titleAsc'}">document.forms[0].searchFilter.value='titleDesc';</c:when>
                                <c:otherwise>document.forms[0].searchFilter.value='titleAsc';</c:otherwise>
                            </c:choose>
                            document.forms[0].submit();
                        ">제목</a>
                    </th>
                    <th width="60px"><a href="#"
                        onclick="
                            <c:choose>
                                <c:when test="${search.searchFilter eq 'nameAsc'}">document.forms[0].searchFilter.value='nameDesc';</c:when>
                                <c:otherwise>document.forms[0].searchFilter.value='nameAsc';</c:otherwise>
                            </c:choose>
                            document.forms[0].submit();
                        ">아티스트이름</a>
                    </th>
                    <th width="60px"><a href="#"
                        onclick="
                            <c:choose>
                                <c:when test="${search.searchFilter eq 'abtitleAsc'}">document.forms[0].searchFilter.value='abtitleDesc';</c:when>
                                <c:otherwise>document.forms[0].searchFilter.value='abtitleAsc';</c:otherwise>
                            </c:choose>
                            document.forms[0].submit();
                        ">앨범제목</a>
                    </th>
                    <th width="20px"><a href="#"
                        onclick="
                            <c:choose>
                                <c:when test="${search.searchFilter eq 'rankAsc'}">document.forms[0].searchFilter.value='rankDesc';</c:when>
                                <c:otherwise>document.forms[0].searchFilter.value='rankAsc';</c:otherwise>
                            </c:choose>
                            document.forms[0].submit();
                        ">순위</a>
                    </th>
                    <th width="20px"><a href="#"
                        onclick="
                            <c:choose>
                                <c:when test="${search.searchFilter eq 'likecountAsc'}">document.forms[0].searchFilter.value='likecountDesc';</c:when>
                                <c:otherwise>document.forms[0].searchFilter.value='likecountAsc';</c:otherwise>
                            </c:choose>
                            document.forms[0].submit();
                        ">좋아요</a>
                    </th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${musicList.size() ne 0}">
                        <c:forEach var="music" items="${musicList}" varStatus="status">
                            <tr>
                                <td>${music.rn}</td>
                                <td><a href="musicManageUpdateForm?mseq=${music.mseq}">${music.title}</a></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty music.atimg}">
                                            <img src="${music.atimg}" width="50" height="50">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/upload/noimage.jpg" width="50" height="50">
                                        </c:otherwise>
                                    </c:choose>
                                    <br>
                                    ${music.name}
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty music.abimg}">
                                            <img src="${music.abimg}" width="50" height="50">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/upload/noimage.jpg" width="50" height="50">
                                        </c:otherwise>
                                    </c:choose>
                                    <br>
                                    ${music.abtitle}
                                </td>
                                <td>${music.rank}</td>
                                <td>${music.likecount}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="10"><h1 style="margin: 0 auto;font-size: 150%;color: black;min-height: 400px;line-height: 400px;">데이터가 없습니다.</h1></td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </form>

    <jsp:include page="paging/paging.jsp">
        <jsp:param value="${search.paging.page}" name="page"/>
        <jsp:param value="${search.paging.beginPage}" name="beginPage"/>
        <jsp:param value="${search.paging.endPage}" name="endPage"/>
        <jsp:param value="${search.paging.prev}" name="prev"/>
        <jsp:param value="${search.paging.next}" name="next"/>
        <jsp:param value="${search.paging.displayRow}" name="displayRow"/>
        <jsp:param value="musicManageList" name="command"/>

        <jsp:param value="${search.searchFilter}" name="searchFilter"/>
        <jsp:param value="${search.selectedTheme}" name="selectedTheme"/>
        <jsp:param value="${search.selectedChart}" name="selectedChart"/>
        <jsp:param value="${search.selectedGenre}" name="selectedGenre"/>
        <jsp:param value="${search.searchkeywordTarget}" name="searchkeywordTarget"/>
        <jsp:param value="${search.searchKeyword}" name="searchKeyword"/>
    </jsp:include>
    <input type="button" value="add" onclick="location.href='musicManageInsertForm'">
</article>