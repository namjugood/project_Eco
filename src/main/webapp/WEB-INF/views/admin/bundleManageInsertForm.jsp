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
    <input type="button" value="list" onclick="location.href='bundleManageList'">
    <div style="width: 100%;margin: 0;padding: 0;box-shadow: 0px 0px 2px black;display:inline-block;float: left;">
        <form action="bundleManageInsert" method="POST">
            <h2>리스트의 정보
                <input type="submit" value="add">
            </h2>
            <input type="hidden" name="bmseq" value="${bundle.bmseq}">
            <div style="width: 80%;display:inline-block;float:left">
                <label for="title">
                    제목 : 
                    <textarea name="title" id="" cols="30" rows="2"><c:out value="${bundle.title}"/></textarea>
                </label>
                <br>
                <label for="useyn_Y">
                    사용여부 : <input id="useyn_Y" type="radio" name="useyn" value="Y"
                    <c:if test="${empty bundle.useyn or bundle.useyn eq 'Y'}">checked</c:if>>
                </label>
                <label for="useyn_N">
                    미사용 : <input id="useyn_N" type="radio" name="useyn" value="N"
                    <c:if test="${bundle.useyn eq 'N'}">checked</c:if>>
                </label>
                <br>
            </div>
        </form>
    </div>
</article>

<script>
    $(function() {
        $(document).on("click", "#bundleDetailMusicList > label", function() {
            $(this).remove();
        })
    });

    function del(form, bmseq) {
        if (confirm("삭제하시겠습니까?")) {
            form.action = "bundleManageDelete?bmseq=" + bmseq;
            form.submit();
        }
    };

    function find() {
        var popupWidth = window.screen.width - 400;
        var popupHeight = window.screen.height - 400;
        var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width="+popupWidth+", height="+popupHeight+",";
        opt += "top="+getMiddlePosition(popupWidth, popupHeight).popupX+", left="+getMiddlePosition(popupWidth, popupHeight).popupY;
        
        var url = "findMusic";

        window.open(url, url + "popup", opt);
    };

    function getMiddlePosition(popupWidth, popupHeight) {
        return {
            popupX : (window.screen.width / 2) - (popupWidth / 2),
            popupY : (window.screen.height / 2) - (popupHeight / 2),
        };
    }
</script>