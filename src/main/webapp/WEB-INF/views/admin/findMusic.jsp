<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

    <head>
        <meta charset="UTF-8">
        <title>음악 찾기</title>
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
                    var mseq = $(this).find("input[name=mseq]").val();
                    var title = $(this).find("input[name=title]").val();
                    var abtitle = $(this).find("input[name=abtitle]").val();
                    var name = $(this).find("input[name=name]").val();
                    var abimg = $(this).find("input[name=abimg]").val();

                    var alreadyValue = false;

                    $(window.opener.document).find("input[name=mseq]").each(function(index, el) {
                        var val = $(el).val();
                        if (mseq === val) {
                            alreadyValue = true;
                        }
                    });

                    if (alreadyValue) {
                        alert("이미 등록된 곡입니다.");
                    } else {
                        var html = "";
                        html += "<label for=\"detail_"+mseq+"\" style=\"width: 200px;margin: 0;padding:0;display:inline-block;position: relative;cursor: pointer;box-shadow: 0px 0px 2px blue;\">";
                        html += "<input type=\"hidden\" name=\"mseq\" value=\""+mseq+"\"";
                        html += ">";
                        html += "<span><img style=\"display:block;\" id=\"abimg\" src=\""+abimg+"\" width=\"70\" height=\"70\" onerror=\"this.src='/upload/noimage.jpg'\">";
                        html += "<dl style=\"margin:0;padding:0;width: 130px;position: absolute;right: 0;top: 0;\">";
                        html += "<p style=\"margin:0;padding:0;margin-bottom: 8px;text-align: right;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;\">"+title+"</p>";
                        html += "<p style=\"margin:0;padding:0;margin-bottom: 8px;text-align: right;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;\">"+abtitle+"</p>";
                        html += "<p style=\"margin:0;padding:0;margin-bottom: 8px;text-align: right;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;\">"+name+"</p>";
                        html += "</dl>";
                        html += "</span>";
                        html += "</label>";
                        
                        $(window.opener.document).find("#bundleDetailMusicList").append(html);
                    }
                
                });
            });
        </script>
    </head>

    <body>
        <article style="min-height:500px;">
            <form action="findMusic" method="GET">
                <input type="hidden" name="searchFilter" value="${search.searchFilter}">
        
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
                <input type="button" value="close" onclick="self.close();">
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
                                        <input type="hidden" name="mseq" value="${music.mseq}" disabled>
                                        <input type="hidden" name="title" value="${music.title}" disabled>
                                        <input type="hidden" name="abtitle" value="${music.abtitle}" disabled>
                                        <input type="hidden" name="name" value="${music.name}" disabled>
                                        <input type="hidden" name="abimg" value="${music.abimg}" disabled>
                                        <td>${music.rn}</td>
                                        <td>${music.title}</td>
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
                <jsp:param value="findMusic" name="command"/>
        
                <jsp:param value="${search.searchFilter}" name="searchFilter"/>
                <jsp:param value="${search.selectedTheme}" name="selectedTheme"/>
                <jsp:param value="${search.selectedChart}" name="selectedChart"/>
                <jsp:param value="${search.selectedGenre}" name="selectedGenre"/>
                <jsp:param value="${search.searchkeywordTarget}" name="searchkeywordTarget"/>
                <jsp:param value="${search.searchKeyword}" name="searchKeyword"/>
            </jsp:include>
        </article>
    </body>