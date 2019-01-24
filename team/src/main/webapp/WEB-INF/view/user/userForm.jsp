<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사용자 등록</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function Post_find() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
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
<h2>사용자 등록</h2>
<div align="center">
<!-- modelAttribute="user" : 현재 페이지가 호출될 때 user 객체가 있어야 한다. -->
<form:form modelAttribute="user" method="post" action="userEntry.shop">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table border="1" style="border-collapse: collapse">
		<tr height="40px"><td>아이디</td><td align="left"><form:input path="userId"/>&nbsp;<font color="red"><form:errors path="userId" /></font></td></tr>
		<tr height="40px"><td>비밀번호</td><td align="left"><form:password path="password"/>&nbsp;<font color="red"><form:errors path="password" /></font></td></tr>
		<tr height="40px"><td>이름</td><td align="left"><form:input path="userName"/>&nbsp;<font color="red"><form:errors path="userName" /></font></td></tr>
		<tr height="40px"><td>전화번호</td><td align="left"><form:input path="phoneNo"/>&nbsp;<font color="red"><form:errors path="phoneNo" /></font></td></tr>
		<tr height="40px"><td>우편번호</td><td align="left">
		<input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly="readonly">
		<input type="button" onclick="Post_find()" value="우편번호 찾기"><br>
		<input type="text" id="address" name="address" placeholder="주소" readonly="readonly">
		<input type="text" id="detailAddress" name="address1"placeholder="상세주소"></tr>
		<tr height="40px"><td>이메일</td><td align="left"><form:input path="email"/>@
		<input type="text" name="email2" id="ov">
		<select id="so" onChange="setValues()">
		<option value="">직접입력</option>
		<option value="naver.com">naver.com</option>
		<option value="daum.net">daum.net</option>
		<option value="nate.com">nate.com</option>
		<option value="yahoo.co.kr">yahoo.co.kr</option>
		<option value="paran.com">paran.com</option>
		<option value="empas.com">empas.com</option>
		<option value="gmail.com">gmail.com</option>
		<option value="hanmir.com">hanmir.com</option>
		</select>
		<tr height="40px"><td>생년월일</td><td align="left"><form:input path="birthDay"/>&nbsp;<font color="red"><form:errors path="birthDay" /></font></td></tr>
		<tr height="40px"><td>성별</td><td><input type="radio" name="gender" value="1" checked="checked">남&nbsp;&nbsp;&nbsp;
		<input type="radio" name="gender" value="2">여</td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="등록">&nbsp;<input type="reset" value="초기화"></td></tr>
	</table>
</form:form>
</div>
</body>
</html>