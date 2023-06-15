<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	let nickCheckSw = 0;
		
	 function fCheck() {
		//아이디 , 닉네임 중복체크 여부 검사
		//let midOk ="${midOK}"
		//let nickNameOk ="${nickNameOk}"
		/* else if(!$$inRegEx.test($$in)){
			alert("");
			myform.$$in.focus();
		} */
		
		let nickName = myform.nickName.value.trim();
		let name = myform.name.value.trim();
		let email1 = myform.email1.value.trim();
		let email2 = myform.email2.value.trim();
		let email = email1+email2;
		
		let nickNameOk = "false"
		let nameOk = "false"
		let emailOk = "false"
		let telOk = "false"
		
				//유효성 검사 + 전화번호, 
		const nickNameRegEx = /^[a-zA-Z0-9가-힣]{2,19}[a-zA-Z0-9가-힣]*$/g; //닉네임 정규식
		const nameRegEx = /^[a-zA-Z가-힣]{1,19}[a-zA-Z가-힣]*$/g; //이름 정규식
		const emailRegEx = /[\w]+@[\w]+[.]{1}[\w]/g; //이메일 정규식
		const telRegEx = /\d{2,3}-\d{3,4}-\d{4}$/g;
		
		let tel1 = myform.tel1.value.trim();
		let tel2 = myform.tel2.value.trim();
		let tel3 = myform.tel3.value.trim();
		let tel =  tel1+"-"+tel2+"-"+tel3;
		
		
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
		let photoName = document.getElementById("fName").value;
		
		let photoNameExe = photoName.substring(photoName.lastIndexOf(".")+1).toLowerCase();
		
		let maxSize = 1024*1024*10;
		
		$("#photo").val(photoName);
		if(photoName.trim()==""){
			photoName="noimage.jpg";
		}
		else if(photoName.trim()!=""){
			let fileSize = document.getElementById("fName").files[0].size;
			
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
		

		
		if(nickCheckSw == 0){
			alert("아이디 중복체크 버튼을 눌러주세요")
			document.getElementById("nickNameBtn").focus();
		}
		else if(nickNameOk=="true" && nameOk=="true" && emailOk=="true" ){
			myform.hobbys.value=hobbys;
			myform.tel.value = tel;
			myform.email.value=email;
			myform.submit();
		}
		
	}
	 
	    
   // 닉네임 중복체크
   function nickCheck() {
   	let nickName = myform.nickName.value;
   	if(nickName.trim() == "" || nickName.length < 2 || nickName.length > 20) {
   		alert("닉네임을 확인하세요!(닉네임는 2~20자 이내)");
   		myform.nickName.focus();
   		return false;
   	}
   	
   	if(nickName=='${sNickName}'){
   		alert("기존 닉네임을 유지합니다.");
   		nickCheckSw = 1;
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
   		error: function(){
   		    
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
		<form name="myform" method="post" action="${ctp}/member/memberUpdateOk" class="was-validated" enctype="multipart/form-data">
    <h2>회원 정보 수정</h2>
    <br/>
    <div class="form-group">
      아이디 :
      <input type="text" class="form-control" name="mid" id="mid" value="${sMid}" readonly/>
    </div>
    <div class="form-group">
      <label for="nickName">닉네임 : &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" name="nickNameBtn" id="nickNameBtn" class="btn btn-secondary btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" value="${vo.nickName}" required />
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" value="${vo.name}" required />
    </div>
    <div class="form-group">
      <label for="email1">Email address:</label>
        <div class="input-group mb-3">
          <c:set var="emails" value="${fn:split(vo.email,'@')}"/>
          <c:set var="email1" value="${emails[0]}"/>
          <c:set var="email2" value="${emails[1]}"/>
          
          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" value="${email1}" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="@naver.com" ${email2=='naver.com'? 'selected' :''} >naver.com</option>
              <option value="@hanmail.net" ${email2=='hanmail.net'? 'selected' :''}>hanmail.net</option>
              <option value="@hotmail.com" ${email2=='hotmail.com'? 'selected' :''}>hotmail.com</option>
              <option value="@gmail.com" ${email2=='gmail.com'?'selected':''}>gmail.com</option>
              <option value="@nate.com" ${email2=='nate.com'?'selected':''}>nate.com</option>
              <option value="@yahoo.com" ${email2=='yahoo.com'?'selected':''}>yahoo.com</option>
            </select>
          </div>
        </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
        <label class="form-check-label">
        
          <input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender=='남자'}">checked</c:if>>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자" <c:if test="${vo.gender=='여자'}">checked</c:if>>여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <input type="date" name="birthday" class="form-control" value="${fn:substring(vo.birthday,0,10)}"/>
    </div>
    <c:set var="tels" value="${fn:split(vo.tell,'-')}"/>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select">
              <option value="010" <c:if test="${tels[0]=='010'}">selected</c:if>>010</option>
              <option value="02"  <c:if test="${tels[0]=='02'}">selected</c:if>>서울</option>
              <option value="031" <c:if test="${tels[0]=='031'}">selected</c:if>>경기</option>
              <option value="032" <c:if test="${tels[0]=='032'}">selected</c:if>>인천</option>
              <option value="041" <c:if test="${tels[0]=='041'}">selected</c:if>>충남</option>
              <option value="042" <c:if test="${tels[0]=='042'}">selected</c:if>>대전</option>
              <option value="043" <c:if test="${tels[0]=='043'}">selected</c:if>>충북</option>
              <option value="051" <c:if test="${tels[0]=='051'}">selected</c:if>>부산</option>
              <option value="052" <c:if test="${tels[0]=='052'}">selected</c:if>>울산</option>
              <option value="061" <c:if test="${tels[0]=='061'}">selected</c:if>>전북</option>
              <option value="062" <c:if test="${tels[0]=='062'}">selected</c:if>>광주</option>
            </select>-
        </div>
        <input type="text" name="tel2" size=4 maxlength=4 class="form-control" value="${fn:trim(tels[1])}"/>-
        <input type="text" name="tel3" size=4 maxlength=4 class="form-control" value="${fn:trim(tels[2])}"/>
      </div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <c:set var="addresses" value="${fn:split(vo.address,'/')}"/>
      <c:set var="postcode" value="${addresses[0]}"/>
      <c:set var="roadaddress" value="${addresses[1]}"/>
      <c:set var="detailaddress" value="${addresses[2]}"/>
      <c:set var="extraaddress" value="${addresses[3]}"/>

      <input type="hidden" name="address" id="address">
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" value="${postcode}">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" value="${roadaddress}">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control" value="${detailaddress}"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control" value="${extraaddress}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="homepage">Homepage address:</label>
      <input type="text" class="form-control" name="homePage" value="${vo.homePage}" placeholder="홈페이지를 입력하세요." id="homePage"/>
    </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <!-- <option value="">직업선택</option> -->
        <option <c:if test="${vo.job=='기타'}">selected</c:if>>기타</option>
        <option <c:if test="${vo.job=='학생'}">selected</c:if>>학생</option>
        <option <c:if test="${vo.job=='회사원'}">selected</c:if>>회사원</option>
        <option <c:if test="${vo.job=='공무원'}">selected</c:if>>공무원</option>
        <option <c:if test="${vo.job=='군인'}">selected</c:if>>군인</option>
        <option <c:if test="${vo.job=='의사'}">selected</c:if>>의사</option>
        <option <c:if test="${vo.job=='법조인'}">selected</c:if>>법조인</option>
        <option <c:if test="${vo.job=='세무인'}">selected</c:if>>세무인</option>
        <option <c:if test="${vo.job=='자영업'}">selected</c:if>>자영업</option>
        <option <c:if test="${vo.job=='기타'}">selected</c:if>>기타</option>
      </select>
    </div>
    <div class="form-group">
    	<c:set var="strHobby" value="${vo.hobby}"/>
    	
      <div class="form-check-inline">
        <span class="input-group-text">취미</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="등산" name="hobby" <c:if test="${fn:contains(strHobby,'등산')}">selected</c:if>/>등산
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="낚시" name="hobby" <c:if test="${fn:contains(strHobby,'낚시')}">selected</c:if>/>낚시
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="수영" name="hobby" <c:if test="${fn:contains(strHobby,'수영')}">selected</c:if>/>수영
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="독서" name="hobby" <c:if test="${fn:contains(strHobby,'독서')}">selected</c:if>/>독서
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="영화감상" name="hobby" <c:if test="${fn:contains(strHobby,'영화감상')}">selected</c:if>/>영화감상
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="바둑" name="hobby" <c:if test="${fn:contains(strHobby,'바둑')}">selected</c:if>/>바둑
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="축구" name="hobby" <c:if test="${fn:contains(strHobby,'축구')}">selected</c:if>/>축구
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked <c:if test="${fn:contains(strHobby,'기타')}">selected</c:if>/>기타
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요.">${vo.content}</textarea>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp;
        <label class="form-check-label">
       
          <input type="radio" class="form-check-input" name="userInfoSw" value="공개" <c:if test="${vo.userInfoSw=='공개'}">checked</c:if>/>공개
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="userInfoSw" value="비공개"  <c:if test="${vo.userInfoSw=='비공개'}">checked</c:if>/>비공개
        </label>
      </div>
    </div>
    <div  class="form-group">
      회원 사진(파일용량:10MByte이내) : <img src="${ctp}/member/${vo.photo}"/>
      <input type="file" name="fName" id="fName" class="form-control-file border"/>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">정보수정</button> &nbsp;
    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
    <button type="button" class="btn btn-secondary" onclick="">돌아가기</button>
    <input type=hidden name="mid" id="${sMid}"/>
    <input type=hidden name="tel" id="tel"/>
    <input type=hidden name="email" id="email"/>
    <input type=hidden name="photo" id="photo"/>
    <input type=hidden name="hobbys" id="hobbys"/>
  </form>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>