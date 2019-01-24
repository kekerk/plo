<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>MyPage</title>
<style type="text/css">
	table{width:90%; border-collapse:collapse}
	td{border:1px solid #bcbcbc; text-align:center; padding:8px}
	.snip1535 {
  background-color: #aaaaaa;
  border: none;
  color: #ffffff;
  cursor: pointer;
  display: inline-block;
  font-family: 'BenchNine', Arial, sans-serif;
  font-size: 1em;
  font-size: 22px;
  line-height: 1em;
  margin: 15px 40px;
  outline: none;
  padding: 12px 40px 10px;
  position: relative;
  text-transform: uppercase;
  font-weight: 700;
}
.snip1535:before,
.snip1535:after {
  border-color: transparent;
  -webkit-transition: all 0.25s;
  transition: all 0.25s;
  border-style: solid;
  border-width: 0;
  content: "";
  height: 24px;
  position: absolute;
  width: 24px;
}
.snip1535:before {
  border-color: #aaaaaa;
  border-right-width: 2px;
  border-top-width: 2px;
  right: -5px;
  top: -5px;
}
.snip1535:after {
  border-bottom-width: 2px;
  border-color: #aaaaaa;
  border-left-width: 2px;
  bottom: -5px;
  left: -5px;
}
.snip1535:hover,
.snip1535.hover {
  background-color: #aaaaaa;
}
.snip1535:hover:before,
.snip1535.hover:before,
.snip1535:hover:after,
.snip1535.hover:after {
  height: 100%;
  width: 100%;
}	
</style>
<link rel="stylesheet" href="../abcmart/abcmart.css" />
<script type="text/javascript">
	window.onload = function(){
		document.getElementById("minfo").style.display = 'block';
		document.getElementById("oinfo").style.display = 'none';
	}
	function disp_div(id){
		document.getElementById("minfo").style.display = 'none';
		document.getElementById("oinfo").style.display = 'none';
		document.getElementById(id).style.display = "block";
	}
	function list_disp(id){
		var disp = document.getElementById(id);
		if(disp.style.display == 'block'){
			disp.style.display = 'none';
		} else {
			disp.style.display = "block";
		}
	}
	$(".hover").mouseleave(
			  function() {
			    $(this).removeClass("hover");
			  }
			);
</script>

</head>
<body>
<div class="container_wrap">          
    <div class="container_area">
        <div class="container_layout">
            <header class="add_header">
                <h2 class="sub_tit">Mypage</h2>
            </header>
            <section class="order_basketCont mem_basket">
<table>
	<tr><th><a href="javascript:disp_div('minfo')" class="snip1535" style="width: 90%">ȸ����������</a></th>
		<th><a href="javascript:disp_div('oinfo')" class="snip1535" style="width: 90%">�ֹ���������</a></th>
	</tr>
</table>                          
<div class="table_basic no_point mt10 gallery_line_type1">
	<div id="oinfo">
    <table>
    
		<colgroup>
			<col width="100">
			<col width="410">
			<col width="250">
			<col width="340">                            
		</colgroup>
	<thead>
	<tr>
		<th>�ֹ���ȣ</th>
		<th>�ֹ�����</th>
		<th>���αݾ�/��ۺ�</th>
		<th>���ֹ��ݾ�</th>
	</tr>
	<c:forEach items="${orderlist}" var="order" varStatus="stat">
		<tr><td align="center">
			<a href="javascript:list_disp('saleLine${stat.index}')" class="w3-button w3-white w3-border w3-border-red w3-round-large">${order.no}</a></td>
			<td align="center"><fmt:formatDate value="${order.orderdate}" pattern="yyyy-MM-dd"/></td>
			<td align="center"><c:if test="${order.usepoint == null}">0</c:if>
			-<fmt:formatNumber value="${order.usepoint}" pattern="#,###"/>��/+2,500��</td>
			<td align="right"><fmt:formatNumber value="${order.amount}" pattern="#,###"/>��</td></tr>
		<tr><td colspan="3" align="center">
			<div id="saleLine${stat.index}" style="display:none">
			<form action="../user/back.shop" method="get">
				<table>
					<tr><th width="25%">��ǰ��/������</th><th width="25%">��ǰ����</th>
						<th width="25%">���ż���</th><th width="25%">��ǰ�Ѿ�</th>
						<th width="25%">���</th></tr>
					<c:forEach items="${order.itemList}" var="orderItem">
						<input type="hidden" name="no" value="${orderItem.no}">
						<input type="hidden" name="itemname" value="${orderItem.item.name}">
						<input type="hidden" name="quantity" value="${orderItem.quantity}">
						<input type="hidden" name="itemsize" value="${orderItem.itemsize}">
						<tr><td align="center" class="title">${orderItem.item.name}/${orderItem.itemsize}</td>
							<td align="right"><fmt:formatNumber value="${orderItem.item.price}" pattern="#,###"/>��</td>
							<td align="right">${orderItem.quantity}</td>
							<td align="right"><fmt:formatNumber value="${orderItem.quantity * orderItem.item.price}" pattern="#,###"/>��</td>
							<td align="right"><input type="submit" value="��ǰ">&nbsp;<input type="submit" value="����"></tr>
					</c:forEach>
				</table>
			</form></div></td>	
		</tr>
		</c:forEach>
	</thead>
	</table>
</div>
</div>
<div id="minfo">
	<table>
		<tr><td colspan="2">ȸ������</td></tr>
		<tr><td>���̵�</td><td>${user.userId}</td></tr>
		<tr><td>�̸�</td><td>${user.userName}</td></tr>
		<tr><td>�����ȣ</td><td>${user.postcode}</td></tr>
		<tr><td>��ȭ��ȣ</td><td>${user.phoneNo}</td></tr>
		<tr><td>�ּ�</td><td>${user.address}</td></tr>
		<tr><td>�̸���</td><td>${user.email}</td></tr>
		<tr><td>�������</td><td><fmt:formatDate value="${user.birthDay}" pattern="yyyy-MM-dd" /></td></tr>
	</table>
</div><br>
<a href="updateForm.shop?id=${user.userId}">[ȸ����������]</a>&nbsp;
<c:if test="${loginUser.userId != 'admin'}">
	<a href="delete.shop?id=${user.userId}">[ȸ��Ż��]</a>&nbsp;
</c:if>
<c:if test="${loginUser.userId == 'admin'}">
	<a href="../admin/list.shop">[ȸ�����]</a>&nbsp;
</c:if>
<a href="logout.shop?id=${user.userId}">[�α׾ƿ�]</a>&nbsp;
</section>
</div>
</div>
</div>
</body>
</html>