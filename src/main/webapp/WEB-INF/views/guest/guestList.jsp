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
	<title>방명록(페이지 분량 조절)</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
	th{
		background-color:#eee;
		text-align:center;
	}
	
	</style>
	<script >
	'use strict'
	
	function pageCheck(){
		let pageSize = document.getElementById("pageSize").value;
		location.href="${ctp}/guest/guestList?pag=${pag}&pageSize="+pageSize;
	}
	
	function delCheck(idx){
		let ans = confirm("현재 게시물을 삭제하십니까?");
		if(ans) location.href="${ctp}/GuestDelete.gu?idx="+idx;
	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>	
	<div class="container">
		<h2 class="text-center">방명록 리스트</h2>
		<table class="table table-borderless mb-0 p-0">
				<tr>
					<td>
					<c:if test="${sAdmin != 'adminOk'}">
						<a href="${ctp}/guest/adminLogin" class="btn btn-secondary btn-sm">관리자</a>
					</c:if>
					<c:if test="${sAdmin == 'adminOk'}">
						<a href="${ctp}/guest/adminLogout" class="btn btn-danger btn-sm">관리자로그아웃</a>
					</c:if>
					</td>
					<td style="text-align:right;"><a href="${ctp}/guest/guestInput" class="btn btn-primary btn-sm">글쓰기</a></td>
				</tr>	
			</table>
			<table class="table table-borderless mb-0 p-0">
				<tr>
					<td class="text-left">
						<select name="pageSize" id="pageSize" onchange="pageCheck()">
							<option <c:if test="${pageSize==1}">selected</c:if>>1</option>
							<option <c:if test="${pageSize==3}">selected</c:if>>3</option>
							<option <c:if test="${pageSize==5}">selected</c:if>>5</option>
							<option <c:if test="${pageSize==10}">selected</c:if>>10</option>
						</select>건
					</td>
					<td class="text-right">
						<!--첫페이지 /이전페이지/현재페이지번호/총페이지수/다음페이지/마지막페이지 -->
						<c:if test="${pag>1}">
							<a href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${1}">◁◁</a>
							<a href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${pag-1}">◀</a>
						</c:if>
						${pag}/${totalPage}
						<c:if test="${pag<totalPage}">
							<a href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${pag+1}">▶</a>  
							<a href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${totalPage}">▷▷</a>
						</c:if>						
					</td>
				</tr>
			</table>
			
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<table class="table table-borderless mb-0">
				<tr>
					<td>
					번호 : ${curScrStartNo}
					<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
					<c:if test="${sAdmin == 'adminOk'}"><a href="javascript:delCheck(${vo.idx})" class="btn btn-danger">삭제</a></c:if>
					
					</td>
					<td style="text-align:right;">방문IP : ${vo.hostIp}</td>
				</tr>
			</table>
			<table class="table bordered mt-0">
				<tr>
					<th style="20%">성명</th>
					<td style="25%">${vo.name}</td>
					<th style="20%">방문일자</th>
					<td style="35%">${fn:substring(vo.visitDate,0,19)}</td>
				</tr>
				<tr>
					<th>메일주소</th>
					<td colspan="3">
		        <c:if test="${empty vo.email || fn:length(vo.email)<5 || fn:indexOf(vo.email,'@')==-1 || fn:indexOf(vo.email,'.')==-1}">- 없음 -</c:if>
		        <c:if test="${!empty vo.email && fn:length(vo.email)>=5 && fn:indexOf(vo.email,'@')!=-1 && fn:indexOf(vo.email,'.')!=-1}">${vo.email}</c:if>
	      	</td>
				</tr>
				<tr>
					<th>홈페이지</th>
					<td colspan="3">
						<c:if test="${empty vo.homePage || fn:length(vo.homePage)<10 || fn:indexOf(vo.homePage,'https://')==-1 || fn:indexOf(vo.homePage,'.')==-1}">- 없음 -</c:if>
						<c:if test="${!empty vo.homePage && fn:length(vo.homePage)>=10 || fn:indexOf(vo.homePage,'hppts://')!=-1 }">${vo.homePage}</c:if>
					</td>
				</tr>
				<tr>
					<th>방문소감</th>
					<td colspan="3">${fn:replace(vo.content,newLine,'<br/>')}</td>
				</tr>
			</table>
		</c:forEach>
		<br/>
		<!-- 처음 페이지 < 이전블록 < 1(4) 2(5) 3(6) > 다음블록 > 마지막 페이지 -->
		<div class="text-center">
    <c:if test="${pag > 1}">[<a href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=1">첫페이지</a>]</c:if>
    <c:if test="${curBlock > 0}">[<a href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a>]</c:if>
    <c:forEach var="i" begin="${curBlock*blockSize + 1}" end="${curBlock*blockSize + blockSize}" varStatus="st">
      <c:if test="${i <= totalPage && i == pag}">[<font color="red">${i}</font>]</c:if>
      <c:if test="${i <= totalPage && i != pag}">[<font color="red"><a href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${i}">${i}</a></font>]</c:if>
    </c:forEach>
    <c:if test="${curBlock < lastBlock}">[<a href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize + 1}">다음블록</a>]</c:if>
    <c:if test="${pag < totalPage}">[<a href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${totalPage}">마지막페이지</a>]</c:if>
		<div class="text-center">
			<ul class="pagination text-center justify-content-center border-secondary">	
				<c:if test="${pag>1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=1">첫페이지</a></li></c:if>
				<c:if test="${curBlock>0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize+1}">이전블록</a></li></c:if>
				<c:forEach var="i" begin="${curBlock*blockSize+1}" end="${curBlock*blockSize + blockSize}" varStatus="st">
					<c:if test="${i<=totalPage && i== pag}"><li class="page-item active bg-secondary"><a class="page-link bg-secondary" href="#">${i}</a></li></c:if>
					<c:if test="${i<=totalPage && i!= pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
				</c:forEach>
				<c:if test="${curBlock<lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize+1}">다음블록</a></li></c:if>
				<c:if test="${pag<totalPage}"><li class="page-item"><a class="page-link  text-secondary" href="${ctp}/guest/guestList?pageSize=${pageSize}&pag=${totalPage}">마지막페이지</a></li></c:if>
			</ul>
		</div>
  </div>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>