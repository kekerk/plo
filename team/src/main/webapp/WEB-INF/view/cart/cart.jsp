<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>장바구니</title>
<link rel="stylesheet" href="../abcmart/abcmart.css" />
<script type="text/javascript">
function upDownCount(obj){
    var prdtCount = $(obj).parent().find("input[name='prdtCount']").val();
    if(isNaN(prdtCount) || !prdtCount) {
        prdtCount = 0; 
    }
    
    // UP & DOWN
    if($(obj).val() == "+"){
        $(obj).parent().find("input[name='prdtCount']").val(eval(prdtCount)+1);
    }else if($(obj).val() == "-"){
        if(prdtCount > 1) {
            $(obj).parent().find("input[name='prdtCount']").val(prdtCount-1);
        }
    }
}
function updateCount(obj){
    var prdtCount = $(obj).parent().find("input[name='prdtCount']").val();
    var itemno = $(obj).parent().parent().parent().parent().find("input[name='itemno']").val();
    var size = $(obj).parent().parent().parent().parent().find("input[name='size']").val();
    
    if(!prdtCount || !itemno){
        alert("수량을 입력하세요.");
        return;
    }
    
    $.ajax({
        type: "POST"
        ,url: "cartupdate.shop"
        ,data: {itemno : itemno, quantity : prdtCount, size : size}
        ,success : function(data) {
            console.log(data)
            window.location.reload();
        }
        ,error: function(data) {
            alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
        }
    });
}
function allCheck(){
    if($("#allChecked").is(":checked")){
        $("input[name=check]").prop("checked",true);
    }else{
        $("input[name=check]").prop("checked",false);
    }
}
$(document).ready(function(){
	$("input[name=check]").on('click', function() {
		if ( $(this).prop('checked') ) {
			$(this).parent().addClass("selected");
		} else { 
			$(this).parent().removeClass("selected"); 
		}
	})
})
</script>
</head>
<body>
 <div class="container_wrap">          
    <div class="container_area">
        <div class="container_layout">
            <header class="add_header">
                <h2 class="sub_tit">장바구니</h2>
            </header>
            <form name="cartProductForm" id="cartProductForm" action="checkout.shop" method="post">
                <input type="hidden" name="firstYn" value="false"/>
                <section class="order_basketCont mem_basket">
                    <ul class="order_step">
                        <li class="step1 this"><em>01</em><p>장바구니</p></li>
                        <li class="step2"><em>02</em><p>주문서작성/결제</p></li>
                        <li class="step3"><em>03</em><p>결제완료</p></li>
                        <li class="step4"></li>
                    </ul>                                                   
                        <div class="basket_box mt40">
                            <p class="ico_notice">장바구니에 담긴 상품은 저장되지 않습니다.</p>
                            <div class="table_basic no_point mt10 gallery_line_type1">
                                <table>
									<colgroup>
										<col width="30">
										<col width="300">
										<col width="150">
										<col width="140">
										<col width="140">
										<col width="140">                                      
										<col width="*">
									</colgroup>
									<thead>
										<tr>
											<th><input type="checkbox" title="장바구니 목록 전체 선택" id="allChecked" name="allChecked" onclick="allCheck(this);"/></th>
											<th>상품명/옵션</th>
											<th>판매가</th>
											<th>수량</th>
											<th>할인금액</th>
											<th>주문금액/<br>적립예정 포인트</th>                                           
											<th>선택</th>
										</tr>
									</thead>
										<c:forEach items="${cart.itemSetList}" var="itemSet" varStatus="stat" >
										<tr><td><input type="checkbox" name="check" value="${stat.index}"/></td>
												<td class="align-left"><a href="../item/detail.shop?itemno=${itemSet.item.itemno}">
												<c:forEach items="${itemSet.item.picturelist}" var="pic">
												<c:if test="${pic.type == 0}">
												<img src="../picture/${pic.pictureurl}" width="80" height="80">
												</c:if>
												</c:forEach>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												${itemSet.item.name}/${itemSet.size}</a>
												<input type="hidden" name="itemno" value="${itemSet.item.itemno}">
												<input type="hidden" name="size" value="${itemSet.size}">
												</td>
												<td><fmt:formatNumber value="${itemSet.item.price}" pattern="#,###"/></td>
												<td class="check_list_box">
													<div class="incrementer" align="center">
														<div class="count_box">
															<input type="text" name='prdtCount' value="${itemSet.quantity}" class='qty' readonly='readonly'/>
															<input type='button' onclick="upDownCount(this);" value='+' class='qtyplus'/>
															<input type='button' onclick="upDownCount(this);" value='-' class='qtyminus'/>
															<button class="btn_sType5" onclick="updateCount(this);">변경</button>
														</div>
													</div>
												</td>
												<c:set var="dis" value="${dis + (itemSet.item.discount * itemSet.quantity)}" />
												<td><fmt:formatNumber value="${dis}" pattern="#,###"/></td>
												<c:set var="tot" value="${tot + (itemSet.item.price * itemSet.quantity)}" />
												<td><fmt:formatNumber value="${itemSet.item.price * itemSet.quantity}" pattern="#,###"/>/<br>
												<fmt:formatNumber value="${(itemSet.item.price * itemSet.quantity) / 20}" pattern="#,###"/></td>
												<td>
													<p><a href="checkout.shop?check=${stat.index}" class="btn_sType4 fs11">바로구매</a></p>                  
													<p><a href="cartDelete.shop?index=${stat.index}" class="btn_sType1 fs11">삭제</a></p>
													<c:set var="index" value="${stat.index}"/>
												</td>
										</tr>
										</c:forEach> 
								</table>
                            </div>
                        </div>
                        
                        
                        <div class="total_price mt40">
                            <div class="totalBox total1">
                                <dl>
                                    <dt>주문금액</dt>
                                    <dd id="totalPrdtAmtArea">
                                        <fmt:formatNumber value="${tot}" pattern="#,###"/>
                                        <span>원</span>
                                    </dd>
                                </dl>
                            </div>
                            <div class="totalBox total2">
                                <dl>
                                    <dt>총 할인금액</dt>
                                    <dd id="totalDscntAmtArea"><fmt:formatNumber value="${dis}" pattern="#,###"/><span>원</span></dd>
                                </dl>
                                <ul class="list_type1">
                                    <li><span class="fl-l">행사할인</span><span class="fl-r" id="totalDscntAmtSpan">0<em>원</em></span></li>
                                </ul>
                            </div>
                            <div class="totalBox total3">
                                <dl>
                                    <dt>배송비</dt>
                                    <dd id="orderDlvyAmtArea">
                                        2,500
                                        <span>원</span>
                                    </dd>
                                </dl>
                            </div>
                            <div class="totalBox total4">
                                <dl>
                                    <dt>결제예정금액</dt>
                                    <dd class="fc_type1" id="totalAmtArea">
                                        <fmt:formatNumber value="${tot + 2500 - dis}" pattern="#,###"/>
                                        <span>원</span>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                        <section class="btn_group_section">
                    <ul>
                        <li><input type="submit" class="btn_lType1" value="선택상품 구매"></li>
                    </ul>
                </section>
                        </section>
                        </form>
                  </div>
             </div>
       	</div>
</body>
</html>