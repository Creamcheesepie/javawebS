<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 목록</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		function detailInfo(idx){
			$.ajax({
				type:"post",
				url:"${ctp}/member/memberDetailInfo",
				data : {idx:idx},
				success:function(vo){
					let str = "<h3>"+vo.nickName+"님 상세정보<h3>";
					str += '아이디 : '+vo.mid+'<br/>';
					str += '닉네임 : '+vo.nickName+'<br/>';
					str += '성별 : '+vo.gender+'<br/>';
					str += '생일 : '+vo.birthday+'<br/>';
					str += '전화번호 : '+vo.tell+'<br/>';
					str += '주소 : '+vo.address+'<br/>';
					str += '이메일 : '+vo.email+'<br/>';
					str += '홈페이지 : '+vo.homePage+'<br/>';
					str += '직업 : '+vo.job+'<br/>';
					str += '취미 : '+vo.hobby+'<br/>';
					str += '자기소개 : '+vo.content+'<br/>';
					str += '포인트 : '+vo.point+'<br/>';
					str += '등급 : '+vo.level+'<br/>';
					str += '방문횟수 : '+vo.visitCnt+'<br/>';
					str += '가입일자 : '+vo.signInDate+'<br/>';
					str += '최종로그인시간 : '+vo.lastDate+'<br/>';
					$('#detailShow').html(str);
					$('#detailInfo').modal('show');
				},
				error:function(){
					alert("전송오류 발생")
				}
			})
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
		<div class="row text-center">
			<div class="col-2">이름</div>
			<div class="col-2">아이디</div>
			<div class="col-2">닉네임</div>
			<div class="col-2">성별</div>
			<div class="col-2">생일</div>
			<div class="col-2">직업</div>
		</div>
		<hr/>
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<div class="row text-center">
			<div class="col-2">${vo.name}</div>
			<div class="col-2">${vo.mid}</div>
			<div class="col-2"><a href="javascript:detailInfo('${vo.idx}')">${vo.nickName}</a></div>
			<div class="col-2">${vo.gender}</div>
			<div class="col-2">${vo.birthday}</div>
			<div class="col-2">${vo.job}</div>
		</div>
	</c:forEach>
</div>
  <!-- The Modal -->
  <div class="modal" id="detailInfo">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">회원 상세 정보</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <span id="detailShow" name="detailShow"></span>
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