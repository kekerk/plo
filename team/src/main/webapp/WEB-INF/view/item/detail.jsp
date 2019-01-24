<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� �� ����</title>
<link rel="stylesheet" href="../abcmart/abcmart.css" />
<link rel="stylesheet" href="${path}/lightslider/css/lightslider.css" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<style>
ul {
	list-style: none outside none;
	padding-left: 0;
	margin: auto;
}

.demo .item {
	margin-bottom: 60px;
}

.content-slider li {
	text-align: center;
	color: #FFF;
}

.content-slider h3 {
	margin: 30px;
	padding: 70px 0;
}

.demo {
	width: 500px;
}

.demo img {
	width: 400px;
}
</style>
<script src="${path}/lightslider/js/lightslider.js"></script>
<script>
$(document).ready(function() {
	$("#content-slider").lightSlider({
        loop:true,
      	auto:true,
        keyPress:true
    });
    $('#image-gallery').lightSlider({
        gallery:true,
        item:1,
        thumbItem:9,
        slideMargin: 0,
        speed:500,
        auto:true,
        loop:true,
        onSliderLoad: function() {
            $('#image-gallery').removeClass('cS-hidden');
        }  
    });
});
</script>
<script>

	function mobRfShop() {


		// ��ٱ��� ��ư Ŭ�� �� ȣ�� �޼ҵ�(������� �ʴ� ��� ����)
		document.getElementsById("cartBtn")[0].onmouseup = sendCart;
		document.getElementsById("cartBtn")[1].onmouseup = sendCart;
		document.getElementsById("cartBtn")[2].onmouseup = sendCart;

		function sendCart() {
			sh.sendCart();
		}
	}
</script>
<script>
function Selectsize(size){
 	document.f.size.value = size;
}
</script>
<script>

var isLogin = 'false';

var dscntSellPrice = '69000';

var prdtSellPrice = '69000';

var totalDscntSellPrice = dscntSellPrice;

var dlvyAmt = '2500';

var dlvyStdAmt = '20000';

var masterPrdtCode = '0068639';

jQuery(function($) {
	var dscntUserGbnCode = "Y";

	if(dscntUserGbnCode == "M"){
		 alert("����� ȸ���� ���� ������ ��ǰ�Դϴ�.\n�α��� �� �̿��Ͻñ� �ٶ��ϴ�.");
         var redirectUrl = location.href;
         location.href = '/abc/login/form?redirectUrl=' + redirectUrl;
    }

   if(dscntUserGbnCode == "CM"){
         alert("����� ȸ���� ���� ������ ��ǰ�Դϴ�.\n����� ȸ������ ��ȯ �� �������ֽñ� �ٶ��ϴ�.");
         location.href = '/abc/user/memberShipAgreement?mode=change';
    }
	   
    if(dscntUserGbnCode == "U"){
         alert("ABC��Ʈ ȸ���� ���� ������ ��ǰ�Դϴ�.\n�α��� �� �̿��Ͻñ� �ٶ��ϴ�.");
         var redirectUrl = location.href;
         location.href = '/abc/login/form?redirectUrl=' + redirectUrl;
    }    
	   
    
    //$("body").rightClick( function(e) {});
    
    
    // ������ȸ
    $(".smart_calculate > a").click(function(e){
        if(isLogin == 'true'){
            getPrdtCouponList($(this), masterPrdtCode);
            $(this).addClass('on');
            $(this).next(".list_drop_down").addClass("on");
            $(this).closest('tr').siblings('tr').find("a").removeClass('on');
            $(this).closest('tr').siblings('tr').find(".list_drop_down").removeClass('on');
        }else{
            alert("�α��� �� �������� �� ����Ʈ ���� ������ �ֽ��ϴ�.");
        }
    });
    
    // ��ǰ���� ��ȸ�� ����Ŭ��
    $("#findProductCoupon").on("click", "a.dscntCpn", function(){
        // ����Ʈ����
        $(".ico_close").closest('.list_drop_down').removeClass('on').siblings('a').removeClass('on');
        
        $('input[name="selectedNormalCpnUserCpnSeq"]').val($(this).find("input[name='userCpnSeq']").val());
        
        var newUserCpnSeq = $(this).find("input[name='userCpnSeq']").val();
        
        //���������� üũ������ �Լ�ȣ��
        selectCoupon(newUserCpnSeq, masterPrdtCode, 1);
    });
    
    // �߰����� ��ȸ�� ����Ŭ��
    $("#findAddCoupon").on("click", "a.dscntCpn", function(){
        // ����Ʈ����
        $(".ico_close").closest('.list_drop_down').removeClass('on').siblings('a').removeClass('on');
        
        $('input[name="selectedDoubleCpnUserCpnSeq"]').val($(this).find("input[name='userCpnSeq']").val());
        
        var newUserCpnSeq = $(this).find("input[name='userCpnSeq']").val();
        
        selectCoupon(newUserCpnSeq, masterPrdtCode, 1);
    });
    
    // ��ۺ����� ��ȸ�� ����Ŭ��
    $("#findDeliveryCoupon").on("click", "a.dscntCpn", function(){
        // ����Ʈ����
        $(".ico_close").closest('.list_drop_down').removeClass('on').siblings('a').removeClass('on');
    });
    
    
    // �����ǰ�ϰ���� ������   ���콺 ���� ȿ��
  /*  $(".onlinePrdtSize").hoverIntent(
        function () {
            $(this).addClass('select');
        }, 
        function () {
            $(this).removeClass("select");
        }
      );*/
});


function optionClick(obj,prdtCode, optnId, optnValue, prdtKorName, dscntSellPrice, soldoutYn){
    // ��ٱ���list add
    cartList.productDataSetting(prdtCode, optnId, optnValue, prdtKorName, dscntSellPrice, soldoutYn);
}

function optionClickForToolbar(obj){
    $(obj).toggleClass('on');
    $(obj).next(".list_drop_down").toggleClass("on");
    
    // �ϴ��� ���ÿ�ǰ����Ʈ�ڽ��� �����ִٸ� �ݾ��ش�
    if($(obj).parent().parent().parent().parent().find(".rltnSelectBox").hasClass("on")){
        $(obj).parent().parent().parent().parent().find(".rltnSelectBox").trigger("click");
    }
}


//rltnSelectBox
function rltnPrdtListClick(obj){
    $(obj).toggleClass('on');
    $(obj).next(".relationGoodsList").toggleClass("on");
    
    // ���� ���� ����Ʈ�ڽ��� ������ �ȿ� ���̾��˾��� OFF���ش�
    if(!$(obj).next(".relationGoodsList").hasClass("on")){
        $(obj).next(".relationGoodsList").find(".add_prd_layer").removeClass("on");
        return;
    }
}


function rltnOptionLayerOpen(thisObj, rltnPrdtCode, prdtEngName, rltnDscntSellPrice){
    var obj = $(thisObj).parent().parent().find(".add_prd_layer"); // �ɼǸ���Ʈ���̾ ������ div����
    
    if(!$(obj).hasClass("on")){
        // ���ÿ�ǰ�� �ɼǵ����� GET
        cartList.productOptionPopup(rltnDscntSellPrice, prdtEngName, rltnPrdtCode, obj);
        
        // ���� ���̾��˾� �� �ݱ�
        $(thisObj).parent().parent().parent().find(".add_prd_layer").removeClass("on");
        
        // Ŭ���ѰŸ� ����
        $(obj).addClass('on');
        
    }else{
        // �ɼǼ��� �ѹ� �� ������ �ݱ�
        $(obj).removeClass('on');
    }
}


function rltnOptionLayerSelectBoxOpen(obj){
    $(obj).toggleClass('on');
    $(obj).next(".add_prd_list").toggleClass("on");
}


function rltnOptionLayerComplete(obj){
    var optnValueObj = $(obj).parent().parent().find(".optionSelectBox"); // ���õ� �����͸� �����ִ� ��

    var prdtCode = $(optnValueObj).attr("prdtCode");             // ��ǰ�ڵ�
    var prdtKorName = $(optnValueObj).attr("prdtKorName");       // ��ǰ��
    var dscntSellPrice = $(optnValueObj).attr("dscntSellPrice"); // ���ΰ�
    var soldoutYn = $(optnValueObj).attr("optnLaveCount") <= 0 ? true : false; // ǰ������
    var optnId = $(optnValueObj).attr("optnId");           // �ɼǾ��̵�
    var optnValue = $(optnValueObj).attr("optnValue");     // �ɼǰ�
    
    if (isEmpty(optnValue) || isEmpty(optnId)) {
        alert("�ɼǴ�(��) ������ �� �����ϴ�.");
    } else {
        // ��ٱ���list add
        cartList.productDataSetting(prdtCode, optnId, optnValue, prdtKorName, dscntSellPrice, soldoutYn);

        // ����ٱ�select�ڽ��� a��ũ trigger
        $(obj).parent().parent().parent().parent().parent().parent().find(".rltnSelectBox").trigger("click");
    }
}


function rltnOptionLayerClose(obj){
    $(obj).closest('.add_prd_layer').removeClass('on');
}


function rltnOptionLayerSelectBoxSelected(obj, prdtCode, prdtKorName, dscntSellPrice, optnLaveCount, optnId, optnValue){
    var selectboxObj = $(obj).parent().parent().parent().find(".optionSelectBox");
    
    
    // ���� ������ ���� ����Ʈ�ڽ���ܿ� ���������� ��,
    $(selectboxObj).html(optnValue + "<span class='ico_arrow1'></span>");
    // ����Ʈ�ڽ� �ݾ��ش�.
    $(selectboxObj).toggleClass('on');
    $(selectboxObj).next(".add_prd_list").toggleClass("on");
}

