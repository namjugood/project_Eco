<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style type="text/css">
        body {
            text-align: center;
        }

        #paging {
            font-size: 150%;
        }

        #paging input[type="button"] {
            background: none;
            border: none;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <div id="paging">
        <form action="${param.command}" method="GET" name="paging">
            <!-- default -->
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="beginPage" value="${param.beginPage}">
            <input type="hidden" name="endPage" value="${param.endPage}">
            <input type="hidden" name="prev" value="${param.prev}">
            <input type="hidden" name="next" value="${param.next}">
            <input type="hidden" name="displayRow" value="${param.displayRow}">

            <!-- 모든 페이지별 필요값 저장 -->
            <input type="hidden" name="searchFilter" value="${param.searchFilter}">
            <input type="hidden" name="selectedGenre" value="${param.selectedGenre}">
            <input type="hidden" name="selectedTheme" value="${param.selectedTheme}">
            <input type="hidden" name="selectedChart" value="${param.selectedChart}">
            <input type="hidden" name="selectedGroupyn" value="${param.selectedGroupyn}">
            <input type="hidden" name="selectedGender" value="${param.selectedGender}">
            <input type="hidden" name="searchkeywordTarget" value="${param.searchkeywordTarget}">
            <input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
            <input type="hidden" name="selectedAbtype" value="${param.selectedAbtype}">
            <input type="hidden" name="searchUseyn" value="${param.searchUseyn}">
            <c:choose>
                <c:when test="${empty param.selectedGseq}"><input type="hidden" name="selectedGseq" value="0"></c:when>
                <c:otherwise><input type="hidden" name="selectedGseq" value="${param.selectedGseq}"></c:otherwise>
            </c:choose>
            
            <!-- 페이징 기본정보에 따른 버튼 출력 -->
            <c:if test="${param.prev}">
                <input type="button" value="◀" onclick="this.form.page.value='${param.beginPage-1}';paging.submit();">
            </c:if>
            <c:forEach begin="${param.beginPage}" end="${param.endPage}" var="index">
                <c:choose>
                    <c:when test="${param.page==index}">
                        <input type="button" value="${index}" style="cursor:default;text-decoration:underline;">
                    </c:when>
                    <c:otherwise>
                        <input type="button" value="${index}" onclick="this.form.page.value='${index}';paging.submit();">
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${param.next}">
                <input type="button" value="▶" onclick="this.form.page.value='${param.endPage+1}';paging.submit();">
            </c:if>
        </form>
    </div>
</body>

</html>