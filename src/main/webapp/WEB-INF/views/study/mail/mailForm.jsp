<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
	'use strict'
	
	
	function selectEmail(email){
		$("#toMail").val(email);
		$("#mailListModal").modal('hide');
	}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
<p><br/></p>
	<h3>메일 보내기</h3>
	<p>받는 사람의 메일 주소를 정확하게 입력하셔야합니다.</p>
	<form name="myform" method="post">
		<table class="table table-borderd">
			<tr>
				<th>받는사람</th>
				<td>
					<input type="text" name="toMail" id="toMail" value="${email}" placeholder="받는 사람의 메일 주소를 입력하세요" class="form-control" required autofocus />
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" placeholder="메일 제목을 입력하세요" class="form-control" required/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="7" name="content" class="form-control" required></textarea></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="submit" value="메일전송" class="btn btn-success"/>
					<input type="reset" value="다시쓰기" class="btn btn-warning"/>
					<input type="button" value="주소록" class="btn btn-info" data-toggle="modal" data-target="#mailListModal"/>
					<input type="button" value="돌아가기" onclick="location.herf='${ctp}/'" class="btn btn-success"/>
					
				</td>
			</tr>
		</table>
	</form>

</div>
  <!-- The Modal -->
  <div class="modal" id="mailListModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">주소록</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <c:forEach var="vo" items="${vos}" varStatus="st">
          	<div class="row">
          		<div class="col-4">닉네임(아이디)</div>
          		<div class="col-8">${vo.nickName}(${vo.mid})</div>
          		<div class="col-3">이메일</div>
          		<div class="col-9">${vo.email}</div>
          		<div class="col-12">
          			<input type="button" onclick="selectEmail('${vo.email}')" value="보내기" data-dismiss="modal"/>
          		</div>
          	</div>
          	<hr/>
          </c:forEach>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>