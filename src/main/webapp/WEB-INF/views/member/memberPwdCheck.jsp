<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 체크</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>

	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
<p><br/></p>
<h2>비밀번호 확인</h2>
	
	<form name="myform" method="post">
		<table class="table table-bordered">
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" id="pwd" class="form-control" autofocus required></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="submit" value="회원정보확인" class="btn btn-success">
					<input type="reset" value="다시입력" class="btn btn-warning">
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberLogin'"  class="btn btn-secondary">
					<input type="hidden" name="mid" id="mid" value="${sMid}"/>
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>