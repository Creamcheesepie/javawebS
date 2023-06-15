<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>fileUpload</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use stricy';
		
		//처음 로딩시 처리내용(다운로드 파일은 가려준다.)
		$(document).ready(function(){
			$("#downloadFile").hide();
			$("#fileHidebtn").hide();
			
			$("#fileViewbtn").click(function(){
				$("#downloadFile").show();
				$("#fileHidebtn").show();
				$("#fileViewbtn").hide();
			});
			$("#fileHidebtn").click(function(){
				$("#downloadFile").hide();
				$("#fileHidebtn").hide();
				$("#fileViewbtn").show();
			})
			
			
		});
		
		function fCheck(){
			let fName1 = document.getElementById("fName").value;
			
			//alert("파일명" + fName);
			
			//확장자 추출
			let ext1 = fName1.substring(fName1.lastIndexOf(".")+1).toUpperCase();
			
			
			let maxSize = 1024 * 1024 *20; //15메가바이트 용량의 파일까지 업로드 가능함.
			
			if(fName1.trim()==""){ //파일명 유무 체크(제일 먼저 할것) 파일 없는데 다른 체크하면 오류나지?
				alert("업로드할 파일을 선택하세요.");
				return false;
			}
			
			let fileSize1 = document.getElementById("fName").files[0].size;
			
			if(ext1 != "JPG" && ext1 != "GIF" && ext1 != "ZIP" && ext1 != "HWP" && ext1 != "PNG" ){
				alert("업로드 가능한 파일은 '.jpg/.gif/.zip/.hwp'입니다. ");
			}
			else if(fileSize1>maxSize){ //파일 용량 검사단.
				alert("업로드 가능한 용량은 20메가바이트입니다.")
			}
			else{
				//alert("전송완료");
				myform.submit();
			}
			
		}
		
		//파일 삭제
		function fileDelete(file){
			let ans = confirm("선택한 파일을 지우시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type:"post",
				url:"${ctp}/study/fileUpload/fileDelete",
				data:{file:file},
				success:function(res){
					if(res==1){
						alert("파일이 삭제되었습니다.");
						location.reload();
					}
					else{
						alert("파일 삭제 실패~~");
					}
				},
				error:function(){
					alert("전송오류발생");
				}
			})
			
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<p><br/></p>
	<h2>파일 업로드 연습</h2>
	<form name="myform" method="post" enctype="multipart/form-data">
		<p>
		올린이 : <input type="text" name="mid" value="${sMid}" readonly/>
		</p>
		<p>파일명:
			<input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.png,.gif,.zip,.ppt,.pptx,.hwp"/> 
		</p>
			<input type="button" value="업로드" onclick="fCheck()" class="btn btn-success"/>
			<input type="reset" value="다시선택" class="btn btn-warning"/>
	</form>
	<hr/>
	<input type="button" value="저장된 파일 보기" id="fileViewbtn" class="btn btn-secondary"/>
	<input type="button" value="저장된 파일 가리기" id="fileHidebtn" class="btn btn-secondary"/>
	<hr/>
	<div id="downloadFile">
		<h3>저장된 파일 정보(총 ${filesCnt}건)</h3>
		<p>저장 경로 : ${ctp}/resources/data/study/*.*</p>
		<table class="table talble-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>파일명</th>
			<th>파일형식</th>
			<th>비고</th>
		</tr>
		<c:forEach var="file" items="${files}" varStatus="st">
		<tr>
			<td>${st.count}</td>
			<td><a href="${ctp}/resources/data/study/${file}" download>${file}</a></td>
			<td>
				<c:set var="fNameArr" value="${fn:split(file,'.')}"/>
				<c:set var="extName" value="${fn:toLowerCase(fNameArr[fn:length(fNameArr)-1])}"/>
				<c:if test="${extName=='zip'}">압축파일</c:if>
				<c:if test="${extName=='hwp'}">한글파일</c:if>
				<c:if test="${extName=='ppt'||extName=='pptx'}">ppt파일</c:if>
				<c:if test="${extName=='jpg'||extName=='png'||extName=='gif' }">
					<img src="${ctp}/resources/data/study/${file}" width="100px"/>
				</c:if>
				(${extName})
			</td>
			<td>
				<input type="button" value="다운로드" onclick="location.href='${ctp}/study/fileUpload/fileDownAction?file=${file}';" class="btn btn-success btn-sm"/>
				<input type="button" value="삭제" onclick="fileDelete('${file}')" class="btn btn-danger btn-sm"/>
			</td>
		</tr>
		</c:forEach>
		<tr><td colspan="4" class="m-0 p-0"></td></tr>
		</table>
		<hr/>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>