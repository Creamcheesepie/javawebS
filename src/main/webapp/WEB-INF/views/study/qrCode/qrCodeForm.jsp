<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>qrCode 연습하기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<p><br/></p>
<h3>qrCode 연습하기</h3>
<hr/>
<div class="row">
	<div class="col">
		<a href="${ctp}/study/qrCode/qrCodeEx1" class="btn btn-success">개인정보 등록</a>
		<a href="${ctp}/study/qrCode/qrCodeEx2" class="btn btn-primary">소개 사이트 등록</a>
		<a href="${ctp}/study/qrCode/qrCodeEx3" class="btn btn-info">티켓예매 등록</a>
		<a href="${ctp}/study/qrCode/qrCodeEx4" class="btn btn-info">DB저장하기</a>
	</div>
</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>