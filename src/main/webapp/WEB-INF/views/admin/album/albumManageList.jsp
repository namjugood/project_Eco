<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/adminhf/header.jsp" %>
<script type="text/javascript">
function go_search_album() {
	var theForm = document.frm;
	if( theForm.key.value=="") return;
	theForm.action =  "albumManageList?first=yes";
	theForm.submit();
}
function go_total_album() {
	var theForm = document.frm;
	theForm.key.value="";
	theForm.action =  "albumManageList?first=yes";
	theForm.submit();
}
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
    
    <form action="albumManageList" method="GET" name="frm">
    	<input type="button" value="theme" class="submit"
				onclick="ThemeManage()">
		<input type="button" value="chart" class="submit"
				onclick="ChartManage()">
		<input type="button" value="genre" class="submit"
				onclick="GenreManage()">
        <br>
            검색어 : 
            <input type="text" name="key" value="${key}">
 			<input type="button" class="search_album" value="검색"  onclick="go_search_album()">
 			<input type="button" class="total_album" value="전체보기 " onclick="go_total_album()">

        <input type="button" value="add" onclick="location.href='albumManageInsertForm'">
    </form>

    <table border="1" style="width:950px;margin: 0 auto;">
        <thead>
            <tr>
                <th>앨범번호</th>
                <th>이미지</th>
                <th>타이틀</th>
                <th>가수</th>
                <th>장르</th>
                <th>앨범타입</th>
                <th>발매일</th>
                <th>좋아요수</th>
                <th>수록곡수</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${albumList.size() ne 0}">
                    <c:forEach var="album" items="${albumList}" varStatus="status">
                        <tr>
                            <td>${album.abseq}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty album.img}">
                                        <img src="${album.img}" width="50">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="../upload/noimage.jpg" width="50">
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><a href="albumManageUpdateForm?abseq=${album.abseq}">${album.title}</a></td>
                            <td>${album.name}</td>
                            <td>${album.abgenre}</td>
                            <td>${album.abtype}</td>
                            <td><fmt:formatDate value="${album.pdate}" type="date" pattern="yyyy.MM.dd"/></td>
                            <td>${album.likecount}</td>
                            <td>${album.mucount}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="9"><h1 style="margin: 0 auto;font-size: 150%;color: black;min-height: 400px;line-height: 400px;">데이터가 없습니다.</h1></td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
<jsp:include page="../paging/paging.jsp">
    <jsp:param value="${paging.page}" name="page"/>
    <jsp:param value="${paging.beginPage}" name="beginPage"/>
    <jsp:param value="${paging.endPage}" name="endPage"/>
    <jsp:param value="${paging.prev}" name="prev"/>
    <jsp:param value="${paging.next}" name="next"/>
    <jsp:param value="albumManageList" name="command"/>
</jsp:include>
</article>

