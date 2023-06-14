<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict'
		
		function midFind(){
			let email = $("#toMail").val();
			let name = $("#name").val();
			$.ajax({
				type:"post",
				url:"${ctp}/member/memberMidFind",
				data : {email:email,name:name},
				success :function(res){
					alert(res);
					location.herf="${ctp}/member/memberLogin"
				},
				error : function(){
					alert("전송오류 발생")
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
	<h2>아이디 찾기</h2>
	<p>회원가입시 입력하신 이름과 이메일을 정확하게 입력해 주세요.</p>
	<form method="post">
		<table class="table table-bordered">
			<tr>
				<th>성함</th>
				<td><input type="text" name="name" id="name" class="form-control"  required></td>
			</tr>
			<tr>
				<th>메일주소</th>
				<td><input type="text" name="toMail" id="toMail" class="form-control"  required></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="아이디 찾기" onclick="midFind()" class="btn btn-success">
					<input type="reset" value="다시입력" class="btn btn-warning">
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberLogin'"  class="btn btn-secondary">
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>