<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
function checkSelectAll()  {
	  // 전체 체크박스
	  const checkboxes 
	    = document.querySelectorAll('input[name="ckb"]');
	  // 선택된 체크박스
	  const checked 
	    = document.querySelectorAll('input[name="ckb"]:checked');
	  // select all 체크박스
	  const selectAll 
	    = document.querySelector('input[name="ckall"]');
	  
	  if(checkboxes.length === checked.length)  {
	    selectAll.checked = true;
	  }else {
	    selectAll.checked = false;
	  }

	}

	function selectAll(selectAll)  {
	  const checkboxes 
	     = document.getElementsByName('ckb');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	  })
	}
function checkSelectAll(checkbox)  {
	  const selectall 
	    = document.querySelector('input[name="ckall"]');
	  
	  if(checkbox.checked === false)  {
	    selectall.checked = false;
	  }
	}

	function selectAll(selectAll)  {
	  const checkboxes 
	     = document.getElementsByName('ckb');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	  })
	}
</script>

<article>
<form>
<h3 style="text-align: center; margin-top:50px;">앨범타입</h3>
<table border="1" style="margin:0 auto; width:400px; margin-top:50px;">
	<tr>
		<td width="100px"><input type="checkbox" value="ckall"name="ckall" onclick='selectAll(this)'>모두선택</td>
		<td style="text-align:center">앨범타입</td>
	</tr>
	<c:forEach var="abtype" items="${abtypeListByAlbum}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="ckb" onclick='checkSelectAll(this)'/></td>
			<td>${abtype}</td>
		</tr>
	</c:forEach>
</table>
<div id="btn" style="margin:0 auto; width:400px;">
	<input type="button" value="del" style="margin:0 auto;">
</div>
</form>
</article>