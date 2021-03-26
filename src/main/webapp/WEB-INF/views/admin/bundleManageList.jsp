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
</script>
<article style="min-height:500px;margin-top:100px;">
    <form action="bundleManageList" method="GET">
        <input type="hidden" name="searchFilter" value="${search.searchFilter}">
        <label>
            <select name="searchUseyn" onchange="this.form.submit();">
                <option value="">전체</option>
                <option value="Y" <c:if test="${search.searchUseyn eq 'Y'}">selected</c:if>>사용</option>
                <option value="N" <c:if test="${search.searchUseyn eq 'N'}">selected</c:if>>미사용</option>
            </select>
        </label>
        <label for="name">
            <select name="searchkeywordTarget">
                <option value="title" <c:if test="${empty search.searchkeywordTarget or search.searchkeywordTarget eq 'title'}">selected</c:if>>제목</option>
            </select>
            검색어 : 
            <input type="text" name="searchKeyword" value="${search.searchKeyword}">
        </label>
        <input type="submit" value="search">
        <select name="displayRow" onchange="this.form.submit();">
            <option value="5" <c:if test="${search.paging.displayRow eq 5}">selected</c:if>>5개씩 보기</option>
            <option value="10" <c:if test="${search.paging.displayRow eq 10}">selected</c:if>>10개씩 보기</option>
            <option value="15" <c:if test="${search.paging.displayRow eq 15}">selected</c:if>>15개씩 보기</option>
            <option value="20" <c:if test="${search.paging.displayRow eq 20}">selected</c:if>>20개씩 보기</option>
            <option value="30" <c:if test="${search.paging.displayRow eq 30}">selected</c:if>>30개씩 보기</option>
        </select>
        (${search.paging.totalCount})

        <table border="1" style="width:950px;margin: 0 auto;" style="table-layout: fixed">
            <thead>
                <tr>
                    <th width="20px">번호</th>
                    <th><a href="#" onclick="
                            <c:choose>
                                <c:when test="${search.searchFilter eq 'titleAsc'}">document.forms[0].searchFilter.value='titleDesc';</c:when>
                                <c:otherwise>document.forms[0].searchFilter.value='titleAsc';</c:otherwise>
                            </c:choose>
                            document.forms[0].submit();
                        ">제목</a>
                    </th>
                    <th><a href="#" onclick="
                            <c:choose>
                                <c:when test="${search.searchFilter eq 'useynAsc'}">document.forms[0].searchFilter.value='useynDesc';</c:when>
                                <c:otherwise>document.forms[0].searchFilter.value='useynAsc';</c:otherwise>
                            </c:choose>
                            document.forms[0].submit();
                        ">사용여부</a>
                    </th>
                    <th><a href="#" onclick="
                            <c:choose>
                                <c:when test="${search.searchFilter eq 'cdateAsc'}">document.forms[0].searchFilter.value='cdateDesc';</c:when>
                                <c:otherwise>document.forms[0].searchFilter.value='cdateAsc';</c:otherwise>
                            </c:choose>
                            document.forms[0].submit();
                        ">생성일자</a>
                    </th>
                    <th><a href="#" onclick="
                            <c:choose>
                                <c:when test="${search.searchFilter eq 'mucountAsc'}">document.forms[0].searchFilter.value='mucountDesc';</c:when>
                                <c:otherwise>document.forms[0].searchFilter.value='mucountAsc';</c:otherwise>
                            </c:choose>
                            document.forms[0].submit();
                        ">총 곡수</a>
                    </th>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${bundleList.size() ne 0}">
                        <c:forEach var="bundle" items="${bundleList}" varStatus="status">
                            <tr>
                                <td>${bundle.rn}</td>
                                <td><a href="bundleManageUpdateForm?bmseq=${bundle.bmseq}">${bundle.title}</a></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${bundle.useyn eq 'Y'}">사용</c:when>
                                        <c:otherwise>미사용</c:otherwise>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${bundle.cdate}" pattern="yyyy.MM.dd"></fmt:formatDate></td>
                                <td>${bundle.mucount}</td>
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
        <jsp:param value="bundleManageList" name="command"/>

        <jsp:param value="${search.searchFilter}" name="searchFilter"/>
        <jsp:param value="${search.selectedTheme}" name="selectedTheme"/>
        <jsp:param value="${search.selectedChart}" name="selectedChart"/>
        <jsp:param value="${search.selectedGenre}" name="selectedGenre"/>
        <jsp:param value="${search.searchkeywordTarget}" name="searchkeywordTarget"/>
        <jsp:param value="${search.searchKeyword}" name="searchKeyword"/>
        <jsp:param value="${search.searchUseyn}" name="searchUseyn"/>
    </jsp:include>
    <input type="button" value="add" onclick="location.href='bundleManageInsertForm'">
</article>
