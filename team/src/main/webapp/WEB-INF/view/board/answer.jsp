<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<head>
<meta charset="EUC-KR">
<title>상품문의</title>
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
<h2>상품 답변 작성</h2>
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
                    <span>${item.price }<span>원</span></span>
                    
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
              <th>문의유형</th>
          <c:choose>
		  <c:when test="${qa.qtype == 5}">
		    <td class="align-center"><font style="font-weight:bold;">사이즈</font></td>
		    </c:when>
		    <c:when test="${qa.qtype==4}">
		    <td class="align-center"><font style="font-weight:bold;">신발관리법</font></td>
		    </c:when>
		    <c:when test="${qa.qtype==3}">
		    <td class="align-center"><font style="font-weight:bold;">입고문의</font></td>
		    </c:when>
		    <c:when test="${qa.qtype==2}">
		    <td class="align-center"><font style="font-weight:bold;">가격</font></td>
		    </c:when>
		    <c:when test="${qa.qtype==1}">
		    <td class="align-center"><font style="font-weight:bold;">상품검색</font></td>
		    </c:when>
		</c:choose>
       </tr>
    <tr>
        <th>제목</th>
             <td>
             <input type="text" class="text" id="title4" name="title" style="width:395px" maxlength="50" value="${qa.title}" readonly="readonly">
             <span class="fc_type4"></span>
             </td>
    </tr>	
    <tr>
     <th>내용</th>
        <td><input type="text" name="answer" style="width:360.5px; height:108px;"/></td>
      </tr>
      </tbody>
    </table>
   </div>
        <button type="submit" class="btn_mType1">등록</button>
        <button type="button" class="btn_mType3" data-dismiss="modal">닫기</button>
 </form>
        
    </div>
</div></div>
</body>
</html>