<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��й�ȣ ����</title>
</head>
<body>
<form method="post" action="passChange.shop">
<input type="hidden" name="authKey" value="${authKey}">
<table>
	<tr><td>������ ��й�ȣ</td><td><input type="password" name="pass1"></td></tr>
	<tr><td>��й�ȣ Ȯ��</td><td><input type="password" name="pass2"></td>
		<td><input type="submit" value="Ȯ��"></td></tr>
</table>
</form>
</body>
</html>