<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>uuid 공부</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		let str = '';
		let cnt=0;
		
		function uuidCheck(){
			$.ajax({
				type:"post",
				url: "${ctp}/study/uuid/uuidForm",
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
	<h3>UUID에 대하여</h3>
	<hr/>
	<p>
	UUID(Universally Unique IDentifier)란, 네트워크 상에서 고유성이 보장되는 id를 만들기 위한 규약
	32자리의 16진수(128비트)로 표현된다.
	형식 : 8-4-4-4-14 자리로 표현된다.
	
	</p>
<hr/>
<p>
	<input type="button" value="UUID 확인" onclick="uuidCheck()" class="btn btn-success"/>
	</p>
<hr/>
<div>결과 출력</div>
<span id="demo"></span>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>