<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- Navbar -->
	<div class="w3-top">
		<div class="w3-bar w3-black w3-card">
			<a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a> <a
				href="http://localhost:9090/javawebS" class="w3-bar-item w3-button w3-padding-large">HOME</a> 
			<a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">guest</a>
			<c:if test="${sLevel <=3 }">
				<a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Board</a>
				<a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">pds</a>
				
				<div class="w3-dropdown-hover w3-hide-small">
					<button class="w3-padding-large w3-button" title="More">study<i class="fa fa-caret-down"></i>
					</button>
					<div class="w3-dropdown-content w3-bar-block w3-card-4">
						<a href="${ctp}/study/password/sha256" class="w3-bar-item w3-button">암호화(sha256)</a> 
						<a href="${ctp}/study/password/aria" class="w3-bar-item w3-button">암호화(ARIA)</a> 
						<a href="${ctp}/study/password/bCryptPassword" class="w3-bar-item w3-button">암호화(MD5)</a>
						<a href="${ctp}/study/mail/mailForm" class="w3-bar-item w3-button">email연습</a>
						<a href="${ctp}/study/uuid/uuidForm" class="w3-bar-item w3-button">uuid연습</a>
						<a href="${ctp}/study/ajax/ajaxForm" class="w3-bar-item w3-button">ajax연습</a>
						<a href="${ctp}/study/fileUpload/fileUploadform" class="w3-bar-item w3-button">파일업로드 연습</a>
					</div>
				</div>
				<div class="w3-dropdown-hover w3-hide-small">
					<button class="w3-padding-large w3-button" title="More">study2<i class="fa fa-caret-down"></i>
					</button>
					<div class="w3-dropdown-content w3-bar-block w3-card-4">
						<a href="${ctp}/study/validator/validatorForm" class="w3-bar-item w3-button">validator연습</a> 
						<a href="${ctp}/study/kakaomap/kakaomap" class="w3-bar-item w3-button">kakaoMap연습</a>
						<a href="${ctp}/study/qrCode/qrCodeForm" class="w3-bar-item w3-button">qrCode 연습</a>
						<a href="${ctp}/study/captcha/captchaForm" class="w3-bar-item w3-button">captcha연습</a>
						<a href="${ctp}/study/thumbnail/thumbnailForm" class="w3-bar-item w3-button">섬네일 연습</a>
						<a href="${ctp}/errorPage/errorMain" class="w3-bar-item w3-button">error연습</a>
						<a href="${ctp}/study/transaction/transaction" class="w3-bar-item w3-button">transaction 연습</a>
					</div>
				</div>
				<div class="w3-dropdown-hover w3-hide-small">
					<button class="w3-padding-large w3-button" title="More">마이페이지<i class="fa fa-caret-down"></i>
					</button>
					<div class="w3-dropdown-content w3-bar-block w3-card-4">
						<a href="${ctp}/member/memberList" class="w3-bar-item w3-button">회원목록</a> 
						<a href="${ctp}/member/memberPwdUpdate" class="w3-bar-item w3-button">비밀번호 변경</a> 
						<a href="${ctp}/member/memberPwdCheck" class="w3-bar-item w3-button">정보수정</a>
						<a href="javascript:memberDelete('${sMid}')" class="w3-bar-item w3-button">탈퇴</a>
						<c:if test="${sLevel==0}">
						<a href="${ctp}/admin/adminPage" class="w3-bar-item w3-button">관리자</a>
						</c:if>
					</div>
				</div>
				</c:if>
				<c:if test="${empty sLevel}">
				<a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">로그인</a>
				<a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">회원가입</a>
				</c:if>
				<c:if test="${!empty sLevel}">
				<a href="${ctp}/member/memberInfo" class="w3-bar-item w3-button w3-padding-large w3-hide-small">회원정보</a>
				<a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">로그아웃</a>
			</c:if>
			<a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a>
		</div>
	</div>

	<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
	<div id="navDemo"
		class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top"
		style="margin-top: 46px">
		<a href="#band" class="w3-bar-item w3-button w3-padding-large"
			onclick="myFunction()">BAND</a> 
			<a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">guest</a>
		<a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Board</a> <a href="#"
			class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">pds</a>
			
			<a href="${ctp}/study/password/sha256"  class="w3-bar-item w3-button w3-padding-large">암호화(sha256)</a> 
			<a href="${ctp}/study/password/aria"  class="w3-bar-item w3-button w3-padding-large">암호화(ARIA)</a> 
			<a href="${ctp}/study/password/bCryptPassword"  class="w3-bar-item w3-button w3-padding-large">암호화(MD5)</a>
	</div>
	<script>
		'use strict'
		
		function memberDelete(mid){
			let ans = confirm("정말로 탈퇴하시겠습니까?");
			
			if(!ans){
				return false;
			}
			else{
				let ans = confirm("정말로 탈퇴하시겠습니까?? 이후 30일 동안 동일한 아이디로 재가입 하실 수 없습니다!");
				if(!ans){
					return false;					
				}
				else{
					location.href="${ctp}/member/memberDelete";
				}
			}
			
		}
	</script>