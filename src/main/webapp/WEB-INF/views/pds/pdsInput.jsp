<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>pdsInput</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
	'use strict'
	
	let appendCnt = 1;
	function fileAppend(){
		appendCnt++;
		let fileBox = '';
		fileBox +='<div id="fBox'+appendCnt+'" class="mt-2">';
		fileBox +='<input type="file" name="FName'+appendCnt+'" id="FName'+appendCnt+'" class="fileUp form-control-file border mt3" style="float:left;width:85%"/>';
		fileBox +='<input type="button" value="삭제" onclick="deleteBox('+appendCnt+')" class="btn btn-danger form-control mt3" style="float:left;width:10%"/>';
		fileBox +='';
		fileBox +='';
		fileBox +='</div>';
		$("#fileAppend").append(fileBox);
		
	}
	
	function deleteBox(cnt){
		$("#fBox"+cnt).remove();
		appendCnt--;
	}
	
	//자료 올리기
	function fCheck(){
		let FName = $("#FName").val();
		let title = $("#title").val();
		let pwd = $("#pwd").val();
		let maxSize = 1024*1024*20;  //chleo 20mb 허용	
		
		if(FName.trim()==""){
			alert="업로드할 파일명을 선택하세요."
			return false;
		}
		else if(title.trim()==""){
			alert="업로드할 파일의 제목을 입력하시오."
			return false;
		}
		else if(pwd.trim()==""){
			alert="업로드할 파일의 비밀번호를 입력하시오."
			return false;
		}
		
		//파일 사이즈 처리.. 보류
	
   	let fileSize = 0;
   	for(let i=1; i<=appendCnt; i++) {
   		let imsiName = 'FName' + i;
   		if(isNaN(document.getElementById(imsiName))) {
   			let FName = document.getElementById(imsiName).value;
   			if(FName != "") {
   				fileSize += document.getElementById(imsiName).files[0].size;
   				let ext = FName.substring(FName.lastIndexOf(".")+1).toUpperCase();
   				if(ext != "JPG" && ext != "GIF" && ext != "PNG" && ext != "ZIP" && ext != "HWP" && ext != "PPT" && ext != "PPTX" && ext != "PDF") {
   					alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/ppt' 파일입니다.");
   					return false;
   				}
   			}
   		}
    } 
		
		
		myform.fileSize.value = fileSize;
		myform.submit();
		
	}
	
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>	
	<div class="container">
		<form name="myform" method="post" enctype="multipart/form-data">
			<h2 class="text-center">자료실(${part})업로드</h2>
			<br/>
			<div>
				<input type="button" value="파일추가" onclick="fileAppend()" class="btn btn-info mt-2"/>
				<input type="file" name="file" id="FName" multiple class="form-control-file bordered"/>
			</div>
			<div id="fileAppend"></div>
			<div class="mt-2">
				올린이 : ${sNickName}
			</div>
			<div class="mt-2">
			 	제목 : <input type="text" name="title" id="title" placeholder="자료의 제목을 입력하세요." class="form-control" required/>
			</div>
			<div class="mt-2">
				내용 : <textarea rows="12" name="content" id="content" placeholder="자료의 상세내역을 입력하세요." class="form-control"></textarea>
			</div>
			<div class="mt-2">
				분류 
				<select name="part" id="part">
					<option ${part=="전체"?"selected" :""}>분류선택</option>
					<option ${part=="학습"?"selected" :""}>학습</option>
					<option ${part=="여행"?"selected" :""}>여행</option>
					<option ${part=="음식"?"selected" :""}>음식</option>
					<option ${part=="음악"?"selected" :""}>음악</option>
					<option ${part=="영상"?"selected" :""}>영상</option>
					<option ${part=="기타"?"selected" :""}>기타</option>
				</select>
			</div>
			<div class="mt-2">
				공개여부 : <input type="radio" name="openSw" value="공개" checked/>공개 &nbsp;&nbsp;
								<input type="radio" name="openSw" value="바공개" />비공개
			</div>
			<div class="mt-2">
				비밀번호 :
				<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." required/>
			</div>
			<div class="mt-2">
				<input type="button" value="업로드" onclick="fCheck()" class="btn btn-success"/>&nbsp;
				<input type="reset" value="다시입력"  class="btn btn-warning"/>&nbsp;
				<input type="button" value="돌아가기" onclick="location.href='${ctp}/PdsList.psd?part=${part}&pageSize=${pageSize}&nowPage=${nowPage};'" class=" btn btn-secondary"/>
			</div>
			<input type="hidden" name="mid" value="${sMid}"/>
			<input type="hidden" name="nickName" value="${sNickName}"/>
			<input type="hidden" name="fileSize"/>
			<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
		</form>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>