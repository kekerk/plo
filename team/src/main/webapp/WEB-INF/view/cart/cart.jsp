<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ٱ���</title>
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
        alert("������ �Է��ϼ���.");
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
            alert('�ý��� ������ �߻� �߽��ϴ�. �����ڿ��� �����ϼ���.');
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
                <h2 class="sub_tit">��ٱ���</h2>
            </header>
            <form name="cartProductForm" id="cartProductForm" action="checkout.shop" method="post">
                <input type="hidden" name="firstYn" value="false"/>
                <section class="order_basketCont mem_basket">
                    <ul class="order_step">
                        <li class="step1 this"><em>01</em><p>��ٱ���</p></li>
                        <li class="step2"><em>02</em><p>�ֹ����ۼ�/����</p></li>
                        <li class="step3"><em>03</em><p>�����Ϸ�</p></li>
                        <li class="step4"></li>
                    </ul>                                                   
                        <div class="basket_box mt40">
                            <p class="ico_notice">��ٱ��Ͽ� ��� ��ǰ�� ������� �ʽ��ϴ�.</p>
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
											<th><input type="checkbox" title="��ٱ��� ��� ��ü ����" id="allChecked" name="allChecked" onclick="allCheck(this);"/></th>
											<th>��ǰ��/�ɼ�</th>
											<th>�ǸŰ�</th>
											<th>����</th>
											<th>���αݾ�</th>
											<th>�ֹ��ݾ�/<br>�������� ����Ʈ</th>                                           
											<th>����</th>
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
															<button class="btn_sType5" onclick="updateCount(this);">����</button>
														</div>
													</div>
												</td>
												<c:set var="dis" value="${dis + (itemSet.item.discount * itemSet.quantity)}" />
												<td><fmt:formatNumber value="${dis}" pattern="#,###"/></td>
												<c:set var="tot" value="${tot + (itemSet.item.price * itemSet.quantity)}" />
												<td><fmt:formatNumber value="${itemSet.item.price * itemSet.quantity}" pattern="#,###"/>/<br>
												<fmt:formatNumber value="${(itemSet.item.price * itemSet.quantity) / 20}" pattern="#,###"/></td>
												<td>
													<p><a href="checkout.shop?check=${stat.index}" class="btn_sType4 fs11">�ٷα���</a></p>                  
													<p><a href="cartDelete.shop?index=${stat.index}" class="btn_sType1 fs11">����</a></p>
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
                                    <dt>�ֹ��ݾ�</dt>
                                    <dd id="totalPrdtAmtArea">
                                        <fmt:formatNumber value="${tot}" pattern="#,###"/>
                                        <span>��</span>
                                    </dd>
                                </dl>
                            </div>
                            <div class="totalBox total2">
                                <dl>
                                    <dt>�� ���αݾ�</dt>
                                    <dd id="totalDscntAmtArea"><fmt:formatNumber value="${dis}" pattern="#,###"/><span>��</span></dd>
                                </dl>
                                <ul class="list_type1">
                                    <li><span class="fl-l">�������</span><span class="fl-r" id="totalDscntAmtSpan">0<em>��</em></span></li>
                                </ul>
                            </div>
                            <div class="totalBox total3">
                                <dl>
                                    <dt>��ۺ�</dt>
                                    <dd id="orderDlvyAmtArea">
                                        2,500
                                        <span>��</span>
                                    </dd>
                                </dl>
                            </div>
                            <div class="totalBox total4">
                                <dl>
                                    <dt>���������ݾ�</dt>
                                    <dd class="fc_type1" id="totalAmtArea">
                                        <fmt:formatNumber value="${tot + 2500 - dis}" pattern="#,###"/>
                                        <span>��</span>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                        <section class="btn_group_section">
                    <ul>
                        <li><input type="submit" class="btn_lType1" value="���û�ǰ ����"></li>
                    </ul>
                </section>
                        </section>
                        </form>
                  </div>
             </div>
       	</div>
</body>
</html>