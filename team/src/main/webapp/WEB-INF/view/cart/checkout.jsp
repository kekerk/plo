<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="../abcmart/abcmart.css" />
<link rel="shortcut icon" href="https://image.abcmart.co.kr/nexti/images/abcmart_new/favicon.ico">
<title>Insert title here</title>
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
</script>
<script type="text/javascript">
$(document).on("change","input[name=selectAddr]",function(){
	var strValue=$('[name="selectAddr"]:checked').val();
	if(strValue == '1'){
        $('#name').val('${sessionScope.loginUser.userName}');
        $('#phoneNo').val('${sessionScope.loginUser.phoneNo}');
        $('#postcode').val('${sessionScope.loginUser.postcode}');
        $('#address').val('${sessionScope.loginUser.address}');
	} else {
		$('#name').val("");
	    $('#phoneNo').val(null);
	    $('#postcode').val(null);
	    $('#address').val(null);
	}
});
$(document).ready(function (){
	$("#applyPointBtn").click(function(){
		event.preventDefault();
		var point = $('#point').val();
		var totval = $('#totvalue').val();
		var lastval = totval - point;
		var lla = lastval.toLocaleString();
		if(point < 100){
			alert('100�� �̸��� ��� �Ұ��մϴ�.');
		} else if(point > '${sessionScope.loginUser.point}'){
			alert('����Ʈ�� �����մϴ�.');
			$('#point').val('');
		} else{
			$('#totvalue').val(lastval);
			$('#usePointSpan').html(point);
			$('#totval').html(lla);
			$("#point").prop("readonly",true);
			$('#applyPointBtn').remove();
		}

	});
});
function fillcheck(){
	if($('input[name=fill]').is(":checked") == false){
		alert('�ʼ������� Ȯ�� �� üũ���ּ���.');
		return false;
	} else{
		return true;
	}
}
</script>
</head>
<body>          
<div class="container_area">
    <div class="container_layout">
        <header class="add_header">
            <h2 class="sub_tit">�ֹ����ۼ�/����</h2>
        </header>
        <form name="orderForm" id="orderForm" method="post" action="end.shop" onsubmit="return fillcheck()">
        <c:forEach var="c" items="${check}">
        <input type="hidden" name="check" value="${c}">
        </c:forEach>
            <!-- order_basketCont -->
            <section class="order_basketCont order_sheet">
                <ul class="order_step">
                    <li class="step1"><em>01</em><p>��ٱ���</p></li>
                    <li class="step2 this"><em>02</em><p>�ֹ����ۼ�/����</p></li>
                    <li class="step3"><em>03</em><p>�����Ϸ�</p></li>
                    <li class="step4"></li>
                </ul>
                <!-- basket_box �Ϲݻ�ǰ-->
                <div class="basket_box mt40">
                    <div class="positR">
                        <h3 class="tit_type1 fs16 ml10">�ֹ� ����Ʈ</h3>
                        <p class="positA r10 b1 ico_notice">��ǰ���� �� �ɼǺ����� ��ǰ�� �Ǵ� ��ٱ��Ͽ��� �����մϴ�.<a href="" class="btn_sType1 ml5">�ֹ����� ����</a></p>
                    </div>
                    <div class="table_basic no_point mt10 gallery_line_type1">
                        <table>
							<colgroup>
								<col width="350">
								<col width="200">
								<col width="150">
								<col width="200">
								<col width="200">                                                            
							</colgroup>
							<thead>
								<tr> 
									<th>��ǰ��/�ɼ�</th>
									<th>�ǸŰ�</th>
									<th>����</th>
									<th>���αݾ�</th>
									<th>�ֹ��ݾ�<br>(�������� ����Ʈ)</th>					
								</tr>
							</thead>
							
							<tbody>			
								<c:forEach items="${sessionScope.CART.itemSetList}" var="itemSet" varStatus="stat">
								<c:forEach items="${check}" var="ck">
								<c:if test="${stat.index==ck}">
									<tr>
										<td class="align-left"><c:forEach items="${itemSet.item.picturelist}" var="pic">
										<c:if test="${pic.type == 0}">
										<img src="../picture/${pic.pictureurl}" width="80" height="80">
										</c:if>
										</c:forEach>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										${itemSet.item.name}/${itemSet.size}
										<input type="hidden" name="itemlist.itemno" value="${itemSet.item.itemno}">
										<input type="hidden" name="size" value="${itemSet.size}">
										<input type="hidden" name="itemlist.itemname" value="${itemSet.item.name}"></td>
										<td><fmt:formatNumber value="${itemSet.item.price}" pattern="#,###"/>
											<input type="hidden" name="itemlist.price" value="${itemSet.item.price}"></td>					
										<td>${itemSet.quantity}<input type="hidden" name="itemlist.quantity" value="${itemSet.quantity}"></td>
										<td><fmt:formatNumber value="${itemSet.item.discount}" pattern="#,###"/>
											<input type="hidden" name="itemlist.discount" value="${itemSet.item.discount}"></td>
										<c:set var="dis" value="${dis + (itemSet.item.discount * itemSet.quantity)}"/>
										<c:set var="tot" value="${tot + (itemSet.item.price * itemSet.quantity)}" />
										<c:set var="po" value="${po + (itemSet.item.price * itemSet.quantity) / 20}" />
										<td><fmt:formatNumber value="${itemSet.item.price * itemSet.quantity}" pattern="#,###"/>/<br>
										<fmt:formatNumber value="${(itemSet.item.price * itemSet.quantity) / 20}" pattern="#,###"/></td>
										<td></td>
									</tr>
								</c:if>
								</c:forEach> 
								</c:forEach> 							
							</tbody>
						</table>
                    </div>
                </div>
                <!-- // basket_box -->

                <!-- total_price -->
                <div class="total_price mt40">
                    <div class="totalBox total1">
                        <dl>
                            <dt>�ֹ��ݾ�</dt>
                            <dd><fmt:formatNumber value="${tot}" pattern="#,###" /><span>��</span></dd>
                        </dl>
                    </div>
                    <div class="totalBox total2">
                        <dl>
                            <dt>���αݾ�</dt>
                            <dd class="totalDscntArea"><fmt:formatNumber value="${dis}" pattern="#,###" /><span>��</span></dd>
                        </dl>
                        <ul class="list_type1" id="dscntInfoUl" style="display:none;">
                            
                        </ul>
                    </div>
                    <div class="totalBox total3">
                        <dl>
                            <dt>��ۺ�</dt>
                            <dd class="orderDlvyAmtArea">2,500<span>��</span></dd>
                        </dl>
                    </div>
                    <div class="totalBox total4">
                        <dl>
                            <dt>���������ݾ�</dt>
                            <dd class="fc_type1" id="totalAmtArea"><fmt:formatNumber value="${tot + 2500 - dis}" pattern="#,###" /><span>��</span></dd>
                        </dl>
                    </div>
                </div>
                <!-- //total_price -->
				
                <div class="mt60">
                    <h3 class="tit_type1 fs16 ml10">����� ����</h3>
                    <section id="dlvyInfoSection" class="table_basic mt10 bgfa">
                        <table>
                            <colgroup>
                                <col width="160px"><col width="*"><col width="160px"><col width="*">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>
                                        <label for="or_name2"><em class="fc_type1">��</em> �̸�</label>
                                    </th>
                                    <td colspan="3" align="left">
                                    	<input type="hidden" name="userid" value="${sessionScope.loginUser.userId}">
                                        <input type="text" name="receiver" class="rcvrInfo" maxlength="25" id="name" style="width:130px;" />
                                        <input type="radio" name="selectAddr" value="1" class="mr5 ml10"><label for="or_na1">�ֹ��ڿ� ����</label>
                                        <input type="radio" name="selectAddr" value="2" class="mr5 ml10"><label for="or_na2">�ű��Է�</label>         
                                    </td>
                                </tr>                              
                                <tr>
                                    <th>
                                        <label for="or_phone2"><em class="fc_type1">��</em> �޴��� ��ȣ</label>
                                    </th>
                                    <td colspan="3" align="left">
                                        <input type="text" name="phone" id="phoneNo" class="rcvrInfo" maxlength="15" style="width:130px"/>
                                    </td>
                                </tr>
                                <tr class="dlvyType dlvyType01" >
                                    <th>
                                        <label for="or_address2"><em class="fc_type1">��</em> �ּ�</label>
                                    </th>
                                    <td colspan="3" align="left">
                                        <p class="mb5">
                                            <input type="text" name="postcode" id="postcode" class="text rcvrInfo" style="width:130px" readonly="readonly"/>                                   
                                            <input type="button" onclick="Post_find()" value="�����ȣ ã��">
                                        </p>
                                        <input type="text" name="address" id="address" class="text rcvrInfo" style="width:300px" readonly="readonly" maxlength="100"/>
                                        <input type="text" name="detailAddress" id="detailAddress" class="text rcvrInfo" style="width:300px" placeholder="������ �ּҸ� �Է��ϼ���." maxlength="50"/>
                                    </td>
                                </tr>
                                <tr class="dlvyType dlvyType01" >
                                    <th>
                                        <label for="or_memo"><em class="fc_type1">&nbsp;</em>��� �� ��û����</label>
                                    </th>
                                    <td colspan="3" align="left">
                                        <input type="text" name="require" class="text rcvrInfo exceptSpecialChar" style="width:900px" placeholder="��� �޼����� 40�� �̳��� �Է��� �ּ���." maxlength="40"/>
                                    </td>
                                </tr>     
                            </tbody>
                        </table>
                    </section>
                </div>
                <div class="mt60 clearbox">
                    <div class="fl-l w550">
                        <div class="mt60">
                            <h3 class="tit_type1 fs16 ml10">����Ʈ ����</h3>
                            <section class="table_basic mt10 bgfa">
                                <table>
                                    <colgroup>
                                        <col width="160px"><col width="*">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th rowspan="2">
                                                <label for="or_coupon">&nbsp;&nbsp;����Ʈ ����</label>
                                            </th>
                                            <td>
                                                <p>��밡�� ����Ʈ : <span class="tit_type3 fc_type2">
                                                <fmt:formatNumber value="${sessionScope.loginUser.point}" pattern="#,###" /></span></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="text" name="usepoint" id="point" style="width:150px;" placeholder="100 ������ ��� ����" maxlength="10" /> ��
                                                <a id="applyPointBtn" href="" class="btn_sType1 ml10 mr5 non">����</a>    
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </section>           
                        </div>
                    </div>
                    <div class="fl-l w490 ml60">
                        <h3 class="tit_type1 fs16 ml10">�����ݾ�</h3>
                        <section class="table_basic mt10 bgfa or_price">
                            <table>
                                <colgroup>
                                    <col width="160px"><col width="*">
                                </colgroup>
                                <tbody>
                                    <tr class="order_pay">
                                        <th>
                                            <label for="or_price1">&nbsp;&nbsp;�ֹ��ݾ�</label>
                                        </th>
                                        <td>
                                            <span class="tit_type2"><fmt:formatNumber value="${tot}" pattern="#,###" /></span>��
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="or_price2">&nbsp;&nbsp;���αݾ�</label>
                                        </th>
                                        <td>
                                        	<input type="hidden" name="discount" value="${dis}">
                                            <span class="tit_type3 totalDscntArea"><fmt:formatNumber value="${dis}" pattern="#,###" /></span>��
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            <label for="or_price4">&nbsp;&nbsp;��ۺ�</label>
                                        </th>
                                        <td>
                                            <p class="or_bLine"><span class="tit_type3 orderDlvyAmtArea">2,500</span>��</p>
                                            <p>
                                                <em class="mr10 fc_type5" id="dlvyCouponUseInfo" style="display: none;">���������� ���</em><em class="right"><span class="tit_type3" id="applyDlvyCouponSpan">(-) 0</span>��</em>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="or_price4">&nbsp;&nbsp;�������� ����Ʈ</label>
                                        </th>
                                        <td>                                       
                                            <p><em class="right"><span class="tit_type3" id="applyDoublePointCouponSpan">(+)
                                            <fmt:formatNumber value="${po}" pattern="#,###" /></span>P</em></p>
                                            <fmt:parseNumber value="${po}" pattern="####.0" var="ipo"/>
                                            <input type="hidden" name="addpoint" value="${ipo}">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="or_price3">&nbsp;&nbsp;����Ʈ ����</label>
                                        </th>
                                        <td>
                                            <span id="usePointSpan" class="tit_type3">0</span>��
                                        </td>
                                    </tr>
                                    <tr class="total_pay">
                                        <th>
                                            <label for="or_price3">&nbsp;&nbsp;������ �ݾ�</label>
                                        </th>
                                        <td>
                                        	<input type="hidden" id="totvalue" name="amount" value="${tot - dis + 2500}">
                                            <span class="fs22" id="totval"><fmt:formatNumber value="${tot - dis + 2500}" pattern="#,###" /></span>��
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </section>
                    </div>
                </div>
                
                <div class="clear mt60" align="center">
                    <h3 class="tit_type1 fs16 ml10">�������� ����</h3>
                    <section class="table_basic mt10 bgfa">
                        <table>
                            <colgroup>
                                <col width="580px"><col width="*">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <td colspan="2" align="center">
									<input type="radio" name="paytype" value="1" class="mr5 ml15" id="pymntMeansCode01"/><label for="pymntMeansCode01">�ſ�ī��&nbsp;</label>
									<input type="radio" name="paytype" value="2" class="mr5 ml15" id="pymntMeansCode02"/><label for="pymntMeansCode02">������ü&nbsp;</label>
									<input type="radio" name="paytype" value="3" class="mr5 ml15" id="pymntMeansCode03"/><label for="pymntMeansCode03">�޴���&nbsp;</label>
									<input type="radio" name="paytype" value="4" class="mr5 ml15" id="pymntMeansCode04"/><label for="pymntMeansCode04">������&nbsp;</label>
									<input type="radio" name="paytype" value="5" class="mr5 ml15" id="pymntMeansCode07"/><label for="pymntMeansCode07">���̹�����&nbsp;</label>
									</td>
								</tr>
                            </tbody>
                        </table>
                    </section>
                </div>
                <p class="mt5 ml5" align="center">
                    <input type="checkbox" name="fill" id="cbOrderClause"/>
                    <label for="cbOrderClause" class="fc_type5"><span class="fc_type6">[�ʼ�]</span> �ֹ��ϴ� ��ǰ, ����, �������, ���γ��� ���� ���� Ȯ�� �Ͽ�����, ���ſ� �����մϴ�. (���ڻ�ŷ��� �� 8�� ��2��)</label>
                </p>
                <section class="btn_group_section">
                    <ul>
                        <li><input type="submit" class="btn_lType1" value="�����ϱ�"></li>
                    </ul>
                </section>
            </section>
        </form>
    </div> 
</div>        
</body>
</html>