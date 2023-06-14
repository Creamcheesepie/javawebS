<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberMain</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
<p><br/></p>
<h3>회원 전용방</h3>
	<p>${sMid} 님 로그인 중입니다.</p>
	<p>현재 등급은 ${strLevel}입니다.</p>
	<c:if test="${!empty sTempPwd}">
		<hr/>
		현재 임시 비밀번호로 로그인 하셨습니다. 비밀번호를 변경해주세요.
		<a href="${ctp}/member/memberPwdUpdate" class="btn btn-success">바꾸러가기!</a>
		
	</c:if>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>