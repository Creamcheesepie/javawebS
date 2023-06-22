<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	
	<script>
	function imageSearch(){
		 var searchStr = searchForm.searchStr.value;
		 
		 $.ajax({
			type:"get",
			data:{searchStr:searchStr},
			url:"${ctp}/study/kakaomap/kakaomapStaticEx1Search",
			success:function(){
				location.reload();
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
<jsp:include page="/WEB-INF/views/study/kakaomap/kakaomenu.jsp"/>
<div class="container">
<p><br/></p>
<h3>이미지 섬네일 제작하기</h3>
<div class="row mb-3">
	<div class="col-2">
	 <div id="staticMap" style="width:150px;height:150px;"></div>
	</div>
	<div class="col-10">
		<form name="searchForm">
			<input type="text" name="searchStr" id="searchSet" value="${searchStr}"/><input type="button" onclick="imageSearch()" value="검색">
		</form>
	</div>
</div>
<div id="map" style="width:100%;height:500px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d50d68f65732dab8ab61379182e4fe11&libraries=services"></script>
<script>
var staticCenter;
//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 

// 키워드로 장소를 검색합니다
ps.keywordSearch('${searchStr}', placesSearchCB); 

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
        staticCenter = map.getCenter();
        
      	//이미지 지도에서 마커가 표시될 위치입니다 
        var markerPosition  = staticCenter; 

        // 이미지 지도에 표시할 마커입니다
        // 이미지 지도에 표시할 마커는 Object 형태입니다
        var marker = {
            position: markerPosition
        };

        var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
            staticMapOption = { 
                center: staticCenter, // 이미지 지도의 중심좌표
                level: 3, // 이미지 지도의 확대 레벨
                marker: marker // 이미지 지도에 표시할 마커 
            };    

        // 이미지 지도를 생성합니다
        var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
       
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
    });
}

</script>
<hr/>

<p><br/></p>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>