<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ֹ� Ȯ�� ��ǰ</title>
<style type="text/css">
	table{width:90%; border-collapse:collapse}
	th,td{border:3px solid #bcbcbc; text-align:center; padding:8px}
	th{background-color:#4CAF50; color:white; text-align:center}
	td.title{background-color:#e2e2e2; color:purple}
</style>
</head>
<body>
<div align="center">
<h2>${loginUser.userName}���� �ֹ��Ͻ� ���� �Դϴ�.</h2>
<h2>����� ����</h2>
<table>
	<tr><td width="30%" class="title">������ ID</td>
	<td width="70%">${loginUser.userId}</td></tr>
	<tr><td width="30%" class="title">�޴»��</td>
	<td width="70%">${order.receiver}</td></tr>
	<tr><td width="30%" class="title">�ּ�</td>
	<td width="70%">${order.address}</td></tr>
	<tr><td width="30%" class="title">��ȭ��ȣ</td>
	<td width="70%">${order.phone}</td></tr>

</table><br><br>
<h2>�ֹ� �Ϸ� ��ǰ ���</h2>
<table>
<tr><td>
<table>
	<tr><td>��ǰ��/������</td><td>��ǰ����</td><td>����</td></tr>	
	<c:forEach items="${itemSetList}" var="orderItem">
		<tr><td>${orderItem.item.name}/${orderItem.size}</td><td><fmt:formatNumber value="${orderItem.item.price}" pattern="#,###" />��</td>
		<td>${orderItem.quantity}</td><c:set var="dis" value="${orderItem.item.discount + order.usepoint}"/></tr>		
	</c:forEach>
</table>
</td>
<td>
<table>
<tr><td>���αݾ�/��ۺ�</td></tr>
<tr><td><fmt:formatNumber value="${dis}" pattern="#,###" />��/2,500��</td></tr>
</table>
<tr><td colspan="4" style="text-align:right">�ѱݾ�:<fmt:formatNumber value="${order.amount}" pattern="#,###" />��</td></tr>
<tr><td colspan="4"><a href="../item/itemlist.shop">��ǰ���</a></td></tr>
</table>
</div>
</body>
</html>