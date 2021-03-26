<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
	body{width:400px; height:300px;margin:0 auto;background-color: white;margin:0 auto;}
	#wrap{width: 400px;height:300px;padding:0px;margin:0 auto;border:2px solid silver;}
	h1 {width:100%; height:60px;font-family:'Noto Sans KR', sans-serif; font-size: 45px;background:#311851;color:white; 	
		font-weight:bold;text-align: center;margin:0;}
    form#checking{position:relative;float:left;width:100%;height:100%;padding:0px;}
    #textbox{position:relative;color:black; border:0px;margin:20px 50px; border-bottom:2px silver;font-size:18px;height:50px;font-weight:bold;float:left;border-bottom:2px solid silver;}
    input::placeholder{color: silver;}
	input[type=button], input[type=submit]{width:100px; height:50px;line-height:50px; font-size:18px;font-weight:bold;border:none; border-radius:10px; background:#C9C6F7;}
    #result1{position:relative;float:left;width:100%;height:100px;text-align:center;font-weight:bold;font-size:110%;}
    #search_btn{position:relative;margin:0 auto;margin-top:20px;}
    #result2{position:relative;float:left;width:100%;height:100px;text-align:center;font-weight:bold;font-size:110%;}
    #use_btn{position:relative;margin:0 auto;margin-top:20px;}
</style>
<script type="text/javascript">
	function idok(){
		opener.formm.id.value="${id}";
		opener.formm.reid.value="${id}";
		self.close();
	}
</script>
</head>
<body>
<div id="wrap">
<form id="checking" method="post" name="formm" action="idCheckForm">
    <h1>ID 중복확인</h1>
	<input id="textbox" type=text name="id" value="${id}" size="25" placeholder="아이디를 재입력해주세요">
	<br>
    <c:if test="${result == 1}">
        <div id="result1">
            <script type="text/javascript">	opener.document.joinForm.id.value="";</script>
            ${id}는<br> 이미 사용중인 아이디입니다.
            <br>
            <input id="search_btn" type="submit" value="검색" class="submit"><br>
        </div>
    </c:if>
    <c:if test="${result==-1}" >
        <div id="result2">
            <a>${id}는 사용 가능한 ID입니다.</a>
            <br>
            <input id="search_btn" type="submit" value="검색">
            <input id="use_btn" type="button" value="사용" class="cancel" onclick="idok();">
        </div>
    </c:if>
</form>	
</div>
</body>
</html>