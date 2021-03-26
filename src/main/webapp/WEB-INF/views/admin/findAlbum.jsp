<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <head>
        <meta charset="UTF-8">
        <title>앨범 찾기</title>
        <script src="js/jquery-3.5.1-min.js"></script>
        <style>
            * {
                font-size: 95%;
            }
        </style>
        <script>
            $(function() {
                if ("${message}" !== "") {
                    alert("${message}");
                }
        
                $("tbody > tr")
                .mouseover(function() {
                    $(this).css({
                        backgroundColor: "#3f3fff",
                        color: "white",
                        cursor: "pointer"
                    });
                })
                .mouseleave(function() {
                    $(this).css({
                        backgroundColor: "white",
                        color: "black",
                    })
                })
                .click(function() {
                    if(confirm("해당 앨범으로 선택하시겠습니까? \n(아티스트가 다를 경우, 선택한 앨범의 아티스트로 자동 저장됩니다.)")) {
                        var abseq = $(this).find("input[name=abseq]").val();
                        var atseq = $(this).find("input[name=atseq]").val();
                        var title = $(this).find("input[name=title]").val();
                        var img = $(this).find("input[name=img]").val();
                        var content = $(this).find("input[name=content]").val();
                        var abtype = $(this).find("input[name=abtype]").val();
                        var gseq = $(this).find("input[name=gseq]").val();
                        var pdate = $(this).find("input[name=pdate]").val();
                        var name = $(this).find("input[name=name]").val();
        
                        $(window.opener.document).find("input[name=abseq]").val(abseq);
                        $(window.opener.document).find("#abtitle").text(title);
                        $(window.opener.document).find("input[name=atseq]").val(atseq);
                        $(window.opener.document).find("input[name=atimg]").val($(this).find("#atimg").attr("src"));
                        $(window.opener.document).find("input[name=abimg]").val($(this).find("#abimg").attr("src"));
                        $(window.opener.document).find("#atimg").attr("src", $(this).find("#atimg").attr("src"));
                        $(window.opener.document).find("#abimg").attr("src", img);
                        $(window.opener.document).find("#atname").text(name);
                        
                        self.close();
                    }
                });
            });
        </script>
    </head>

    <body>
        <article style="min-height:500px;">
            <form action="findAlbum" method="GET">
                <input type="hidden" name="atseq" value="${search.atseq}">
                <input type="hidden" name="searchFilter" value="${search.searchFilter}">
        
                <label for="selectedAbtype">
                    앨범종류
                    <select id="selectedAbtype" name="selectedAbtype" onchange="this.form.submit();">
                        <option value="">선택안함</option>
                        <c:forEach var="abtype" items="${abtypeListByAlbum}" varStatus="status">
                            <option value="${abtype}"
                                <c:if test="${search.selectedAbtype eq abtype}">selected</c:if>
                            >${abtype}</option>
                        </c:forEach>
                    </select>
                </label>
                <label for="selectedGseq">
                    앨범장르
                    <select id="selectedGseq" name="selectedGseq" onchange="this.form.submit();">
                        <option value="0">선택안함</option>
                        <c:forEach var="genre" items="${genreListByAlbum}" varStatus="status">
                            <option value="${genre.gseq}"
                                <c:if test="${search.selectedGseq eq genre.gseq}">selected</c:if>
                            >${genre.title}</option>
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
                        <option value="title" <c:if test="${empty search.searchkeywordTarget or search.searchkeywordTarget eq 'title'}">selected</c:if>>앨범제목</option>
                        <option value="name" <c:if test="${search.searchkeywordTarget eq 'name'}">selected</c:if>>아티스트이름</option>
                    </select>
                    검색어 : 
                    <input type="text" name="searchKeyword" value="${search.searchKeyword}">
                </label>
                <input type="submit" value="search">
                <table border="1" style="width:950px;margin: 0 auto;" style="table-layout: fixed">
                    <thead>
                        <tr>
                            <th width="10px">번호</th>
                            <th width="10px"><a href="#"
                                onclick="
                                    <c:choose>
                                        <c:when test="${search.searchFilter eq 'atseqAsc'}">document.forms[0].searchFilter.value='atseqDesc';</c:when>
                                        <c:otherwise>document.forms[0].searchFilter.value='atseqAsc';</c:otherwise>
                                    </c:choose>
                                    document.forms[0].submit();
                                ">아티스트</a></th>
                            <th width="10px"><a href="#"
                                onclick="
                                    <c:choose>
                                        <c:when test="${search.searchFilter eq 'titleAsc'}">document.forms[0].searchFilter.value='titleDesc';</c:when>
                                        <c:otherwise>document.forms[0].searchFilter.value='titleAsc';</c:otherwise>
                                    </c:choose>
                                    document.forms[0].submit();
                                ">앨범제목</a></th>
                            <th width="10px">앨범재킷</th>
                            <th width="10px"><a href="#"
                                onclick="
                                    <c:choose>
                                        <c:when test="${search.searchFilter eq 'pdateAsc'}">document.forms[0].searchFilter.value='pdateDesc';</c:when>
                                        <c:otherwise>document.forms[0].searchFilter.value='pdateAsc';</c:otherwise>
                                    </c:choose>
                                    document.forms[0].submit();
                                ">발매일</a></th>
                            <th width="10px"><a href="#"
                                onclick="
                                    <c:choose>
                                        <c:when test="${search.searchFilter eq 'abtypeAsc'}">document.forms[0].searchFilter.value='abtypeDesc';</c:when>
                                        <c:otherwise>document.forms[0].searchFilter.value='abtypeAsc';</c:otherwise>
                                    </c:choose>
                                    document.forms[0].submit();
                                ">앨범타입</a></th>
                            <th width="10px"><a href="#"
                                onclick="
                                    <c:choose>
                                        <c:when test="${search.searchFilter eq 'gseqAsc'}">document.forms[0].searchFilter.value='gseqDesc';</c:when>
                                        <c:otherwise>document.forms[0].searchFilter.value='gseqAsc';</c:otherwise>
                                    </c:choose>
                                    document.forms[0].submit();
                                ">장르</a></th>
                            <th width="10px"><a href="#"
                                onclick="
                                    <c:choose>
                                        <c:when test="${search.searchFilter eq 'rankAsc'}">document.forms[0].searchFilter.value='rankDesc';</c:when>
                                        <c:otherwise>document.forms[0].searchFilter.value='rankAsc';</c:otherwise>
                                    </c:choose>
                                    document.forms[0].submit();
                                ">순위</a></th>
                            <th width="10px"><a href="#"
                                onclick="
                                    <c:choose>
                                        <c:when test="${search.searchFilter eq 'likecountAsc'}">document.forms[0].searchFilter.value='likecountDesc';</c:when>
                                        <c:otherwise>document.forms[0].searchFilter.value='likecountAsc';</c:otherwise>
                                    </c:choose>
                                    document.forms[0].submit();
                                ">좋아요</a></th>
                            <th width="10px"><a href="#"
                                onclick="
                                    <c:choose>
                                        <c:when test="${search.searchFilter eq 'mucountAsc'}">document.forms[0].searchFilter.value='mucountDesc';</c:when>
                                        <c:otherwise>document.forms[0].searchFilter.value='mucountAsc';</c:otherwise>
                                    </c:choose>
                                    document.forms[0].submit();
                                ">곡수</a></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${albumList.size() ne 0}">
                                <c:forEach var="album" items="${albumList}" varStatus="status">
                                    <tr>
                                        <input type="hidden" name="abseq" value="${album.abseq}" disabled>
                                        <input type="hidden" name="atseq" value="${album.atseq}" disabled>
                                        <input type="hidden" name="title" value="${album.title}" disabled>
                                        <input type="hidden" name="img" value="${album.img}" disabled>
                                        <input type="hidden" name="content" value="${album.content}" disabled>
                                        <input type="hidden" name="abtype" value="${album.abtype}" disabled>
                                        <input type="hidden" name="gseq" value="${album.gseq}" disabled>
                                        <input type="hidden" name="pdate" value="${album.pdate}" disabled>
                                        <input type="hidden" name="name" value="${album.name}" disabled>
                                        <td>${album.rn}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty album.atimg}">
                                                    <img id="atimg" src="${album.atimg}" width="30" height="30">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="/upload/noimage.jpg" width="30" height="30">
                                                </c:otherwise>
                                            </c:choose>
                                            <br>
                                            ${album.name}
                                        </td>
                                        <td>${album.title}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty album.img}">
                                                    <img id="abimg" src="${album.img}" width="50">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="/upload/noimage.jpg" width="50">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><fmt:formatDate value="${album.pdate}" pattern="yyyy.MM.dd"></fmt:formatDate></td>
                                        <td>${album.abtype}</td>
                                        <td>${album.abgenre}</td>
                                        <td>${album.rank}</td>
                                        <td>${album.likecount}</td>
                                        <td>${album.mucount}</td>
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
                <jsp:param value="findAlbum" name="command"/>
        
                <jsp:param value="${search.searchFilter}" name="searchFilter" />
                <jsp:param value="${search.selectedAbtype}" name="selectedAbtype" />
                <jsp:param value="${search.selectedGseq}" name="selectedGseq" />
                <jsp:param value="${search.searchkeywordTarget}" name="searchkeywordTarget" />
                <jsp:param value="${search.searchKeyword}" name="searchKeyword" />
            </jsp:include>
        </article>        
    </body>