//$(".smart_calculate").on("click", ".ico_close", function(){
function closeCouponLayerPopup(obj){
    $(obj).closest('.list_drop_down').removeClass('on').siblings('a').removeClass('on');
}


var cartList = {
        // ��ǰ�ڵ�
        prdtCode : null,
        
        // �ɼǾ��̵�
        optnId : null,
        
        // �ɼǰ�
        optnValue : null,
        
        // ��ǰ��
        prdtName : null,
        
        // �ǸŰ�
        prdtPrice : null,
        
        // ��ٱ��� ����Ʈ �ε���
        liIndex : $('#prdtList li:visible').length,
        
        // [���ٿ�] �����ͻ�ǰ selectbox �̺�Ʈ
        productDataSettingForToolBar : function(prdtCode, optnId, optnValue, prdtName, prdtPrice, soldoutYn){
            cartList.productDataSetting(prdtCode, optnId, optnValue, prdtName, prdtPrice, soldoutYn);
            // selectbox �ݾ��ֱ�
            $(".toolBarMasterPrdtSelect > a").trigger("click");
        },
        
        // ��ǰ������ ���� [�����ͻ�ǰ�� �ɼǼ��� , ���ÿ�ǰ�� �ɼǼ��ý� �۵�]
        productDataSetting : function(prdtCode, optnId, optnValue, prdtName, prdtPrice, soldoutYn){
            if(!prdtCode || !optnId || !optnValue || !prdtName || !prdtPrice){ return; }
            if(soldoutYn == "true"){ alert("ǰ���� ��ǰ�Դϴ�."); return; }
            
            cartList.prdtCode = prdtCode;       // ��ǰ�ڵ�
            cartList.optnId = optnId;           // �ɼǾ��̵�
            cartList.optnValue = optnValue;     // �ɼǰ�
            cartList.prdtName = prdtName;       // ��ǰ��
            cartList.prdtPrice = prdtPrice;     // ��ǰ����
            
            // ��ǰ ��ȿ�� �˻�
            var result = cartList.productValidation(prdtCode, optnId);
            if(!result){ return; }
            
            // ��ٱ��ϸ���Ʈ add
            cartList.productAdd();
        },
        
        // ��ǰ���
        productAdd : function(){
            var html = [];
            html.push("<li class='"+ cartList.liIndex +" bg_list'>");
            html.push("    <div class='clearfix positR'>");
            html.push("        <p class='add_prd_box fl-l mt5'>" + cartList.prdtName + "/ " + cartList.optnValue);
            html.push("        </p><div class='add_prd_layer'></div>");
            html.push("        <div class='count_box fl-r'>");
            html.push("<fieldset class='fl-l'>");
            html.push("<input type='button' value='-' class='qtyminus' onclick='cartList.productCountUpDown(\"DOWN\", "+cartList.liIndex+", this);'>");
            html.push("<input type='text' name='optnBuyCount' value='1' class='qty' readonly='readonly' maxlength='3' onkeydown='onlyNum();' onchange='javascript:cartList.productCountUpDown(\"TEXT\", "+cartList.liIndex+", this);'>");
            html.push("<input type='button' value='+' class='qtyplus' onclick='cartList.productCountUpDown(\"UP\", "+cartList.liIndex+", this);'>");
            html.push("</fieldset>");
            html.push("            <p class='fl-r mt5'><span class='unitPrdtPrice"+cartList.liIndex+"' prdtPrice='"+cartList.prdtPrice+"'>");
            html.push(                  price_format(cartList.prdtPrice) + "</span>��");
            html.push("                <a href='javascript:cartList.productRemove("+cartList.liIndex+");' class='ico_delete'>����</a>");
            html.push("            </p>");
            html.push("        </div>");
            html.push("    </div>");
            html.push("</li>");
        
            $(".prdtList").append(html.join(""));
            $(".prdtList").find(".no_data").hide(); // ������ �ɼ��� �����ϴ� ����(���ٿ�������)
            
            // css������ ����
            if(!$('.borderTopDisplay').is(":visible")){
                $(".borderTopDisplay").show(); // ��ٱ��� ���ſ��� �ڽ� show
            }
            
            // �����Ϳ� hidden�� [�ϳ��� �����ؾ��ϹǷ�]
            var dataHtml = [];
            dataHtml.push("<input type='hidden' name='prdtCodes' value='"+ cartList.prdtCode +"'>");
            dataHtml.push("<input type='hidden' name='optnIds' value='"+ cartList.optnId +"'>");
            dataHtml.push("<input type='hidden' name='prdtPrices' value='"+ cartList.prdtPrice +"'>");
            dataHtml.push("<input type='hidden' name='prdtCounts' value='1'>");
            dataHtml.push("<input type='hidden' name='prdtCodeOptnIdStr' value='"+cartList.prdtCode + cartList.optnId+"'>"); 
            $("#prdtList").find("."+cartList.liIndex).append(dataHtml.join(""));
            
            cartList.liIndex++;
            
            // �Ѱ����ݾ� ���
            cartList.productTotalAmt();
        },
        
        // ��ǰ����
        productRemove : function(liIndex){
            $("."+liIndex).remove();
            
            // �Ѱ����ݾ� ���
            cartList.productTotalAmt();
            
            if($('#prdtList li:visible').length == 0){
                $(".prdtList").find(".no_data").show(); // ������ �ɼ��� �����ϴ� ����
                
                // css������ ���� (���� �� �Ⱥ��̰��Ϸ���...)
                if($('.borderTopDisplay').is(":visible")){
                    $(".borderTopDisplay").hide(); // ��ٱ��� ���ſ��� �ڽ� hide
                }
            }
            
        },
        
        // ��ǰ��������
        productCountUpDown : function(strObj, liIndex, arrowObj){
            var thisObj = $("#prdtList").find("."+liIndex).find("input[name='prdtCounts']"); 
            var nowBuyCount = $(thisObj).val(); // ���� ����
            
            if (strObj == "UP") {
                $(thisObj).val(parseInt(nowBuyCount) + 1);
            } else if (strObj == "DOWN") {
                if(parseInt(nowBuyCount) - 1 != 0){
                    $(thisObj).val(parseInt(nowBuyCount) - 1);
                }else{
                    return;
                }
            } else { // �Է�â���� ���� ������ �ٲٴ°��
                $(thisObj).val($(arrowObj).val());
            }
            
            $(".prdtList").find("."+liIndex).find("input[name='optnBuyCount']").val($(thisObj).val());
            
            // ��ǰ���� * ��ǰ���� �� �����ݾ׺����ֱ�
            var unitPrdtPriceObj = $(arrowObj).parent().next(".fl-r").find(".unitPrdtPrice"+ liIndex);
            var unitPrdtPrice = $(unitPrdtPriceObj).attr("prdtPrice")
            $(".unitPrdtPrice"+ liIndex).html(price_format(Number(unitPrdtPrice) * Number($(thisObj).val())));
            
            // �Ѱ����ݾ� ���
            cartList.productTotalAmt();
        },
        
 
        
        // �Ѱ����ݾ� ���
        productTotalAmt : function(){
            var totalPrice = 0;
            
            $("input[name='prdtPrices']").each(function(){
                // ��ǰ����
                var price = Number($(this).val());
                
                // ��ǰ����
                var prdtCount = $(this).parent().find("input[name='prdtCounts']").val();
                
                // �� ����
                totalPrice += (price * Number(prdtCount));
            });
            
            // �� �����ݾ� �����ֱ� (��ǰ�����ʰ� ���ٿ� ��� �����Ų��)
            $("span.totalAmt").html(price_format(totalPrice));
            
            // �� ��ǰ���� ��������
            $(".totalPrdtCount").html(price_format($('#prdtList li:visible').length));
        },
        
        // ��ǰ ��ȿ���˻�
        productValidation : function(prdtCode, optnId){
            // �̹� ���Եȿɼ��� ��� [��ǰ�ڵ�� �ɼǾ��̵� ��� Ȯ��]
            try{
                $("input[name='prdtCodeOptnIdStr']").each(function(idx, prdtCodeOptnIdStr){
                    if(prdtCode + optnId == $(this).val()){
                        throw prdtCodeOptnIdStr;
                    }
                });
                return true;
            } catch(e){
                alert("�̹� �����ϴ� ��ǰ�Դϴ�.");
                return false;
            }
        },
    
    isOnGoing : true, // ��ٱ��ϴ�� ����Ŭ�����۸�������...
    
    // ��ٱ��� ���
    addCart : function(){
        // [��ٱ��ϴ��] ��ٱ��ϸ���Ʈ�� ������ִ� ��ǰ�� ���� ��ȯ
        if(cartList.isOnGoing){
            cartList.isOnGoing = false;
            var prdtList = [];
            var ednList = [];
            $("#prdtList").find('li:visible').not(".no_data").each(function(){
                var prdtOpts = {
                        prdtCode      : $(this).find("input[name=prdtCodes]").val(),
                        optnId        : $(this).find("input[name=optnIds]").val(), 
                        prdtCount     : $(this).find("input[name=optnBuyCount]").val()
                };
                prdtList.push(prdtOpts);
                
                /* EDNplus */
                var tmp = $(this).find("input[name=prdtCodes]").val()+"";
                var prdtFind = -1; 
               	ednList.map(function(item, i){
                	if(tmp == item.prdtCode) {
                		prdtFind = i;
                		return;
                	}
                });
                if(prdtFind > -1) {
                	ednList[prdtFind].prdtCount = parseInt(ednList[prdtFind].prdtCount)+parseInt($(this).find("input[name=optnBuyCount]").val())+"";
                }else {
	                var prdtTmp = {
	                        prdtCode      : $(this).find("input[name=prdtCodes]").val(),
	                        prdtCount     : $(this).find("input[name=optnBuyCount]").val(),
	                        price		  : $(this).find("input[name=prdtPrices]").val()
	                };
	                ednList.push(prdtTmp);
                }
                
                
            });
            
            if (prdtList == null || $.trim(prdtList) == "") {
                alert("�ɼ��� �������ּ���.");
                cartList.isOnGoing = true;
                return false;
            }
            
            $.ajax({
                type : "POST"
                ,url : "/abc/order/addCartProducts"
                ,data : {"prdtData" : JSON.stringify(prdtList)}
                ,dataType : "json"
                ,success : function(data) {
                    cartList.isOnGoing = true;
                    if(data.success) {
                    	
                    	/* EDNplus */
                    	var adbay = new adbayCartClass('abcmart');
                   		ednList.map(function(a){
	                   		adbay.setGoods(a.prdtCode,parseInt(a.prdtCount),parseInt(a.price));
               			});
                   		adbay.setMethod('add'); //��ٱ��Ͽ� ��ǰ�� �߰� �� ���
                    	 
                        if (confirm("�ش� ��ǰ�� ��ٱ��Ͽ� �����ϴ�.\n��ٱ��� �������� �̵��Ͻðڽ��ϱ�?")) {
                            document.location.href = "/abc/order/cart";
                        }
                   		
                   		adbay.send();
                    } else {
                        var msg = uniqueMsg(data.errorMessages).join("\n");    //�ߺ� �޽��� ������ ����
                        alert(msg);
                        if(msg.indexOf("����� ���� Ư�� ��ǰ�Դϴ�.") != -1) {
                            document.location.href = "/abc/promotion/startEvent?eventId=000214";
                        }
                    }
                }
                ,error: function(data) {
                    cartList.isOnGoing = true;
                    alert('�ý��� ������ �߻� �߽��ϴ�. �����ڿ��� �����ϼ���.');
                }
            });
        }
    },
    
    // �ٷα���
    quickOrder : function(dlvyTypeCode) {
        // [�ٷα���] ��ٱ��ϸ���Ʈ�� ������ִ� ��ǰ�� ���� ��ȯ
        if(cartList.isOnGoing){
            cartList.isOnGoing = false;
            var prdtList = [];
            $("#prdtList").find('li:visible').not(".no_data").each(function(){
                var prdtOpts = {
                        prdtCode      : $(this).find("input[name=prdtCodes]").val(),
                        optnId        : $(this).find("input[name=optnIds]").val(), 
                        prdtCount     : $(this).find("input[name=optnBuyCount]").val()
                }
                prdtList.push(prdtOpts);
            });
            
            if (prdtList == null || $.trim(prdtList) == "") {
                alert("�ɼ��� �������ּ���.");
                cartList.isOnGoing = true;
                return false;
            }
            
            var confirmMsg = "�ش� ��ǰ�� �ٷα��� �Ͻðڽ��ϱ�?";
            if (dlvyTypeCode == "02") {
            	confirmMsg = "�����Ͻ� ������ ��� ������ ����\n�Ⱦ� �غ� �Ⱓ�� 1~5�� �ҿ�˴ϴ�.\n\n�ش��ǰ�� ���忡�� �Ⱦ��Ͻðڽ��ϱ�?";
            }
            if(confirm(confirmMsg)){
                $.ajax({
                    type : "POST"
                    ,url : "/abc/order/quickOrderForDetail"
                    ,data : {"prdtData" : JSON.stringify(prdtList), "dlvyTypeCode" : dlvyTypeCode}
                    ,dataType : "json"
                    ,success : function(data) {
                        cartList.isOnGoing = true;
                        if(data.success) {
                            document.location.href = "https://www.abcmart.co.kr/abc/order/order";
                        } else {
                            var msg = uniqueMsg(data.errorMessages).join("\n");    //�ߺ� �޽��� ������ ����
                            if (data.isErrorConfirm) {
                            	if (confirm(msg)) {
                            		$.ajax({
                                        type : "POST"
                                        ,url : "/abc/order/quickOrderForDetail"
                                        ,data : {"prdtData" : JSON.stringify(prdtList), "dlvyTypeCode" : "01"}
                                        ,dataType : "json"
                                        ,success : function(data) {
                                            cartList.isOnGoing = true;
                                            if(data.success) {
                                                document.location.href = "https://www.abcmart.co.kr/abc/order/order";
                                            } else {
                                                var msg = uniqueMsg(data.errorMessages).join("\n");    //�ߺ� �޽��� ������ ����
                                                alert(msg);
                                                if(msg.indexOf("����� ���� Ư�� ��ǰ�Դϴ�.") != -1) {
                                                    document.location.href = "/abc/promotion/startEvent?eventId=000214";
                                                }
                                            }
                                        }
                                        ,error: function(data) {
                                            cartList.isOnGoing = true;
                                            alert('�ý��� ������ �߻� �߽��ϴ�. �����ڿ��� �����ϼ���.');
                                        }
                                    });
                            	}
                            } else {
                            	alert(msg);
                            }
                            if(msg.indexOf("����� ���� Ư�� ��ǰ�Դϴ�.") != -1) {
                                document.location.href = "/abc/promotion/startEvent?eventId=000214";
                            }
                        }
                    }
                    ,error: function(data) {
                        cartList.isOnGoing = true;
                        alert('�ý��� ������ �߻� �߽��ϴ�. �����ڿ��� �����ϼ���.');
                    }
                });
            } else{
                cartList.isOnGoing = true;
            }
        }
    }
};


