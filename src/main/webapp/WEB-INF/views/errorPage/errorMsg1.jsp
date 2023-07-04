<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>errorMsg1</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<p><br/></p>
	<h2>에러가 발생하였습니다!!!</h2>
	<hr/>
	<h3>현재 시스템 정비 중입니다. </h3>
	<p>
		사용에 불편을 드려 죄송합니다.<br/>
		빠른 시일 내에 복구하도록 하겠습니다.
	</p>
	<a href="${ctp}/errorPage/errorMain" class="btn btn-success">메인으로 돌아가기</a>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>