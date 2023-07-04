<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<p><br/></p>
	<div style="margin-top: 3%">
		<h3>404오류가 발생하였습니다.</h3>
		<h4>페이지 경로를 찾을 수 없습니다.</h4>
		<h4>정확한 주소로 접속해 주세요!</h4>
		<a href="${ctp}/errorPage/errorMain" class="btn btn-primary">돌아가기</a>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>