function receiveNoticeClick(selectOption){
    if(isLogin != 'true'){
        // ��ȸ�� �Ұ�
        if(confirm("�α��� ���� �̿��� �����մϴ�.")){
            moveLoginForm();
            return;
        }else{
            return;
        }
    }else{
        // SNSȸ�� �Ұ�
        var userType = "";
        if(userType == 'SNS'){
            alert("���԰� �˸� ���񽺴� �¶���, ����� ȸ���� �����մϴ�.");
            return;
        }else{
            // ���԰��û���̾��˾� open
            $("select[name='reinifoProductDetailSelectedOption']").val(selectOption);
            layerPopupShow($('div#target2'), false);
        }
    }
}


function closeLayerPopup(){
    layerPopupHide($('div#target2'));
}


function rininfoReq(){
    if(isLogin == 'true'){
        var prdtCode = masterPrdtCode;
        var optnId = $("select[name='reinifoProductDetailSelectedOption']").val();
        
        var hpNum1 = $.trim($("select[name='hpNum1']").val());
        var hpNum2 = $.trim($("input[name='hpNum2']").val());
        var hpNum3 = $.trim($("input[name='hpNum3']").val());

        if(!optnId) {
            alert("����� �������ּ���.");
            return false;
        }

        if(hpNum1.length <= 2 || hpNum2.length <= 2 || hpNum3.length <= 3) {
            alert("�ڵ��� ��ȣ�� �Է����ּ���.");
            return false;
        }

        $.ajax({
            type : "post"
            , url : "/abc/mypage/saveReceiveNotice"
            , dataType : "json"
            , data: {
                prdtCode : prdtCode
                , optnId : optnId
                , hpNum1 : hpNum1
                , hpNum2 : hpNum2
                , hpNum3 : hpNum3
            }
            ,success : function(data) {
                if (data.save) {
                    alert("���԰� �˸� ���� ��û�� �Ϸ�Ǿ����ϴ�.");
                    clearRininfo();
                    closeLayerPopup();
                    return false;
                } else {
                    alert("������ ��ǰ�� ��û ������ �����մϴ�.");
                    clearRininfo();
                    return false;
                }
            }
            ,error: function(xhr, status, error) {
                alert("�ý��� ������ �߻� �߽��ϴ�. �����ڿ��� �����ϼ���.");
            }
        });
        return false;
    }
}

function goHashSearch(hashTag){
    var encoding = encodeURIComponent(hashTag);
    window.open('/abc/search/search?searchTerm='+encoding, '_blank'); 
}


function clearRininfo(){
    $("select[name='reinifoProductDetailSelectedOption'] option:eq(0)").attr("selected", "selected");
    $("select[name='hpNum1'] option:eq(0)").attr("selected", "selected");
    $("input[name='hpNum2']").val("");
    $("input[name='hpNum3']").val("");
}
function upDownCount(obj){
    var prdtCount = $(obj).parent().find("input[name='quantity']").val();
    if(isNaN(prdtCount) || !prdtCount) {
        prdtCount = 0; 
    }
    
    // UP & DOWN
    if($(obj).val() == "+"){
        $(obj).parent().find("input[name='quantity']").val(eval(prdtCount)+1);
    }else if($(obj).val() == "-"){
        if(prdtCount > 1) {
            $(obj).parent().find("input[name='quantity']").val(prdtCount-1);
        }
    }
}
function updateCount(obj){
	
}
</script>
</head>
<body>
	<div class="container_area">
		<div class="container_layout">
			<div class="product_detail_box1">
				<div class="detail_box1_left" style="margin-top: 210px">
