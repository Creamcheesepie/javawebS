<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>aria 암호화</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		let str = '';
		let cnt=0;
		
		function ariaCheck(){
			let pwd = document.getElementById("pwd").value;
			
			$.ajax({
				type:"post",
				url: "${ctp}/study/password/aria",
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
	<h3>ARIA 암호화</h3>
	<hr/>
	<p>
	ARIA 암호화는 경량환경 및 하드웨어 구현을 위해 최적화된 알고리즘으로, Involutional SPN 구조를 가지는 범용블록 암호화 알고리즘이다.<br/>
	ARIA가 사용하는 연산은 XOR 과 같은 단순한 바이트 단위 연산으로, 블록 크기는 128비트(총 비트수 256)이다.<br/>
	ARIA는 Academy(학계), Research Institute(연구소),Agency(정부기관)의 첫글자를 따서 만들었다.<br/>
	ARIA 암호화는 복호화가 가능하다.
	</p>
<hr/>
<p>
	<input type="text" name="pwd" id="pwd" autofocus/>
	<input type="button" value="ARIA암호화" onclick="ariaCheck()" class="btn btn-success"/>
	</p>
<hr/>
<div>결과 출력</div>
<span id="demo"></span>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>