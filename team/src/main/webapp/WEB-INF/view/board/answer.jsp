<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<head>
<meta charset="EUC-KR">
<title>��ǰ����</title>
<link rel="stylesheet" href="${path}/lightslider/css/abcmart.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
</head>
<body>
<div id="target3" class="pop_wrap" style="width: 700px; margin-left: 30%;">
<header class="pop_header">
<h2>��ǰ �亯 �ۼ�</h2>
</header>
<div class="pop_container qnaBox">
    <div class="pop_content detail_info_area">
        <header class="product_tit qna_tit clearfix">
            <div class="fl-l mr30 proImg">
              <c:forEach var="pic" items="${item.picturelist}">
             <c:if test="${pic.type==0}">
                <img src="../picture/${pic.pictureurl}" onerror="imageError(this)">
                </c:if>
            </c:forEach>
            </div>
            <div class="fl-l mt5">
                <span class="fs18 fc_type5 mb10">${item.brand}</span>
                <h2 class="tit_type1 fs22">${item.name}</h2>
                <p class="mt40">
                    <span>${item.price }<span>��</span></span>
                    
                </p>
            </div>
        </header>

<form action="answer.shop" method="post">
    <input type="hidden" name="num" value="${param.num}"/>
    <input type="hidden" name="itemno" value="${param.itemno}"/>
    <input type="hidden" name="userid" value="${loginUser.userId}"/>
            <div class="mt20 table_basic">
                <table>
                    <colgroup>
                        <col width="20%">
                        <col width="*">
                    </colgroup>
            
    <tbody>
              <tr>
              <th>��������</th>
          <c:choose>
		  <c:when test="${qa.qtype == 5}">
		    <td class="align-center"><font style="font-weight:bold;">������</font></td>
		    </c:when>
		    <c:when test="${qa.qtype==4}">
		    <td class="align-center"><font style="font-weight:bold;">�Ź߰�����</font></td>
		    </c:when>
		    <c:when test="${qa.qtype==3}">
		    <td class="align-center"><font style="font-weight:bold;">�԰���</font></td>
		    </c:when>
		    <c:when test="${qa.qtype==2}">
		    <td class="align-center"><font style="font-weight:bold;">����</font></td>
		    </c:when>
		    <c:when test="${qa.qtype==1}">
		    <td class="align-center"><font style="font-weight:bold;">��ǰ�˻�</font></td>
		    </c:when>
		</c:choose>
       </tr>
    <tr>
        <th>����</th>
             <td>
             <input type="text" class="text" id="title4" name="title" style="width:395px" maxlength="50" value="${qa.title}" readonly="readonly">
             <span class="fc_type4"></span>
             </td>
    </tr>	
    <tr>
     <th>����</th>
        <td><input type="text" name="answer" style="width:360.5px; height:108px;"/></td>
      </tr>
      </tbody>
    </table>
   </div>
        <button type="submit" class="btn_mType1">���</button>
        <button type="button" class="btn_mType3" data-dismiss="modal">�ݱ�</button>
 </form>
        
    </div>
</div></div>
</body>
</html>