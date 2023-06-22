<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>kakomapEx1.jsp(기본지도)</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d50d68f65732dab8ab61379182e4fe11"></script>
	<script>
		function addressSave(latitude,longitude){
			var address = myform.address.value;
			
			if(address==""){
				alert("선택한 지점의 장소명을 입력해주세요");
				myform.address.focus();	
				return false;
			}
			
			var query = {
					address:address,
					latitude:latitude,
					longitude:longitude
			}
			$.ajax({
				type:"post",
				url:"${ctp}/study/kakaomap/kakaomapEx1",
				data:query,
				success:function(res){
					if(res==1) alert("등록에 성공하였습니다.");
					else alert("동일한 이름이 있습니다. 다른 이름을 지정해 주세요")
				},
				error : function(){
					alert("전송오류가 발생하였습니다.");
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
<p><br/></p>
<h2>kakaoMap API(클릭한 위치에 마커 표시하기)</h2>
<hr/>
<h3>원하는 위치에 마커를 클릭해 주세요</h3>
<form name="myform">
<div id="clickLatlng"></div>
</form>
<div id="map" style="width:100%;height:450px;"></div>

<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(36.63514005228479, 127.45952698562377	), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter() 
}); 
// 지도에 마커를 표시합니다
marker.setMap(map);

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng; 
    
    // 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latlng);
    
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    message += '<input type="button" value="처음위치로" onclick="location.reload();"/><br/>';
    message += '<p>선택한 지점의 장소명 : <input type="text" name="address" id="address"/>';
    message += '<input type="button" value="장소저장" onclick="addressSave('+latlng.getLat()+','+latlng.getLng()+')" class="btn btn-success-sm mr-2"/>';
    message += '</p>';
    message += '';
    message += '';

    var resultDiv = document.getElementById('clickLatlng'); 
    resultDiv.innerHTML = message;
    
});
</script>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>