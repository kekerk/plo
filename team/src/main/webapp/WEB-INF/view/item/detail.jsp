<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 상세 보기</title>
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


		// 장바구니 버튼 클릭 시 호출 메소드(사용하지 않는 경우 삭제)
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
		 alert("멤버십 회원만 구매 가능한 상품입니다.\n로그인 후 이용하시기 바랍니다.");
         var redirectUrl = location.href;
         location.href = '/abc/login/form?redirectUrl=' + redirectUrl;
    }

   if(dscntUserGbnCode == "CM"){
         alert("멤버십 회원만 구매 가능한 상품입니다.\n멤버십 회원으로 전환 후 구매해주시기 바랍니다.");
         location.href = '/abc/user/memberShipAgreement?mode=change';
    }
	   
    if(dscntUserGbnCode == "U"){
         alert("ABC마트 회원만 구매 가능한 상품입니다.\n로그인 후 이용하시기 바랍니다.");
         var redirectUrl = location.href;
         location.href = '/abc/login/form?redirectUrl=' + redirectUrl;
    }    
	   
    
    //$("body").rightClick( function(e) {});
    
    
    // 쿠폰조회
    $(".smart_calculate > a").click(function(e){
        if(isLogin == 'true'){
            getPrdtCouponList($(this), masterPrdtCode);
            $(this).addClass('on');
            $(this).next(".list_drop_down").addClass("on");
            $(this).closest('tr').siblings('tr').find("a").removeClass('on');
            $(this).closest('tr').siblings('tr').find(".list_drop_down").removeClass('on');
        }else{
            alert("로그인 시 쿠폰할인 및 포인트 등의 혜택이 있습니다.");
        }
    });
    
    // 상품쿠폰 조회후 쿠폰클릭
    $("#findProductCoupon").on("click", "a.dscntCpn", function(){
        // 리스트숨김
        $(".ico_close").closest('.list_drop_down').removeClass('on').siblings('a').removeClass('on');
        
        $('input[name="selectedNormalCpnUserCpnSeq"]').val($(this).find("input[name='userCpnSeq']").val());
        
        var newUserCpnSeq = $(this).find("input[name='userCpnSeq']").val();
        
        //쿠폰할인율 체크를위한 함수호출
        selectCoupon(newUserCpnSeq, masterPrdtCode, 1);
    });
    
    // 추가쿠폰 조회후 쿠폰클릭
    $("#findAddCoupon").on("click", "a.dscntCpn", function(){
        // 리스트숨김
        $(".ico_close").closest('.list_drop_down').removeClass('on').siblings('a').removeClass('on');
        
        $('input[name="selectedDoubleCpnUserCpnSeq"]').val($(this).find("input[name='userCpnSeq']").val());
        
        var newUserCpnSeq = $(this).find("input[name='userCpnSeq']").val();
        
        selectCoupon(newUserCpnSeq, masterPrdtCode, 1);
    });
    
    // 배송비쿠폰 조회후 쿠폰클릭
    $("#findDeliveryCoupon").on("click", "a.dscntCpn", function(){
        // 리스트숨김
        $(".ico_close").closest('.list_drop_down').removeClass('on').siblings('a').removeClass('on');
    });
    
    
    // 정상상품일경우의 사이즈   마우스 오버 효과
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
    // 장바구니list add
    cartList.productDataSetting(prdtCode, optnId, optnValue, prdtKorName, dscntSellPrice, soldoutYn);
}

function optionClickForToolbar(obj){
    $(obj).toggleClass('on');
    $(obj).next(".list_drop_down").toggleClass("on");
    
    // 하단의 관련용품셀렉트박스가 열려있다면 닫아준다
    if($(obj).parent().parent().parent().parent().find(".rltnSelectBox").hasClass("on")){
        $(obj).parent().parent().parent().parent().find(".rltnSelectBox").trigger("click");
    }
}


//rltnSelectBox
function rltnPrdtListClick(obj){
    $(obj).toggleClass('on');
    $(obj).next(".relationGoodsList").toggleClass("on");
    
    // 가장 상위 셀렉트박스가 닫힐때 안에 레이어팝업도 OFF해준다
    if(!$(obj).next(".relationGoodsList").hasClass("on")){
        $(obj).next(".relationGoodsList").find(".add_prd_layer").removeClass("on");
        return;
    }
}


function rltnOptionLayerOpen(thisObj, rltnPrdtCode, prdtEngName, rltnDscntSellPrice){
    var obj = $(thisObj).parent().parent().find(".add_prd_layer"); // 옵션리스트레이어가 보여질 div영역
    
    if(!$(obj).hasClass("on")){
        // 관련용품의 옵션데이터 GET
        cartList.productOptionPopup(rltnDscntSellPrice, prdtEngName, rltnPrdtCode, obj);
        
        // 기존 레이어팝업 다 닫기
        $(thisObj).parent().parent().parent().find(".add_prd_layer").removeClass("on");
        
        // 클릭한거만 열기
        $(obj).addClass('on');
        
    }else{
        // 옵션선택 한번 더 누르면 닫기
        $(obj).removeClass('on');
    }
}


function rltnOptionLayerSelectBoxOpen(obj){
    $(obj).toggleClass('on');
    $(obj).next(".add_prd_list").toggleClass("on");
}


function rltnOptionLayerComplete(obj){
    var optnValueObj = $(obj).parent().parent().find(".optionSelectBox"); // 선택된 데이터를 갖고있는 놈

    var prdtCode = $(optnValueObj).attr("prdtCode");             // 상품코드
    var prdtKorName = $(optnValueObj).attr("prdtKorName");       // 상품명
    var dscntSellPrice = $(optnValueObj).attr("dscntSellPrice"); // 할인가
    var soldoutYn = $(optnValueObj).attr("optnLaveCount") <= 0 ? true : false; // 품절여부
    var optnId = $(optnValueObj).attr("optnId");           // 옵션아이디
    var optnValue = $(optnValueObj).attr("optnValue");     // 옵션값
    
    if (isEmpty(optnValue) || isEmpty(optnId)) {
        alert("옵션는(은) 생략할 수 없습니다.");
    } else {
        // 장바구니list add
        cartList.productDataSetting(prdtCode, optnId, optnValue, prdtKorName, dscntSellPrice, soldoutYn);

        // 가장바깥select박스용 a링크 trigger
        $(obj).parent().parent().parent().parent().parent().parent().find(".rltnSelectBox").trigger("click");
    }
}


