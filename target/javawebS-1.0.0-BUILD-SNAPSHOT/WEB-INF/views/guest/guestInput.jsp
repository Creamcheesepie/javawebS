<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>방명록 작성</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>	
	<h2 class="text-center">방명록작성</h2>
	<div class="container">
	<form name="myform" method="post" class="was-validated">
		<div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required>
      <div class="valid-feedback">잘하셨습니다~!</div>
      <div class="invalid-feedback">내용을 입력해 주세요!</div>
    </div>
		<div class="form-group">
      <label for="email">E-mail</label>
      <input type="text" class="form-control" id="email" placeholder="이메일을 입력하세요." name="email" >
    </div>
		<div class="form-group">
      <label for="email">홈페이지</label>
      <input type="text" class="form-control" id="homePage" placeholder="이메일을 입력하세요." name="homePage" value="https://">
    </div>
    <div class="form-group">
      <label for="pwd">방문소감</label>
      <textarea row="5" name="content" id="content" class="form-control" required></textarea>
      <div class="valid-feedback">잘하셨습니다~!</div>
      <div class="invalid-feedback">내용을 입력해주세요!</div>
    </div>
    <div class="form-group">
	    <button type="submit" class="btn btn-primary">방명록 등록</button>
	    <button type="reset" class="btn btn-warning">다시 쓰기</button>
	    <button type="button" onclick="location.href='${ctp}/GuestList.gu'" class="btn btn-danger">돌아가기</button>
    </div>
   	<input type="hidden" name="hostIp" value="<%=request.getRemoteAddr()%>"/>
	</form>	
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>