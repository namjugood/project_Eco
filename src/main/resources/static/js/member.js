function move_pw(){
	document.frm.action = "findPwForm";
	document.frm.submit();
}

function move_Id(){
	document.frm.action = "findId";
	document.frm.submit();
}


function find_id_pw(){
	var url = "findIdPw";
	var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=800, ";
	opt = opt + "height=700, top=300, left=300";
	window.open(url, "Find Id/Pw", opt);
}


function go_update(){
	if (document.joinForm.pwd.value == "") {
	    alert("비밀번호를 입력해 주세요.");
	    document.joinForm.pwd.focus();
	}else if ((document.joinForm.pwd.value != document.joinForm.pwdCheck.value)) {
	    alert("비밀번호가 일치하지 않습니다.");
	    document.joinForm.pwd.focus();
	}else if (document.joinForm.name.value == "") {
	    alert("이름을 입력해 주세요.");
	    document.joinForm.name.focus();
	} else if (document.joinForm.email.value == "") {
	    alert("이메일을 입력해 주세요.");
	    document.joinForm.email.focus();
	}else {
	    document.joinForm.action = "memberUpdate";
	    document.joinForm.submit();
	}
}


function go_save(){
	if (document.formm.id.value == "") {
	    alert("아이디를 입력하여 주세요."); 	    
	    document.formm.id.focus();
	} else if(document.formm.reid.value=""){
		alert("아이디 중복확인을 클릭해주세요");		
		document.formm.id.focus();
	} else if (document.formm.pwd.value == "") {
	    alert("비밀번호를 입력해 주세요.");	    
	    document.formm.pwd.focus();
	}else if ((document.formm.pwd.value != document.formm.pwdCheck.value)) {
	    alert("비밀번호가 일치하지 않습니다.");	    
	    document.formm.pwd.focus();
	}else if (document.formm.name.value == "") {
	    alert("이름을 입력해 주세요.");	    
	    document.formm.name.focus();
	} else if (document.formm.email.value == "") {
	    alert("이메일을 입력해 주세요.");	   
	    document.formm.email.focus();
	}else{
		document.formm.action = "join";
	    document.formm.submit();
	}
}

function post_zip(){
	var url = "findZipNum";
	var pop = "toolbar=no, menubar=no, scrollbars=no, "
	+ "resizable=no, width=550, height=300, top=300, left=300";
	window.open(url, "find Zip num", pop);
}


function idcheck(){
	if(document.formm.id.value==""){
		alert('아이디를 입력하여 주세요');
		document.formm.id.focus();
		return;	
	}
	var url = "idCheckForm?id=" + document.formm.id.value;
	var pop = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=400; height=300";
	window.open(url, "IdCheck", pop);
}


function go_next(){
	if(document.formm.okon[0].checked==true){
		document.formm.action = "joinForm";
		document.formm.submit();
	} else if (document.formm.okon[1].checked == true){
		alert('약관에 동의하셔야만 합니다.');
	}
}


function loginCheck(){
	if(document.loginFrm.id.value==""){
		alert("아이디를 입력하세요");
		document.loginFrm.id.focus();
		return false;
	}
	if(document.loginFrm.pwd.value==""){
		alert("비밀번호를 입력하세요");
		document.loginFrm.pwd.focus();
		return false;
	}
	return true;
}

function go_next(){
	if(document.formm.okon[0].checked == true){
		document.formm.action = "joinForm";
		document.formm.submit();
	}else if(document.formm.okon[1].checked==true){
		alert('약관에 동의하셔야만 합니다');
	}
}

function idCheck(){
	var id = document.getElementById("id").value;
	var checkId = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	var url = "idCheckForm";
	
	if(document.formm.id.value==""){
		alert("아이디를 입력하세요");
		formm.id.focus();
		return;
	}
	if(checkId.test(id)==false){
		
		formm.id.focus(); 
		return; 
	}
	
	url += "?id=" + document.formm.id.value;
	var pop = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=500, height=350";
	window.open(url, "IdCheck", pop);
}

