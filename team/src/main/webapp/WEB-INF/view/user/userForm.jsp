<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����� ���</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function Post_find() {
        new daum.Postcode({
            oncomplete: function(data) {
                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

                // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
                var addr = ''; // �ּ� ����

                //����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
                    addr = data.roadAddress;
                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
                    addr = data.jibunAddress;
                }
                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
    function setValues(){
    	var so = document.getElementById("so");
    	var ov = document.getElementById("ov");
    	ov.value = so.options[so.selectedIndex].value;
    }
</script>
</head>
<body>
<h2>����� ���</h2>
<div align="center">
<!-- modelAttribute="user" : ���� �������� ȣ��� �� user ��ü�� �־�� �Ѵ�. -->
<form:form modelAttribute="user" method="post" action="userEntry.shop">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table border="1" style="border-collapse: collapse">
		<tr height="40px"><td>���̵�</td><td align="left"><form:input path="userId"/>&nbsp;<font color="red"><form:errors path="userId" /></font></td></tr>
		<tr height="40px"><td>��й�ȣ</td><td align="left"><form:password path="password"/>&nbsp;<font color="red"><form:errors path="password" /></font></td></tr>
		<tr height="40px"><td>�̸�</td><td align="left"><form:input path="userName"/>&nbsp;<font color="red"><form:errors path="userName" /></font></td></tr>
		<tr height="40px"><td>��ȭ��ȣ</td><td align="left"><form:input path="phoneNo"/>&nbsp;<font color="red"><form:errors path="phoneNo" /></font></td></tr>
		<tr height="40px"><td>�����ȣ</td><td align="left">
		<input type="text" id="postcode" name="postcode" placeholder="�����ȣ" readonly="readonly">
		<input type="button" onclick="Post_find()" value="�����ȣ ã��"><br>
		<input type="text" id="address" name="address" placeholder="�ּ�" readonly="readonly">
		<input type="text" id="detailAddress" name="address1"placeholder="���ּ�"></tr>
		<tr height="40px"><td>�̸���</td><td align="left"><form:input path="email"/>@
		<input type="text" name="email2" id="ov">
		<select id="so" onChange="setValues()">
		<option value="">�����Է�</option>
		<option value="naver.com">naver.com</option>
		<option value="daum.net">daum.net</option>
		<option value="nate.com">nate.com</option>
		<option value="yahoo.co.kr">yahoo.co.kr</option>
		<option value="paran.com">paran.com</option>
		<option value="empas.com">empas.com</option>
		<option value="gmail.com">gmail.com</option>
		<option value="hanmir.com">hanmir.com</option>
		</select>
		<tr height="40px"><td>�������</td><td align="left"><form:input path="birthDay"/>&nbsp;<font color="red"><form:errors path="birthDay" /></font></td></tr>
		<tr height="40px"><td>����</td><td><input type="radio" name="gender" value="1" checked="checked">��&nbsp;&nbsp;&nbsp;
		<input type="radio" name="gender" value="2">��</td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="���">&nbsp;<input type="reset" value="�ʱ�ȭ"></td></tr>
	</table>
</form:form>
</div>
</body>
</html>