<div class="demo w3-container w3-padding w3-center">
        <div class="item">            
            <div class="clearfix" style="max-width:100%;">
            <ul id="image-gallery" class="gallery list-unstyled cS-hidden">
            <c:forEach var="pic" items="${item.picturelist}">
                <c:if test="${pic.type==1}">
                <li data-thumb="../picture/${pic.pictureurl}"> 
                    <img class="w3-circle w3-hover-opacity" src="../picture/${pic.pictureurl}" style="width:200px; height:200px;" />
                </li>
                </c:if>
           </c:forEach>
           </ul>
           </div>
        </div>
 </div>
					<section class="detail_add_box" style="margin-left:15%;">

						<div class="detail_add_box1">

							<div class="rating_box">
								<p class="tit_type1 fs14">��ǰ ������</p>
								<p class="tit_type2">
							    ${satavg}
							    <span class="won fs20">%</span>
								</p>
								<p class="tit_type3 mt5">
			<c:if test="${evavg==5}">
			<label for="score1"><span class="score4"><em>�ڡڡڡڡ�</em></span></label>
			</c:if>
			<c:if test="${evavg==4}">
			<label for="score1"><span class="score4"><em>�ڡڡڡ�</em></span></label>
			</c:if>
			<c:if test="${evavg==3}">
			<label for="score1"><span class="score4"><em>�ڡڡ�</em></span></label>
			</c:if>
			<c:if test="${evavg==2}">
			<label for="score1"><span class="score4"><em>�ڡ�</em></span></label>
			</c:if>
			<c:if test="${evavg==1}">
			<label for="score1"><span class="score4"><em>��</em></span></label>
			</c:if>
									
									<em class="ml10">${evavg} / 5</em>
								</p>
							</div>

							<div class="appraisal_box">
								<ul class="mt5">

		  <li><strong class="tit_type3">������</strong> 
									
	      <c:choose>
		  <c:when test="${sizeavg==5}">
		    <td class="align-left">�� �������</td>
		    </c:when>
		    <c:when test="${sizeavg==4}">
		    <td class="align-left">5mm���� ������ ���ƿ�</td>
		    </c:when>
		    <c:when test="${sizeavg==3}">
		    <td class="align-left">5mm ���� ū �� ���ƿ�</td>
		    </c:when>
		    <c:when test="${sizeavg==2}">
		    <td class="align-left">10mm ���� ���� �� ���ƿ�</td>
		    </c:when>
		    <c:when test="${sizeavg==1}">
		    <td class="align-left">10mm ���� ū �� ���ƿ�</td>
		    </c:when>
		</c:choose>

		<li> 
		           <c:if test="${coloravg==5}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ��� ���ƿ�</span></li>
                   </c:if>
                   <c:if test="${coloravg==4}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ�麸�� �ణ ��ƿ�</span></li>
                   </c:if>
                   <c:if test="${coloravg==3}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ�麸�� �ణ ��ο���</span></li>
                   </c:if>
                   <c:if test="${coloravg==2}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ�麸�� ���� ��ƿ�</span></li>
                   </c:if>
                   <c:if test="${coloravg==1}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ�麸�� ���� ��ο���</span></li>
                   </c:if>

								</ul>
								<a href="#info_box2" class="btn_sType1">��ǰ�ı� �ٷΰ���</a>
							</div>
						</div>

					</section>

				</div>

				<div class="detail_box1_right" style="width:55%;">
					<div class="detail_info_area ">
					
						<header class="product_tit clearfix">
							<div class="fl-l mr15">
								<img src="http://image.abcmart.co.kr/nexti/images/abcmart/client/1542/20160908091420710.gif"
									alt="����Ű" width="128" height="68" onerror="imageError(this)">
								<p class="align-center mt10">
									<a href="/abc/product/brandShop?brandId=000050">
									<img src="http://image.abcmart.co.kr/nexti/images/abcmart_new/btn_brand.gif"
										alt=""></a>
								</p>
							</div>

							<div class="fl-l mt5 tit_group">

								<h2 class="tit_type1">${item.brand}</h2>
								<h3 class="tit_type1 fs16">${item.name}</h3>
							</div>
						</header>


						<section class="detail_section detail_info1">
							<dl>
								<dt>�ǸŰ�</dt>
								<dd class="detail_price">
									<div>
										<span class="price" align="left">
										<fmt:formatNumber value="${item.price}" pattern="#,###"/><em class="won">��</em>
										</span>
									</div>

								</dd>
							</dl>
						</section>
						<section class="detail_section">

							<dl>
								<dt>��ۺ�</dt>
								<dd class="mt3" align="left">2,500��</dd>
							</dl>
						</section>
						<section class="detail_section">
							<dl>
								<dt>�÷�</dt>
								<span style="margin-left:-40%">${item.color}</span>
								<dd>
								</dd>
							</dl>
						</section>
						<section class="detail_section">
							<dl>
								<dt>������</dt>
								<dd align="left">
								 <select onchange="Selectsize(this.value)" id="addsize"> 
		<option>����</option><c:forEach var="size" items="${item.size}"><option value="${size.size}">${size.size}</option></c:forEach> 
		</select>
								</dd>
							</dl>
						</section>


						<section class="detail_section ">
<section class="check_list_box borderTopDisplay" style="">
<form action="../cart/cartAdd.shop" name="f">
 <input type="hidden" name="itemno" value="${item.itemno}">
			<input type="hidden" name="size" value="${size}">
         <ul class="prdtList" id="prdtList">
           <li class="0 bg_list">    
           <div class="clearfix positR">        
           <p class="add_prd_box fl-l mt5"> <font style="font-weight:bold;">${item.name}</font></p> <!-- itemno, size, quantity -->
           <div class="add_prd_layer"></div>        
         
				<div class="incrementer" align="center">
						<div class="count_box">
							<input type="text" name='quantity' value="0" class='qty' readonly='readonly'/>
							<input type='button' onclick="upDownCount(this);" value='+' class='qtyplus'/>
							<input type='button' onclick="upDownCount(this);" value='-' class='qtyminus'/>							
						</div>
				</div>
			</div></li></ul>
			<section class="btn_group_section new">
						<ul>

							<li><input type="submit" value="��ٱ���" class="btn_lType1"></li>
							<li><a href="../item/itemlist.shop" class="btn_lType2">���</a>
					</li>
						</ul>
					</section>
  </form>                                   
                                    </section>
						</section>

					</div>
			</div>
			</div>
			<div class="product_detail_box3 ">
				<div class="info_box1" id="info_box1">



					<ul class="clearfix detail_tab" style="width:65%;">
						<li class="current"><a href="#info_box1">��ǰ ����</a></li>
						<li><a href="#info_box2">��ǰ �ı� (<span class="reviewCount">${listcount}</span>)
						</a></li>
						<li><a href="#info_box3">��ǰ Q&amp;A (<span
								class="qnaCount">${qavg}</span>)
						</a></li>
						<li><a href="#info_box4">��� / ��ȯ / ��ǰ / AS�ȳ�</a></li>
					</ul>

					<section class="align-center">
						<p>
			<c:forEach var ="pic" items="${item.picturelist}">
			<c:if test="${pic.type==2}">
			<img alt="" src="../picture/${pic.pictureurl}" style="height: 1000px; width: 600px">
			</c:if>
			</c:forEach>
						</p>
					</section>


					<section class="table_basic">
						<table>
							<colgroup>
								<col width="200px">
								<col width="*">
								<col width="200px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>����</th>
									<td>����</td>

									<th>����</th>
									<td>�������� ����</td>
								</tr>
								<tr>
									<th>����</th>
									<td>${item.color }</td>

									<th>ġ��</th>
									<td>
									<c:forEach var="size" items="${item.size}">
									${size.size} /
									</c:forEach>
									</td>
								</tr>
								<tr>
									<th>������</th>
									<td>�������� ����</td>

									<th>������</th>
									<td>�������� ����</td>
								</tr>
								<tr>
									<th>������</th>
									<td>�ε��׽þ�</td>

									<th>������</th>
									<td></td>
								</tr>
								<tr>
									<th>A/S å���ڿ� ��ȭ��ȣ</th>
									<td>�Ź��� A/S ����� : 080-701-7770</td>

									<th>�������</th>
									<td>�������� ����</td>
								</tr>
								<tr>
									<th>Ư�̻���</th>
									<td></td>

									<th>ǰ����������</th>
									<td>�� ��ǰ�� ���� ��� �Һ��ں����ذ� ���ؿ� �ǰ��Ͽ� �����ص帳�ϴ�. (ǰ�������Ⱓ : �����Ϸκ���
										6���� �̳�)</td>
								</tr>
								<tr>
									<th>������TIP</th>
									<td></td>

									<th>���纰 �������</th>
									<td>������ �������� ������ ������ �ε巯�� �ַ� �о�ֽñ� �ٶ��ϴ�. ����Ź�� ���� �ʴ�
										�����Դϴ�. ���� ���� �ʰ� ���ֽñ� �ٶ��, ���� ���� ������ ������ ���� �ɷ��� �۾��ֽñ� �ٶ��ϴ�. ��Ź��
										���� �ʴ� ��ǰ�Դϴ�.</td>
								</tr>
							</tbody>
						</table>

					</section>

					<p class="ico_notice">���ڻ�ŷ� ����� ��ǰ�������� ��ÿ� ���� �ۼ��Ǿ����ϴ�.</p>


				</div>

				<div class="info_box2 mt60" id="info_box2">

					<ul class="clearfix detail_tab" style="width:65%;">
						<li><a href="#info_box1">��ǰ ����</a></li>
						<li class="current"><a href="#info_box2">��ǰ �ı� (<span
								class="reviewCount">${listcount}</span>)
						</a></li>
						<li><a href="#info_box3">��ǰ Q&amp;A (<span
								class="qnaCount">${qavg }</span>)
						</a></li>
						<li><a href="#info_box4">��� / ��ȯ / ��ǰ / AS�ȳ�</a></li>
					</ul>
