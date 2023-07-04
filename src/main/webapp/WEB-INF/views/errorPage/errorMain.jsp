<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>errorMain.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<p><br/></p>
	<h2>에러 발생에 대한 대처 연습</h2>
	<hr/>
	<div>
		<pre>
			JSP 파일(view)에서의 서블릿 에러가 발생시는 JSP 파일 상단에 @page 지시자를 이용한 에러페이지로 이동처리 한다.
			< % @ page errorPage = "에러 발생시 처리할 JSP 파일 경로와 파일명" % >
		</pre>
	</div>
	<p>
		<a href="${ctp}/errorPage/error1" class="btn btn-success">JSP 오류페이지 호출</a>
	</p>
	<hr/>
	<pre>
		서블릿(servlet)에서의 에러가 발생시 대비하여 처리하는 방법?
		-web.xml에 error에 필요한 설정을 미리해두고 지정 페이지로 보내준다.
		처리방법?(web.xml)
		< error-page>
			< error-code>에러발생코드번호(400/404/500)< /error-code>
			< location>< /location>
		< /error-page>
	</pre>
	<p>
		<a href="${ctp}/dfhkashfuohu2rh890h2831h45nihe80fh802" class="btn btn-secondary">Servlet 오류(404)</a>
	</p>
	<p>
		<a href="${ctp}/errorPage/error500Check" class="btn btn-secondary">Servlet 오류(500)</a>
	</p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>