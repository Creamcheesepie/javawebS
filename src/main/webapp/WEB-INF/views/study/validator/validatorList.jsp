<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userList2.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		"use strict"
		
		function userDelete(idx){
			let ans = confirm("정말로 삭제하시겠습니까?");
			if(!ans){
				return false
			}
			else{
				location.href="${ctp}/user2/userDelete?idx="+idx;
			}
			
		}
		
		 function userDelete2(idx){
			 $.ajax({
				 type : "POST",
				 url : "${ctp}/user2/userDelete2",
				 data : {idx:idx},
				 success:function(res){
					 if(res=="1"){
						 alert("삭제되었습니다.")
						 location.reload();
					 }
				 },
				 error:function(){
					 alert("전송에러!");
				 }
			 })
			 
		 }
		 
		 
		 function userUpdateForm(idx,name,age,address){
			 $("#idx").val(idx);
			 $("#name").val(name);
			 $("#age").val(age);
			 $("#address").val(address);
			 
		 }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
<p><br/></p>
 <h2>User 리스트2</h2>
 <h3>
 	<c:if test="${empty mid}">전체결과</c:if>
 	<c:if test="${!empty mid}">부분결과(${mid}(${totCnt}건))</c:if>
 
 </h3>
 
 <table class="table table-borderless">
 	<tr>
 		<td>
 			<form>
			<div class="input-group">
				<input type="text" name="mid" class="form-control mr2" placeholder="검색할 아이디를 입력하세요"/>
				<div class="input-group-append">
				<input type="submit" value="아이디 부분 검색" class="btn btn-success mr-2"/>
				<input type="button" value="아이디 전제 검색" onclick="location.href='${ctp}/user2/userList2'" class="btn btn-warning"/>
				</div>
			</div>
			</form>
		</td>
	</tr>
 </table>
 
 
 <table class="table table-hover text-center">
 	<tr>
 		<td>번호</td>
 		<td>아이디</td>
 		<td>성명</td>
 		<td>나이</td>
 		<td>주소</td>
 		<td>비고</td>
 	</tr>	
 	<c:forEach var="vo" items="${vos}" varStatus="st">
 		<tr>
 			<td>${st.count}</td>
 			<td>${vo.mid}</td>
 			<td>${vo.name}</td>
 			<td>${vo.age}</td>
 			<td>${vo.address}</td>
 			<td>
	 			<button onclick="userDelete(${vo.idx})" class="badge badge-danger" >삭제</button>
	 			<button onclick="userDelete2(${vo.idx})" class="badge badge-danger" >삭제2</button>
	 			<button onclick="userUpdateForm('${vo.idx}','${vo.name}','${vo.age}','${vo.address}')" class="badge badge-primary" data-toggle="modal" data-target="#myModal" >수정</button>
 			</td>
 		</tr>
 	</c:forEach>
 	<tr><td colspan="5" class="m-0 p-0"><a href="${ctp}/study/validator/validatorForm" class="btn btn-warning">돌아가기</a></td></tr>
 </table>
 
</div>
<p><br/></p>
<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body"> 
      <form method="post" action="${ctp}/user2/userUpdateOk">
        <div>
        	성명 : <input type="text" name="name" id="name" class="form-control">
        </div>
        <div>
        	나이 : <input type="number" name="age" id="age" class="form-control">
        </div>
        <div>
        	주소 : <input type="text" name="address" id="address" class="form-control">
        </div>
        <div>
        <input type="hidden" name="idx" id="idx"/>
        <input type="submit" value="정보수정" class="form-control btn btn-success">
        </div>
      </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>