<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>저장된 지명 검색</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
	function addressSearch(){
		var address = myform.address.value;
		if(address==""){
			alert("검색할 지점을 선택하세요.");
			return false;
		}
		myform.submit
	}
	
	function addressDelete(){
		var address = myform.address.value;
		if(address==""){
			alert("삭제할 지점을 선택하세요.");
			return false;
		}
		var ans= confirm("선택하신 지역명을 DB에서 지우시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type:"post",
			data:{address:address},
			url:"${ctp}/study/kakaomap/kakaoAddressDelete",
			success:function(){
				alert("삭제되었습니다");
				location.herf="${ctp}/study/kakaomap/kakaomapEx2";
			},
			error:function(){
				alert("전송오류 발생");
			}
		})
		
	}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
<jsp:include page="/WEB-INF/views/study/kakaomap/kakaomenu.jsp"/>
<h2>DB에 저장된 지명으로 검색하기</h2>
<p><br/></p>
<hr/>
<div><form name="myform" method="post">
<select name="">
	<option value="">지역선택</option>
	<c:forEach var="avo" items="${vos}" varStatus="st">
		<option value="${avo.address}"<c:if test="${vo.address == avo.address}">selected</c:if>>${avo.address}</option>
	</c:forEach>
</select>
<input type="button" value="지역검색" onclick="addressSearch()"/>
<input type="button" value="지역삭제" onclick="addressDelete()"/>
</form></div>
<hr/>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d50d68f65732dab8ab61379182e4fe11"></script>
<div id="map" style="width:100%;height:500px;"></div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude}); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>