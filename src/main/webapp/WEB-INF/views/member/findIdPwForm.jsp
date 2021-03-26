<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
 form{position:relative;margin:0 auto;width:600px;height:480px;border:3px solid silver;background:none;padding:50px;padding-top:100px; z-index:20;}
   #inputInfo{align-content:center;width:100%;height:100%;z-index:3;}
    .textbox{position:relative;color:black; border:0px;margin-bottom:20px; border-bottom:2px silver;font-size:18px;height:50px;font-weight:bold;}
    input::placeholder{color: silver;}
    #login{width:402px;height:70px;padding:0px;margin:30px 0px;border:none;background:#C9C6F7;border-radius:10px;font-size:140%;color:black;font-weight:bold;}
    .btn{position:relative;width:196px;height:50px;border:none;background:#C9C6F7;border-radius:10px;font-size:100%;color:black;font-weight:bold;}
</style>
<script type="text/javascript">
function move_pw(){
	document.frm.action="findPwForm";
	document.frm.submit();
}

function move_Id(){
	document.frm.action="findIdForm";
	document.frm.submit();
}
</script>
<article>
	<form method="post" name="frm">
		<div id="inputInfo" style="margin-left: 80px">
		<input id="login" type="submit" value="아이디 찾기" onClick="move_Id()">
		<input id="login" type="submit" value="비밀번호 찾기" onClick="move_pw()">
		<br>
			${msg}
		</div>
	</form>
</article>