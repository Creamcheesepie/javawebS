<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>정보 사이트 등록</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		function qrCheck(){
			let moveUrl = $("#moveUrl").val();
			
			
			if(moveUrl.trim() =="" ){
				alert("이동할 주소를 입력해주세요");
				return false;
			}
			
			$.ajax({
				type:"post",
				url:"${ctp}/study/qrCode/qrCodeEx2",
				data: {moveUrl:moveUrl},
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
<h3>정보 사이트로 이동하기</h3>
<hr/>
<form name="myform" method="post">
	<b>개인 정보 입력</b><hr/>
	<hr>
		<form >
		<div class="input-group">
		이동할 주소 :<input type="text" name="moveUrl" id="moveUrl" value="naver.com" class="form-control"/>
			<div class="input-group-append">
				<input type="button" value="링크 QR 생성" onclick="qrCheck()" class="btn btn-success"/>
			</div>
		</div>
		</form>
	<hr>
	
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