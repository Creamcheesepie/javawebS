<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/postCodeFind.js"></script>
	<script>
	'use strict'
	//아이디와 중복버튼을 클릭햇는지의 여부를 확인하기위한 변수(버튼 클릭 후에는 내용 수정을 하지 못하도록(버튼을 통해서만 가능?)
	let idCheckSw = 0;
	let nickCheckSw = 0;
		
	 function fCheck() {
		//아이디 , 닉네임 중복체크 여부 검사
		//let midOk ="${midOK}"
		//let nickNameOk ="${nickNameOk}"
		/* else if(!$$inRegEx.test($$in)){
			alert("");
			myform.$$in.focus();
		} */
		
		let mid = myform.mid.value.trim();
		let pwd = myform.pwd.value.trim();
		let nickName = myform.nickName.value.trim();
		let name = myform.name.value.trim();
		let email1 = myform.email1.value.trim();
		let email2 = myform.email2.value.trim();
		let email = email1+email2;
		
		
		let midOk = "false"
		let pwdOk = "false"
		let nickNameOk = "false"
		let nameOk = "false"
		let emailOk = "false"
		let telOk = "false"
		
				//유효성 검사 + 전화번호, 
		const midRegEx = /^[a-zA-Z0-9]{4,20}[^\W]/; //아이디 정규식
		const pwdRegEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/g; //비밀번호 정규식
		const nickNameRegEx = /^[a-zA-Z0-9가-힣]{2,19}[a-zA-Z0-9가-힣]*$/g; //닉네임 정규식
		const nameRegEx = /^[a-zA-Z가-힣]{1,19}[a-zA-Z가-힣]*$/g; //이름 정규식
		const emailRegEx = /[\w]+@[\w]+[.]{1}[\w]/g; //이메일 정규식
		const telRegEx = /\d{2,3}-\d{3,4}-\d{4}$/g;
		
		let tel1 = myform.tel1.value.trim();
		let tel2 = myform.tel2.value.trim();
		let tel3 = myform.tel3.value.trim();
		let tel =  tel1+"-"+tel2+"-"+tel3;
		
		//아이디 검사
		if(mid==""){
			alert("아이디를 입력하세요!");
			myform.mid.focus();
			return false;
		}
		else if(!midRegEx.test(mid)){
			alert("아이디는 영문 대소문자에 숫자를 포함하여 4~12글자로 입력해주세요!");
			myform.mid.focus();
			return false;
		}else{
			midOk="true";
		}
		
		//비밀먼호 검사
		if(pwd==""){
			alert("비밀번호를 입력하세요!");
			myform.pwd.focus();
			return false;
		}
		else if(!pwdRegEx.test(pwd)){
			alert("비밀번호는 영문 대소문자에 특수문자 1개 이상,8글자 이상으로 입력해주세요!");
			myform.pwd.focus();
			return false;
		}else{
			pwdOk="true";
		}
		
		//닉네임 검사
		if(nickName==""){
			alert("닉네임을 입력하세요!");
			myform.nickName.focus();
			return false;
		}
		else if(!nickNameRegEx.test(nickName)){
			alert("닉네임은 한글, 영문, 숫자까지 입력할 수 있습니다.");
			myform.nickName.focus();
			return false;
		}else{
			nickNameOk="true";
		}
		
		//이름 검사
		if(name==""){
			alert("이름을 입력하세요!");
			myform.name.focus();
			return false;
		}
		else if(!nameRegEx.test(name)){
			alert("이름은 한글, 영문까지 입력할 수 있습니다.");
			myform.nickName.focus();
			return false;
		}else{
			nameOk="true";			
		}
		
		//사진 처리
		let photoName = document.getElementById("photoFile").value;
		
		let photoNameExe = photoName.substring(photoName.lastIndexOf(".")+1).toLowerCase();
		
		let maxSize = 1024*1024*10;
		
		
		if(photoName.trim()==""){
			photoName="noimage.jpg";
		}
		else if(photoName.trim()!=""){
			let fileSize = document.getElementById("photoFile").files[0].size;
			
			if(photoNameExe!="jpg" && photoNameExe!="png" && photoNameExe!="gif" ){
				alert("프로필 사진으로 업로드 가능한 이미지는 jpg,png,gif 확장자를 가진 이미지 파일입니다.");
				return false;
			}
			
			if(fileSize>maxSize){
				alert("프로필 사진으로 업로드 가능한 이미지의 크기는 10mb까지입니다.");
				return false;
			}
		
		}
		
		
		
		
		//이메일 검사
		if(email1==""){
			alert("이메일을 입력하세요!");
			myform.email1.focus();
			return false;
		}
		else if(!emailRegEx.test(email)){
			alert("이메일을 형식에 맞게 입력해주세요.");
			myform.birthday.focus();
			return false;
		}	else{
			emailOk="true";
		}
		
		if(tel2 !="" && tel3 != ""){
			if(!telRegEx.test(tel)){
				alert("전화번호 형식을 확인세요.");
				myform.tel.focus();
				return false;
			}
			else{
				telOk="true";
			}
		}
		
		
		//주소 묶어주기.
		let postcode = myform.postcode.value + " ";
		let roadAddress = myform.roadAddress.value + " ";
		let detailAddress = myform.detailAddress.value + " ";
		let extraAddress = myform.extraAddress.value + " "; //공백을 넣어주는 이유? : 나중에 정보 수정시 값 불러오기 용이하게 하기 위함.
		myform.address.value  = postcode +"/"+ roadAddress +"/"+ detailAddress+"/"+ extraAddress +"/";
		
		//
		let hobbys = "";
		let hobby = document.getElementsByName("hobby");
		for (let i = 0; i<hobbys.length; i++){
			if(document.getElementsByName("hobby")[i].checked ==true){
				hobbys += document.getElementsByName("hobby")[i].value + "/";
			}
		}
		
		
		/*
			if(sMidOk == null || sMidOk == "no"){
			alert("아이디 중복체크를 해주세요!");
			return false;
		}
		
		if(sNickNameOk == null || sNickNameOk == "no"){
			alert("닉네임 중복체크를 해주세요!");
			return false;
		} 
		*/
		
		if(idCheckSw == 0){
			alert("아이디 중복체크 버튼을 눌러주세요")
			document.getElementById("midBtn").focus();
		}
		else if(nickCheckSw == 0){
			alert("아이디 중복체크 버튼을 눌러주세요")
			document.getElementById("nickNameBtn").focus();
		}
		else if(midOk=="true" && pwdOk=="true" && nickNameOk=="true" && nameOk=="true" && emailOk=="true" ){
			myform.hobbys.value=hobbys;
			myform.tel.value = tel;
			myform.email.value=email;
			myform.submit();
		}
		
	}
	 
  // 아이디 중복체크
  function idCheck() {
  	let mid = myform.mid.value;
  	if(mid.trim() == "" || mid.length < 4 || mid.length > 20) {
  		alert("아이디를 확인하세요!(아이디는 4~20자 이내)");
  		myform.mid.focus();
  		return false;
  	}
  	
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/member/memberIdCheck",
  		data : {mid : mid},
  		success:function(res) {
  			if(res == "1") {
  				alert("이미 사용중인 아이디 입니다. 다시 입력해 주세요");
  				$("#mid").focus();
  			}
  			else  {
  				alert("사용 가능한 아이디 입니다.");
  				idCheckSw = 1;
  				$("#pwd").focus();
  			}
  		},
  		error: function(xhr, status, error){
  		    console.log(status, error);
  		}
  	});
  }
	    
   // 닉네임 중복체크
   function nickCheck() {
   	let nickName = myform.nickName.value;
   	if(nickName.trim() == "" || nickName.length < 2 || nickName.length > 20) {
   		alert("닉네임을 확인하세요!(닉네임는 2~20자 이내)");
   		myform.nickName.focus();
   		return false;
   	}
   	
   	$.ajax({
   		type : "post",
   		url  : "${ctp}/member/memberNickCheck",
   		data : {nickName : nickName},
   		success:function(res) {
   			if(res == "1") {
   				alert("이미 사용중인 닉네임 입니다. 다시 입력해 주세요");
   				$("#nickName").focus();
   			}
   			else  {
   				alert("사용 가능한 닉네임 입니다.");
   				nickCheckSw = 1;	
   				$("#name").focus();
   			}
   		},
   		error: function(xhr, status, error){
   		    console.log(status, error);
   		}
   	});
   }
	
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>	
	<div class="container">
		<%-- <form name="myform" method="post" action="${ctp}/member/memberJoinOk" class="was-validated" enctype="multipart/form-data"> --%>
		<form name="myform" method="post" action="${ctp}/member/memberJoinOk" class="was-validated">
    <h2>회 원 가 입</h2>
    <br/>
    <div class="form-group">
      <label for="mid">아이디 : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" name="midBtn" id="midBtn" class="btn btn-secondary btn-sm" onclick="idCheck()"/></label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 :</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
    </div>
    <div class="form-group">
      <label for="nickName">닉네임 : &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" name="nickNameBtn" id="nickNameBtn" class="btn btn-secondary btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
    </div>
    <div class="form-group">
      <label for="email1">Email address:</label>
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="@naver.com" selected>naver.com</option>
              <option value="@hanmail.net">hanmail.net</option>
              <option value="@hotmail.com">hotmail.com</option>
              <option value="@gmail.com">gmail.com</option>
              <option value="@nate.com">nate.com</option>
              <option value="@yahoo.com">yahoo.com</option>
            </select>
          </div>
        </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자">여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <input type="date" name="birthday" class="form-control" value="<%=java.time.LocalDate.now()%>"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select">
              <option value="010" selected>010</option>
              <option value="02">서울</option>
              <option value="031">경기</option>
              <option value="032">인천</option>
              <option value="041">충남</option>
              <option value="042">대전</option>
              <option value="043">충북</option>
              <option value="051">부산</option>
              <option value="052">울산</option>
              <option value="061">전북</option>
              <option value="062">광주</option>
            </select>-
        </div>
        <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>-
        <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <input type="hidden" name="address" id="address">
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="homepage">Homepage address:</label>
      <input type="text" class="form-control" name="homePage" value="http://" placeholder="홈페이지를 입력하세요." id="homePage"/>
    </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <!-- <option value="">직업선택</option> -->
        <option selected>기타</option>
        <option>학생</option>
        <option>회사원</option>
        <option>공무원</option>
        <option>군인</option>
        <option>의사</option>
        <option>법조인</option>
        <option>세무인</option>
        <option>자영업</option>
        <option>기타</option>
      </select>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">취미</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="userInfoSw" value="공개" checked/>공개
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="userInfoSw" value="비공개"/>비공개
        </label>
      </div>
    </div>
    <div  class="form-group">
      회원 사진(파일용량:10MByte이내) :
      <input type="file" name="photoFile" id="photoFile" class="form-control-file border"/>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button> &nbsp;
    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
    <button type="button" class="btn btn-secondary" onclick="">돌아가기</button>
    <input type=hidden name="tel" id="tel"/>
    <input type=hidden name="email" id="email"/>
    <input type=hidden name="hobbys" id="hobbys"/>
  </form>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>