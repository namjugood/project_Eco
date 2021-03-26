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
        <form action="bundleManageUpdate" method="POST">
            <h2>리스트의 정보
                <input type="submit" value="save">
                <input type="button" value="del" onclick="del(this.form, '${bundle.bmseq}');">
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

    <div style="width: 100%;margin: 0;padding: 0;box-shadow: 0px 0px 2px black;display:inline-block;float: left;">
        <form action="bundleManageDetailSave" method="POST">
            <h2>리스트의 상세정보
                <input type="submit" value="save">
                <input type="button" value="find" onclick="find();">
            </h2>
            <input type="hidden" name="bmseq" value="${bundle.bmseq}">
            <div id="bundleDetailMusicList" style="width: 100%;display:inline-block;float:left;">
                <c:forEach var="detail" items="${detailList}" varStatus="status">
                    <label for="detail_${detail.mseq}" style="width: 200px;margin: 0;padding:0;display:inline-block;position: relative;cursor: pointer;box-shadow: 0px 0px 2px blue;">
                        <input type="hidden" name="mseq" value="${detail.mseq}">
                        <span><img style="display:block;" id="abimg" src="${detail.abimg}" width="70" height="70" onerror="this.src='/upload/noimage.jpg'">
                            <dl style="margin:0;padding:0;width: 130px;position: absolute;right: 0;top: 0;">
                                <p class="singleline-ellipsis" style="margin:0;padding:0;margin-bottom: 8px;text-align: right;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${detail.title}</p>
                                <p class="singleline-ellipsis" style="margin:0;padding:0;margin-bottom: 8px;text-align: right;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${detail.abtitle}</p>
                                <p class="singleline-ellipsis" style="margin:0;padding:0;margin-bottom: 8px;text-align: right;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${detail.name}</p>
                            </dl>
                        </span>
                    </label>
                </c:forEach>
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