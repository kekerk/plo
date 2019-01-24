<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>관리자용 상품 상세보기 </title>
</head>
<body>
   <div align="center">
         <h2>관리자용 상품 상세 화면</h2>
         <div style="float: left; width: 60%;">
            <table border="1">
               <tr>
                  <td width="12%">상품번호</td>
                  <td>${item.itemno}</td>
               </tr>
               <tr>
                  <td>상품명</td>
                  <td>${item.name}</td>
               </tr>
               <tr>
                  <td>원가</td>
                  <td>${item.cost}</td>
               </tr>
               <tr>
                  <td>브랜드</td>
                  <td>${item.brand}</td>
               </tr>
               <tr>
                  <td>가격</td>
                  <td>${item.price}</td>
               </tr>
               <tr>
                  <td>할인율</td>
                  <td>${item.discount}</td>
               </tr>
               <tr>
                  <td>색상</td>
                  <td>${item.color}</td>
               </tr>
               <tr>
                  <td>수량</td>
                  <td>${item.total}</td>
               </tr>
               <tr>
                  <td>상품설명</td>
                  <td>${item.content}</td>
               </tr>
            </table>
         </div>
         <div style="float: left; width: 40%;">
            <table border="1">
               <tr>
                  <td colspan="2">사이즈별 수량</td>
               </tr>
                        <tr>
                           <td align="center">사이즈</td>
                           <td align="center">수량</td>
                        </tr>
                        <c:forEach items="${item.size}" var="s">
                        <tr>
                           <td align="center">${s.size}</td>
                           <td align="center">${s.quantity}개</td>
                        </tr>
                        </c:forEach>                     
            </table>
         </div>

         <div style="float: left; width: 100%; padding: 10px;">
            <hr>
            <table>
               <tr>
                  <td colspan="2">사진</td>
               </tr>

                        <tr>
                           <td >사이즈</td>
                           <td>타입(상단 사진 1,하단사진 2)</td>
               
                        </tr>
                           <c:forEach items="${item.picturelist}" var="pic">
                           <tr>
                           <td><img src="../picture/${pic.pictureurl}" width="200" height="250"></td>
                           <td align="right">${pic.type }</td>
                           </tr>
                        </c:forEach>   

            </table>

            <table>
               <tr>
                  <td colspan="2">
                     <input type="button" value="상품목록"
                     onclick="location.href='list.shop'"></td>
               </tr>
            </table>
         </div>
   </div>
</body>
</html>