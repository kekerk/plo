<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<title></title>
<script>
function listcall(page){
	  document.sf.pageNum.value=page;
	  document.sf.submit();
}
</script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", sans-serif}
</style>
</head>
<body class="w3-light-grey w3-content" style="max-width:1600px">



<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->

  <!-- Header -->
  <header id="portfolio">
    <div class="w3-container">

  <c:if test="${board.cate==1 && board.subcate==1}">
    <h1><b>스니커즈</b></h1>
  </c:if>
  <c:if test="${board.cate==1 && board.subcate==2}">
    <h1><b>런닝화</b></h1>
  </c:if>
  <c:if test="${board.cate==1 && board.subcate==3}">
    <h1><b>슬립온</b></h1>
  </c:if>
  <c:if test="${board.cate==2 && board.subcate==1}">
    <h1><b>옥스퍼드</b></h1>
  </c:if>
  <c:if test="${board.cate==2 && board.subcate==2}">
    <h1><b>로퍼</b></h1>
  </c:if>
  <c:if test="${board.cate==2 && board.subcate==3}">
    <h1><b>힐</b></h1>
  </c:if>
  <c:if test="${board.cate==3 && board.subcate==1}">
    <h1><b>플립플랍</b></h1>
  </c:if>
    <c:if test="${board.cate==3 && board.subcate==2}">
    <h1><b>슬라이드</b></h1>
  </c:if>
    <c:if test="${board.cate==3 && board.subcate==3}">
    <h1><b>스트랩</b></h1>
  </c:if>
    <c:if test="${board.cate==4 && board.subcate==1}">
    <h1><b>워커</b></h1>
  </c:if>
    <c:if test="${board.cate==4 && board.subcate==2}">
    <h1><b>앵클</b></h1>
  </c:if>
    <c:if test="${board.cate==4 && board.subcate==3}">
    <h1><b>레인</b></h1>
  </c:if>
    <div class="w3-section w3-bottombar w3-padding-16">
    </div>
    </div>
  </header>
  
  <!-- 게시물 표현부-->
  <c:if test="${param.cate==1}">
  <c:forEach var="list" items="${boardlist}">
  <c:set var = "content" value="${list.content }"/>
  <div class="w3-row-padding w3-third">
      <a href="detail.shop?itemno=${list.itemnum}&cate=${param.cate}"><img src="img/${list.file1}"  style="width:250px; height:450px;" class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.title}</b></p>
        <p>${fn:substring(content,0,9)}....</p><br>
        <p>조회수:${list.readcnt}</p>
      </div>
</div> 
</c:forEach>
</c:if>

<c:if test="${param.code==2}">
  <c:forEach var="list" items="${list}">
  <c:set var = "content" value="${list.content }"/>
  <div class="w3-row-padding w3-third">
      <a href="info.bo?num=${list.num}"><img src="img/${list.file1}"  style="width:250px; height:450px;" class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.title}</b></p>
        <p>${fn:substring(content,0,12)}...</p><br>
        <p>조회수:${list.readcnt}</p>
      </div>
</div> 
</c:forEach>
</c:if>

<c:if test="${param.code==3}">
  <c:forEach var="list" items="${list}">
  <c:set var = "content" value="${list.content }"/>
  <div class="w3-row-padding w3-third">
      <a href="info.bo?num=${list.num}"><img src="img/${list.file1}"  style="width:250px; height:450px;" class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.title}</b></p>
        <p>${fn:substring(content,0,12)}...</p><br>
        <p>조회수:${list.readcnt}</p>
      </div>
</div> 
</c:forEach>
</c:if>

<c:if test="${param.code==4}">
  <c:forEach var="list" items="${list}">
  <c:set var = "content" value="${list.content }"/>
  <div class="w3-row-padding w3-third">
      <a href="info.bo?num=${list.num}"><img src="img/${list.file1}"  style="width:250px; height:450px;" class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.title}</b></p>
        <p>${fn:substring(content,0,12)}...</p><br>
        <p>조회수:${list.readcnt}</p>
      </div>
</div> 
</c:forEach>
</c:if>

<c:if test="${param.code==5}">
  <c:forEach var="list" items="${list}">
  <c:set var = "content" value="${list.content }"/>
  <div class="w3-row-padding w3-third">
      <a href="info.bo?num=${list.num}"><img src="img/${list.file1}"  style="width:250px; height:450px;" class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.title}</b></p>
        <p>${fn:substring(content,0,12)}...</p><br>
        <p>조회수:${list.readcnt}</p>
      </div>
