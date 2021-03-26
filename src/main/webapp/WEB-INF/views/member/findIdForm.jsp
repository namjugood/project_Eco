<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
 form{position:relative;margin:0 auto;width:600px;height:480px;border:3px solid silver;background:none;padding:50px;padding-top:100px; z-index:20;}
   #inputInfo{align-content:center;width:100%;height:100%;z-index:3;}
    .textbox{position:relative;color:black; border:0px;margin-bottom:20px; border-bottom:2px silver;font-size:18px;height:50px;font-weight:bold;}
    input::placeholder{color: silver;}
    #login{width:402px;height:70px;padding:0px;margin:30px 0px;border:none;background:#C9C6F7;border-radius:10px;font-size:140%;color:black;font-weight:bold;}
    .btn{position:relative;width:196px;height:50px;border:none;background:#C9C6F7;border-radius:10px;font-size:100%;color:black;font-weight:bold;}
</style>
</head>
<body>
<article>
	<form method="post" name="frm"  action="lookupNamePhone">
		<div id="inputInfo" style="margin-left: 80px">
			<label><input class="textbox" name="name"
				placeholder="이름" type="text" size="36"
				style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid silver;"
				value="${name}"></label><br>
			<label><input class="textbox" name="phone"
				placeholder="전화번호" type="text" size="36"
				style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid silver;"
				value="${phone}"></label><br>
			<input id="login" type="submit" value="인증번호 전송">
			<br>
			${msg}
		</div>	
	</form>
</article>
</body>
</html>