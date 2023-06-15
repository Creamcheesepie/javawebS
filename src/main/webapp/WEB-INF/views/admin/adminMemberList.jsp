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
					let str = "<h3>"+vo.nickName+"님 상세정보</h3>";
					str += '아이디 : '+vo.mid+'<br/>';
					str += '닉네임 : '+vo.nickName+'<br/>';
					str += '이름 : '+vo.name+'<br/>';
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
		
		function memberSearch(){
			let keyWord= $("#keyWord").val();
			let searchStr = $("#searchStr").val();
			
			$.ajax({
				type:"post",
				data:{keyWord:keyWord,searchStr:searchStr},
				url:"${ctp}/member/memberSearch",
				success:function(vos){
					let str = "<h3>"+searchStr+" 검색결과</h3><hr/>";
					if(vos!=""){
						for(let i=0 ; i<vos.length;i++){
							str += '아이디 : '+vos[i].mid+'<br/>';
							str += '닉네임 : '+vos[i].nickName+'<br/>';
							str += '이름 : '+vos[i].name+'<br/>';
							str += '이메일 : '+vos[i].email+'<br/>';
							str += '직업 : '+vos[i].job+'<br/>';
							str += '등급 : '+vos[i].level+'<br/>';
							str += '가입일자 : '+vos[i].signInDate+'<br/>';
							str += '최종로그인시간 : '+vos[i].lastDate+'<br/><hr/>';
						}
						$('#detailShow').html(str);
						$('#detailInfo').modal('show');
					}
					else{
						str+="검색결과가 없습니다.";
					}
					
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
	<form method="post">
	<div class="row">
		<div class="col-4"></div>
		<div class="col-2 text-right">
			<select name="keyWord" id="keyWord" class="form-control">
				<option value="mid" selected>아이디</option>			
				<option value="nickName">닉네임</option>			
				<option value="name">이름</option>				
			</select>
		</div>
		<div class="col-4">
			<input type="text" id="searchStr" name="searchStr" placeholder="검색어를 입력해주세요" class="form-control"/>
		</div>
		<div class="col-2">
			<input type="button" value="검색" onclick="memberSearch()" class="btn btn-success form-control"/>
		</div>
	</div>
	</form>
	<hr/>
		<div class="row text-center">
			<div class="col-2">이름</div>
			<div class="col-2">아이디</div>
			<div class="col-2">닉네임</div>
			<div class="col-2">성별</div>
			<div class="col-4">등급</div>
		</div>
		<hr/>
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<div class="row text-center">
			<div class="col-2">${vo.name}</div>
			<div class="col-2">${vo.mid}</div>
			<div class="col-2"><a href="javascript:detailInfo('${vo.idx}')">${vo.nickName}</a></div>
			<div class="col-2">${vo.gender}</div>
			<div class="col-4">
				<select>
				
				</select>
			${vo.birthday}
			</div>
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