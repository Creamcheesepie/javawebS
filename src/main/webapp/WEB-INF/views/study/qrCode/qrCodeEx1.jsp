<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인정보 등록</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		function qrCheck(){
			let mid = $("#mid").val();
			let name = $("#name").val();
			let email = $("#email").val();
			
			if(mid.trim() == "" || name.trim() =="" || email.trim()==""){
				alert("개인 정보를 확인해주세요.");
				return false;
			}
			
			let query ={
					mid:mid,
					name:name,
					email:email
			}
			
			$.ajax({
				type:"post",
				url:"${ctp}/study/qrCode/qrCodeEx1",
				data: query,
				success:function(res){
					alert("QR코드가 생성되었습니다.\n"+res+"님 정보입니다.");
					let qrCode = 'QR code명 : '+ res+'<br>' ;
					qrCode +='<img src="${ctp}/resources/data/qrCode/'+res+'.png"/>';
					$("#demo").html(qrCode);
				},
				error:function(){
					alert("전송오류가 발생하였습니다.");
				}
			})
			
		}
		
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<p><br/></p>
<h3>개인정보를 QR코드로 생성</h3>
<hr/>
<form name="myform" method="post">
	<b>개인 정보 입력</b><hr/>
	<table class="table table-bordered">
		<tr>
			<th>아이디</th>
			<td><input type="text" name="mid" id="mid" value="${sMid}" class="form-control"/></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" id="name" value="길동 홍" class="form-control"/></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email" id="email" value="gnldbs1004@naver.com" class="form-control"/></td>
		</tr>
		<tr>
		<td colspan="2" class="text-center">
			<input type="button" value="QR코드 생성" onclick="qrCheck()" class="btn btn-primary mr-3"/>
			<input type="button" value="다시 입력"  onclick="location.reload" class="btn btn-warning"/>
		</td>
		</tr>
	</table>
</form>
<hr/>
생성된 QR코드
<br>
<div id="demo"></div>
<hr/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>