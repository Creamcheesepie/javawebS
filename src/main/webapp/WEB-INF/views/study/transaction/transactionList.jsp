<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 목록</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<p><br/></p>
	<div style="margin-top:3%"><h3>회원목록</h3></div>
	<div class="row">
		<div class="col-1">번호</div>
		<div class="col-2">아이디</div>
		<div class="col-1">이름</div>
		<div class="col-1">나이</div>
		<div class="col-2">주소</div>
		<div class="col-2">아이디</div>
		<div class="col-2">별명</div>
		<div class="col-1">직업</div>
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<div class="col-1">${vo.idx}</div>
		<div class="col-2">${vo.mid}</div>
		<div class="col-1">${vo.name}</div>
		<div class="col-1">${vo.age}</div>
		<div class="col-2">${vo.address}</div>
		<div class="col-2">${vo.mid}</div>
		<div class="col-2">${vo.nickName}</div>
		<div class="col-1">${vo.job}</div>
	</c:forEach>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>