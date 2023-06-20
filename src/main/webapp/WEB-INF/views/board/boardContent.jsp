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
	
	//전체댓글(보이기/가리기)
	$(document).ready(function(){
		$("#reply").show();
		
		
		$("#replyHideBtn").click(function(){
			$("#reply").slideUp(500);
			$("#replyHideBtn").hide();
			$("#replyViewBtn").show();
		})
		
		$("#replyViewBtn").click(function(){
			$("#reply").slideDown(500);
			$("#replyHideBtn").show();
			$("#replyViewBtn").hide();
		})
		
	});
	
	function goodCheck(){
		location.href="${ctp}/board/boardGoodCheck?idx=${vo.idx}&pageSize=${pageVO.pageSize}&pag=${pageVO.pag}";
		
	}
	
	function boardDelete(){
		let ans = confirm("이 글을 삭제하시겠습니까?");
		if(ans)location.href="${ctp}/board/boardDelete?idx=${vo.idx}&pageSize=${pageVO.pageSize}&pag=${pageVO.pag}&flag=${flag}&nickName=${vo.nickName}";
		
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
			url : "${ctp}/board/boardReplyInput",
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
	
	//댓글 삭제
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
	
	//대댓글 폼 출력하기 원 댓글의 댓글, 대댓글의 댓글....
	function insertReply(idx,nickName,groupId,level){
		let insReply = '';
		insReply +='<div class="container">';
		insReply +='<table class="m-2 p-0" style="width:90%">';
		insReply +='<tr>';
		insReply +='<td class="p-0 text-left">';
		insReply +='<div >';
		insReply +='답변 댓글 달기 : <input type="text" name="nickName" value="${sNickName}" size="6" readonly class="p-0"/>';
		insReply +='</div>';
		insReply +='</td>';
		insReply +='<td class="text-right">';
		insReply +='<input type="button" value="답글 달기" onclick="replyCheck2('+idx+','+groupId+','+level+')"';
		insReply +='</td><tr/><tr><td colspan="2" class="text-center p-0">';
		insReply +='<textarea row="3" class="form-control p-0" name="content" id="content'+idx+'">';
		insReply +='@'+nickName+'\n';
		insReply +='</textarea>';
		insReply +='</td>';
		insReply +='</tr>';
		insReply +='</table>';
		insReply +='</div>';
		
		$("#replyBoxOpenBtn"+idx).hide();
		$("#replyBoxCloseBtn"+idx).show();
		$("#replyBox"+idx).html(insReply);
		$("#replyBox"+idx).slideDown(250);
	}
	
	//대댓글 창 닫기
	function closeReply(idx){
		$("#replyBoxOpenBtn"+idx).show();
		$("#replyBoxCloseBtn"+idx).hide();
		$("#replyBox"+idx).slideUp(250);
	}
	
	function replyCheck2(idx,groupId,level){
		let boardIdx= '${vo.idx}';
		let mid = '${sMid}';
		let nickName = '${sNickName}';
		let content = $("#content"+idx).val();
		let postIp = '${pageContext.request.remoteAddr}';
		
		if(content == ""){
			alert("답변글(대댓글을 입력하세요.)");
			$("#content"+idx).focus();
			return false;
		}
		
		let query = {
				boardIdx : ${vo.idx},
				mid : mid,
				nickName : nickName,
				content : content,
				postIp : postIp,
				groupId : groupId,
				level : level
		}
		
		$.ajax({
			type:"post",
			url:"${ctp}/board/boardReplyInput2",
			data:query,
			success:function(){
				location.reload();
			},
			error: function(){
				alert("전송오류 발생");
			}
		})
	}
	
	//대댓글 수정하기
	function updateReplyForm(idx,content){
		let insReply = '';
		insReply +='<div class="container">';
		insReply +='<table class="m-2 p-0" style="width:90%">';
		insReply +='<tr>';
		insReply +='<td class="p-0 text-left">';
		insReply +='<div>';
		insReply +='댓글 수정하기 : <input type="text" name="nickName" value="${sNickName}" size="6" readonly class="p-0"/>';
		insReply +='</div>';
		insReply +='</td>';
		insReply +='<td class="text-right">';
		insReply +='<input type="button" value="답글 달기" onclick="updateReply('+idx+')"';
		insReply +='</td><tr/><tr><td colspan="2" class="text-center p-0">';
		insReply +='<textarea row="3" class="form-control p-0" name="content" id="content'+idx+'">';
		insReply += content.replaceAll("<br/>","\n");
		insReply +='</textarea>';
		insReply +='</td>';
		insReply +='</tr>';
		insReply +='</table>';
		insReply +='</div>';
		
		$("#replyBoxOpenBtn"+idx).hide();
		$("#replyBoxCloseBtn"+idx).show();
		$("#replyBox"+idx).html(insReply);
		$("#replyBox"+idx).slideDown(250);
		
	}
	
	
	
	//댓글 전체 수정하기
	function updateReply(idx){
		let content = $("#content"+idx).val();
		let postIp = "${pageContext.request.remoteAddr}"
		
		if(content==""){
			alert("답변글(대댓글)을 입력하세요.");
			$("#content"+idx).focus();
			return false;
		}
		
		let query = {
				idx:idx,
				content:content,
				postIp : postIp
		}
		
		$.ajax({
			type:"post",
			url:"${ctp}/board/boardReplyUpdate",
			data:query,
			success:function(){
				alert("댓글이 수정되었씁디나!")
				location.reload();
			},
			error:function(){
				
			}
		})
		
	}
	
	
	
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
		<!-- 댓글(대댓글) 보이기 가리기 처리 -->
		<div class="text-center mb-3">
			<input type="button" value="댓글 보이기" id="replyViewBtn" class="btn btn-secondary" style="display:none;"/>
			<input type="button" value="댓글 가리기" id="replyHideBtn" class="btn btn-secondary" />
		</div>
		<!-- 댓글 리스트  -->
	<div id="reply" class="container">
	<table class="table table-hover text-left">
		<tr>
			<th class="text-left">작성자</th>
			<th>댓글내용</th>
			<th>작성일자</th>
			<th>접속IP</th>
			<th>답글 쓰기</th>
		</tr>
		<c:forEach var="replyVO" items="${replyVOS}">
			<tr>
				<td class="text-left">
				${replyVO.nickName}
					<c:if test="${sMid == replyVO.mid ||sLevel == 0}">
						(<a href="javascript:replyDelete(${replyVO.idx})" title="댓글삭제"><b>삭제</b></a>)
					</c:if>
				</td>
				<td class="text-center">${fn:replace(replyVO.content, newLine,"<br/>")}</td>
				<td class="text-center">${fn:substring(replyVO.WDate,0,10)}</td>
				<td class="text-center">${replyVO.postIp}</td>
				<td class="text-center m-0 p-0">
				<c:if test="${sMid == replyVO.mid ||sLevel == 0}">
					<c:set var="content" value="${fn:replace(replyVO.content, newLine,'<br/>') }"/>
					<input type="button" value="답글" onclick="insertReply('${replyVO.idx}','${replyVO.nickName}','${replyVO.groupId}','${replyVO.level}')" id="replyBoxOpenBtn${replyVO.idx}" class="btn btn-success btn-sm"/>
					<input type="button" value="수정" onclick="updateReplyForm('${replyVO.idx}','${content}')" id="replyBoxBtn${replyVO.idx}" class="btn btn-success btn-sm"/>
					<input type="button" value="닫기" onclick="closeReply(${replyVO.idx})"  id="replyBoxCloseBtn${replyVO.idx}" class="btn btn-success btn-sm"/>
				</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="5" class="m-0 p-0" style="border-top:none;">
					<div id="replyBox${replyVO.idx}"></div>
				</td>
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