<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
	
	function pageCheck(){
		let pageSize = document.getElementById("pageSize").value;
		location.href="${ctp}/board/boardList?pag=${pageVO.pag}&pageSize="+pageSize;
	}
	
	function searchCheck(){
		let searchString = $("#searchString").val();
		
		if(searchString.trim()==""){
			alert("찾고자 하는 검색어를 입력하세요!");
			searchFrom.searchString.focus();
		}1
		else{
			searchForm.submit();
		}
		
		
		
	}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>	
	<div class="container">
		<h2 class="text-center">게시판 리스트</h2>
		<table class="table table-borderless">
			<tr>
				<td>
					<c:if test="${sLevel==0 ||sLevel<2}">
						<a href="${ctp}/board/boardInput" class="btn btn-primary btn-sm">글쓰기</a>
					</c:if>
				
				</td>
				<td>
					<select name="pageSize" id="pageSize" onchange="pageCheck()">
						<option <c:if test="${pageVO.pageSize==5}">selected</c:if>>5</option>
						<option <c:if test="${pageVO.pageSize==10}">selected</c:if>>10</option>
						<option <c:if test="${pageVO.pageSize==15}">selected</c:if>>15</option>
						<option <c:if test="${pageVO.pageSize==20}">selected</c:if>>20</option>
					</select>건 표시
				</td>
			</tr>
		</table>
		<table class="table table-hover text-center">
			<tr class="table-dark text-white">
				<th>글 번호</th>
				<th>글 제목</th>
				<th>작성자</th>
				<th>작성시간</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
			<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<%-- <c:if test="${vo.openSw eq'ok'}"> --%>
					<tr>
						<td>${curScrStartNo}</td>
						<td>
							
							<c:if test="${vo.openSw == 'ok' ||sLevel ==0||sMid==vo.mid}">
							<c:if test="${vo.hour_diff<=24}"><img src="${ctp}/board/new.gif"/></c:if>
							<a href="${ctp}/board/boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}(${vo.replyCount})</a>
							<c:if test="${vo.hour_diff<=24}">&nbsp;<span class="badge badge-warning text-white">new!</span></c:if>
							</c:if>
							<c:if test="${vo.openSw != 'ok'&&sLevel !=0&&sMid!=vo.mid}">
							<c:if test="${vo.hour_diff<=24}"><img src="${ctp}/board/new.gif"/></c:if>
							${vo.title}(비공개)
							<c:if test="${vo.hour_diff<=24}">&nbsp;<span class="badge badge-warning text-white">new!</span></c:if>
							</c:if>
							
						</td>
						<td>${vo.nickName}</td>
						<td>
							<!-- 24시간 이내는 시간만 표시 이후는 날짜만 표시-->
							<!-- 단(24시간 안에 만족하는 자료),단 오늘날짜만 시간으로 표시하고,어제 날짜는 날짜로 표시하세요! -->
							<c:if test="${vo.date_diff==1}">
								<c:if test="${vo.hour_diff<=24}">${fn:substring(vo.WDate,0,10)}</c:if>
							</c:if>
							<c:if test="${vo.hour_diff<=24}">${fn:substring(vo.WDate,10,16)}</c:if>
							<c:if test="${vo.hour_diff>24}">${fn:substring(vo.WDate,0,10)}</c:if>	
							<!-- 선생님 방식 3항 비교
								<c:if test="${vo.hour_diff>24}">${fn:substring(vo.WDate,0,10)}</c:if>
								<c:if test="${vo.hour_diff <= 24}">
									${vo.date_diff==0?fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,11,19)}
								</c:if>
							 -->						
						</td>
						<td>${vo.readNum}</td>
						<td>${vo.good}</td>
					</tr>
					<c:set var="curScrStartNo" value="${pageVO.curScrStartNo-1}"/>
				<%-- </c:if> --%>
			</c:forEach>
		</table>
		<!-- 블록페이지 -->
		<ul class="pagination text-center justify-content-center border-secondary pagination-sm">	
				<c:if test="${pageVO.pag>1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=1">첫페이지</a></li></c:if>
				<c:if test="${pageVO.curBlock>0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}">이전블록</a></li></c:if>
				<c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize+1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
					<c:if test="${i<=pageVO.totPage && i== pageVO.pag}"><li class="page-item active bg-secondary"><a class="page-link bg-secondary" href="#">${i}</a></li></c:if>
					<c:if test="${i<=pageVO.totPage && i!= pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
				</c:forEach>
				<c:if test="${pageVO.curBlock<pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}">다음블록</a></li></c:if>
				<c:if test="${pageVO.pag<pageVO.totPage}"><li class="page-item"><a class="page-link  text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">마지막페이지</a></li></c:if>
			</ul>
	</div>
	<br/>
	<!-- 검색 기능 -->
	<div class="container text-center">
		<form name="searchForm" method="post" action="${ctp}/board/boardSearch">
			<b>검색</b><br/>
			<select name="search">
				<option value="title" selected>글제목</option>
				<option value="nickName">글쓴이</option>
				<option value="content">글내용</option>
			</select>
			<input type="text" name="searchString" id="searchString"/>
			<input type="button" value="검색" onclick="searchCheck()" class="btn btn-success btn-sm"/>
			<input type="hidden" name="pag" value="${pageVO.pag}"/>
			<input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
		</form>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>