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
<article>
	<form method="post" name="frm"  action="findIdCertificationNum">
		<div id="inputInfo" style="margin-left: 80px">
	<tr align="center" bgcolor="white" >
		<td width="430"><h3>성명 : ${member.name}</h3>
			<input type="hidden" name="name" value="${member.name}"></td></tr>
	<tr align="center" bgcolor="white" >	<td width="430">
			<h3>전화번호 : ${member.phone}</h3>
			<input type="hidden" name="phone" value="${member.phone}">
			<input type="hidden" name="id" value="${member.id}">	</td></tr>
	<tr align="center" bgcolor="white" >
		<td width="430">
		<label><input class="textbox" name="inputNum"
				placeholder="인증번호(4자리)" type="text" size="36"
				style="padding-left: 0px; height: 60px; align-content: center; border-bottom: 2px solid silver;"
				></label><br>
		<input id="login" type="submit" value="인증번호 확인"></td>
	</tr>
	<br>
			${msg}
</div>
</form>
</article>