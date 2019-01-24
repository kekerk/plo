<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판 목록</title>
<script type="text/javascript">
   function list(pageNum) {
      var searchType = document.searchform.searchType.value;
      if(searchType ==null||searchType.length == 0){
         document.searchform.searchContent.value="";
         document.searchform.pageNum.value ="1";
         location.href="itemlist.shop?pageNum="+pageNum;
      }else{
         document.searchform.pageNum.value=pageNum;
         document.searchform.submit();
         return true;
      }
      return false;
   }
</script>
</head>
<body>
<table border="1" style="border-collapse: collapse; width: 100%;">
   <tr><td colspan="5" align="center">
     <form action="itemlist.shop" method="post" name="searchform" onsubmit="return list(1)">
        <input type="hidden" name="pageNum" value="1">
        <select name="searchType" id="searchType">
        <option value="">선택해주세요</option>
        <option value="name">제품명</option>
        <option value="itemno">제품번호</option>
        <option value="brand">브랜드</option>
        </select>&nbsp;
        <script type="text/javascript">
           if('${param.searchType}'!=''){
              document.getElementById("searchType").value ='${param.searchType}';
           }
        </script>
        <input type="text" name="searchContent" value="${param.searchContent}">
        <input type="submit" value="검색">
     </form>
   </td></tr>
   <c:if test="${listcount >0 }">
   <tr align="center" valign="middle">
   <td colspan="9">상품 리스트</td><td>글개수: ${listcount}</td></tr>
   <tr align="center" valign="middle" bordercolor="#212121">
   <th height="26">제품번호</th><th height="26">제품명</th><th height="26">브랜드</th>
   <th height="26">원가</th><th height="26">판매가</th><th height="26">할인율</th>
   <th height="26">색상</th><th height="26">수량</th><th height="26">등록날짜</th><th height="26"></th></tr>
   <c:forEach items="${itemlist}" var="item">
   <tr align="center" valign="middle" bordercolor="#333333" 
   onmouseover="this.style.backgroundColor='#5CD1E5'"
   onmouseout="this.style.backgroundColor=''">
   <c:set var="boardcnt" value="${boardcnt-1}"/>
   <td>
   <a href="iteminfo.shop?itemno=${item.itemno}">${item.itemno}</a></td><td>
   <a href="iteminfo.shop?itemno=${item.itemno}">${item.name}</a></td><td >${item.brand}</td>
   <td align="right">${item.cost}￦</td><td align="right">${item.price}￦</td>
   <td align="right">${item.discount}％</td><td>${item.color}</td><td align="right">${item.total}개</td>
   <td><fmt:formatDate value="${item.regdate}" pattern="yyyy-MM-dd"/></td><td><a href="../admin/itemupdate.shop?itemno=${item.itemno}">[수정]</a>
            <a href="../admin/itemdelete.shop?itemno=${item.itemno}">[삭제]</a>
           </td></tr>
   </c:forEach>
   <tr align="center" height="26"><td colspan="10">
   <c:if test="${pageNum>1 }"><a href="javascript:list(${pageNum -1})">[이전]</a></c:if> 
   <c:if test="${pageNum<=1 }">[이전]</c:if>
   <c:forEach var="a" begin="${startpage}" end="${endpage}">
   <c:if test="${a==pageNum}">[${a}]</c:if>
   <c:if test="${a!=pageNum}"><a href="javascript:list(${a})">[${a}]</a></c:if>
   </c:forEach>
   <c:if test="${pageNum<maxpage}"><a href="javascript:list(${pageNum +1})">[다음]</a></c:if> 
   <c:if test="${pageNum>=maxpage}">[다음]</c:if>
   </td></tr>
   </c:if>
   <c:if test="${listcount ==0 }">
      <tr><td colspan="5">등록된아이템이 없습니다.</td></tr>
   </c:if>
</table>
</body>
</html>