</from>






					<script>
$(function() {
    // �� ����Ī
    $('section.evaluate_list ul.tabs li a').on('click', function() {
        var type = $(this).data('type');
        if(isEmpty(type)) {
            return false;
        }
        turnReviewPageAjax(type, 1);

        $('section.evaluate_list ul.tabs li.current').removeClass('current');
        $(this).parent('li').addClass('current');
    });
});

function turnAllReviewPageAjax(page) {
    turnReviewPageAjax('all', page);
}

function turnNormalReviewPageAjax(page) {
    turnReviewPageAjax('normal', page);
}

function turnPhotoReviewPageAjax(page) {
    turnReviewPageAjax('photo', page);
}

function turnReviewPageAjax(type, page) {
    if(type == null || type == undefined || type == '' || (type != 'all' && type != 'normal' && type != 'photo')) {
        return false;
    }

    if(!page) {
        page = 1;
    }

    $.ajax({
        type: 'get',
        url: '/abc/product/ajaxListProductReviews',
        data: {
            type: type,
            prdtCode: '0068359',
            prdtGbnCode: '01000000',
            page: page
        },
        success: function(data) {
            if(location.hash == '#evaluate_area') {
                location.hash = null;
                location.hash = '#evaluate_area';
            } else {
                location.hash = '#evaluate_area';
            }
            var $parent = $('div.linear_list');
            $parent.html(data);
        }
    });
}

function turnAdminReviewPageAjax(page) {
    if(!page) {
        page = 1;
    }

    $.ajax({
        type: 'get',
        url: '/abc/product/ajaxListAdminProductReviews',
        data: {
            prdtCode: '0068359',
            page: page
        },
        success: function(data) {
            if(location.hash == '#evaluate_area') {
                location.hash = null;
                location.hash = '#evaluate_area';
            } else {
                location.hash = '#evaluate_area';
            }
            var $parent = $('div.grid_list');
            $parent.html(data);
        }
    });
}

function isEmpty(value) {
    return (value == null || value == undefined || value == '');
}
</script>

					<div class="evaluate_area" id="evaluate_area">


						<section class="evaluate_list">
							<ul class="tabs">
								<li class="current"><a style="cursor: pointer;"
									data-type="all">��ü(${listcount})</a></li>
							</ul>
<div class="linear_list">
<script>
$(function() {
    $('.toggle_btn').off('click', 'a');
    $('.toggle_btn').on('click', 'a', function(e){ 
        e.preventDefault(); 
        $(this).toggleClass('current');
        $(this).closest('tr').next('.more_viewBox').toggleClass('on');
    });

    $('#btnWriteReview').on('click', function() {
        if(confirm('��ǰ�ı�� �������������� �ۼ� �����մϴ�. ������������ �̵��Ͻðڽ��ϱ�?')) {
            return true;
        }
        return false;
    });

    // Ư�� �ı�� ����
    $(".btnReviewUpdate").click(function() {
        var prdtRvwSeq = $(this).data('prdt-rvw-seq');
        var prdtCode = '0066398';
        var url = 'http://www.abcmart.co.kr/abc/mypage/updateMyReviewForm?prdtRvwSeq=' + prdtRvwSeq + '&prdtCode=' + prdtCode;
        var options = 'width=718,height=1110,scrollbars=yes';
        window.open(url, 'about:blank', options);
    });

    $('.btnReviewDelete').on('click', function() {
        var prdtRvwSeq = $(this).data('prdt-rvw-seq');
        if(confirm('�����Ͻðڽ��ϱ�?')) {
            location.href = 'http://www.abcmart.co.kr/abc/mypage/deleteMyReview?prdtRvwSeq=' + prdtRvwSeq;
        }
    });
});
</script>
<div class="table_basic mt10">
    <table>
        <colgroup>
            <col width="550"><col width="120"><col width="140"><col width="150"><col width="*">
        </colgroup>
        <thead>
            <tr>
                <th>����</th>
                <th>������</th>
                <th>��ǰ������</th>
                <th>�ۼ���</th>
                <th>�ۼ���</th>
            </tr>
        </thead>         
           <tbody>
   <c:forEach items="${evlist}" var="e">
		<tr><td class="align-center toggle_btn"><a href="#">${e.title}</a></td>
		<c:choose>
		  <c:when test="${e.size==5}">
		    <td class="align-left">�� �������</td>
		    </c:when>
		    <c:when test="${e.size==4}">
		    <td class="align-left">5mm���� ������ ���ƿ�</td>
		    </c:when>
		    <c:when test="${e.size==3}">
		    <td class="align-left">5mm ���� ū �� ���ƿ�</td>
		    </c:when>
		    <c:when test="${e.size==2}">
		    <td class="align-left">10mm ���� ���� �� ���ƿ�</td>
		    </c:when>
		    <c:when test="${e.size==1}">
		    <td class="align-left">10mm ���� ū �� ���ƿ�</td>
		    </c:when>
		</c:choose>
			<td style="width:15px;">
			<c:if test="${e.score==5}">
			<label for="score1"><span class="score4"><em>�ڡڡڡڡ�</em></span></label>
			</c:if>
			<c:if test="${e.score==4}">
			<label for="score1"><span class="score4"><em>�ڡڡڡ�</em></span></label>
			</c:if>
			<c:if test="${e.score==3}">
			<label for="score1"><span class="score4"><em>�ڡڡ�</em></span></label>
			</c:if>
			<c:if test="${e.score==2}">
			<label for="score1"><span class="score4"><em>�ڡ�</em></span></label>
			</c:if>
			<c:if test="${e.score==1}">
			<label for="score1"><span class="score4"><em>��</em></span></label>
			</c:if>
			</td>
			<td>${e.userid }</td>
			<td><fmt:formatDate pattern="yy-MM-dd" value="${e.registdate}"/></td></tr>
				<tr class="more_viewBox">
                    <td colspan="5">
                       <div class="more_txt">
                       <ul class="clearfix">
                   <c:if test="${e.satisfy==5 }">
                   <li><strong>��ǰ ������</strong>
                   <span>���� �����ؿ�</span></li>
                   </c:if>
                   <c:if test="${e.satisfy==4}">
                   <li><strong>��ǰ ������</strong>
                   <span>�����ؿ�</span></li>
                   </c:if>
                   <c:if test="${e.satisfy==3 }">
                   <li><strong>��ǰ ������</strong>
                   <span>�����̿���</span></li>
                   </c:if>
                   <c:if test="${e.satisfy==2 }">
                   <li><strong>��ǰ ������</strong>
                   <span>���ο���</span></li>
                   </c:if>
                   <c:if test="${e.satisfy==1 }">
                   <li><strong>��ǰ ������</strong>
                   <span>���� �����</span></li>
                   </c:if>
                   
                   
                   <c:if test="${e.size==5}">
                   <li><strong class="tit_type3">������</strong>
                   <span>�� �������</span></li>
                   </c:if>
                   <c:if test="${e.size==4}">
                   <li><strong class="tit_type3">������</strong>
                   <span>5mm���� ������ ���ƿ�</span></li>
                   </c:if>
                   <c:if test="${e.size==3}">
                   <li><strong class="tit_type3">������</strong>
                   <span>5mm���� ū �� ���ƿ�</span></li>
                   </c:if>
                   <c:if test="${e.size==2}">
                   <li><strong class="tit_type3">������</strong>
                   <span>10mm���� ���� �� ���ƿ�</span></li>
                   </c:if>
                   <c:if test="${e.size==1}">
                   <li><strong class="tit_type3">������</strong>
                   <span>10mm���� ū �� ���ƿ�</span></li>
                   </c:if>
                   
                   <c:if test="${e.color==5}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ��� ���ƿ�</span></li>
                   </c:if>
                   <c:if test="${e.color==4}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ�麸�� �ణ ��ƿ�</span></li>
                   </c:if>
                   <c:if test="${e.color==3}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ�麸�� �ణ ��ο���</span></li>
                   </c:if>
                   <c:if test="${e.color==2}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ�麸�� ���� ��ƿ�</span></li>
                   </c:if>
                   <c:if test="${e.color==1}">
                   <li><strong class="tit_type3">����</strong>
                   <span>ȭ�麸�� ���� ��ο���</span></li>
                   </c:if>
                   </ul>
                   <div class="mt20">
                   <img src="../picture/${e.pictureurl}" style="width:200px;">
                   <font style="font-size:20pt;">${e.content}</font>
                   </div>  
                  </div>
                                
                  </td>
   </tr>
	</c:forEach>                       
            </tbody>
    </table>
</div>

<div class="positR">
    <a href="../board/eval.shop?itemno=${item.itemno}" class="btn_mType1">��ǰ�ı� �ۼ�</a>
