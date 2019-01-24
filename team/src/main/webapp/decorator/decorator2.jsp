<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator"
   uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head></head>
<title>관리자페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
</style>
<decorator:head/>

</head>
<body class="w3-content" style="max-width:1200px">

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-bar-block w3-white w3-collapse w3-top" style="z-index:3;width:250px" id="mySidebar">
  <div class="w3-padding-64 w3-large w3-text-grey" style="font-weight:bold">
     <a href="${path}/admin/admain.shop" class="w3-bar-item w3-button">main</a>
    <a onclick="myAccFunc(1)" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn">
      회원관리 </i>
    </a>
    <div id="demoAcc1" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="${path}/admin/list.shop" class="w3-bar-item w3-button">회원리스트</a>
    </div>
    <a onclick="myAccFunc(2)" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn">
      상품관리 </i>
    </a>
    <div id="demoAcc2" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="${path}/admin/itemadd.shop" class="w3-bar-item w3-button">상품 등록</a>
      <a href="#" class="w3-bar-item w3-button">재고관리</a>
      <a href="${path}/admin/itemlist.shop" class="w3-bar-item w3-button">상품 리스트</a>
    </div>
    <a href="${path}/user/main.shop" class="w3-bar-item w3-button">쇼핑몰main</a>
  </div>
</nav>

<!-- Top menu on small screens -->
<header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
  <div class="w3-bar-item w3-padding-24 w3-wide">LOGO</div>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
</header>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px">
         <decorator:body/>
  <!-- End page content -->
</div>


<script>
// Accordion 
function myAccFunc(a) {
  var x = document.getElementById("demoAcc"+a);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}

// Click on the "Jeans" link on page load to open the accordion for demo purposes
document.getElementById("myBtn").click();


// Open and close sidebar
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
  document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
  document.getElementById("myOverlay").style.display = "none";
}
</script>

</body>
</html>