<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>transaction</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
	'use strict';
	
	function check1(){
		myform.action = "${ctp}/study/transaction/input1";
		myform.submit();
	}
	
	function check2(){
		myform.action = "${ctp}/study/transaction/input2";
		myform.submit();
	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="margin-top:3%">
<p><br/></p>
	<h2>transaction 연습</h2>
		<pre>
			transaction: 작업의 최소단위
			하나의 프로세스 처리과정 중에서 두개 이상의 자료(작업)을 동시에 처리하고자 할 때,
			두개 이상의 작업 중 하나라도 처리가 미결된 상태로 작업이 종료되게 된다면,
			이미 실행된 작업들도 동시에 초기화 되어야한다. (roll back):작업의 원자성
		</pre>
	<form name="myform" method="post">
		<h3>유저 등록폼</h3>
		<table class="table table-bordered text-center">
			<tr>
				<th>
					아이디:
				</th>
				<td>
					<input type="text" name="mid" class="form-control">
				</td>
			</tr>
			<tr>
				<th>
					성명
				</th>
				<td>
					<input type="text" name="name" class="form-control">	
				</td>
			</tr>
			<tr>
				<th>
					나이
				</th>
				<td>
					<input type="number" name="age" class="form-control">
				</td>
			</tr>
			<tr>
				<th>
					주소
				</th>
				<td>
					<input type="text" name="address" class="form-control">
				</td>
			</tr>
			<tr>
				<th>
					별명
				</th>
				<td>
					<input type="text" name="nickName" class="form-control">
				</td>
			</tr>
			<tr>
				<th>
					직업
				</th>
				<td>
					<input type="text" name="job" class="form-control">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" onclick="check1()" value="회원등록1(개별처리)" class="btn btn-success">
					<input type="button" onclick="check2()" value="회원등록2(일괄처리)" class="btn btn-primary">
					<input type="button" onclick="reset" value="다시 입력" class="btn btn-warning">
					<input type="button" onclick="location.href='${ctp}/study/transaction/transactionListGet'" value="회원전체보기" class="btn">
					
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>