</div>
        </div>

						</section>
					</div>
				</div>

				<div class="info_box3" id="info_box3">

					<ul class="clearfix detail_tab" style="width:65%;">
						<li><a href="#info_box1">��ǰ ����</a></li>
						<li><a href="#info_box2">��ǰ �ı� (<span class="reviewCount">${listcount}</span>)
						</a></li>
						<li class="current"><a href="#info_box3">��ǰ Q&amp;A (<span
								class="qnaCount">${qavg}</span>)
						</a></li>
						<li><a href="#info_box4">��� / ��ȯ / ��ǰ / AS�ȳ�</a></li>
					</ul>

					<div class="qna_area">







<script>
'use strict';

$(function() {
    if(location.href.indexOf('#info_box3') != -1) {
        $('html, body').animate({
            scrollTop: parseInt($('#info_box3').offset().top)
        }, 500);
    }
    

    $('.qna_btn').off('click', 'a');
    $('.qna_btn').on('click', 'a', function(e) {
        e.preventDefault(); 
        $(this).closest('tr').next('.qna_answer_box').toggleClass('on');
    });
    
    
    $("a.btnUpdate").click(function() {
        if (confirm('�����Ͻðڽ��ϱ�?')) {
            var cnslSeq = $(this).parent().attr("cnslSeq");
            var gubun = $(this).parent().attr("gubun");
            var cnslClassId = $(this).parent().attr("cnslClassId");
            $.ajax({
                url: ""
                , data: {
                    "cnslSeq" : cnslSeq
                }
                , dataType: "html"
                , success: function(data) {
                    var $layer = $('div#target3');
                    $layer.html('');
                    $layer.html(data);
                    wrapWindowByMask();
                    layerPosition($layer);
                    $layer.attr('tabindex', 0).show().focus();
                    $layer.find('.pop_x , .btn_mType3').click(function() {
                        $layer.hide();
                        $('div.bg_mask').hide();
                        $layer.html('');
                    });
                }
            });
        } else {
            return false;
        }
    });
    
    $("a.btnDelete").click(function() {
        if (confirm('�����Ͻðڽ��ϱ�?')) {
            var cnslSeq = $(this).parent().attr("cnslSeq");
            var gubun = $(this).parent().attr("gubun");
            var cnslClassId = $(this).parent().attr("cnslClassId");
            var tabs = '';
            $.ajax({
                type: "post"
                , url: 'http://www.abcmart.co.kr/abc/customer/deleteOnlineCounsel'
                , data: {
                    "cnslSeq" : cnslSeq
                }
                , dataType: "json"
                , success: function(data) {
                    if (data.save) {
                        alert("�����Ǿ����ϴ�.");
                        var reloadUrl = location.href;
                        if(reloadUrl.indexOf('#') != -1) {
                            reloadUrl = reloadUrl.substring(0, reloadUrl.indexOf('#')) + '#info_box3';
                        }
                        location.href = reloadUrl;
                        location.reload(true);
                    } else {
                        alert(data.errorMessages[0]);
                    }
                }
                , error: function(xhr, status, error) {
                    alert("�ý��� ������ �߻� �߽��ϴ�. �����ڿ��� �����ϼ���.");
                }
            });
        } else {
            return false;
        }
    });
});

function wrapWindowByMask() {
    var maskWidth = $(window).width();
    var maskHeight = $(window).height();
    $('.bg_mask').css({'width': maskWidth, 'height': maskHeight, 'opacity': '0.6', 'z-index': '500'});
    $('.bg_mask').show();
}

function layerPosition(obj) {
    obj.css("margin-left", '-' + obj.width() / 2 + 'px');
    if(obj.height() > $(window).height() - 100) {
        obj.css("overflow-y", "scroll").css("height", $(window).height() - 100 + 'px').css("margin-top", '-' + obj.height() / 2 + 'px');
    } else {
        obj.css("margin-top" , '-' + obj.height()/2 + 'px');
    }
}

function turnQnAPageAjax(page) {
    var newPage = isEmpty(page) ? "1" : page;
    var $parent = $('div.qna_area').parent();
    $('div.qna_area').remove();
    $.ajax({
        type: 'get',
        url: '',
        data: {prdtCode: '0068359', page: newPage},
        success: function(data) {
            $parent.append(data);
            $('.qna_btn').off('click', 'a');
            $('.qna_btn').on('click', 'a', function(e) {
                e.preventDefault(); 
                $(this).closest('tr').next('.qna_answer_box').toggleClass('on');
            });
        }
    });
}




function showQnAFormLayer() {
    alert('�α����� �ʿ��� ����Դϴ�.');
    //�α��� ��ȿ��
    var redirectUrl = location.href;
    location.href = '/user/login.shop'
}

</script>
	<div class="qna_area">
	<section class="list_area">
	<ul class="list_type1">
	<li>�ܼ� ��ǰ���, ������� ����, ��ǳ��� ����, �Խ����� ���ݿ� ���� �ʴ� ���� �뺸 ���� ������
		�� �ֽ��ϴ�.</li>
	<li>�������� ���� �����Ȳ ���Ǵ� <span class="fc_type2">�������������θ��塯</span>
			������ �����Ͻþ� �ش� �������� �����Ͻø� �� �� ��Ȯ�� Ȯ���� �����մϴ�.
	</li>
	<li>�ֹ�/���/��ǰ �� AS �� ��Ÿ ���Ǵ� <span class="fc_type2">1:1
			��㹮��(����������&gt;���μ�ø&gt;���ǻ��)</span>�� �����ֽñ� �ٶ��ϴ�.<br> (��ǰ ��ü�� ����
		���ǰ� �ƴ� �ֹ�/���/��ǰ �� AS ���� ��Ÿ���Ǹ� �ۼ��Ͻ� ��� ���ǻ�� �޴��� ���� �̵��� �� �ֽ��ϴ�.)
	</li>
	</ul>
</section>

<section class="qna_list">
		<div class="table_basic mt10">
		<table>
		<colgroup>
		    <col width="130">
		    <col width="130">
			<col width="590">
			<col width="130">
			<col width="*">
		    </colgroup>
			<thead>
			<tr>
			<th>�亯����</th>
			<th>��������</th>
			<th>����</th>
			<th>�ۼ���</th>
			<th>�ۼ���</th>
	</tr>
</thead>
<tbody>
	<tr class="group-center">
<c:if test="${qavg==0}">
	<td colspan="5">�ۼ��� ��ǰ Q&amp;A�� �����ϴ�.</td>
</c:if>
	<c:forEach items="${qlist}" var="q">
		<tr class="group-center">
		<c:if test="${!empty q.answer}">
		<td><span class="fc_type2">�亯�Ϸ�</span></td>
		</c:if>
		<c:if test="${empty q.answer}">
		<td><span class="fc_type2"><font style="font-color:black;">�亯����</font></span></td>
		</c:if>
	<c:choose>
		  <c:when test="${q.qtype==5}">
		    <td class="align-center"><font style="font-weight:bold;">������</font></td>
		    </c:when>
		    <c:when test="${q.qtype==4}">
		    <td class="align-center"><font style="font-weight:bold;">�Ź߰�����</font></td>
		    </c:when>
		    <c:when test="${q.qtype==3}">
		    <td class="align-center"><font style="font-weight:bold;">�԰���</font></td>
		    </c:when>
		    <c:when test="${q.qtype==2}">
		    <td class="align-center"><font style="font-weight:bold;">����</font></td>
		    </c:when>
		    <c:when test="${q.qtype==1}">
		    <td class="align-center"><font style="font-weight:bold;">��ǰ�˻�</font></td>
		    </c:when>
		</c:choose>
		<td class="align-center qna_btn"><a href="#">${q.title}</a></td>
			<td>${q.userid }</td>
			<td><fmt:formatDate pattern="yy-MM-dd" value="${q.regidate}"/></td></tr>
   <tr class="qna_answer_box">
      <td colspan="5">
        <div class="quest_box clearfix positR">
           <span class="ico_quest fl-l">����</span>
             <div class="quest_txt">
                <section class="qna_txtsection align-center">
                   ${q.content }<br>
       </section>
                                            
</div>
  </div>
                                    
  <div class="answer_box clearfix">
    <span class="ico_answer fl-l">�亯</span> 
      <div class="answer_txt align-center">${q.answer}</div>
         </div>
         <c:if test="${loginUser.userId == 'admin' }">
           <a href="#" class="btn_mType1" style="align:right;" data-toggle="modal" data-target="#myModal2"> 
										<span class="tooltip_type1">�亯</span></a></c:if>                         
      </td>
   </tr>
	</c:forEach>                       
</tr>

</tbody>
</table>
</div>
<div class="modal" id="myModal2">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h2>��ǰ �亯 �ۼ�</h2>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
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
                <span class="fs18 fc_type5 mb10">${item.brand }</span>
                <h2 class="tit_type1 fs22">${item.name}</h2>
                <p class="mt40">
                    <span>${item.price }<span>��</span></span>
                </p>
            </div>
        </header>
    <form action="answer.shop" method="post">
    <input type="hidden" name="itemno" value="${param.itemno }"/>
    <input type="hidden" name="userid" value="${loginUser.userId}"/>
            <div class="mt20 table_basic">
                <table>
                    <colgroup>
                        <col width="20%">
                        <col width="*">
                    </colgroup>
            
            <tbody>
            <c:forEach var="q" items="${anslist}">
              <tr>
              <th>��������</th>
          <c:choose>
		  <c:when test="${q.qtype==5}">
		    <td class="align-center"><font style="font-weight:bold;">������</font></td>
		    </c:when>
		    <c:when test="${q.qtype==4}">
		    <td class="align-center"><font style="font-weight:bold;">�Ź߰�����</font></td>
		    </c:when>
		    <c:when test="${q.qtype==3}">
		    <td class="align-center"><font style="font-weight:bold;">�԰���</font></td>
		    </c:when>
		    <c:when test="${q.qtype==2}">
		    <td class="align-center"><font style="font-weight:bold;">����</font></td>
		    </c:when>
		    <c:when test="${q.qtype==1}">
		    <td class="align-center"><font style="font-weight:bold;">��ǰ�˻�</font></td>
		    </c:when>
		</c:choose>
       </tr>
    <tr>
        <th>����</th>
             <td>
             <input type="text" class="text" name="title" style="width:395px" maxlength="50" value="${q.title}" readonly="readonly">
             <span class="fc_type4"></span>
             </td>
    </tr>	
    <tr>
     <th>����</th>
        <td><textarea class="text" name="answer"></textarea></td>
      </tr>
      </c:forEach>
      </tbody>
    </table>
   </div>
   <!-- Modal footer -->
        <div class="modal-footer">
        <button type="submit" class="btn_mType1" >���</button>
        <button type="button" class="btn_mType3" data-dismiss="modal">�ݱ�</button>
        </div>
 </form>
        </div>
        
        
    </div>
  </div>
  </div>
  </div>
  </div>
