<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�����ڿ� ��ǰ �󼼺��� </title>
</head>
<body>
   <div align="center">
         <h2>�����ڿ� ��ǰ �� ȭ��</h2>
         <div style="float: left; width: 60%;">
            <table border="1">
               <tr>
                  <td width="12%">��ǰ��ȣ</td>
                  <td>${item.itemno}</td>
               </tr>
               <tr>
                  <td>��ǰ��</td>
                  <td>${item.name}</td>
               </tr>
               <tr>
                  <td>����</td>
                  <td>${item.cost}</td>
               </tr>
               <tr>
                  <td>�귣��</td>
                  <td>${item.brand}</td>
               </tr>
               <tr>
                  <td>����</td>
                  <td>${item.price}</td>
               </tr>
               <tr>
                  <td>������</td>
                  <td>${item.discount}</td>
               </tr>
               <tr>
                  <td>����</td>
                  <td>${item.color}</td>
               </tr>
               <tr>
                  <td>����</td>
                  <td>${item.total}</td>
               </tr>
               <tr>
                  <td>��ǰ����</td>
                  <td>${item.content}</td>
               </tr>
            </table>
         </div>
         <div style="float: left; width: 40%;">
            <table border="1">
               <tr>
                  <td colspan="2">����� ����</td>
               </tr>
                        <tr>
                           <td align="center">������</td>
                           <td align="center">����</td>
                        </tr>
                        <c:forEach items="${item.size}" var="s">
                        <tr>
                           <td align="center">${s.size}</td>
                           <td align="center">${s.quantity}��</td>
                        </tr>
                        </c:forEach>                     
            </table>
         </div>

         <div style="float: left; width: 100%; padding: 10px;">
            <hr>
            <table>
               <tr>
                  <td colspan="2">����</td>
               </tr>

                        <tr>
                           <td >������</td>
                           <td>Ÿ��(��� ���� 1,�ϴܻ��� 2)</td>
               
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
                     <input type="button" value="��ǰ���"
                     onclick="location.href='list.shop'"></td>
               </tr>
            </table>
         </div>
   </div>
</body>
</html>