<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<div>
	<P>
		<a href="${ctp}/study/kakaomap/kakaomap" class="btn btn-primary">메인가기</a>
		<a href="${ctp}/study/kakaomap/kakaomapEx1" class="btn btn-success">클릭시 마커 표시하기</a>
		<a href="${ctp}/study/kakaomap/kakaomapEx2" class="btn btn-warning">DB에저장된 지명 검색</a>
		<a href="${ctp}/study/kakaomap/kakaomapEx3" class="btn btn-info">키워드 검색</a>
		<a href="${ctp}/study/kakaomap/kakaomapEx4" class="btn btn-secondary">카테고리별로 지도 표시</a>
		<a href="${ctp}/study/kakaomap/kakaomapStaticEx1" class="btn btn-blue">검색어 기준 섬네일 만들기</a>
		<a href="${ctp}/study/kakaomap/kakaomapStaticEx2" class="btn btn-blue">경로검색</a>
	</P>
	
</div>