<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userInpu2.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
<p><br/></p>
	<h3>회원 등록</h3>
	<form method="post">
	<div class="row">
		<div class="col-sm-4"></div>
		<div class="col-sm-2">아이디</div>
		<div class="col-sm-2"><input type="text" name="mid" placeholder="아이디를 입력해주세요" class="form-control"/></div>
		<div class="col-sm-4"></div>
		<div class="col-sm-4"></div>
		<div class="col-sm-2">성함</div>
		<div class="col-sm-2"><input type="text" name="name" placeholder="이름을 입력해주세요" class="form-control"/></div>
		<div class="col-sm-4"></div>
		<div class="col-sm-4"></div>
		<div class="col-sm-2">나이</div>
		<div class="col-sm-2"><input type="number" name="age" class="form-control"/></div>
		<div class="col-sm-4"></div>
		<div class="col-sm-4"></div>
		<div class="col-sm-2">주소</div>
		<div class="col-sm-2"><input type="text" name="address" placeholder="사는 지역을 입력해주세요. class="form-control""/></div>
		<div class="col-sm-4"></div>
	</div>
	<input type="submit" value="등록하기" class="btn btn-success"/>
	</form>
	
</div>
<p><br/></p>
</body>
</html>