<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>captchaForm</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
	#captchaImage {
		width: 230px;
		height: 50px;
		border: 2px dotted #A3C552;
		text-align : center;
		padding : 5px;		
	}
	</style>
	<script>
		'use strict';
		
		$(document).ready(function(){
			$('#refreshBtn').click(function(e){
				$.ajax({
					type:"post",
					url:"${ctp}/study/captcha/captchaImage",
					async:false,
				});
			});
			
			$('#confirm').click(function(e){
				e.preventDefault();
				
				let strCaptcha = $("#strCaptcha").val();
				$.ajax({
					type:"post",
					url:"${ctp}/study/captcha/captcha",
					data:{strCaptcha:strCaptcha}
				}).done(function(result){
					if(result == "1")alert("로봇이 아니시군요. 계속진행하시지요.");
					else alert("인간이 아니신가요? 다시 입력해주세요.");
				});
			});
		});
		
	</script>
	
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
<p><br/></p>
<h2>captcha 연습</h2>
	<hr/>
	<pre>
		CAPTCHA는 기계는 인식할 수 없으나 사람은 쉽게 인식할 수 있는 텍스트, 이미지를 통해서 사람과 기계를 구별하는 프로그램이다.
		-preventDefault란? 
		a 태그나 submit 태그는 누르게 되면 href를 통해서 이동하서나, 창이 새로고침하여 실행되게 되는데,
		이때 preventDefault를 통해서 이러한 동작을 막아준다.
		주로 사용하는 경우는?
		(1) a 태그를 눌렀을 때도 href 링크로 이동하지 않게 할 경우
		(2) form 태그 안에 submit 역할을 하는 버튼을 눌렀을 떄도 새롤 실행하지 않게 하고 싶을 경우...(단, submit은 작동굄)
	</pre>
	<form name="myform">
		<p>다음 코드를 입력해 주세요 : <img src="${ctp}/images/captcha.png" id="captchaImage"/></p>
		<p>
			<input type="text" name="strCaptcha" id="strCaptcha"/>
			<button id="confirmBtn">확인</button>
			<button id="refreshBtn">새로고침</button>
		</p>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>