<div class="positR">
		<p class="paginate"></p>

		<ul class="btn_group">
										<li><a href="#" class="btn_mType1" data-toggle="modal" data-target="#myModal"> 
										<span class="tooltip_type1">Q&amp;A �ۼ�</span>
										</a></li>
									</ul>
								</div>
							</section>
						</div>
					</div>
				</div>
				
<div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h2>��ǰ Q&amp;A �ۼ�</h2>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
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
                <span class="fs18 fc_type5 mb10">${item.brand }</span>
                <h2 class="tit_type1 fs22">${item.name}</h2>
                <p class="mt40">
                    <span>${item.price }<span>��</span></span>
                </p>
            </div>
        </header>
    <form id="form-target3" action="qna.shop" method="post">
    <input type="hidden" value="${param.itemno}" name="itemno"/>
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
              <td>
             <div class="qnatype">
                 <input type="radio" id="qnatype0" name="qtype" value="1" checked=""><label for="qnatype0">��ǰ�˻�</label>
                                        
                 <input type="radio" id="qnatype1" name="qtype" value="2"><label for="qnatype1">����</label>
                                        
                 <input type="radio" id="qnatype2" name="qtype" value="3"><label for="qnatype2">�԰���</label>
                                        
                  <input type="radio" id="qnatype3" name="qtype" value="4"><label for="qnatype3">�Ź߰�����</label>
                                        
                  <input type="radio" id="qnatype4" name="qtype" value="5"><label for="qnatype4">������</label>                 
             </div>
          </td>
       </tr>
    <tr>
        <th>����</th>
             <td>
             <input type="text" class="text" name="title" style="width:395px" maxlength="50">
             <span class="fc_type4">(50�� �̳�)</span>
             </td>
    </tr>	
    <tr>
     <th>����</th>
        <td><textarea class="text" name="content"></textarea></td>
      </tr>
      </tbody>
    </table>
   </div>
   <!-- Modal footer -->
        <div class="modal-footer">
        <button type="submit" class="btn_mType1" >���</button>
        <button type="button" class="btn_mType3" data-dismiss="modal">�ݱ�</button>
        </div>
 </form>
        </div>
        
        
    </div>
  </div>
  </div>
  </div>
  </div>
  <div class="info_box4" id="info_box4">
					<ul class="clearfix detail_tab" style="width:65%;">
						<li><a href="#info_box1">��ǰ ����</a></li>
						<li><a href="#info_box2">��ǰ �ı� (<span class="reviewCount">${listcount}</span>)
						</a></li>
						<li><a href="#info_box3">��ǰ Q&amp;A (<span
								class="qnaCount">${qavg }</span>)
						</a></li>
						<li class="current"><a href="#info_box4">��� / ��ȯ / ��ǰ /
								AS�ȳ�</a></li>
					</ul>



					<div class="as_info_area grid-box">
						<div class="grid-row">
							<section class="as_info_section grid-2 no_line_left">
								<h2 class="tit_type1 ico_trans">
									<strong class="fc_type1">���</strong>�ȳ�
								</h2>
								<div>
									<h3>��ۺ�</h3>
									<ul class="list_type1">
										<li>2���� �̸� ���� �� <span class="fc_type2">2500��</span></li>
										<li>2���� �̻� ���� �� <span class="fc_type2">���׹���</span> (���ֵ� ��
											��Ÿ ������ �߰����� ����)
										</li>
									</ul>
								</div>
								<div>
									<h3>��� �����</h3>
									<ul class="list_type1">
										<li>���� 4�� ���� �ֹ� ���� ���˴ϴ�. (<span class="fc_type2">�¶���
												�߼�</span>�� ����)
										</li>
										<li>���� �Ϸ� �� ��� 2�� �ҿ�˴ϴ�. (�ָ� �� ������ ����)</li>
										<li>�ù���� ������ ���� �ټ� ������ �� �ֽ��ϴ�. (������� 1588-1255)</li>
										<li>�������� ���� �߼��� <span class="fc_type2">2~3�� �� �ҿ�</span>��
											�� �ֽ��ϴ�.
										</li>
									</ul>
								</div>
							</section>


							<section class="as_info_section grid-2 positR">
								<h2 class="tit_type1 ico_change">
									��.�������� ��ȯ / ��ǰ(ȯ��) / AS <strong class="fc_type1">���ռ���</strong>
								</h2>
								<div>
									<h3>ABC-MART�� �¶��Τ��������� ���� ���� ���� ��ȯ/��ǰ/AS ������ �����մϴ�.</h3>
									<ul class="list_type1">
										<li>��ȯ�� ������ ��ȯ�� �����մϴ�.</li>
										<li>���忡 �湮�Ͽ� �����Ͻø� �ù�� �����Դϴ�.</li>
										<li>���忡 �湮�Ͽ� �����Ͻ� ��� ���ų������� �����Ͽ� �ֽñ� �ٶ��ϴ�.</li>
										<li>���忡�� ��ǰ ���� �Ͻ� ��� ȯ���� �¶��� ����� Ȯ�� �� ó���˴ϴ�.<br>(Ȯ��
											�Ⱓ 2-3�� �ҿ� / �����Ͻ� ������������ ȯ��)
										</li>
									</ul>
								</div>
								<a href="/abc/customer/sortAreaList"
									class="btn_sType1 mt20 ml10">�������θ��� Ȯ���ϱ�<i
									class="ico_arrow_left"></i></a>
							</section>
						</div>
						<div class="grid-row">
							<section class="as_info_section grid-2 no_line_left pt40">
								<h2 class="tit_type1 ico_memo">
									��ȯ����ǰ(ȯ��) ���� �� <strong class="fc_type1">���ǻ���</strong>
								</h2>
								<div class="mt15">
									<ul class="basic_list_type">
										<li>- ��ǰ�� ������ ������ 7�� �̳�(��ǰ�ҷ��� ��� 30��)�� �������ֽñ� �ٶ��ϴ�.</li>
										<li>- ���� �� �պ� �ù�� �ΰ��˴ϴ�. <br>&nbsp;&nbsp;(��, ��ǰ �ҷ�,
											������� ��� �ù�� ȯ���ص帳�ϴ�.)
										</li>
										<li>- ���� �� 14�� �̳��� ��ǰ�� ��ǰ���� �������� ���� ��� ������ ��ҵ˴ϴ�.<br>&nbsp;&nbsp;(���
											���� ����)
										</li>
									</ul>
								</div>
								<div>
									<h3>
										��ȯ/��ǰ(ȯ��)�� <span class="fc_type2">�Ұ�����</span> ���
									</h3>
									<ul class="list_type1">
										<li>�Ź�/�Ƿ��� �ܺο��� ������ ���</li>
										<li>��ǰ�� �Ѽյ� ���</li>
										<li>��ǰ�� �پ��ִ� ��(Tag)�� �н�/�Ѽ��� ���</li>
										<li>�귣�� �ڽ� �н�/�Ѽյ� ���</li>
									</ul>
								</div>
								<div>
									<h3>��ȯ/��ǰ(ȯ��) �� �ڽ� ���� ��</h3>
									<p class="list_type1">�귣�� �ڽ��� �Ѽ��� ������ �ù� �ڽ� �� Ÿ �ڽ��� �����Ͽ�
										�߼����ֽñ� �ٶ��ϴ�.</p>
									<div class="clearfix mt20">
										<figure class="fl-l packing_info1">
											<img
												src="http://image.abcmart.co.kr/nexti/images/abcmart_new/img_box01.jpg"
												alt="">
											<figcaption>
												<strong>�ùٸ� �ڽ����� ��</strong>
												<!-- <p>��ǰ�귣�� �ڽ��� �Ѽ��� ������ �ù� �ڽ� �� Ÿ �ڽ��� �����մϴ�.</p> -->
											</figcaption>
										</figure>
										<figure class="fl-l packing_info2">
											<img
												src="http://image.abcmart.co.kr/nexti/images/abcmart_new/img_box02.jpg"
												alt="">
											<figcaption>
												<strong>��ȯ/ȯ���� <span class="fc_type2">�Ұ��� ���</span></strong>
												<!-- <p>��ǰ�귣�� �ڽ��� �Ѽ��� ������ �ù� �ڽ� �� Ÿ �ڽ��� �����մϴ�.</p>
                            <p>�귣�� �ڽ��� �������� ������� �� ������ ���� �ڽ� �Ѽս� ��ȯ/ȯ���� �Ұ��� �մϴ�.</p>
                            <p>��ǰ �귣�� �ڽ� �Ѽ� �� �н� �� ��ǰ�� �߼۵Ǿ��� ��� ��ȯ/ȯ���� �Ұ��� �մϴ�.</p> -->
											</figcaption>
										</figure>
									</div>
								</div>
							</section>

							<section class="as_info_section grid-2 pt40 positR">
								<h2 class="tit_type1 ico_chat">
									<strong class="fc_type1">��ȯ����ǰ</strong>(ȯ��) ���
								</h2>
								<div>
									<h3>��ȯ/��ǰ(ȯ��) ó�� ����</h3>
									<ul class="step_box">
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">01.</span> ��ǰ/��ȯ ����
												</dt>
												<dd>�¶��� ���θ��� �α��� �� ���� ������ &gt; ���γ��� &gt; ��ǰ/��ȯ/AS &gt;
													��ǰ/��ȯ ��û</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">02.</span> �����Ϸ�
												</dt>
												<dd>���������� &gt; ���γ��� &gt; ��ǰ/��ȯ/AS &gt; ��ǰ��Ȳ �Ǵ� ��ȯ ��Ȳ
													&gt; ����Ȯ�� ���� Ȯ��</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">03.</span> ABC-MART�� ��ǰ �߼�
												</dt>
												<dd>�ּ� : ��⵵ ��õ�� �𰡸� ��Ƿ�579���� 39 2�� ABC-MART �¶��� ��������</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">04.</span> ABC-MART�� ��ǰ����
												</dt>
												<dd>��ȯ : ��ȯ�߼� / ��ǰ : ȯ��ó�� �� ȯ�ҿϷ�</dd>
												<dd>������(ī��, ����) ������ ���� 3~4�� �� ȯ��Ȯ�� ����</dd>
											</dl>
										</li>
									</ul>
								</div>
								<div class="pt10">
									<h3>��ȯ/��ǰ(ȯ��) ��ۺ� �ȳ�</h3>
									<ul class="list_type1">
										<li>�պ� �ù�� : ���� ��ۺ� (2500��) + ��ǰ ��ۺ�(2500��) = �� 5,000�� ��
											�ΰ��˴ϴ�. <br>(������ �Ǵ� ȯ�ұݾ׿��� ���� ����)
										</li>
										<li>��, �����ֽ� ��ǰ�� <span class="fc_type1">�ҷ� �Ǵ� �����</span>����
											Ȯ�� �� ��� �ù�� ȯ���ص帳�ϴ�. <br>(�����Ͻ� ������������ �ù�� ȯ��)
										</li>
										<li>�����ù�(�������) �� Ÿ�ù� �̿� �� �߰��� �߻��Ǵ� �ݾ��� ���Բ��� �δ����ּž� �մϴ�.</li>
									</ul>
									<p class="add_info mt15 fs12">
										�� ������� �ڵ� ȸ������ ��� : ��ȯ/��ǰ ���� �� ����ó�� �¶������� ���� �� <span>ȸ������
											������</span>
									</p>
								</div>
								<a href="/abc/mypage/returnServiceRequest" class="btn_sType2"
									target="_blank">��ȯ/��ǰ(ȯ��) ��û</a>
							</section>
						</div>



						<div class="grid-row">
							<section class="as_info_section2">
								<h2 class="tit_type1 ico_alim mb15">
									<strong class="fc_type1">AS�Ұ�</strong>�ȳ�
								</h2>
								<div class="grid-box">
									<div>&nbsp;- ������ ��ȭ �������� �߻��� ���� ������ A/S ���� �Ұ��մϴ�.</div>

									<div>
										<br> &nbsp;- �Ź� ��Ź���� ���� �̿��� ���� �� ������ �Ұ��մϴ�.
									</div>

									<div>
										<br> &nbsp;- �縻����� ���� �����ֺ� ��Ǯ������ ���ǰ� �Ұ��մϴ�.
									</div>

								</div>
							</section>
						</div>


						<div>
							<section class="as_info_section2 positR">
								<h2 class="tit_type1 ico_as">
									<strong class="fc_type1">AS(����/����)</strong> ���
								</h2>
								<ul class="basic_list_type mt15">
									<li>- �������� ���忡���� ���� �����մϴ�. (���� �湮 ���� �� �ù�� ����)</li>
									<li>- �ܺ� ��ȭ �� �߰ߵ� ��ǰ �̻� ���� ����/���� ��û�� �¶��� ���θ� ����
										������&gt;��ǰ/��ȯ/AS �Ǵ� �����͸� ���� �������ֽñ� �ٶ��ϴ�.</li>
									<li>- ���� ���� ��ǰ�� ABC-MART�� ������ ��� Ȯ���� ����� �ݼ۵ǰų� ó���� �ʾ��� ��
										�ֽ��ϴ�.</li>
									<li>- ���� �Ϸ� �� 15�� �̳� ��ǰ �������� ���� ��� ������ ��� �˴ϴ�.</li>
									<li>- ���忡�� �����Ͻ� ��ǰ�� ó�������� ����������&gt;��ǰ/��ȯ/AS ���� Ȯ�� �� ��
										�ֽ��ϴ�.(����� ȸ���� ����)</li>
								</ul>
								<a href="/abc/mypage/reqOnlnAsList" class="btn_sType2">AS ��û</a>

								<div class="clearfix" style="margin-left:20%;">
									<section class="as_box1 positR fl-l">
										<h3>���� AS</h3>
										<ul class="list_type1">
											<li>������ ���ϴ� ������ �ڼ��ϰ�(���� ÷�� ����) �������ָ� ó�� �� ������ �� �� �ֽ��ϴ�.</li>
											<li>���� ���� �� �պ� �ù��(5000��)�� �ΰ��˴ϴ�.</li>
											<li>�����ù�(�������) �� Ÿ�ù� �̿� �� �߰��� �߻��Ǵ� �ݾ��� ���Բ��� �δ����ּž� �մϴ�.</li>
										</ul>

										<a
											href="/abc/customer/faqList?parentDepth=0004&amp;depth=000403"
											class="btn_sType1 mt15 ml10">���������� �ڼ��� ����<i
											class="ico_arrow_left"></i></a>

										<ul class="step_box">
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">01.</span> AS ����
													</dt>
													<dd>
														�¶��� ���θ��� �α��� ���� ������ &gt; ���γ��� &gt; ��ǰ/��ȯ/AS �Ǵ�<br>�����͸�
														���� ���� &gt; AS��û (1588-9667 / 080-701-7770)
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">02.</span> �����Ϸ�
													</dt>
													<dd>���������� &gt; ���γ��� &gt; ��ǰ/��ȯ/AS &gt; AS��û &gt; ����Ȯ��
														���� Ȯ��</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">03.</span> ABC-MART�� ��ǰ
														�߼�
													</dt>
													<dd>
														�ּ� : ����Ư���� �߱� ������ 100, B�� 21��(������ 2��, ���ο���) ABCMART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�¶���
														AS����� ��
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">04.</span> ABC-MART�� ��ǰ����
														�귣��� �Ǵ� ������ü ����
													</dt>
													<dd>���� �Ⱓ�� �� 2�� ���� �ҿ� / ���� �Ϸ� �� ���� ���� �뺸</dd>
													<dd>(���� ���뿡 ���� ���� ����� û���� �� �ֽ��ϴ�.)</dd>
												</dl>
											</li>
										</ul>
									</section>

		<section class="as_box2 fl-l">
		<h3>���� AS</h3>
		<ul class="list_type1">
			<li>�ҷ����� Ȯ�εǴ� ������ �ڼ��ϰ�(���� ÷�� ����) �������ֽø� ó�� �� ������ �� ��
						�ֽ��ϴ�.</li>
					<li>��ǰ �ҷ����� ���� ���� ���� �� �պ� �ù��� ABC-MART���� �δ��մϴ�. <br>
												(������� �ù� �̿� ����)
				</li>
			</ul>

			<ul class="step_box">
						<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">01.</span> AS ����
													</dt>
													<dd>
														�¶��� ���θ��� �α��� ���� ������ &gt; ���γ��� &gt; ��ǰ/��ȯ/AS �Ǵ�<br>�����͸�
														���� ���� &gt; AS��û (1588-9667 / 080-701-7770)
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">02.</span> �����Ϸ�
													</dt>
													<dd>���������� &gt; ���γ��� &gt; ��ǰ/��ȯ/AS &gt; AS��û &gt; ����Ȯ��
														���� Ȯ��</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">03.</span> ABC-MART�� ��ǰ
														�߼�
													</dt>
													<dd>
														�ּ� : ����Ư���� �߱� ������ 100, B�� 21��(������ 2��, ���ο���) ABCMART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�¶���
														AS����� ��
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">04.</span> ABC-MART�� ��ǰ����
														�귣��� �Ǵ� ������ü ����
													</dt>
													<dd>���� �Ⱓ�� �� 2�� ���� �ҿ� / ��� Ȯ�� �� ���� ���� �뺸</dd>
													<dd>�ҷ� ���� �� ���� ��ȯ �Ǵ� ȯ�� ó�� / �ҷ��� �ƴ� ��� ���� �ȳ� �� ��ǰ �ݼ�</dd>
													<dd>(2�� ���� ���� ����)</dd>
												</dl>
											</li>
										</ul>
									</section>
								</div>
							</section>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>
 
</body>
</html>