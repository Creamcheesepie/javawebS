<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
	'use strict';
	
	function goodCheck(){
		location.href="${ctp}/board/boardGoodCheck?idx=${vo.idx}&pageSize=${pageSize}&pag=${pag}";
		
	}
	
	function boardDelete(){
		let ans = confirm("이 글을 삭제하시겠습니까?");
		if(ans)location.href="${ctp}/board/boardDelete?idx=${vo.idx}&pageSize=${pageSize}&pag=${pag}&flag=${flag}&nickName=${vo.nickName}";
		
	}
	
	/* 댓글달기(ajax활용) */
	function replyCheck(){
		let content = $("#content").val();
		if(content.trim()==""){
			alert("댓글을 입력하세요!");
			$("#content").focus();
			return false;
		}
		let query = {
				boardIdx : ${vo.idx},
				mid : '${sMid}',
				nickName : '${sNickName}',
				content : content,
				postIp : '${pageContext.request.remoteAddr}'
		}
		$.ajax({
			type : "post",
			url : "${ctp}/BoardReplyInput",
			data : query,
			success : function(res){
				if(res == "1"){
					alert("댓글이 입력되었습니다.");
					location.reload();
				}
				else{
					alert("댓글 입력 실패");
				}
			},
			error : function(){
				alert("전송오류.");
			}
		});
	}
	
	function replyDelete(idx){
		let ans = confirm("댓글을 삭제하시겠습니까?");
		
		if(ans){
			$.ajax({
				type : "post",
				url : "${ctp}/board/boardReplyDelete",
				data : {idx:idx},
				success : function(res){
					
					if(res=='1'){
						alert("댓글이 삭제되었습니다.");
						location.reload();
					}
					else {
						alert("오류가 발생하여 댓글이 삭제되지 않았습니다.")
					}
				},
				error : function(){
					alert("오류가 발생하여 댓글이 삭제되지 않았습니다. 잠시 기다리신 후 새로고침하여 삭제하시거나 이 현상이 반복되면 운영자에게 문의주십시오.")
				}
			})
		};
		
		
	}

	//댓글 삭제
	
	
	
	</script>
	<style>
	th{
		text-align:center;
		background-color: #eee;
	}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>	
	<div class="container">
		<h2>글 내용 보기</h2>
		<table class="table table-borderless m-0 p-0">
			<tr>
				<td class="text-right">작성자  ip : ${vo.hostIp}</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th>글쓴이</th>
				<td>${vo.nickName}</td>
				<th>작성일</th>
				<td>${fn:substring(vo.WDate,0,fn:length(vo.WDate)-2)}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">${vo.title}</td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td>${vo.homePage}</td>
				<th>조회수</th>
				<td>${vo.readNum}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td >${vo.email}</td>
				<th>좋아요</th>
				<td>${vo.good}(<a href="javascript:goodCheck()">👍</a>)</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3" height="350px">${fn:replace(vo.content,newLine,"<br/>")}</td>
			</tr>
			<tr>
				<td colspan="4" class="text-center">
					<c:if test="${flag != 'search'}">
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList?pageSize=${pageSize}&pag=${pag}'" class="btn btn-warning"/>
					</c:if>
					<c:if test="${flag == 'search'}">
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardSearch?search=${search}&searchString=${searchString}&pageSize=${pageSize}&pag=${pag}'" class="btn btn-warning"/>
					</c:if>
					<c:if test="${sNickName==vo.nickName ||sLevel== 0}">
						<input type="button" value="수정하기" onclick="location.href='${ctp}/board/boardUpdate?search=${search}&searchString=${searchString}&pageSize=${pageSize}&pag=${pag}&idx=${vo.idx}'" class="btn btn-success"/>
						<input type="button" value="삭제하기" onclick="boardDelete()" class="btn btn-danger"/>
					</c:if>
				</td>
			</tr>
			
		</table> 
		
		<!-- 이전글 다음글 처리 -->
		<c:if test="${flag != 'search'}">
		<table class="table table-borderless">
			<tr>
					<td>
						<c:if test="${vo.idx<pnVOS[0].idx}">
						  👆 <a href="${ctp}/board/boardContent?idx=${pnVOS[0].idx}">다음글 : ${pnVOS[0].title}</a>
						</c:if>
						<c:if test="${vo.idx>pnVOS[1].idx}">
							👇 <a href="${ctp}/board/boardContent?idx=${pnVOS[1].idx}">이전글 : ${pnVOS[1].title}</a><br/>
						</c:if>
					</td>
			</tr>
		</table>
		</c:if>
		<!-- 댓글 리스트  -->
	<div class="container">
	<table class="table table-hover text-left">
		<tr>
			<th>작성자</th>
			<th>댓글내용</th>
			<th>작성일자</th>
			<th>접속IP</th>
		</tr>
		<c:forEach var="replyVo" items="${replyVos}">
			<tr>
				<td class="text-center">
				${replyVo.nickName}
					<c:if test="${sMid == replyVo.mid ||sLevel == 0}">
						(<a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제"><b>삭제</b></a>)
					</c:if>
				</td>
				<td class="text-center">${fn:replace(replyVo.content, newLine,"<br/>")}</td>
				<td class="text-center">${fn:substring(replyVo.WDate,0,10)}</td>
				<td class="text-center">${replyVo.postIp}</td>
				
			</tr>
		</c:forEach>
	</table>
	</div>
		
		
		<!-- 댓글 입력창 -->

		<form name="replyForm">
			<table class="table table-center">
				<tr>
					<td style="width:85%" class="text-left">
						글 내용 : 
						<textarea rows="4" class="form-control" name="content" id="content"></textarea>
					</td>
					<td style="width:15%">
						<p>작성자 : ${sNickName}</p>
						<p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info"/></p>
					</td>
				</tr>
			</table>
		</form>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>