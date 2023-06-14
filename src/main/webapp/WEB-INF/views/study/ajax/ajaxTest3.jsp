<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ajaxTest3</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict'
		
		function midCheck(){
			let mid = document.getElementById("mid").value;
			if(mid.trim()==""){
				alert("아이디를 입력하세요");
				return false;
			}
			
			$.ajax({
				type:"post",
				url:"${ctp}/study/ajax/ajaxTest3_1",
				data:{mid:mid},
				success:function(vo){
					alert(vo);
					let str = "<b>vo로 전송된 자료의 출력</b>";
					if(vo != ''){
						str+='성명 : ' +vo.name+ '<br/>';
						str+='이메일 : ' +vo.eamil+ '<br/>';
						str+='홈페이지 : ' +vo.homePage+ '<br/>';
						str+='주소 : ' +vo.adress+ '<br/>';
						str+='포인트 : ' +vo.point+ '<br/>';						
					}
					else{
						srt+='자료가 업어요!!';
					}
					$('#demo').html(str);
				},
				error:function(){
					alert("전송오류!");
				}
			})
		}
		
		
		function midCheck2(){
			let mid = document.getElementById("mid").value;
			if(mid.trim()==""){
				alert("아이디를 입력하세요");
				return false;
			}
			
			$.ajax({
				type:"post",
				url:"${ctp}/study/ajax/ajaxTest3_2",
				data:{mid:mid},
				success:function(vos){
	
					let str = "<b>vo로 전송된 자료의 출력</b>";
					if(vos != ''){
						str+='<table class="table table-bordered">';
						for(let i=0; i<vos.length;i++){
							
						str+='<tr><th>성명 : </th><td>' +vos[i].name+ '</td>';
						str+='<th>이메일 : </th><td>' +vos[i].eamil+ '</td>';
						str+='<th>홈페이지 : </th><td>' +vos[i].homePage+ '</td>';
						str+='<th>주소 : </th><td>' +vos[i].adress+ '</td>';
						str+='<th>포인트 : </th><td>' +vos[i].point+ '</td></tr>';
						
						}
						str+='</table>';
					}
					else{
						str+='자료가 업어요!!';
					}
					$('#demo').html(str);
				},
				error:function(){
					alert("전송오류!");
				}
			})
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<p><br/></p>
	<h3>Member id serch by ajax transper</h3>
	<form>
		<p>
		 Member ID : 
		 <input type="text" id="mid" name="mid" autofocus/><br/>
		 <input type="button" value="same member ID search" onclick="midCheck()" class="btn btn-success"/>
		 <input type="button" value="same part member ID search" onclick="midCheck2()" class="btn btn-success"/>
		 <input type="reset" value="reset" onclick="midCehck()" class="btn btn-success"/>
		 <input type="button" value="return" onclick="location.href='${ctp}/study/ajax/ajaxForm'" class="btn btn-success"/>
			
		</p>
	</form>
	<p>
	search : <span id="demo" name="demo"></span>
	</p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>