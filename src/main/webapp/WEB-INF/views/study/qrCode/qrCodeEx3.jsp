<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>영화 예매하기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		function qrCheck(){
			let movieName = $("#movieName").val();
			let movieDate = $("#movieDate").val();
			let movieTime = $("#movieTime").val();
			let movieAdult = $("#movieAdult").val();
			let movieChild = $("#movieChild").val();
			let mid = $("#mid").val();
			
			
			if(movieName.trim()=="" || movieDate.trim()==""||movieTime.trim()==""){
				alert("입력하신 정보를 확인해주세요");
				return false;
			}
			//qr코드내역에 영화제목_상영날짜_상영시간_성인인원수_아동인원수_아이디
			let movieTemp = movieName+"_";
			movieTemp += movieDate+"_";
			movieTemp += movieTime+"_A";
			movieTemp += movieAdult+"_C";
			movieTemp += movieChild+"_";
			movieTemp += mid;
			
			$.ajax({
				type:"post",
				url:"${ctp}/study/qrCode/qrCodeEx3",
				data: {movieTemp:movieTemp},
				success:function(res){
					alert("QR코드가 생성되었습니다.\n"+res+"입니다.");
					let qrCode = 'QR code명 : '+ res+'<br>' ;
					qrCode +='<img src="${ctp}/resources/data/qrCode/'+res+'.png"/>';
					$("#demo").html(qrCode);
				},
				error:function(){
					alert("전송오류가 발생하였습니다.");
				}
			})
			
		}
		
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<p><br/></p>
<h3>영화 티켓 예매하기</h3>
<hr/>
<form name="myform" method="post">
	<b>생성된 qr코드를 메일로 전송해드립니다. 전송받은 qr코드를 입장시 매표소에 제시해주세요.</b><hr/>
	<hr>
		<form method="post">
		 <h4>${sMid}님 티켓예매</h4>
		<table class="table table-bordered">
			<tr>
				<th>
					영화
				</th>
				<td>
				<select name="movieName" id="movieName" class="form-control" required>
						<option value="" selected>영화선택</option>
						<option>인어공주</option>
						<option>스파이더맨</option>
						<option>엘리멘탈</option>
						<option>범죄도시3</option>
						<option>인디아나존스</option>
						<option>귀공자</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>상영일자</th>
				<td>
					<input type="date" name="movieDate" id="movieDate" value="<%=LocalDate.now() %>" class="form-control"/>
				</td>
			</tr>
			<tr>
				<th>상영시간</th>
				<td>
					<select name="movieTime" id="movieTime" class="form-control" required>
						<option value="" selected>상영시간 선택</option>
						<option>12:00</option>
						<option>15:00</option>
						<option>18:00</option>
						<option>21:00</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>인원수</th>
				<td>
					성인<input type="number" name="movieAdult" id="movieAdult" value="1" min="1" /><br/>
					아동<input type="number" name="movieChild" id="movieChild" value="0" min="0"/>
				</td>
			</tr>
			<tr>
			 <td colspan="2">
			 	<input type="button" value="티켓 예매 하기" onclick="qrCheck()" class="btn btn-success mr-2"/>
			 	<input type="reset" value="다시 예매 하기" class="btn btn-warning mr-2"/>
			 	<input type="button" value="돌아가기" onclick="location.href='${ctp}/study/qrCode/qrCodeForm';" class="btn btn-danger"/>
			 </td>
			</tr>
		</table>
		<input type="hidden" name="mid" id="mid" value="${sMid}"/>
		</form>
	<hr>
	
</form>
<hr/>
생성된 QR코드
<br>
<div id="demo"></div>
<hr/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>