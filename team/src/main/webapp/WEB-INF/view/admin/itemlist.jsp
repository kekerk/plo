<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� ���</title>
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
        <option value="">�������ּ���</option>
        <option value="name">��ǰ��</option>
        <option value="itemno">��ǰ��ȣ</option>
        <option value="brand">�귣��</option>
        </select>&nbsp;
        <script type="text/javascript">
           if('${param.searchType}'!=''){
              document.getElementById("searchType").value ='${param.searchType}';
           }
        </script>
        <input type="text" name="searchContent" value="${param.searchContent}">
        <input type="submit" value="�˻�">
     </form>
   </td></tr>
   <c:if test="${listcount >0 }">
   <tr align="center" valign="middle">
   <td colspan="9">��ǰ ����Ʈ</td><td>�۰���: ${listcount}</td></tr>
   <tr align="center" valign="middle" bordercolor="#212121">
   <th height="26">��ǰ��ȣ</th><th height="26">��ǰ��</th><th height="26">�귣��</th>
   <th height="26">����</th><th height="26">�ǸŰ�</th><th height="26">������</th>
   <th height="26">����</th><th height="26">����</th><th height="26">��ϳ�¥</th><th height="26"></th></tr>
   <c:forEach items="${itemlist}" var="item">
   <tr align="center" valign="middle" bordercolor="#333333" 
   onmouseover="this.style.backgroundColor='#5CD1E5'"
   onmouseout="this.style.backgroundColor=''">
   <c:set var="boardcnt" value="${boardcnt-1}"/>
   <td>
   <a href="iteminfo.shop?itemno=${item.itemno}">${item.itemno}</a></td><td>
   <a href="iteminfo.shop?itemno=${item.itemno}">${item.name}</a></td><td >${item.brand}</td>
   <td align="right">${item.cost}��</td><td align="right">${item.price}��</td>
   <td align="right">${item.discount}��</td><td>${item.color}</td><td align="right">${item.total}��</td>
   <td><fmt:formatDate value="${item.regdate}" pattern="yyyy-MM-dd"/></td><td><a href="../admin/itemupdate.shop?itemno=${item.itemno}">[����]</a>
            <a href="../admin/itemdelete.shop?itemno=${item.itemno}">[����]</a>
           </td></tr>
   </c:forEach>
   <tr align="center" height="26"><td colspan="10">
   <c:if test="${pageNum>1 }"><a href="javascript:list(${pageNum -1})">[����]</a></c:if> 
   <c:if test="${pageNum<=1 }">[����]</c:if>
   <c:forEach var="a" begin="${startpage}" end="${endpage}">
   <c:if test="${a==pageNum}">[${a}]</c:if>
   <c:if test="${a!=pageNum}"><a href="javascript:list(${a})">[${a}]</a></c:if>
   </c:forEach>
   <c:if test="${pageNum<maxpage}"><a href="javascript:list(${pageNum +1})">[����]</a></c:if> 
   <c:if test="${pageNum>=maxpage}">[����]</c:if>
   </td></tr>
   </c:if>
   <c:if test="${listcount ==0 }">
      <tr><td colspan="5">��ϵȾ������� �����ϴ�.</td></tr>
   </c:if>
</table>
</body>
</html>