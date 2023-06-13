<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>bCryptPassword 암호화</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		let str = '';
		let cnt=0;
		
		function bCryptPasswordCheck(){
			let pwd = document.getElementById("pwd").value;
			
			$.ajax({
				type:"post",
				url: "${ctp}/study/password/bCryptPassword",
				data: {pwd:pwd},
				success : function(res){
					cnt++;
					str += cnt + res + "<br/>";
					$("#demo").html(str);
				}
			})
			
		}
	</script>
	
</head>
<body class="d-flex flex-column min-vh-100">
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
<p><br/></p>
	<h3>bCryptPassword 암호화</h3>
	<hr/>
	<pre>
	- spring security framework 에서 제공하는 클래스 중 하나로, 비밀번호를 암호화 하는데 사용된다.
	주로 자바의 서버 프로그램 개발을 위해서 필요한 '인증'/'권한부여'및 '보안기능'을 제공해주는 프레임워크에 속한다.
	- bCryptPasswordEncoder는 BCrypt 해싱함수를 사용하여 비밀번호를 인코딩해주는 메서드와 가용제 의해 제출된 비밀번호를
		저장소에 저장된 비밀번호와의 일치여부를 확인해주는 메소드로 제공된다.
	- bCryptPasswordEncoder는 PasswordEncoder 인터페이스를 구현한 클래스이다.
	- 사용되는 메소드?
		1)encode(java.lang.CharSequence) : 패스워드를 암호화해주는 메소드이다.
			반환타입은 String이다.
			encode() 메서드는 sha-1에 의한 8byte(64bit)로 결합된 해시키를 랜덤하게 생성된 솔트(salt)를 지원한다.
		2)matchers(java.lang.CharSequence)
			제출된 인코딩되지 않는 패스워드의 일치여부를 판단하기 위해 인코딩된 패스워드와 비교 판단한다.
			반환타입은 boolean이다. 
	</pre>
<hr/>
<p>
	<input type="text" name="pwd" id="pwd" autofocus/>
	<input type="button" value="bCryptPassword암호화" onclick="bCryptPasswordCheck()" class="btn btn-success"/>
	</p>
<hr/>
<div>결과 출력</div>
<span id="demo"></span>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>