<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<meta charset="EUC-KR">
<title>�ı� �ۼ�</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
</head>
<body>
<div class="xans-element- xans-board xans-board-writepackage-4 xans-board-writepackage xans-board-4 "><!--Ÿ��Ʋ, ������ġ-->
<div class="xans-element- xans-board xans-board-title-4 xans-board-title xans-board-4 allStore-board-menupackage "><div class="title">
            <a href="${path}/" class="w3-button w3-center w3-theme" style="width:3cm;">Ȩ</a><h2><font color="#555555">REVIEW</font></h2>
        </div>
</div>
<!--Ÿ��Ʋ, ������ġ-->
<form action="evalwrite.shop" method="post"
   enctype="multipart/form-data">
<input type="hidden" value="${param.itemno}" name="itemno"/>
<div class="xans-element- xans-board xans-board-write-4 xans-board-write xans-board-4">
<div class="ec-base-table typeWrite ">
	<table border="1" summary="" style="width:80%; margin-left:12%;" class="w3-table-all">
            <colgroup>
<col style="width:130px;">
<col style="width:auto;">
</colgroup>
<tbody>
<tr>
<th scope="row">����</th>
 <td> <input id="subject" name="title" fw-filter="isFill" fw-label="����" fw-msg="" class="inputTypeText" placeholder="" maxlength="125" type="text" style="width:80%;">  </td>
 </tr>
<tr class="displaynone">
<th scope="row">�ۼ���</th>
<td><input name="userid" value="${loginUser.userId}" readonly="readonly" style="width:80%;"/></td>
</tr>
<tr class="displaynone">
<th scope="row">����</th>
                    <td><input id="score0" name="score" fw-filter="" fw-label="����" fw-msg="" value="5" type="radio" checked="checked"><label for="score0"><span class="score5"><em>�ڡڡڡڡ�</em></span></label>
<input id="score1" name="score" fw-filter="" fw-label="����" fw-msg="" value="4" type="radio"><label for="score1"><span class="score4"><em>�ڡڡڡ�</em></span></label>
<input id="score2" name="score" fw-filter="" fw-label="����" fw-msg="" value="3" type="radio"><label for="score2"><span class="score3"><em>�ڡڡ�</em></span></label>
<input id="score3" name="score" fw-filter="" fw-label="����" fw-msg="" value="2" type="radio"><label for="score3"><span class="score2"><em>�ڡ�</em></span></label>
<input id="score4" name="score" fw-filter="" fw-label="����" fw-msg="" value="1" type="radio"><label for="score4"><span class="score1"><em>��</em></span></label></td>
</tr>

<tr class="displaynone">
<th scope="row">��ǰ ������</th>
                    <td><input id="satisfy0" name="satisfy" fw-filter="" fw-label="������" fw-msg="" value="5" type="radio" checked="checked"><label for="satisfy0"><span class="satisfy5"><em>���� �����ؿ�</em></span></label>
<input id="satisfy1" name="satisfy" fw-filter="" fw-label="����" fw-msg="" value="4" type="radio"><label for="satisfy1"><span class="satisfy4"><em>�����ؿ�</em></span></label>
<input id="satisfy2" name="satisfy" fw-filter="" fw-label="����" fw-msg="" value="3" type="radio"><label for="satisfy2"><span class="satisfy3"><em>�����̿���</em></span></label>
<input id="satisfy3" name="satisfy" fw-filter="" fw-label="����" fw-msg="" value="2" type="radio"><label for="satisfy3"><span class="satisfy2"><em>���ο���</em></span></label>
<input id="satisfy4" name="satisfy" fw-filter="" fw-label="����" fw-msg="" value="1" type="radio"><label for="satisfy4"><span class="satisfy1"><em>�ſ� ���ο���</em></span></label></td>
</tr>

<tr class="displaynone">
<th scope="row">����</th>
                    <td><input id="color0" name="color" fw-filter="" fw-label="����" fw-msg="" value="5" type="radio" checked="checked"><label for="point0"><span class="point5"><em>ȭ��� ���ƿ�</em></span></label>
<input id="point1" name="color" fw-filter="" fw-label="����" fw-msg="" value="4" type="radio"><label for="color1"><span class="point4"><em>ȭ�麸�� �ణ ��ƿ�</em></span></label>
<input id="point2" name="color" fw-filter="" fw-label="����" fw-msg="" value="3" type="radio"><label for="color2"><span class="point3"><em>ȭ�麸�� �ణ ��ο���</em></span></label>
<input id="point3" name="color" fw-filter="" fw-label="����" fw-msg="" value="2" type="radio"><label for="color3"><span class="point2"><em>ȭ�麸�� ���� ��ƿ�</em></span></label>
<input id="point4" name="color" fw-filter="" fw-label="����" fw-msg="" value="1" type="radio"><label for="color4"><span class="point1"><em>ȭ�麸�� ���� ��ο���</em></span></label></td>
</tr>

<tr class="displaynone">
<th scope="row">������</th>
                    <td><input id="size0" name="size" fw-filter="" fw-label="������" fw-msg="" value="5" type="radio" checked="checked"><label for="point0"><span class="point5"><em>�� �������</em></span></label>
<input id="size1" name="size" fw-filter="" fw-label="����" fw-msg="" value="4" type="radio"><label for="point1"><span class="point4"><em>5mm ���� ���� �� ���ƿ�</em></span></label>
<input id="size2" name="size" fw-filter="" fw-label="����" fw-msg="" value="3" type="radio"><label for="point2"><span class="point3"><em>5mm ���� ū �� ���ƿ�</em></span></label>
<input id="size3" name="size" fw-filter="" fw-label="����" fw-msg="" value="2" type="radio"><label for="point3"><span class="point2"><em>10mm ���� ���� �� ���ƿ�</em></span></label>
<input id="size4" name="size" fw-filter="" fw-label="����" fw-msg="" value="1" type="radio"><label for="point4"><span class="point1"><em>10mm ���� ū �� ���ƿ�</em></span></label></td>
</tr>
<tr>
<td colspan="2" class="clear">			
<div id="content_CONTAINER" class="nneditor-container" >	

<input type="text" name="content" style="width:100%; height:400px;"/>
</div>

       </td>
    </tr>
</tbody>
<tbody class="">
<tr>
<th scope="row">÷������1</th>
  <td><input name="picture" type="file"></td>
    </tr>
<tr>
</tbody>

</table>
</div>
<div class="ec-base-button ">
  <span class="gLeft">
  <a href="../board/list.shop" class="w3-button w3-theme">���</a>
 </span>
  <span class="gRight">
 <button type="submit" class="w3-button w3-theme">���</button>
<a href="javascript:history.back();" class="w3-button w3-theme">���</a>
            </span>
  </div>
</div>
</form></div>
</body>
</html>