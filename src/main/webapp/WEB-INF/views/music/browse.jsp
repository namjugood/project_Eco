<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article id="music_browse">
    <ul id="themeAndGenre">
        <!-- 차트 -->
        <c:forEach var="chart" items="${chartList}" varStatus="status">
            <li <c:if test="${search.selectedType eq 'chart' and search.selectedSeq eq chart.cseq}">class="selected"</c:if>>
                <a href="/browse?selectedType=chart&selectedSeq=${chart.cseq}">${chart.title}</a>
            </li> 
        </c:forEach>
    
        <!-- 장르 -->
        <c:forEach var="genre" items="${genreList}" varStatus="status">
            <li <c:if test="${search.selectedType eq 'genre' and search.selectedSeq eq genre.gseq}">class="selected"</c:if>>
                <a href="/browse?selectedType=genre&selectedSeq=${genre.gseq}">${genre.title}</a>
            </li> 
        </c:forEach>
    </ul>
    
    <div class="waste">
        <!-- 선택된 타입이 차트면 제목은 차트의 타이틀, 장르면 제목은 장르의 타이틀 (디폴트값이 chart, "1"이기 때문에 otherwise는 구문은 없음)-->
        <h4 class="selectedTitle">
            <c:choose>
                <c:when test="${search.selectedType eq 'chart'}">
                    <c:forEach var="chart" items="${chartList}" varStatus="status">
                        <c:if test="${chart.cseq == search.selectedSeq}">${chart.title}</c:if>
                    </c:forEach>        
                </c:when>
                <c:when test="${search.selectedType eq 'genre'}">
                    <c:forEach var="genre" items="${genreList}" varStatus="status">
                        <c:if test="${genre.gseq == search.selectedSeq}">${genre.title}</c:if>
                    </c:forEach>        
                </c:when>
            </c:choose>
        </h4>
    
        <!-- 전체듣기 -->
        <a class="allListen iconButton" id="playListAddAll" style="cursor: pointer;font-size: 12px;margin-bottom:20px;font-weight: 100;margin-left:20px">
            <span style="font-weight: 100; font-size: 10px; color: #333333;">
                <i class="fas fa-play"></i>
            </span>
            전체듣기
        </a>
    </div>
    
    <%@ include file="../include/musicList.jsp" %>

    <c:if test="${search.paging.totalCount gt search.paging.displayRow}">
        <div id="listMore">
            <a href="/browse?selectedType=${search.selectedType}&selectedSeq=${search.selectedSeq}&page=${search.page + 1}">
                더보기
            </a>
        </div>
    </c:if>
    
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>