function rltnOptionLayerClose(obj){
    $(obj).closest('.add_prd_layer').removeClass('on');
}


function rltnOptionLayerSelectBoxSelected(obj, prdtCode, prdtKorName, dscntSellPrice, optnLaveCount, optnId, optnValue){
    var selectboxObj = $(obj).parent().parent().parent().find(".optionSelectBox");
    
    
    // 고객이 선택한 값을 셀렉트박스상단에 고정시켜준 후,
    $(selectboxObj).html(optnValue + "<span class='ico_arrow1'></span>");
    // 셀렉트박스 닫아준다.
    $(selectboxObj).toggleClass('on');
    $(selectboxObj).next(".add_prd_list").toggleClass("on");
}

//$(".smart_calculate").on("click", ".ico_close", function(){
function closeCouponLayerPopup(obj){
    $(obj).closest('.list_drop_down').removeClass('on').siblings('a').removeClass('on');
}


var cartList = {
        // 상품코드
        prdtCode : null,
        
        // 옵션아이디
        optnId : null,
        
        // 옵션값
        optnValue : null,
        
        // 상품명
        prdtName : null,
        
        // 판매가
        prdtPrice : null,
        
        // 장바구니 리스트 인덱스
        liIndex : $('#prdtList li:visible').length,
        
        // [툴바용] 마스터상품 selectbox 이벤트
        productDataSettingForToolBar : function(prdtCode, optnId, optnValue, prdtName, prdtPrice, soldoutYn){
            cartList.productDataSetting(prdtCode, optnId, optnValue, prdtName, prdtPrice, soldoutYn);
            // selectbox 닫아주기
            $(".toolBarMasterPrdtSelect > a").trigger("click");
        },
        
        // 상품데이터 세팅 [마스터상품의 옵션선택 , 관련용품의 옵션선택시 작동]
        productDataSetting : function(prdtCode, optnId, optnValue, prdtName, prdtPrice, soldoutYn){
            if(!prdtCode || !optnId || !optnValue || !prdtName || !prdtPrice){ return; }
            if(soldoutYn == "true"){ alert("품절된 상품입니다."); return; }
            
            cartList.prdtCode = prdtCode;       // 상품코드
            cartList.optnId = optnId;           // 옵션아이디
            cartList.optnValue = optnValue;     // 옵션값
            cartList.prdtName = prdtName;       // 상품명
            cartList.prdtPrice = prdtPrice;     // 상품가격
            
            // 상품 유효성 검사
            var result = cartList.productValidation(prdtCode, optnId);
            if(!result){ return; }
            
            // 장바구니리스트 add
            cartList.productAdd();
        },
        
        // 상품담기
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
            html.push(                  price_format(cartList.prdtPrice) + "</span>원");
            html.push("                <a href='javascript:cartList.productRemove("+cartList.liIndex+");' class='ico_delete'>삭제</a>");
            html.push("            </p>");
            html.push("        </div>");
            html.push("    </div>");
            html.push("</li>");
        
            $(".prdtList").append(html.join(""));
            $(".prdtList").find(".no_data").hide(); // 선택한 옵션이 없습니다 숨김(툴바에만존재)
            
            // css때문에 넣음
            if(!$('.borderTopDisplay').is(":visible")){
                $(".borderTopDisplay").show(); // 장바구니 구매예정 박스 show
            }
            
            // 데이터용 hidden값 [하나만 생성해야하므로]
            var dataHtml = [];
            dataHtml.push("<input type='hidden' name='prdtCodes' value='"+ cartList.prdtCode +"'>");
            dataHtml.push("<input type='hidden' name='optnIds' value='"+ cartList.optnId +"'>");
            dataHtml.push("<input type='hidden' name='prdtPrices' value='"+ cartList.prdtPrice +"'>");
            dataHtml.push("<input type='hidden' name='prdtCounts' value='1'>");
            dataHtml.push("<input type='hidden' name='prdtCodeOptnIdStr' value='"+cartList.prdtCode + cartList.optnId+"'>"); 
            $("#prdtList").find("."+cartList.liIndex).append(dataHtml.join(""));
            
            cartList.liIndex++;
            
            // 총결제금액 계산
            cartList.productTotalAmt();
        },
        
        // 상품삭제
        productRemove : function(liIndex){
            $("."+liIndex).remove();
            
            // 총결제금액 계산
            cartList.productTotalAmt();
            
            if($('#prdtList li:visible').length == 0){
                $(".prdtList").find(".no_data").show(); // 선택한 옵션이 없습니다 보임
                
                // css때문에 넣음 (위에 선 안보이게하려고...)
                if($('.borderTopDisplay').is(":visible")){
                    $(".borderTopDisplay").hide(); // 장바구니 구매예정 박스 hide
                }
            }
            
        },
        
        // 상품수량변경
        productCountUpDown : function(strObj, liIndex, arrowObj){
            var thisObj = $("#prdtList").find("."+liIndex).find("input[name='prdtCounts']"); 
            var nowBuyCount = $(thisObj).val(); // 현재 수량
            
            if (strObj == "UP") {
                $(thisObj).val(parseInt(nowBuyCount) + 1);
            } else if (strObj == "DOWN") {
                if(parseInt(nowBuyCount) - 1 != 0){
                    $(thisObj).val(parseInt(nowBuyCount) - 1);
                }else{
                    return;
                }
            } else { // 입력창에서 직접 수량을 바꾸는경우
                $(thisObj).val($(arrowObj).val());
            }
            
            $(".prdtList").find("."+liIndex).find("input[name='optnBuyCount']").val($(thisObj).val());
            
            // 상품가격 * 상품수량 의 개별금액보여주기
            var unitPrdtPriceObj = $(arrowObj).parent().next(".fl-r").find(".unitPrdtPrice"+ liIndex);
            var unitPrdtPrice = $(unitPrdtPriceObj).attr("prdtPrice")
            $(".unitPrdtPrice"+ liIndex).html(price_format(Number(unitPrdtPrice) * Number($(thisObj).val())));
            
            // 총결제금액 계산
            cartList.productTotalAmt();
        },
        
 
        
        // 총결제금액 계산
        productTotalAmt : function(){
            var totalPrice = 0;
            
            $("input[name='prdtPrices']").each(function(){
                // 상품가격
                var price = Number($(this).val());
                
                // 상품수량
                var prdtCount = $(this).parent().find("input[name='prdtCounts']").val();
                
                // 총 가격
                totalPrice += (price * Number(prdtCount));
            });
            
            // 총 결제금액 보여주기 (상품정보쪽과 툴바에 모두 적용시킨다)
            $("span.totalAmt").html(price_format(totalPrice));
            
            // 총 상품개수 변경해줌
            $(".totalPrdtCount").html(price_format($('#prdtList li:visible').length));
        },
        
        // 상품 유효성검사
        productValidation : function(prdtCode, optnId){
            // 이미 포함된옵션일 경우 [상품코드와 옵션아이디값 모두 확인]
            try{
                $("input[name='prdtCodeOptnIdStr']").each(function(idx, prdtCodeOptnIdStr){
                    if(prdtCode + optnId == $(this).val()){
                        throw prdtCodeOptnIdStr;
                    }
                });
                return true;
            } catch(e){
                alert("이미 존재하는 상품입니다.");
                return false;
            }
        },
    
    isOnGoing : true, // 장바구니담기 연속클릭동작막기위해...
    
    // 장바구니 담기
    addCart : function(){
        // [장바구니담기] 장바구니리스트에 담겨져있는 상품들 정보 반환
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
                alert("옵션을 선택해주세요.");
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
                   		adbay.setMethod('add'); //장바구니에 상품이 추가 될 경우
                    	 
                        if (confirm("해당 상품이 장바구니에 담겼습니다.\n장바구니 페이지로 이동하시겠습니까?")) {
                            document.location.href = "/abc/order/cart";
                        }
                   		
                   		adbay.send();
                    } else {
                        var msg = uniqueMsg(data.errorMessages).join("\n");    //중복 메시지 제거후 개행
                        alert(msg);
                        if(msg.indexOf("모바일 전용 특가 상품입니다.") != -1) {
                            document.location.href = "/abc/promotion/startEvent?eventId=000214";
                        }
                    }
                }
                ,error: function(data) {
                    cartList.isOnGoing = true;
                    alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
                }
            });
        }
    },
    
    // 바로구매
    quickOrder : function(dlvyTypeCode) {
        // [바로구매] 장바구니리스트에 담겨져있는 상품들 정보 반환
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
                alert("옵션을 선택해주세요.");
                cartList.isOnGoing = true;
                return false;
            }
            
            var confirmMsg = "해당 상품만 바로구매 하시겠습니까?";
            if (dlvyTypeCode == "02") {
            	confirmMsg = "선택하신 매장의 재고 유무에 따라\n픽업 준비 기간이 1~5일 소요됩니다.\n\n해당상품을 매장에서 픽업하시겠습니까?";
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
                            var msg = uniqueMsg(data.errorMessages).join("\n");    //중복 메시지 제거후 개행
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
                                                var msg = uniqueMsg(data.errorMessages).join("\n");    //중복 메시지 제거후 개행
                                                alert(msg);
                                                if(msg.indexOf("모바일 전용 특가 상품입니다.") != -1) {
                                                    document.location.href = "/abc/promotion/startEvent?eventId=000214";
                                                }
                                            }
                                        }
                                        ,error: function(data) {
                                            cartList.isOnGoing = true;
                                            alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
                                        }
                                    });
                            	}
                            } else {
                            	alert(msg);
                            }
                            if(msg.indexOf("모바일 전용 특가 상품입니다.") != -1) {
                                document.location.href = "/abc/promotion/startEvent?eventId=000214";
                            }
                        }
                    }
                    ,error: function(data) {
                        cartList.isOnGoing = true;
                        alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
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
        // 비회원 불가
        if(confirm("로그인 이후 이용이 가능합니다.")){
            moveLoginForm();
            return;
        }else{
            return;
        }
    }else{
        // SNS회원 불가
        var userType = "";
        if(userType == 'SNS'){
            alert("재입고 알림 서비스는 온라인, 멤버십 회원만 가능합니다.");
            return;
        }else{
            // 재입고요청레이어팝업 open
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
            alert("사이즈를 선택해주세요.");
            return false;
        }

        if(hpNum1.length <= 2 || hpNum2.length <= 2 || hpNum3.length <= 3) {
            alert("핸드폰 번호를 입력해주세요.");
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
                    alert("재입고 알림 서비스 신청이 완료되었습니다.");
                    clearRininfo();
                    closeLayerPopup();
                    return false;
                } else {
                    alert("동일한 상품의 신청 내역이 존재합니다.");
                    clearRininfo();
                    return false;
                }
            }
            ,error: function(xhr, status, error) {
                alert("시스템 오류가 발생 했습니다. 관리자에게 문의하세요.");
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
								<p class="tit_type1 fs14">상품 만족도</p>
								<p class="tit_type2">
							    ${satavg}
							    <span class="won fs20">%</span>
								</p>
								<p class="tit_type3 mt5">
			<c:if test="${evavg==5}">
			<label for="score1"><span class="score4"><em>★★★★★</em></span></label>
			</c:if>
			<c:if test="${evavg==4}">
			<label for="score1"><span class="score4"><em>★★★★</em></span></label>
			</c:if>
			<c:if test="${evavg==3}">
			<label for="score1"><span class="score4"><em>★★★</em></span></label>
			</c:if>
			<c:if test="${evavg==2}">
			<label for="score1"><span class="score4"><em>★★</em></span></label>
			</c:if>
			<c:if test="${evavg==1}">
			<label for="score1"><span class="score4"><em>★</em></span></label>
			</c:if>
									
									<em class="ml10">${evavg} / 5</em>
								</p>
							</div>

							<div class="appraisal_box">
								<ul class="mt5">

		  <li><strong class="tit_type3">사이즈</strong> 
									
	      <c:choose>
		  <c:when test="${sizeavg==5}">
		    <td class="align-left">정 사이즈에요</td>
		    </c:when>
		    <c:when test="${sizeavg==4}">
		    <td class="align-left">5mm정도 작은것 같아요</td>
		    </c:when>
		    <c:when test="${sizeavg==3}">
		    <td class="align-left">5mm 정도 큰 것 같아요</td>
		    </c:when>
		    <c:when test="${sizeavg==2}">
		    <td class="align-left">10mm 정도 작은 것 같아요</td>
		    </c:when>
		    <c:when test="${sizeavg==1}">
		    <td class="align-left">10mm 정도 큰 것 같아요</td>
		    </c:when>
		</c:choose>

		<li> 
		           <c:if test="${coloravg==5}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면과 같아요</span></li>
                   </c:if>
                   <c:if test="${coloravg==4}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면보다 약간 밝아요</span></li>
                   </c:if>
                   <c:if test="${coloravg==3}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면보다 약간 어두워요</span></li>
                   </c:if>
                   <c:if test="${coloravg==2}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면보다 많이 밝아요</span></li>
                   </c:if>
                   <c:if test="${coloravg==1}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면보다 많이 어두워요</span></li>
                   </c:if>

								</ul>
								<a href="#info_box2" class="btn_sType1">상품후기 바로가기</a>
							</div>
						</div>

					</section>

				</div>

				<div class="detail_box1_right" style="width:55%;">
					<div class="detail_info_area ">
					
						<header class="product_tit clearfix">
							<div class="fl-l mr15">
								<img src="http://image.abcmart.co.kr/nexti/images/abcmart/client/1542/20160908091420710.gif"
									alt="나이키" width="128" height="68" onerror="imageError(this)">
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
								<dt>판매가</dt>
								<dd class="detail_price">
									<div>
										<span class="price" align="left">
										<fmt:formatNumber value="${item.price}" pattern="#,###"/><em class="won">원</em>
										</span>
									</div>

								</dd>
							</dl>
						</section>
						<section class="detail_section">

							<dl>
								<dt>배송비</dt>
								<dd class="mt3" align="left">2,500원</dd>
							</dl>
						</section>
						<section class="detail_section">
							<dl>
								<dt>컬러</dt>
								<span style="margin-left:-40%">${item.color}</span>
								<dd>
								</dd>
							</dl>
						</section>
						<section class="detail_section">
							<dl>
								<dt>사이즈</dt>
								<dd align="left">
								 <select onchange="Selectsize(this.value)" id="addsize"> 
		<option>선택</option><c:forEach var="size" items="${item.size}"><option value="${size.size}">${size.size}</option></c:forEach> 
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

							<li><input type="submit" value="장바구니" class="btn_lType1"></li>
							<li><a href="../item/itemlist.shop" class="btn_lType2">목록</a>
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
						<li class="current"><a href="#info_box1">상품 정보</a></li>
						<li><a href="#info_box2">상품 후기 (<span class="reviewCount">${listcount}</span>)
						</a></li>
						<li><a href="#info_box3">상품 Q&amp;A (<span
								class="qnaCount">${qavg}</span>)
						</a></li>
						<li><a href="#info_box4">배송 / 교환 / 반품 / AS안내</a></li>
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
									<th>성별</th>
									<td>남성</td>

									<th>소재</th>
									<td>상세페이지 참조</td>
								</tr>
								<tr>
									<th>색상</th>
									<td>${item.color }</td>

									<th>치수</th>
									<td>
									<c:forEach var="size" items="${item.size}">
									${size.size} /
									</c:forEach>
									</td>
								</tr>
								<tr>
									<th>굽높이</th>
									<td>상세페이지 참조</td>

									<th>제조자</th>
									<td>상세페이지 참조</td>
								</tr>
								<tr>
									<th>제조국</th>
									<td>인도네시아</td>

									<th>수입자</th>
									<td></td>
								</tr>
								<tr>
									<th>A/S 책임자와 전화번호</th>
									<td>신발팜 A/S 담당자 : 080-701-7770</td>

									<th>제조년월</th>
									<td>상세페이지 참조</td>
								</tr>
								<tr>
									<th>특이사항</th>
									<td></td>

									<th>품질보증기준</th>
									<td>본 제품은 정부 고시 소비자분쟁해결 기준에 의거하여 보상해드립니다. (품질보증기간 : 구입일로부터
										6개월 이내)</td>
								</tr>
								<tr>
									<th>사이즈TIP</th>
									<td></td>

									<th>소재별 관리방법</th>
									<td>가벼운 오염물이 묻었을 때에는 부드러운 솔로 털어내주시기 바랍니다. 물세탁이 되지 않는
										소재입니다. 물에 젖지 않게 해주시기 바라며, 만약 물에 젖었을 때에는 마른 걸레로 닦아주시기 바랍니다. 세탁이
										되지 않는 제품입니다.</td>
								</tr>
							</tbody>
						</table>

					</section>

					<p class="ico_notice">전자상거래 등에서의 상품정보제공 고시에 따라 작성되었습니다.</p>


				</div>

				<div class="info_box2 mt60" id="info_box2">

					<ul class="clearfix detail_tab" style="width:65%;">
						<li><a href="#info_box1">상품 정보</a></li>
						<li class="current"><a href="#info_box2">상품 후기 (<span
								class="reviewCount">${listcount}</span>)
						</a></li>
						<li><a href="#info_box3">상품 Q&amp;A (<span
								class="qnaCount">${qavg }</span>)
						</a></li>
						<li><a href="#info_box4">배송 / 교환 / 반품 / AS안내</a></li>
					</ul>
</from>






					<script>
$(function() {
    // 탭 스위칭
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
									data-type="all">전체(${listcount})</a></li>
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
        if(confirm('상품후기는 마이페이지에서 작성 가능합니다. 마이페이지로 이동하시겠습니까?')) {
            return true;
        }
        return false;
    });

    // 특정 후기글 수정
    $(".btnReviewUpdate").click(function() {
        var prdtRvwSeq = $(this).data('prdt-rvw-seq');
        var prdtCode = '0066398';
        var url = 'http://www.abcmart.co.kr/abc/mypage/updateMyReviewForm?prdtRvwSeq=' + prdtRvwSeq + '&prdtCode=' + prdtCode;
        var options = 'width=718,height=1110,scrollbars=yes';
        window.open(url, 'about:blank', options);
    });

    $('.btnReviewDelete').on('click', function() {
        var prdtRvwSeq = $(this).data('prdt-rvw-seq');
        if(confirm('삭제하시겠습니까?')) {
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
                <th>제목</th>
                <th>사이즈</th>
                <th>상품만족도</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
        </thead>         
           <tbody>
   <c:forEach items="${evlist}" var="e">
		<tr><td class="align-center toggle_btn"><a href="#">${e.title}</a></td>
		<c:choose>
		  <c:when test="${e.size==5}">
		    <td class="align-left">정 사이즈에요</td>
		    </c:when>
		    <c:when test="${e.size==4}">
		    <td class="align-left">5mm정도 작은것 같아요</td>
		    </c:when>
		    <c:when test="${e.size==3}">
		    <td class="align-left">5mm 정도 큰 것 같아요</td>
		    </c:when>
		    <c:when test="${e.size==2}">
		    <td class="align-left">10mm 정도 작은 것 같아요</td>
		    </c:when>
		    <c:when test="${e.size==1}">
		    <td class="align-left">10mm 정도 큰 것 같아요</td>
		    </c:when>
		</c:choose>
			<td style="width:15px;">
			<c:if test="${e.score==5}">
			<label for="score1"><span class="score4"><em>★★★★★</em></span></label>
			</c:if>
			<c:if test="${e.score==4}">
			<label for="score1"><span class="score4"><em>★★★★</em></span></label>
			</c:if>
			<c:if test="${e.score==3}">
			<label for="score1"><span class="score4"><em>★★★</em></span></label>
			</c:if>
			<c:if test="${e.score==2}">
			<label for="score1"><span class="score4"><em>★★</em></span></label>
			</c:if>
			<c:if test="${e.score==1}">
			<label for="score1"><span class="score4"><em>★</em></span></label>
			</c:if>
			</td>
			<td>${e.userid }</td>
			<td><fmt:formatDate pattern="yy-MM-dd" value="${e.registdate}"/></td></tr>
				<tr class="more_viewBox">
                    <td colspan="5">
                       <div class="more_txt">
                       <ul class="clearfix">
                   <c:if test="${e.satisfy==5 }">
                   <li><strong>상품 만족도</strong>
                   <span>아주 만족해요</span></li>
                   </c:if>
                   <c:if test="${e.satisfy==4}">
                   <li><strong>상품 만족도</strong>
                   <span>만족해요</span></li>
                   </c:if>
                   <c:if test="${e.satisfy==3 }">
                   <li><strong>상품 만족도</strong>
                   <span>보통이에요</span></li>
                   </c:if>
                   <c:if test="${e.satisfy==2 }">
                   <li><strong>상품 만족도</strong>
                   <span>별로에요</span></li>
                   </c:if>
                   <c:if test="${e.satisfy==1 }">
                   <li><strong>상품 만족도</strong>
                   <span>리얼 별루다</span></li>
                   </c:if>
                   
                   
                   <c:if test="${e.size==5}">
                   <li><strong class="tit_type3">사이즈</strong>
                   <span>정 사이즈에요</span></li>
                   </c:if>
                   <c:if test="${e.size==4}">
                   <li><strong class="tit_type3">사이즈</strong>
                   <span>5mm정도 작은것 같아요</span></li>
                   </c:if>
                   <c:if test="${e.size==3}">
                   <li><strong class="tit_type3">사이즈</strong>
                   <span>5mm정도 큰 것 같아요</span></li>
                   </c:if>
                   <c:if test="${e.size==2}">
                   <li><strong class="tit_type3">사이즈</strong>
                   <span>10mm정도 작은 것 같아요</span></li>
                   </c:if>
                   <c:if test="${e.size==1}">
                   <li><strong class="tit_type3">사이즈</strong>
                   <span>10mm정도 큰 것 같아요</span></li>
                   </c:if>
                   
                   <c:if test="${e.color==5}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면과 같아요</span></li>
                   </c:if>
                   <c:if test="${e.color==4}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면보다 약간 밝아요</span></li>
                   </c:if>
                   <c:if test="${e.color==3}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면보다 약간 어두워요</span></li>
                   </c:if>
                   <c:if test="${e.color==2}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면보다 많이 밝아요</span></li>
                   </c:if>
                   <c:if test="${e.color==1}">
                   <li><strong class="tit_type3">색상</strong>
                   <span>화면보다 많이 어두워요</span></li>
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
    <a href="../board/eval.shop?itemno=${item.itemno}" class="btn_mType1">상품후기 작성</a>
</div>
        </div>

						</section>
					</div>
				</div>

				<div class="info_box3" id="info_box3">

					<ul class="clearfix detail_tab" style="width:65%;">
						<li><a href="#info_box1">상품 정보</a></li>
						<li><a href="#info_box2">상품 후기 (<span class="reviewCount">${listcount}</span>)
						</a></li>
						<li class="current"><a href="#info_box3">상품 Q&amp;A (<span
								class="qnaCount">${qavg}</span>)
						</a></li>
						<li><a href="#info_box4">배송 / 교환 / 반품 / AS안내</a></li>
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
        if (confirm('수정하시겠습니까?')) {
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
        if (confirm('삭제하시겠습니까?')) {
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
                        alert("삭제되었습니다.");
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
                    alert("시스템 오류가 발생 했습니다. 관리자에게 문의하세요.");
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
    alert('로그인이 필요한 기능입니다.');
    //로그인 유효성
    var redirectUrl = location.href;
    location.href = '/user/login.shop'
}

</script>
	<div class="qna_area">
	<section class="list_area">
	<ul class="list_type1">
	<li>단순 상품비방, 상업적인 내용, 미풍양속 위반, 게시판의 성격에 맞지 않는 글은 통보 없이 삭제될
		수 있습니다.</li>
	<li>오프라인 매장 재고현황 문의는 <span class="fc_type2">‘전국오프라인매장’</span>
			정보를 참고하시어 해당 매장으로 문의하시면 좀 더 정확한 확인이 가능합니다.
	</li>
	<li>주문/배송/반품 및 AS 등 기타 문의는 <span class="fc_type2">1:1
			상담문의(마이페이지&gt;쇼핑수첩&gt;나의상담)</span>에 남겨주시기 바랍니다.<br> (상품 자체에 대한
		문의가 아닌 주문/배송/반품 및 AS 등의 기타문의를 작성하실 경우 나의상담 메뉴로 글이 이동될 수 있습니다.)
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
			<th>답변상태</th>
			<th>문의유형</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
	</tr>
</thead>
<tbody>
	<tr class="group-center">
<c:if test="${qavg==0}">
	<td colspan="5">작성된 상품 Q&amp;A가 없습니다.</td>
</c:if>
	<c:forEach items="${qlist}" var="q">
		<tr class="group-center">
		<c:if test="${!empty q.answer}">
		<td><span class="fc_type2">답변완료</span></td>
		</c:if>
		<c:if test="${empty q.answer}">
		<td><span class="fc_type2"><font style="font-color:black;">답변예정</font></span></td>
		</c:if>
	<c:choose>
		  <c:when test="${q.qtype==5}">
		    <td class="align-center"><font style="font-weight:bold;">사이즈</font></td>
		    </c:when>
		    <c:when test="${q.qtype==4}">
		    <td class="align-center"><font style="font-weight:bold;">신발관리법</font></td>
		    </c:when>
		    <c:when test="${q.qtype==3}">
		    <td class="align-center"><font style="font-weight:bold;">입고문의</font></td>
		    </c:when>
		    <c:when test="${q.qtype==2}">
		    <td class="align-center"><font style="font-weight:bold;">가격</font></td>
		    </c:when>
		    <c:when test="${q.qtype==1}">
		    <td class="align-center"><font style="font-weight:bold;">상품검색</font></td>
		    </c:when>
		</c:choose>
		<td class="align-center qna_btn"><a href="#">${q.title}</a></td>
			<td>${q.userid }</td>
			<td><fmt:formatDate pattern="yy-MM-dd" value="${q.regidate}"/></td></tr>
   <tr class="qna_answer_box">
      <td colspan="5">
        <div class="quest_box clearfix positR">
           <span class="ico_quest fl-l">질문</span>
             <div class="quest_txt">
                <section class="qna_txtsection align-center">
                   ${q.content }<br>
       </section>
                                            
</div>
  </div>
                                    
  <div class="answer_box clearfix">
    <span class="ico_answer fl-l">답변</span> 
      <div class="answer_txt align-center">${q.answer}</div>
         </div>
         <c:if test="${loginUser.userId == 'admin' }">
           <a href="#" class="btn_mType1" style="align:right;" data-toggle="modal" data-target="#myModal2"> 
										<span class="tooltip_type1">답변</span></a></c:if>                         
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
          <h2>상품 답변 작성</h2>
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
                    <span>${item.price }<span>원</span></span>
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
              <th>문의유형</th>
          <c:choose>
		  <c:when test="${q.qtype==5}">
		    <td class="align-center"><font style="font-weight:bold;">사이즈</font></td>
		    </c:when>
		    <c:when test="${q.qtype==4}">
		    <td class="align-center"><font style="font-weight:bold;">신발관리법</font></td>
		    </c:when>
		    <c:when test="${q.qtype==3}">
		    <td class="align-center"><font style="font-weight:bold;">입고문의</font></td>
		    </c:when>
		    <c:when test="${q.qtype==2}">
		    <td class="align-center"><font style="font-weight:bold;">가격</font></td>
		    </c:when>
		    <c:when test="${q.qtype==1}">
		    <td class="align-center"><font style="font-weight:bold;">상품검색</font></td>
		    </c:when>
		</c:choose>
       </tr>
    <tr>
        <th>제목</th>
             <td>
             <input type="text" class="text" name="title" style="width:395px" maxlength="50" value="${q.title}" readonly="readonly">
             <span class="fc_type4"></span>
             </td>
    </tr>	
    <tr>
     <th>내용</th>
        <td><textarea class="text" name="answer"></textarea></td>
      </tr>
      </c:forEach>
      </tbody>
    </table>
   </div>
   <!-- Modal footer -->
        <div class="modal-footer">
        <button type="submit" class="btn_mType1" >등록</button>
        <button type="button" class="btn_mType3" data-dismiss="modal">닫기</button>
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
										<span class="tooltip_type1">Q&amp;A 작성</span>
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
          <h2>상품 Q&amp;A 작성</h2>
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
                    <span>${item.price }<span>원</span></span>
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
              <th>문의유형</th>
              <td>
             <div class="qnatype">
                 <input type="radio" id="qnatype0" name="qtype" value="1" checked=""><label for="qnatype0">상품검색</label>
                                        
                 <input type="radio" id="qnatype1" name="qtype" value="2"><label for="qnatype1">가격</label>
                                        
                 <input type="radio" id="qnatype2" name="qtype" value="3"><label for="qnatype2">입고문의</label>
                                        
                  <input type="radio" id="qnatype3" name="qtype" value="4"><label for="qnatype3">신발관리법</label>
                                        
                  <input type="radio" id="qnatype4" name="qtype" value="5"><label for="qnatype4">사이즈</label>                 
             </div>
          </td>
       </tr>
    <tr>
        <th>제목</th>
             <td>
             <input type="text" class="text" name="title" style="width:395px" maxlength="50">
             <span class="fc_type4">(50자 이내)</span>
             </td>
    </tr>	
    <tr>
     <th>내용</th>
        <td><textarea class="text" name="content"></textarea></td>
      </tr>
      </tbody>
    </table>
   </div>
   <!-- Modal footer -->
        <div class="modal-footer">
        <button type="submit" class="btn_mType1" >등록</button>
        <button type="button" class="btn_mType3" data-dismiss="modal">닫기</button>
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
						<li><a href="#info_box1">상품 정보</a></li>
						<li><a href="#info_box2">상품 후기 (<span class="reviewCount">${listcount}</span>)
						</a></li>
						<li><a href="#info_box3">상품 Q&amp;A (<span
								class="qnaCount">${qavg }</span>)
						</a></li>
						<li class="current"><a href="#info_box4">배송 / 교환 / 반품 /
								AS안내</a></li>
					</ul>



					<div class="as_info_area grid-box">
						<div class="grid-row">
							<section class="as_info_section grid-2 no_line_left">
								<h2 class="tit_type1 ico_trans">
									<strong class="fc_type1">배송</strong>안내
								</h2>
								<div>
									<h3>배송비</h3>
									<ul class="list_type1">
										<li>2만원 미만 구매 시 <span class="fc_type2">2500원</span></li>
										<li>2만원 이상 구매 시 <span class="fc_type2">전액무료</span> (제주도 및
											기타 도선료 추가지역 포함)
										</li>
									</ul>
								</div>
								<div>
									<h3>평균 배송일</h3>
									<ul class="list_type1">
										<li>평일 4시 이전 주문 당일 출고됩니다. (<span class="fc_type2">온라인
												발송</span>에 한함)
										</li>
										<li>결제 완료 후 평균 2일 소요됩니다. (주말 및 공휴일 제외)</li>
										<li>택배사의 사정에 따라 다소 지연될 수 있습니다. (대한통운 1588-1255)</li>
										<li>오프라인 매장 발송은 <span class="fc_type2">2~3일 더 소요</span>될
											수 있습니다.
										</li>
									</ul>
								</div>
							</section>


							<section class="as_info_section grid-2 positR">
								<h2 class="tit_type1 ico_change">
									온.오프라인 교환 / 반품(환불) / AS <strong class="fc_type1">통합서비스</strong>
								</h2>
								<div>
									<h3>ABC-MART는 온라인ㆍ오프라인 매장 구분 없이 교환/반품/AS 접수가 가능합니다.</h3>
									<ul class="list_type1">
										<li>교환은 사이즈 교환만 가능합니다.</li>
										<li>매장에 방문하여 접수하시면 택배비 무료입니다.</li>
										<li>매장에 방문하여 접수하실 경우 구매내역서를 지참하여 주시기 바랍니다.</li>
										<li>매장에서 반품 접수 하신 경우 환불은 온라인 담당자 확인 후 처리됩니다.<br>(확인
											기간 2-3일 소요 / 결제하신 결제수단으로 환불)
										</li>
									</ul>
								</div>
								<a href="/abc/customer/sortAreaList"
									class="btn_sType1 mt20 ml10">오프라인매장 확인하기<i
									class="ico_arrow_left"></i></a>
							</section>
						</div>
						<div class="grid-row">
							<section class="as_info_section grid-2 no_line_left pt40">
								<h2 class="tit_type1 ico_memo">
									교환ㆍ반품(환불) 접수 시 <strong class="fc_type1">주의사항</strong>
								</h2>
								<div class="mt15">
									<ul class="basic_list_type">
										<li>- 제품을 받으신 날부터 7일 이내(상품불량인 경우 30일)에 접수해주시기 바랍니다.</li>
										<li>- 접수 시 왕복 택배비가 부과됩니다. <br>&nbsp;&nbsp;(단, 상품 불량,
											오배송의 경우 택배비를 환불해드립니다.)
										</li>
										<li>- 접수 후 14일 이내에 상품이 반품지로 도착하지 않을 경우 접수가 취소됩니다.<br>&nbsp;&nbsp;(배송
											지연 제외)
										</li>
									</ul>
								</div>
								<div>
									<h3>
										교환/반품(환불)이 <span class="fc_type2">불가능한</span> 경우
									</h3>
									<ul class="list_type1">
										<li>신발/의류를 외부에서 착용한 경우</li>
										<li>상품이 훼손된 경우</li>
										<li>제품에 붙어있는 택(Tag)을 분실/훼손한 경우</li>
										<li>브랜드 박스 분실/훼손된 경우</li>
									</ul>
								</div>
								<div>
									<h3>교환/반품(환불) 시 박스 포장 예</h3>
									<p class="list_type1">브랜드 박스의 훼손이 없도록 택배 박스 및 타 박스로 포장하여
										발송해주시기 바랍니다.</p>
									<div class="clearfix mt20">
										<figure class="fl-l packing_info1">
											<img
												src="http://image.abcmart.co.kr/nexti/images/abcmart_new/img_box01.jpg"
												alt="">
											<figcaption>
												<strong>올바른 박스포장 예</strong>
												<!-- <p>정품브랜드 박스의 훼손이 없도록 택배 박스 및 타 박스로 포장합니다.</p> -->
											</figcaption>
										</figure>
										<figure class="fl-l packing_info2">
											<img
												src="http://image.abcmart.co.kr/nexti/images/abcmart_new/img_box02.jpg"
												alt="">
											<figcaption>
												<strong>교환/환불이 <span class="fc_type2">불가한 경우</span></strong>
												<!-- <p>정품브랜드 박스의 훼손이 없도록 택배 박스 및 타 박스로 포장합니다.</p>
                            <p>브랜드 박스에 직접적인 송장부착 및 낙서로 인한 박스 훼손시 교환/환불이 불가능 합니다.</p>
                            <p>정품 브랜드 박스 훼손 및 분실 후 제품만 발송되어진 경우 교환/환불이 불가능 합니다.</p> -->
											</figcaption>
										</figure>
									</div>
								</div>
							</section>

							<section class="as_info_section grid-2 pt40 positR">
								<h2 class="tit_type1 ico_chat">
									<strong class="fc_type1">교환ㆍ반품</strong>(환불) 요령
								</h2>
								<div>
									<h3>교환/반품(환불) 처리 순서</h3>
									<ul class="step_box">
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">01.</span> 반품/교환 접수
												</dt>
												<dd>온라인 쇼핑몰에 로그인 후 마이 페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS &gt;
													반품/교환 신청</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">02.</span> 접수완료
												</dt>
												<dd>마이페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS &gt; 반품현황 또는 교환 현황
													&gt; 접수확인 상태 확인</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">03.</span> ABC-MART로 상품 발송
												</dt>
												<dd>주소 : 경기도 이천시 모가면 사실로579번길 39 2층 ABC-MART 온라인 물류센터</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">04.</span> ABC-MART에 상품도착
												</dt>
												<dd>교환 : 교환발송 / 반품 : 환불처리 → 환불완료</dd>
												<dd>결제사(카드, 은행) 영업일 기준 3~4일 후 환불확인 가능</dd>
											</dl>
										</li>
									</ul>
								</div>
								<div class="pt10">
									<h3>교환/반품(환불) 배송비 안내</h3>
									<ul class="list_type1">
										<li>왕복 택배비 : 최초 배송비 (2500원) + 반품 배송비(2500원) = 총 5,000원 이
											부과됩니다. <br>(선결제 또는 환불금액에서 차감 선택)
										</li>
										<li>단, 보내주신 상품이 <span class="fc_type1">불량 또는 오배송</span>으로
											확인 될 경우 택배비를 환불해드립니다. <br>(선택하신 결제수단으로 택배비 환불)
										</li>
										<li>지정택배(대한통운) 외 타택배 이용 시 추가로 발생되는 금액은 고객님께서 부담해주셔야 합니다.</li>
									</ul>
									<p class="add_info mt15 fs12">
										※ 대한통운 자동 회수접수 방법 : 교환/반품 접수 시 접수처를 온라인으로 선택 후 <span>회수여부
											‘예’</span>
									</p>
								</div>
								<a href="/abc/mypage/returnServiceRequest" class="btn_sType2"
									target="_blank">교환/반품(환불) 신청</a>
							</section>
						</div>



						<div class="grid-row">
							<section class="as_info_section2">
								<h2 class="tit_type1 ico_alim mb15">
									<strong class="fc_type1">AS불가</strong>안내
								</h2>
								<div class="grid-box">
									<div>&nbsp;- 개인의 착화 습관으로 발생된 힐컵 변형은 A/S 심의 불가합니다.</div>

									<div>
										<br> &nbsp;- 신발 세탁으로 생긴 이염은 심의 및 수선이 불가합니다.
									</div>

									<div>
										<br> &nbsp;- 양말소재로 생긴 힐컵주변 보풀현상은 심의가 불가합니다.
									</div>

								</div>
							</section>
						</div>


						<div>
							<section class="as_info_section2 positR">
								<h2 class="tit_type1 ico_as">
									<strong class="fc_type1">AS(수선/심의)</strong> 요령
								</h2>
								<ul class="basic_list_type mt15">
									<li>- 오프라인 매장에서도 접수 가능합니다. (매장 방문 접수 시 택배비 무료)</li>
									<li>- 외부 착화 후 발견된 상품 이상에 대한 심의/수선 요청은 온라인 쇼핑몰 마이
										페이지&gt;반품/교환/AS 또는 고객센터를 통해 접수해주시기 바랍니다.</li>
									<li>- 접수 없이 상품을 ABC-MART로 보내실 경우 확인이 어려워 반송되거나 처리가 늦어질 수
										있습니다.</li>
									<li>- 접수 완료 후 15일 이내 상품 도착하지 않을 경우 접수가 취소 됩니다.</li>
									<li>- 매장에서 구매하신 상품의 처리절차를 마이페이지&gt;반품/교환/AS 에서 확인 할 수
										있습니다.(멤버십 회원에 한함)</li>
								</ul>
								<a href="/abc/mypage/reqOnlnAsList" class="btn_sType2">AS 신청</a>

								<div class="clearfix" style="margin-left:20%;">
									<section class="as_box1 positR fl-l">
										<h3>수선 AS</h3>
										<ul class="list_type1">
											<li>수선을 원하는 내용을 자세하게(사진 첨부 가능) 기재해주면 처리 시 도움이 될 수 있습니다.</li>
											<li>수선 접수 시 왕복 택배비(5000원)가 부과됩니다.</li>
											<li>지정택배(대한통운) 외 타택배 이용 시 추가로 발생되는 금액은 고객님께서 부담해주셔야 합니다.</li>
										</ul>

										<a
											href="/abc/customer/faqList?parentDepth=0004&amp;depth=000403"
											class="btn_sType1 mt15 ml10">수선예상비용 자세히 보기<i
											class="ico_arrow_left"></i></a>

										<ul class="step_box">
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">01.</span> AS 접수
													</dt>
													<dd>
														온라인 쇼핑몰에 로그인 마이 페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS 또는<br>고객센터를
														통해 접수 &gt; AS신청 (1588-9667 / 080-701-7770)
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">02.</span> 접수완료
													</dt>
													<dd>마이페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS &gt; AS신청 &gt; 접수확인
														상태 확인</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">03.</span> ABC-MART로 상품
														발송
													</dt>
													<dd>
														주소 : 서울특별시 중구 을지로 100, B동 21층(을지로 2가, 파인에비뉴) ABCMART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;온라인
														AS담당자 앞
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">04.</span> ABC-MART에 상품도착
														브랜드사 또는 수선업체 접수
													</dt>
													<dd>수선 기간은 총 2주 정도 소요 / 수선 완료 시 개별 유선 통보</dd>
													<dd>(수선 내용에 따라 수선 비용이 청구될 수 있습니다.)</dd>
												</dl>
											</li>
										</ul>
									</section>

		<section class="as_box2 fl-l">
		<h3>심의 AS</h3>
		<ul class="list_type1">
			<li>불량으로 확인되는 내용을 자세하게(사진 첨부 가능) 기재해주시면 처리 시 도움이 될 수
						있습니다.</li>
					<li>상품 불량으로 인한 심의 접수 시 왕복 택배비는 ABC-MART에서 부담합니다. <br>
												(대한통운 택배 이용 권장)
				</li>
			</ul>

			<ul class="step_box">
						<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">01.</span> AS 접수
													</dt>
													<dd>
														온라인 쇼핑몰에 로그인 마이 페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS 또는<br>고객센터를
														통해 접수 &gt; AS신청 (1588-9667 / 080-701-7770)
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">02.</span> 접수완료
													</dt>
													<dd>마이페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS &gt; AS신청 &gt; 접수확인
														상태 확인</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">03.</span> ABC-MART로 상품
														발송
													</dt>
													<dd>
														주소 : 서울특별시 중구 을지로 100, B동 21층(을지로 2가, 파인에비뉴) ABCMART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;온라인
														AS담당자 앞
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">04.</span> ABC-MART에 상품도착
														브랜드사 또는 수선업체 접수
													</dt>
													<dd>심의 기간은 총 2주 정도 소요 / 결과 확인 후 개별 유선 통보</dd>
													<dd>불량 판정 시 무상 교환 또는 환불 처리 / 불량이 아닐 경우 유선 안내 후 상품 반송</dd>
													<dd>(2차 심의 접수 가능)</dd>
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