<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminhf/header.jsp" %>
<style>
    article * {
        font-size: 95%;
    }
</style>
<article style="min-height:500px;margin-top:100px;position: relative;">
    <h3 style="position: absolute;top:-80px;">${message}</h3>
    <form action="musicManageInsert" method="POST">
        <input type="hidden" name="mseq" value="${music.mseq}" readonly>
        <input type="hidden" name="atseq" value="${music.atseq}" readonly>
        <input type="hidden" name="abseq" value="${music.abseq}" readonly>
        <input type="hidden" name="theme" value="${music.theme}">
        <input type="hidden" name="chart" value="${music.chart}">
        <input type="hidden" name="atimg" value="${music.atimg}">
        <input type="hidden" name="abimg" value="${music.abimg}">


        타이틀 여부 : 
        <label for="titleyn_Y">
            Y<input id="titleyn_Y" type="radio" name="titleyn" value="Y"
            <c:if test="${music.titleyn eq 'Y'}">checked</c:if>
            >
        </label>
        <label for="titleyn_N">
            N<input id="titleyn_N" type="radio" name="titleyn" value="N"
            <c:if test="${empty music.titleyn or music.titleyn eq 'N'}">checked</c:if>
            >
        </label>
        <br>
        <label for="title">
            제목 <input type="text" name="title" value="${music.title}">
        </label>
        <br>
        <div style="width: 30%;display:inline-block;" name="atseq">
            <label for="atseq">
                아티스트: 
                <span id="atname">${music.name}</span>
                <img style="display:block;" id="atimg" src="${music.atimg}" width="100" height="100" onerror="this.src='/upload/noimage.jpg'">
            </label>
            <input type="button" value="find" onclick="find('artist');">
        </div>
        <div style="width: 30%;display:inline-block;" name="abseq">
            <label for="abseq">
                앨범: 
                <span id="abtitle">${music.abtitle}</span>
                <img style="display:block;" id="abimg" src="${music.abimg}" width="100" height="100" onerror="this.src='/upload/noimage.jpg'">
            </label>
            <input type="button" value="find" onclick="find('album');">
        </div>
        <br>
        <div style="width: 30%;display:inline-block;">
            <p>테마</p>
            <div style="width:100%;border: 1px solid gray;height: 100px;overflow-y: scroll;font-size:10px;">
                <c:forEach var="theme" items="${themeList}" varStatus="status">
                    <label for="theme_${theme.tseq}" style="width: 100px;margin: 0;padding:0;display:inline-block;">
                        <input id="theme_${theme.tseq}" type="checkbox" name="tseq" value="${theme.tseq}"
                            <c:forEach var="usersTseq" items="${music.tseqs}" varStatus="status">
                                <c:if test="${usersTseq eq theme.tseq}">checked</c:if>
                            </c:forEach>
                        >${theme.title}
                    </label>    
                </c:forEach>
            </div>
        </div>
        <div style="width: 30%;display:inline-block;">
            <p>차트</p>
            <div style="width:100%;border: 1px solid gray;height: 100px;overflow-y: scroll;font-size:10px;">
                <c:forEach var="chart" items="${chartList}" varStatus="status">
                    <label for="chart_${chart.cseq}" style="width: 100px;margin: 0;padding:0;display:inline-block;">
                        <input id="chart_${chart.cseq}" type="checkbox" name="cseq" value="${chart.cseq}"
                            <c:forEach var="usersCseq" items="${music.cseqs}" varStatus="status">
                                <c:if test="${usersCseq eq chart.cseq}">checked</c:if>
                            </c:forEach>
                        >${chart.title}
                    </label>
                </c:forEach>
            </div>
        </div>
        <div style="width: 30%;display:inline-block;">
            <p>장르</p>
            <div style="width:100%;border: 1px solid gray;height: 100px;overflow-y: scroll;font-size:10px;">
                <c:forEach var="genre" items="${genreList}" varStatus="status">
                    <label for="genre_${genre.gseq}" style="width: 100px;margin: 0;padding:0;display:inline-block;">
                        <input id="genre_${genre.gseq}" type="radio" name="gseq" value="${genre.gseq}"
                                <c:if test="${music.gseq eq genre.gseq}">checked</c:if>
                        >${genre.title}
                    </label>
                </c:forEach>
            </div>
        </div>
        <br>
        <label for="musicby">
            작곡: <input type="text" name="musicby" value="${music.musicby}">
        </label>
        <label for="lyricsby">
            작사: <input type="text" name="lyricsby" value="${music.lyricsby}">
        </label>
        <label for="producingby">
            편곡: <input type="text" name="producingby" value="${music.producingby}">
        </label>
        <br>
        <label for="src">
            음악 링크 <input type="text" name="src" value="${music.src}" style="width:80%;">
        </label>
        <br>
        <br>
        <p>가사</p>
        <textarea name="content" cols="30" rows="10" style="width: 80%;margin: 0 auto;">${music.content}</textarea>
        <br>
        <br>
        <input type="button" value="list" onclick="location.href='musicManageList';">
        <input type="reset" value="cancel">
        <input type="submit" value="save">
    </form>
</article>

<script>
    $(function() {
        $("input:checkbox[name=tseq]").on("click", function() {
            var checkedList = [];
            $("input:checkbox[name=tseq]").each(function() {
                if (this.checked) {
                    checkedList.push($(this).val());
                }
            });
            $("input[name=theme]").val(checkedList.join("|"));
        });
        $("input:checkbox[name=cseq]").on("click", function() {
            var checkedList = [];
            $("input:checkbox[name=cseq]").each(function() {
                if (this.checked) {
                    checkedList.push($(this).val());
                }
            });
            $("input[name=chart]").val(checkedList.join("|"));
        });
    });
    
    function find(type) {
        var popupWidth = window.screen.width - 400;
        var popupHeight = window.screen.height - 400;
        var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width="+popupWidth+", height="+popupHeight+",";
        opt += "top="+getMiddlePosition(popupWidth, popupHeight).popupX+", left="+getMiddlePosition(popupWidth, popupHeight).popupY;
        
        if (type === "artist") {
            var url = "findArtist";
        }
        else if (type === "album") {
            var url = "findAlbum";
        } else {
        }

        window.open(url, url + "popup", opt);
    };

    function getMiddlePosition(popupWidth, popupHeight) {
        return {
            popupX : (window.screen.width / 2) - (popupWidth / 2),
            popupY : (window.screen.height / 2) - (popupHeight / 2),
        };
    }

    
</script>