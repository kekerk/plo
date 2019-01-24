<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ include file = "/WEB-INF/view/jspHandler.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<html>
<head>
<meta charset="EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<link rel="stylesheet"  href="${path}/lightslider/css/lightslider.css"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="${path}/lightslider/css/sub.css">
<link rel="stylesheet" href="${path}/lightslider/css/slick.css">
<link rel="stylesheet" href="${path}/lightslider/css/slick-theme.css">
<style>
    	ul{
			list-style: none outside none;
		    padding-left: 0;
            margin: auto;
		}
        .demo .item{
            margin-bottom: 60px;
        }
		.content-slider li{
		    text-align : center;
		    color: #FFF;
		    
		}
		.content-slider h3 {
		    margin: 30px;
		    padding: 70px 0;
		}
		.demo{
			width: 100%;
		}
		img {
		 width :200px;
		 }

</style>
<script type="text/javascript">
	function list(pageNum){
		var searchType = document.searchform.searchType.value;
		if(searchType == null || searchType.length == 0){
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "list.shop?pageNum="+pageNum;
		} else{
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>
<script src="${path}/lightslider/js/lightslider.js"></script> 
<script>
   
    	 $(document).ready(function() {
			$("#content-slider").lightSlider({
                loop:true,
              	auto:true,
                keyPress:true
            });
            $('#image-gallery').lightSlider({
                gallery:true,
                item:1,
                thumbItem:9,
                slideMargin: 0,
                speed:500,
                auto:true,
                loop:true,
                onSliderLoad: function() {
                    $('#image-gallery').removeClass('cS-hidden');
                }  
            });
		});
</script>
<title>신발팜</title>
</head>
<body class="body">
<!-- Team Container -->
<h2>신발팜</h2>
<p>신발을 팔아보자</p>
 <div class="demo w3-container w3-padding w3-center">
        <div class="item">            
            <div class="clearfix" style="max-width:100%;">
                <ul id="image-gallery" class="gallery list-unstyled cS-hidden">
                <li data-thumb="${path}/picture/air.png"> 
                    <img class="w3-circle w3-hover-opacity" src="${path}/picture/air.png" />
                    <h3>에어포스</h3>
                    <p>&#8361;140,000</p>
                </li>
                 <li data-thumb="${path}/picture/roafer.jpg"> 
                    <img class="w3-circle w3-hover-opacity" src="${path}/picture/roafer.jpg" />
                    <h3>닥터마틴 옥스포드</h3>
                    <p>&#8361;180,000</p>
                </li>
                <li data-thumb="${path}/picture/sandle.jpg"> 
                    <img class="w3-circle w3-hover-opacity" src="${path}/picture/sandle.jpg" />
                     <h3>츄바스코 아즈텍</h3>
                     <p>&#8361;99,000</p>
                </li>
                <li data-thumb="${path}/picture/walker.jpg"> 
                   <img class="w3-circle w3-hover-opacity" src="${path}/picture/walker.jpg" />
                   <h3>레드윙 워커</h3>
                   <p>&#8361;380,000</p>
                </li>
            </ul>
           </div>
        </div>
  </div>
<c:if test="${param.code==1}">
  <c:forEach var="list" items="${boardlist}">
  <c:set var = "content" value="${list.content}"/>
  <div class="w3-row-padding w3-third">
      <a href="detail.shop?itemno=${list.itemno}"><img src="img/${list.file1}"  class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.name}</b></p>
      </div>
</div> 
</c:forEach>
</c:if>
</body>
</html>