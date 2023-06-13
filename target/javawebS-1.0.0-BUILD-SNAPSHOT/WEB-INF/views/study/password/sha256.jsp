<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>sha256 암호화</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		let str = '';
		let cnt=0;
		
		function sha256Check(){
			let pwd = document.getElementById("pwd").value;
			
			$.ajax({
				type:"post",
				url: "${ctp}/study/password/sha256",
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
	<h3>sha256 암호화</h3>
	<hr/>
	<p>
	SHA 256 암호화는 SHA(Secure Hash algorithm) 알고리즘의 한 종류로서, 256비트, 32자리의 문자열로 구성된다.<br/>
	SHA 256 암호화는 단방향 암호화 방식이라서 복호화가 불가능하고, 속도가 빠르다는 장점이 있다.
	</p>
<hr/>
<p>
	<input type="text" name="pwd" id="pwd" autofocus/>
	<input type="button" value="sha256암호화" onclick="sha256Check()" class="btn btn-success"/>
	</p>
<hr/>
<div>결과 출력</div>
<span id="demo"></span>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>