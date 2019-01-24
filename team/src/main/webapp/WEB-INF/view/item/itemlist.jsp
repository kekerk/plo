<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="../abcmart/sub.css" />
<link rel="stylesheet" href="../abcmart/slick.css" />
<link rel="stylesheet" href="../abcmart/slick-theme.css" />
<title>상품목록</title>
<link rel="shortcut icon" href="http://image.abcmart.co.kr/nexti/images/abcmart_new/favicon.ico">
<script type="text/javascript">
function list(pageNum) {
    var searchType = document.searchform.searchType.value;
    if(searchType ==null||searchType.length == 0){
       document.searchform.searchContent.value="";
       document.searchform.pageNum.value ="1";
       location.href="itemlist.shop?pageNum="+pageNum+"&searchPriceStart="+document.searchform.searchPriceStart.value+"&searchPriceEnd="+document.searchform.searchPriceEnd.value;
    }else{
       document.searchform.pageNum.value=pageNum;
       document.searchform.submit();
       return true;
    }
    return false;
 } 
</script>
<style type="text/css">
  .my-hr1 {
    border: 0;
    height: 1px;
    background: #ccc;
  }
  .my-hr3 {
    border: 0;
    height: 3px;
    background: #ccc;
  }

</style>
</head>
<body>
<div class="category_smart_search">
                  <form action="../board/list.shop" method="post" name="searchform" onsubmit="return list(1)">
                    <input type="hidden" name="pageNum" value="1">
                    <input type="hidden" name="cate" value="${param.cate}">
                    <input type="hidden" name="subcate" value="${param.subcate}">
                    <div class="smart_search_area">
                        <section class="smart_section">
                         <select name="searchType" id="searchType" >
                          <option value="">선택해주세요</option>
                          <option value="name">제품명</option>
                          <option value="brand">브랜드</option>
                    </select>&nbsp;
        <script type="text/javascript">
           if('${param.searchType}'!=''){
              document.getElementById("searchType").value ='${param.searchType}';
           }
        </script>
        <input type="text" name="searchContent" value="${param.searchContent}">
        <hr class="my-hr1">
                            <div class="grid-box">
                                <section class="grid-2">
                                    <h3>Price</h3>
                                    <div class="brand_check_box fl-l">
                                        <input type="text" name="searchPriceStart" value="${param.searchPriceStart}" style="width:110px;" maxlength="7" class="inputNumberText"/> 원 ~ <input type="text" name="searchPriceEnd" value="${param.searchPriceEnd}" style="width:110px;" maxlength="7" class="inputNumberText"/> 원
                                         <script type="text/javascript">
                                      if('${param.searchPriceStart}'!=''){
                                         document.getElementById("searchPriceStart").value ='${param.searchPriceStart}';
                                         document.getElementById("searchPriceEnd").value ='${param.searchPriceEnd}';
                                      }
                                      if('${param.searchPriceEnd}'!=''){
                                       document.getElementById("searchPriceStart").value ='${param.searchPriceStart}';
                                       document.getElementById("searchPriceEnd").value ='${param.searchPriceEnd}';
                                    }
      </script>
        </script>
                                    </div>
                                </section>                          
                            </div>
                        </section>
                  <input type="submit" value="검색">
                    </div>          
                </form>
            </div>
<hr class="my-hr3">
           <div class="tabs-content">
            <div id="gallery_tabs_01" class="tabs-cont">
                  <ul class="gallery_basic gallery_box_type1 w150">
            <c:forEach items="${itemlist}" var="item" varStatus="a">
            <li>
               <div class="model_img_box" mode="1">
                  <c:forEach items="${item.picturelist}" var="p">
                  <c:if test="${p.type==0}">
                  <img src="../picture/${p.pictureurl}"
                     alt="W6076BP" onerror="imageError(this)"></c:if>            
                  </c:forEach>
                   <a href="${path}/board/detail.shop?itemno=${item.itemno}"
                     class="over_link" style="display: none;"></a>
               
               </div> <a href="${path}/board/detail.shop?itemno=${item.itemno}"
               class="model_box "> <span class="brand">${item.brand}</span>
               <span class="name">${item.name}</span>
                  <c:if test="${item.discount==0}">
                  <span class="price">
                       <fmt:formatNumber value="${item.price}" pattern="#,###"/>  
                     </span>
                  </c:if>
                  <c:if test="${item.discount!=0}">
                  <span class="price">
                       <fmt:formatNumber type="CURRENCY" value="${item.price-(item.price/item.discount)}" pattern="#,###"/>                        
                        <em class="formal">
                        <fmt:formatNumber value="${item.price}" pattern="#,###"/>  
                        </em>
                    
                     </span>
                  </c:if>

            </a>         
            </li>  
            <c:if test="${a.index != 0 and (a.index+1)%5==0}"></ul>  <hr class="my-hr1"><ul class="gallery_basic gallery_box_type1 w150"></c:if>            
             </c:forEach>
                 </ul>
            </div>
                  <p class="paginate">
            <c:if test="${pageNum>1 }"><a href="javascript:itemlist(${pageNum -1})"><i class="fa fa-chevron-left fa-2x"></i></a></c:if> 
               <c:if test="${pageNum<=1 }"><i class="fa fa-chevron-left fa-2x"></i></c:if>
               <c:forEach var="a" begin="${startpage}" end="${endpage}">
               <c:if test="${a==pageNum}" ><button class="w3-button w3-white w3-border">${a}</button></c:if>
               <c:if test="${a!=pageNum}"><a href="javascript:itemlist(${a})" class="w3-button w3-white w3-border">${a}</a></c:if>
         </c:forEach>
            <c:if test="${pageNum<maxpage}"><a href="javascript:itemlist(${pageNum +1})"><i class="fa fa-chevron-right fa-2x"></i></a></c:if> 
            <c:if test="${pageNum>=maxpage}"><i class="fa fa-chevron-right fa-2x"></i></c:if>
      </p>
        </div>
</body>
</html>