<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminhf/header.jsp" %>

<article style="min-height:500px;margin-top:100px;position: relative;">
    <h3 style="position: absolute;top:-80px;">${message}</h3>
    <form action="artistManageUpdate" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="oldimg" value="${artist.img}">
        <div style="width: 40%;display:inline-block;float:left">
            <label for="atseq">
                순번 <input type="text" name="atseq" value="${artist.atseq}" readonly>
            </label>
            <br>
            <label for="name">
                이름 <input type="text" name="name" value="${artist.name}">
            </label>
            <br>
            <label for="groupyn_Y">
                그룹 : <input id="groupyn_Y" type="radio" name="groupyn" value="Y"
                    <c:if test="${artist.groupyn eq 'Y'}">checked</c:if>
                >
            </label>
            <label for="groupyn_N">
                솔로 : <input id="groupyn_N" type="radio" name="groupyn" value="N"
                    <c:if test="${artist.groupyn eq 'N'}">checked</c:if>
                >
            </label>
            <br>
            <label for="gender_M">
                남성 : <input id="gender_M" type="radio" name="gender" value="M"
                    <c:if test="${artist.gender eq 'M'}">checked</c:if>
                >
            </label>
            <label for="gender_F">
                여성 : <input id="gender_F" type="radio" name="gender" value="F"
                    <c:if test="${artist.gender eq 'F'}">checked</c:if>
                >
            </label>
            <label for="gender_A">
                혼성 : <input id="gender_A" type="radio" name="gender" value="A"
                    <c:if test="${artist.gender eq 'A'}">checked</c:if>
                >
            </label>

            <p>이미지</p>
            <label for="img">
                <img style="display:block;" id="img" src="${artist.img}" width="100" height="100" onerror="this.src='/upload/noimage.jpg'">
            </label>
            <input id="file" type="file" name="img" value="${artist.img}" style="width: 400px;">
            <input type="text" name="imglink" value="" placeholder="링크 미사용시 빈칸을 유지하세요." 
                style="width: 400px;" 
                onchange="document.getElementById('img').src=this.value;">
        </div>
        <div style="width: 40%;display:inline-block;float:left;">
            장르
            <div style="width: 400px;border: 1px solid gray;height: 256px;overflow-y: scroll;">
                <c:forEach var="genre" items="${genreList}" varStatus="status">
                    <label for="genre_${genre.gseq}" style="width: 40%;margin: 0;padding:0;display:inline-block;">
                        <input id="genre_${genre.gseq}" type="radio" name="gseq" value="${genre.gseq}"
                            <c:if test="${artist.gseq eq genre.gseq}">checked</c:if>
                        >${genre.title}
                    </label>
                </c:forEach>    
            </div>
        </div>
        <div style="width: 100%;display:inline-block;">
            <p>소개</p>
            <textarea name="description" style="width: 80%;margin: 0 auto;" cols="30" rows="10">${artist.description}</textarea>
        </div>

        <input type="button" value="list" onclick="location.href='artistManageList'">
        <input type="reset" value="cancel">
        <input type="submit" value="save">
        <input type="button" value="del" onclick="del(this.form, '${artist.atseq}');">
    </form>
</article>

<script>
    //이미지 미리 보기
	fn_imgReader = function(){
		$("#file").on({
			change:function(){
				// 이미지 초기화
				$("#img").attr("src", "");
				
			    var fileList = this.files;
			    var reader = new FileReader();
			    reader.readAsDataURL(fileList[0]);
			    reader.onload = function(){
			        $("#img").attr("src", reader.result);
			    };
			}
		});
	}
    fn_imgReader();
    
    function del(form, atseq) {
        if (confirm("삭제하시겠습니까?")) {
            form.action = "artistManageDelete?atseq=" + atseq;
            form.submit();
        }
    }
</script>