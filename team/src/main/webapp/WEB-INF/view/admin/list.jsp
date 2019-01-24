<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 목록</title>
<script type="text/javascript">
	function allchkbox(chk){
		var chks = document.getElementsByName("idchks");
		for(var i=0; i<chks.length; i++){
			chks[i].checked = chk.checked;
		}
	}
</script>
</head>
<body>

<form action="mailForm.shop" method="post">
	<table border="1" style="border-collapse:collapse" width="100%">
		<tr><td colspan="7">회원목록</td></tr>
		<tr><td align="center">아이디</td><td align="center">이름</td><td align="center">전화번호</td>
		    <td align="center">생일</td><td align="center">이메일</td><td align="center">비고</td></tr>
			<c:forEach items="${userlist}" var="user">
				<tr><td>${user.userId}</td><td>${user.userName}</td><td>${user.phoneNo}</td>
					<td><fmt:formatDate value="${user.birthDay}" pattern="yyyy-MM-dd"/></td><td>${user.email}</td>
				<td><a href="../user/updateForm.shop?id=${user.userId}">[수정]</a>
				<a href="../user/delete.shop?id=${user.userId}">[강제탈퇴]</a>
				<a href="../user/mypage.shop?id=${user.userId}">[회원정보]</a></td></tr>
			</c:forEach>
			
	</table>
</form>

</body>
</html>