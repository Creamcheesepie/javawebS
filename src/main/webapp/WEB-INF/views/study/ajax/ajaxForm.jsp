<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ajaxForm</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict'
		
		function aJaxTest1(idx){
			$.ajax({
				type:"post",
				url:"${ctp}/study/ajax/ajaxTest1",
				data:{idx:idx},
				success:function(res){
					$("#demo").html(res);
				},
				error : function(){
					alert("전송오류!!");
				}
			})
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
<p><br/></p>
	<h2>ajax연습</h2>
	<hr/>
	<p>기본(String) : </p>
		<a href="javascript:aJaxTest1(10)" class="btn btn-success mr-2">값 전달 1</a>
		:<span id="demo"></span>
	<hr/>
	<p>
		응용1(배열값):
		<a href="${ctp}/study/ajax/ajaxTest2_1" class="btn btn-secondary mr-2">시(도)/군(시,군,동)(String 배열)</a>
		<a href="${ctp}/study/ajax/ajaxTest2_2" class="btn btn-secondary mr-2">시(도)/군(시,군,동)(arrayList)</a>
		<a href="${ctp}/study/ajax/ajaxTest2_3" class="btn btn-secondary mr-2">시(도)/군(시,군,동)(Hash map)</a>
	</p>
	<p>
		응용2(데이터베이스):
		<a href="${ctp}/study/ajax/ajaxTest3" class="btn btn-secondary mr-2">회원아이디 검색</a>

	</p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>