</div> 
</c:forEach>
</c:if>

<c:if test="${param.code==6}">
  <c:forEach var="list" items="${list}">
  <c:set var = "content" value="${list.content }"/>
  <div class="w3-row-padding w3-third">
      <a href="info.bo?num=${list.num}"><img src="img/${list.file1}"  style="width:250px; height:450px;" class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.title}</b></p>
        <p>${fn:substring(content,0,12)}...</p><br>
        <p>조회수:${list.readcnt}</p>
      </div>
</div> 
</c:forEach>
</c:if>

<c:if test="${param.code==7}">
  <c:forEach var="list" items="${list}">
<c:set var="content" value="${list.content}"/>
  <div class="w3-row-padding w3-third">
      <a href="info.bo?num=${list.num}"><img src="img/${list.file1}"  style="width:250px; height:450px;" class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.title}</b></p>
        <p>${fn:substring(content,0,12)}...</p><br>
        <p>조회수:${list.readcnt}</p>
      </div>
</div> 
</c:forEach>
</c:if>

<c:if test="${param.code==8}">
  <c:forEach var="list" items="${list}">
  <c:set var = "content" value="${list.content }"/>
  <div class="w3-row-padding w3-third">
      <a href="info.bo?num=${list.num}"><img src="img/${list.file1}"  style="width:250px; height:450px;" class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.title}</b></p>
        <p>${fn:substring(content,0,12)}...</p><br>
        <p>조회수:${list.readcnt}</p>
      </div>
</div> 
</c:forEach>
</c:if>

<c:if test="${param.code==9}">
  <c:forEach var="list" items="${list}">
  <c:set var = "content" value="${list.content }"/>
  <div class="w3-row-padding w3-third">
      <a href="info.bo?num=${list.num}"><img src="img/${list.file1}"  style="width:250px; height:450px;" class="w3-hover-opacity"></a>
      <div class="w3-container w3-white">
        <p><b>${list.title}</b></p>
        <p>${fn:substring(content,0,12)}...</p><br>
        <p>조회수:${list.readcnt}</p>
      </div>
</div> 
</c:forEach>
</c:if>
<table border="1" style="border-collapse:collapse;" class="w3-table-all">
 <c:if test="${boardcount==0}">
 <tr><td colspan="5">등록된 게시글이 없습니다.</td></tr>
 </c:if>
 <c:if test="${boardcount!=0}">
<tr align = "center"><td colspan="5"><font size="3pt">
<c:if test="${pageNum <=1}">[이전]</c:if>
<c:if test="${pageNum > 1}">
 <a href="javascript:listcall(${pageNum	 - 1})"  class="w3-bar-item w3-button w3-hover-black">[이전]</a>
 </c:if>
 
 <c:forEach var="a" begin="${startpage}" end ="${endpage}">
  <c:if test="${a==pageNum}">[${a}]</c:if>
  <c:if test="${a!=pageNum }">
   <a href="javascript:listcall(${a})"  class="w3-bar-item w3-button w3-hover-black">[${a}]</a></c:if>
 </c:forEach> 
 
 <c:if test="${pageNum>=maxpage}">[다음]</c:if>
 <c:if test="${pageNum < maxpage}">
 <a href="javascript:listcall(${pageNum + 1})"  class="w3-bar-item w3-button w3-hover-black">[다음]</a>
 </c:if>
 </font></td></tr></c:if>
 <c:if test="${sessionScope.login =='admin' }">
 <tr align="right">
  <td colspan="6" align="right"><a href="writeForm.bo?code=${param.code }" style="text-decoration: none;">[글쓰기]</a>
  </td>
  </tr>
  </c:if>
</table>
  <form action="list.bo" method="post" name="sf">
  <input type="hidden" name="pageNum" value="1">
  <input type="hidden" name="code" value="${param.code}">
  <select name="column">
    <option value="">선택하세요</option>
    <option value="title">제목</option>
    <option value="content">내용</option>
   </select>
   <script type="text/javascript">
     document.sf.column.value="${param.column}";
   </script>
   <input type="text" name="find" size="50" value="${find}">
   <input type="submit" value="검색">
  </form>
</body>
</html>
