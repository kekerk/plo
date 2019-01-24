




var isLogin = "false";
var imageServer = "http://image.abcmart.co.kr/nexti";

//ajax global 로딩바 셋팅
$(document).bind("ajaxStart", function(){
    if(typeof(loadingBarStart) == 'function'){
        loadingBarStart();
    }
}).bind("ajaxStop", function(){
    if(typeof(loadingBarStop) == 'function'){
        loadingBarStop();
    }
});

// 로딩바 show
function loadingBarStart(){
    if($('div.container_wrap').length != 0){
        // 페이지 외
        $('.container_wrap').after('<p id="loadingBar" class="loading over_loading"><img src="' + imageServer + '/images/abcmart_new/loading.gif"/></p>');
    }
}

// 로딩바 hide
function loadingBarStop(){
    if($('#loadingBar').length != 0){
        $('#loadingBar').remove();
    }
}


jQuery(function($) {
    $("div#quickbar").each(function() {
        $.ajax({
            type: "GET"
            ,url: "/common/quickbar"
            ,dataType: "html"
            ,cache: false
            ,success : function(data) {
                $("div#quickbar").html(data);
                quickbarRolling();
            }
            ,error: function(data) {}
        });
    });

     
    var allCategoryFirstLoad = false;
    $("section.allmenu a").on("click", function(){
        if(allCategoryFirstLoad == false){
            allCategoryFirstLoad = true;

            $(this).find('.btn_menu_all').removeClass("on");
            $(this).find('.view_all_menu').removeClass("on");
            $.ajax({
                type: "post"
                ,url: "/common/category/all"
                ,dataType: "html"
                ,data: {serviceYn : ''}
                ,success : function(data) {
                    $('div.view_all_menu').html(data);
                }
                ,error: function(data) {}
                ,complete: function(data){
                    $(this).find('.btn_menu_all').addClass("on");
                    $(this).find('.view_all_menu').addClass("on");
                }
            });
        }
    });
    
    /*** 전체브랜드 보기 ***/
    var allBrandFirstLoad = false;
    var smartSearchFirstLoad = false;
    var storePickupSearchFirstLoad = false;
    var themeFirstLoad = false;
        
    $("section.allbrand a").click(function() {
		 $(".btn_theme").removeClass('on');
        if(smartSearchFirstLoad){
		      $(".smart_search_box").removeClass('on');
		      $(".btn_smart_search").removeClass('on');
		      $(".view_all_menu").removeClass('on');
		      $(".thema-list").removeClass('on');
		      $(".btn_theme").removeClass('on');
        }
         
        if (!allBrandFirstLoad) {
            allBrandFirstLoad = true;
            var obj = $(this);
            $(obj).click();
            $.ajax({
                type: "post"
                ,url: "/common/brand/all"
                ,dataType: "html"
                ,data: {serviceYn : ''}
                ,success : function(data) {
                    $('div.view_all_brand').html(data);

                    
                    $("article.brandSearch ul li a").click(function(){
                        var sortType = $(this).find("input[name='sortType']").val();
                        var ctgrId = $(this).find("input[name='ctgrId']").val();
                        var rangeStart = $(this).find("input[name='rangeStart']").val();
                        var rangeEnd = $(this).find("input[name='rangeEnd']").val();
                        var sortRange = $(this).find("input[name='sortRange']").val();
                        
                        $("article.brandSearch ul li").removeClass("select");
                        $(this).parent().addClass("select");
                        
                        
                        $("button.searchGNBBrand").parent().find("input[name='brandName']").val("");
                        
                        getBrandList(sortType, ctgrId, rangeStart, rangeEnd, sortRange);
                    });
                    
                    
                    $("button.searchGNBBrand").click(function(){
                        var sortType = '01'; 
                        var brandName = $(this).parent().find("input[name='brandName']").val();

                        if(isEmpty(brandName)){
                            alert("브랜드 명을 입력해주세요.");
                            return;
                        };

                        
                        var pattern = /[^ㄱ-힣]/g;
                        var cut = brandName.substr(0, 1);
                        
                        if (!isEmpty(cut) && pattern.test(cut)){
                            sortType = '02';
                        }
                        
                        $.ajax({
                            type: "POST"
                            ,url: "/common/brand/serachGNBBrand"
                            ,dataType: "html"
                            ,data: {
                                serviceYn : '',
                                brandName : brandName,
                                sortType : sortType
                            }
                            ,success : function(data) {
                                $("article.brandSearch ul li").removeClass("select");
                                $('section.result_brand_box').html(data);
                            }
                            ,error: function(data) {}
                        });
                    });
                    
                    
                    $("button.searchGNBBrand").parent().find("input[name='brandName']").keyup(function(e){
                        if(e.keyCode == 13){
                            $("button.searchGNBBrand").click();
                            return false;
                        }
                    });
                    
                    
                    $("section.allbrand a.close").click(function(){
                        $("section.allbrand a.btn_brand").click();
                    });
                    
                    
                    //getBrandList();
                    $.ajax({
                       type: "post"
                       ,url: "/common/brand/list"
                       ,dataType: "html"
                       ,success : function(data) {
                           $('section.result_brand_box').html(data);
                       }
                       ,error: function(data) {}
                       ,complete : function() {$(obj).click();}
                   });
                }
                ,error: function(data) {}
            });
        }
        return false;
    });
    
    
    $(".smart_search_area .btn_smart_search").on("click", function(){
    	$(".btn_theme").removeClass('on');
        $(".thema-list").removeClass('on');
         if (allBrandFirstLoad) {
                $(".btn_brand").removeClass('on');
                $(".view_all_brand").removeClass('on');
                $(".btn_theme").removeClass('on');
                $(".thema-list").removeClass('on');
         }
         
        if(!smartSearchFirstLoad){
            $.ajax({
                type: "post"
                ,url: "/abc/search/smart"
                ,dataType: "html"
                ,success : function(data) {
                    $(".smart_search_box").html(data);
                    smartSearchFirstLoad = true;
                    
                    searchInit();
                    
                    $(".smartSearchBtn").on("click", function(){
                        $("form[name='totalSearch']").submit();
                    });
                    
                    $("form[name='totalSearch']").on("submit", function(){
                    
                        if(searchValidation() == false){
                            alert("검색 조건을 확인해주세요");
                            return false;
                        }
                        
                        var minPrice = removeComma($("input[name='sPrice']").val());
                        var maxPirce = removeComma($("input[name='ePrice']").val());
                        
                        if(Number(minPrice) > Number(maxPirce)){
                            alert("가격을 확인해주세요");
                            return false;
                        }
                        setParams();
                    });
                    
                    $(".smart_search_box a.ico_close2").click(function(){
                        $(".smart_search_area .btn_smart_search").click();
                    });
                }
                ,error: function(data) {}
            });
        }
    });
    
    
    $(".store-pickup-area, .store-pick-tg-btn").on("click", function(e) {
        $(".view_all_brand").removeClass('on');
        $(".btn_brand").removeClass('on');
        $(".btn_theme").removeClass('on');
        $(".thema-list").removeClass('on');
        if(!storePickupSearchFirstLoad){
            storePickupSearchFirstLoad = true;
            $.ajax({
                type: "post"
                ,url: "/abc/storePickup/storePickupSearch"
                ,dataType: "html"
                ,success : function(data) {
                    $(".gnb-tg-pickup_box").html(data);
                }
                ,error: function(data) {}
            });
        }
    });
    
    
    $(".btn_theme").click(function() {  
    	$(".btn_brand").removeClass('on');
		$(".view_all_brand").removeClass('on');	
		
		$(".smart_search_box").removeClass('on');
		$(".btn_smart_search").removeClass('on');
		$(".view_all_menu").removeClass('on');
		$(".gnb-tg-pickup_box").removeClass('on');
		
		if(!themeFirstLoad){
			themeFirstLoad = true;
			var themeStr = "";
			themeStr += '<div class="detail_box">'
			          +     '<ul>'
			          +          '<li><a href="http://www.abcmart.co.kr/abc/theme/themeList?tmaId=01" class="thema_a">남성</a></li>'
					  +	         '<li><a href="http://www.abcmart.co.kr/abc/theme/themeList?tmaId=02" class="thema_a">여성</a></li>'
					  +	         '<li><a href="http://www.abcmart.co.kr/abc/theme/themeList?tmaId=03" class="thema_a">아동</a></li>'
			          +      '</ul>'
			    	  +	 '</div>';
			
			$(".thema-list").html(themeStr);					
		}			
    });
    

    
    $("div.size_view_box a").mouseenter(function(){
        $("div.size_view_box ul.size_list").html("").removeClass("on");
        
        var selectedUl = $(this).parent().find("ul");
        var prdtCode = $(selectedUl).attr("prdtCode");
        
        $.ajax({
            type: "GET"
            , url: "/common/option"
            , dataType: "html"
            , data : {prdtCode : prdtCode}
            , cache: false
            , success : function(data) {
                $(selectedUl).html(data);
                $(selectedUl).addClass('on');
                $(selectedUl).closest('.tabs-content').css("overflow", "visible");
            }
            , error: function(data) {
                alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
            }
        });
    });
    
    $("div.size_view_box").mouseleave(function(){
        $(this).find(".size_list").removeClass("on");
        $(this).closest('.tabs-content').css("overflow", "hidden");
    });
    
    $("ul#populaWordsArea").each(function() {
        $.ajax({
            type: "POST"
            ,url: "/common/popularWords"
            ,dataType: "json"
            ,success : function(data) {
                $("ul#populaWordsArea").html("");
                for (var i = 0; i < data.words.length; i++) {
                    if (i == 0) {
                        if(data.words[i].dispType == 'url'){
                            $("ul#populaWordsArea").append('<li><a href="' + encodeURI(data.words[i].linkUrl) + '" >' + data.words[i].srchWord + '</a></li>');
                        }else{
                            $("ul#populaWordsArea").append('<li><a href="javascript://" class="sendQuickSearch">' + data.words[i].srchWord + '</a></li>');
                        }
                    } else {
                        if(data.words[i].dispType == 'url'){
                            $("ul#populaWordsArea").append('<li><a href="' + encodeURI(data.words[i].linkUrl) + '" >' + data.words[i].srchWord + '</a></li>');
                        }else{
                            $("ul#populaWordsArea").append('<li><a href="javascript://" class="sendQuickSearch">' + data.words[i].srchWord + '</a></li>');
                        }
                    }
                }
            }
            ,error: function(data) {
            }
        });
    });
    
    //GNB 검색Submit
    $("form[name='topSearchForm']").submit(function(){
        if(isEmpty($('.searchText').val())){
            var adSearchUrl = $('.adSearchUrl').val();
            if(!isEmpty(adSearchUrl)){
                
                var resUrl = adSearchUrl.replace("/mobile/", "/abc/");
                var url = ''; 
                if(resUrl.indexOf('http://') != -1){
                    url = 'http://www.abcmart.co.kr' + resUrl;
                }else{
                    url = resUrl;
                }
                window.location.href = url;
                return false;
            }else{
                alert('검색어를 입력해주세요.');
                return false;
            }
        }
    });
    
    
    $(".couponRegistLayerPopupButton").click(function(){
        if(isLogin == 'false') {
            moveLoginForm();
            return false;
        };
    });
    
    getAdSearchWord();
    

    if ($(".list_top_searches").length > 0) {
        $.ajax({
            url: "/common/ajaxPopularWordList"
            , dataType: "html"
            , success: function(data) {
                $(".list_top_searches").html(data);
                if ($(".list_top_searches li").length > 0) {
                     realtimeTopSearches.init();
                }
            }
        });
    }
    $("form[name='topSearchForm'] input[name='searchTerm']").on("keydown", function(e){
        if(e.keyCode == 13 && isEmpty($(this).val())){ 
            alert('검색어를 입력해주세요.');
            var event = window.event;

            event.returnValue = false;
            event.cancel = true;
            
            if(event.preventDefault){
                event.preventDefault();
            }
        }
    });    
        
    //GNB 검색 영역 이벤트(자동완성)
    $("form[name='topSearchForm'] input[name='searchTerm']").on("keyup", function(e){
        var searchTerm = $(this).val();
        if(!isEmpty(searchTerm)){
            if(!$(".recommend_keyword_section").is(".on")){
                $(".recommend_keyword_section").addClass('on');
            }
        }else{
            $(".recommend_keyword_section").removeClass('on');
            return;
        }
        $.ajax({
            url: "/abc/search/autocomplete"
            , dataType: "html"
            , data : {searchTerm: searchTerm}
            , success: function(data) {
                $(".autoCompleteSearchArea").html(data);
                
                $(".autoKeyword").off("click");
                $(".autoKeyword").on("click", function(){
                    $("form[name='topSearchForm'] input[name='searchTerm']").val($(this).find("a").text());
                });
                
                $(".ico_close3").off("click");
                $(".ico_close3").on("click", function(){
                    $(this).closest('.recommend_keyword_section').removeClass('on');
                });
            }
        });
    });
    
    
    
    // 특수문자 제거 클래스 *배송메세지용
    $('input.exceptSpecialChar').keydown(function(event){
        specialCharValidation(event);
    });
    
    
    $('form').find('input[type=text],input[type=password]').each(function () {

        var $input = $(this);

        var input_text_length_check = function () {
            var text = $input.val();
            var text_length = $input.val().length;
            var limit = parseInt($input.attr("maxlength"));

            if (isNaN(limit)) {
                return false;
            }
            
            var ansi_length = 0;
            var char_length = 0;
            for (var i=0; i < text_length; i++){
                var temp = text.charAt(i);
                if(escape(temp).length > 4){
                    char_length = 2;
                }else{
                    char_length = 1;
                }
                
                if(ansi_length + char_length > limit)
                {
                    alert("허용된 글자수가 초과되었습니다\n초과된 부분은 자동으로 삭제됩니다.");
                    $input.val(text.substr(0,i));
                    return false;
                }
                
                ansi_length = ansi_length + char_length;
            }

        };
        // keyup 이벤트와 input_text_length_check 함수를 바인드한다
        $input.bind('keyup', function () {
            setTimeout(input_text_length_check, 0);
        });
        input_text_length_check();        

    });
    
});


function specialCharValidation(event){
    if((event.shiftKey && (event.keyCode >= 48 && event.keyCode <= 57)) || event.keyCode == 59 || event.keyCode == 186 || event.keyCode == 187 || 
       (event.shiftKey && event.keyCode == 189) || event.keyCode == 106 || event.keyCode == 107 || event.keyCode == 109 || event.keyCode == 110 || event.keyCode == 111 || 
       event.keyCode == 219 || event.keyCode == 220 || event.keyCode == 221 || event.keyCode == 222 || event.keyCode == 188 || event.keyCode == 190 ||
       event.keyCode == 191 || event.keyCode == 192 || event.keyCode == 219 || event.keyCode == 220 || event.keyCode == 221 || event.keyCode == 222){
        event.preventDefault();
    }else{
        // ignore
    }
}

//자동완성 추천 상품 마우스 오버시 해당 상품 show 
function getAutoProduct(prdtId){
    $(".recommend_prd").hide();
    $(".prdt" + prdtId).show();
}


function getBrandList(sortType, ctgrId, rangeStart, rangeEnd, sortRange, obj){
    $.ajax({
       type: "post"
       ,url: "/common/brand/list"
       ,dataType: "html"
       ,data: {
        serviceYn : '',
        sortType : sortType,
        ctgrId : ctgrId,
        rangeStart : rangeStart,
        rangeEnd : rangeEnd,
        sortRange : sortRange
       }
       ,success : function(data) {
           $('section.result_brand_box').html(data);
       }
       ,complete : function() {}
       ,error: function(data) {}
   });
}


function productListDefaultScript() {
    
    $("div.size_view_box a").mouseenter(function(){
        $("div.size_view_box ul.size_list").html("").removeClass("on");
        
        var selectedUl = $(this).parent().find("ul");
        var prdtCode = $(selectedUl).attr("prdtCode");
        
        $.ajax({
            type: "GET"
            , url: "/common/option"
            , dataType: "html"
            , data : {prdtCode : prdtCode}
            , cache: false
            , success : function(data) {
                $(selectedUl).html(data);
                $(selectedUl).addClass('on');
                $(selectedUl).closest('.tabs-content').css("overflow", "visible");
            }
            , error: function(data) {
                alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
            }
        });
    });
    
    $("div.size_view_box").mouseleave(function(){
        $(this).find(".size_list").removeClass("on");
        $(this).closest('.tabs-content').css("overflow", "hidden");
    });
    
    
    $(".wrap_drop_down > a").off("click"); 
    $(".wrap_drop_down > a").click(function(e){
        e.preventDefault(); 
        $(this).toggleClass('on');
        $(this).next(".list_drop_down").toggleClass("on");
    });
    
    
    $(".tabs-nav").off("click", "a");
    $(".tabs-nav").on("click", "a", function(event){
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        
        var tab = $(this).attr("href");
        $(".tabs-cont").not(tab).css("display", "none");
        $(tab).show();
    });
    
    
    $(".gallery_basic li .model_img_box").off("hoverIntent");
    $(".gallery_basic li .model_img_box").hoverIntent(
        function () {
            $(this).find(".over_link").fadeIn("fast");
            $(this).find(".over_view").fadeIn("fast");
        }, 
        function () {
            $(this).find(".over_link").fadeOut("fast");
            $(this).find(".over_view").fadeOut("fast");
        }
    );
}


function quickbarRolling(){
    /* quickbar롤링 */
    
    var quickrolling = $(".quick_list ul");
    if ( $(".quick_list ul li").length > 3 ) {
      $(".quick_list ul li:last-child").prependTo(quickrolling);
      quickrolling.css("margin-top","-66px");
    } 
    $(".quick_product .prev").on("click", function(){
      $(".quick_list ul:not(:animated)").animate({ "margin-top":"-=66px"} , "slow" , function(){
        $(".quick_list ul li:first-child").appendTo(quickrolling);
        quickrolling.css("margin-top","-66px");
      });
      return false;
    });
    $(".quick_product .next").on("click", function(){
      $(".quick_list ul:not(:animated)").animate({ "margin-top":"+=66px"},"slow" ,function(){
        $(".quick_list ul li:last-child").prependTo(quickrolling);
        quickrolling.css("margin-top","-66px");
      });
      return false;
    });
    $().UItoTop({ easingType: 'easeOutQuart' });    
}


function getOrgUrl() {
    var returnUrl = document.location.href;
    var index = returnUrl.indexOf('#');
    if (index != -1) {
        returnUrl = returnUrl.substr(0, index);
    }
    
    return returnUrl;
}


function moveLoginForm(redirectUrlParam) {
    if (isEmpty(redirectUrlParam)) {
         redirectUrlParam = getOrgUrl();
    }
    
    document.location.href = "https://www.abcmart.co.kr/abc/login/form?redirectUrl=" + redirectUrlParam;
}


function openPopupCouponRegister() {
   if(isLogin == 'false') {
       moveLoginForm();
       return false;
   }
    window.open('/abc/mypage/popupCouponRegisterForm','pop_change_pass', 'width=480 , height=345' );
    return false;
}


function addFavorite(){
    var title = '세상의 모든신발 ABC-MART';
    var url = 'http://www.abcmart.co.kr/';
    
    var agent = navigator.userAgent.toLowerCase(); 
    var name = navigator.appName; 

    // IE old version ( IE 10 or Lower ) 
    if ( name == "Microsoft Internet Explorer" || agent.search("trident") > -1
            || agent.search("edge/") > -1 ){
        window.external.AddFavorite(url, title);
    }else if(window.chrome){
       // Google Chrome
       alert("Ctrl+D키를 누르세요")
    }else if (window.sidebar){
       // Firefox
       window.sidebar.addPanel(title, url, ""); 
    }else if(window.opera && window.print){
        // Opera
        var elem = document.createElement('a'); 
        elem.setAttribute('href',url); 
        elem.setAttribute('title',title); 
        elem.setAttribute('rel','sidebar'); 
        elem.click(); 
    }
}



function productDetailCouponDownload(couponId) {
    if (isLogin == 'false') { 
        alert("로그인하셔야 합니다.");
        document.location.href = "https://www.abcmart.co.kr/abc/login/form?redirectUrl=" + getOrgUrl();
        return false;
    }

    $.ajax({
        type: "post"
        ,url: "/abc/product/couponDownload"
        ,data: {
            'cpnId' : couponId
        }
        ,dataType: "json"
        ,success : function(data) {
            var errorMessages = data.errorMessages;
            alert(errorMessages[0]);
        }
    });
    
    return false;
}



function productMemberShipDetailCouponDownload(couponId) {

    if (isLogin == 'false') { 
        alert("로그인하셔야 합니다.");
        //로그인팝업호출
        moveLoginForm();
        return false;
    }
    
    var memberShipYn = "";
    
    if (memberShipYn == 'true'){
        $.ajax({
            type: "post"
            ,url: "/mobile/product/couponDownload"
            ,data: {
                'cpnId' : couponId
            }
            ,dataType: "json"
            ,success : function(data) {
                var errorMessages = data.errorMessages;
                alert(errorMessages[0]);
            }
        });
    } else {
        alert("멤버십 회원만 쿠폰 발급 가능합니다.");
    }
    
    return false;
}



function nonPurchasingCouponDownload(couponId, startDtm, endDtm, returnMessage) {

	if (isLogin == 'false') { 
        alert("로그인하셔야 합니다.");
        document.location.href = "https://www.abcmart.co.kr/abc/login/form?redirectUrl=" + getOrgUrl();
        return false;
    }

    $.ajax({
        type: "post"
        ,url: "/abc/event/nonPurchasingCouponDownload"
        ,data: {
            'cpnNumber' : couponId, 'startDtm' : startDtm, 'endDtm' : endDtm, 'returnMessage' : returnMessage
        }
        ,dataType: "json"
        ,success : function(data) {
            var errorMessages = data.errorMessages;
            alert(errorMessages[0]);
	    }
    });
}



function purchasePeriodCouponDownload(couponId, startDtm, endDtm, returnMessage) {
	
	var number = /[^0-9]/;
	
	if(startDtm == ""){
		alert("이벤트 시작일자를 넣어주세요.");
		return false;
	} else if(startDtm.length != 8){
		alert("이벤트 시작일자가 8자리인지 확인해 주세요.");
		return false;
	} else if(startDtm.search(number) != -1){
		alert("이벤트 시작일자가 숫자인지 확인해 주세요.");
		return false;
	}
	
	if(endDtm == ""){
		alert("이벤트 종료일자를 넣어주세요.");
		return false;
	} else if(endDtm.length != 8){
		alert("이벤트 종료일자가 8자리인지 확인해 주세요.");
		return false;
	} else if(endDtm.search(number) != -1){
		alert("이벤트 종료일자가 숫자인지 확인해 주세요.");
		return false;
	}


	if (isLogin == 'false') { 
        alert("로그인하셔야 합니다.");
        document.location.href = "https://www.abcmart.co.kr/abc/login/form?redirectUrl=" + getOrgUrl();
        return false;
    }

    $.ajax({
        type: "post"
        ,url: "/abc/event/purchasePeriodCouponDownload"
        ,data: {
            'cpnNumber' : couponId, 'startDtm' : startDtm, 'endDtm' : endDtm, 'returnMessage' : returnMessage
        }
        ,dataType: "json"
        ,success : function(data) {
            var errorMessages = data.errorMessages;
            alert(errorMessages[0]);
	    }
    });
}


function productMemberShipRedirectNew(prdtCode, target) {

      if(target == "blank"){
           window.open("http://www.abcmart.co.kr/abc/product/detail?prdtCode=" + prdtCode);
      }else{
          document.location.href = "http://www.abcmart.co.kr/abc/product/detail?prdtCode=" + prdtCode;
      }

   return false;
}


function productMemberShipRedirect(prdtCode, target) {

    var nowDate = new Date();
    var year = nowDate.getFullYear();
    var month = '0'+(nowDate.getMonth()+1);
    var day = '0'+nowDate.getDate();
    var time = '0'+nowDate.getTime();
    
    alert(year);
    alert(month.slice(-2));
    alert(day.slice(-2));
    alert(time); 
    
    return false;
    
    if (isLogin == 'false') { 
        alert("로그인하셔야 합니다.");
        //로그인팝업호출
        moveLoginForm();
        return false;
    }
    
    var memberShipYn = "";
    
    if (memberShipYn == 'true'){
        if(target == "blank"){
             window.open("http://www.abcmart.co.kr/abc/product/detail?prdtCode=" + prdtCode);
        }else{
            document.location.href = "http://www.abcmart.co.kr/abc/product/detail?prdtCode=" + prdtCode;
        }
    } else {
        alert("멤버십 회원만 구매 가능한 상품입니다.\n맴버십 회원 가입후 이용하시기 바랍니다.");
    }
    
    return false;
}


function productMemberShipRedirectDateCheck(prdtCode, target, startDt, endDt) {

    var nowDate = new Date();
    var year = nowDate.getFullYear();
    var month = '0'+(nowDate.getMonth()+1);
    var day = '0'+nowDate.getDate();
    var hours = '0'+nowDate.getHours();
    var minutes = '0'+nowDate.getMinutes();
    var nowDt = year+month.slice(-2)+day.slice(-2)+hours.slice(-2)+minutes.slice(-2);
        
    if(nowDt >= startDt && nowDt < endDt){
	    if (isLogin == 'false') { 
	        alert("로그인하셔야 합니다.");
	        //로그인팝업호출
	        moveLoginForm();
	        return false;
	    }
	    
	    var memberShipYn = "";
	    
	    if (memberShipYn == 'true'){
	        if(target == "blank"){
	             window.open("http://www.abcmart.co.kr/abc/product/detail?prdtCode=" + prdtCode);
	        }else{
	            document.location.href = "http://www.abcmart.co.kr/abc/product/detail?prdtCode=" + prdtCode;
	        }
	    } else {
	        alert("멤버십 회원만 구매 가능한 상품입니다.\n멤버십 회원 가입후 이용하시기 바랍니다.");
	    }
    }else{
        if(target == "blank"){
             window.open("http://www.abcmart.co.kr/abc/product/detail?prdtCode=" + prdtCode);
        }else{
            document.location.href = "http://www.abcmart.co.kr/abc/product/detail?prdtCode=" + prdtCode;
        }
   }    
   
    return false;
}


function productMemberShipEvent( dscntUserGbnCode ) {
    if(dscntUserGbnCode == "M"){
         alert("멤버십 회원만 구매 가능한 상품입니다.\n로그인 후 이용하시기 바랍니다.");
    }

   if(dscntUserGbnCode == "CM"){
         alert("멤버십 회원만 구매 가능한 상품입니다.\n멤버십 회원으로 전환 후 구매해주시기 바랍니다.");
    }
       
    if(dscntUserGbnCode == "U"){
         alert("ABC마트 회원만 구매 가능한 상품입니다.\n로그인 후 이용하시기 바랍니다.");
    }  
}


function birthYearMemberShipCouponDownload(couponId) {

    if (isLogin == 'false') { 
        alert("로그인하셔야 합니다.");
        //로그인팝업호출
        moveLoginForm();
        return false;
    }
    
    var memberShipYn = "";
    
    if (memberShipYn == 'true'){
        $.ajax({
            type: "post"
            ,url: "/abc/product/birthYearMemberShipCouponDownload"
            ,data: {
                'cpnId' : couponId
            }
            ,dataType: "json"
            ,success : function(data) {
                var errorMessages = data.errorMessages;
                alert(errorMessages[0]);
            }
        });
    } else {
        if (confirm("멤버십 회원만 쿠폰 발급 가능합니다.\n멤버십 회원을 가입 하시겠습니까?")) {
        	document.location.href = "/abc/user/memberShipAgreement";
   		}
    }
    
    return false;
}


function shareTwitter(url, title, snsShareGbn, prdtCode){
    setSnsShare(prdtCode, "02", snsShareGbn);

    var encodedTitle = encodeURIComponent("[" + title + "]");
    var result = window.open("http://twitter.com/share?text=" + encodedTitle, 'twitter', 'width=466, height=356');
    if (result) {
        result.focus();
    }
    
    return false;
}


function copyUrl() {
    var trb = getOrgUrl();
    var IE = (document.all) ? true : false;
    if(IE) {
        if(confirm("이 글의 트랙백 주소를 클립보드에 복사하시겠습니까?"))
        window.clipboardData.setData("Text", trb);
    } else {
        temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", trb);
    }
}


function shareFacebook(url, snsShareGbn, prdtCode) {
    if(url == null || url == '' || url == 'undefined') {
        return false;
    }
    
    setSnsShare(prdtCode, "01", snsShareGbn); 

    var url = "http://www.facebook.com/sharer.php?u=http://www.abcmart.co.kr" + url;
    url = url.split("#").join("%23");
    url = encodeURI(url);

    window.open(url, 'facebook', 'width=550,height=340');

    return false;
}


function shareKakaoStory(url, snsShareGbn, prdtCode) {
    if(url == null || url == '' || url == 'undefined') {
        return false;
    }

    setSnsShare(prdtCode, '05', snsShareGbn);


    var shareUrl = "http://www.abcmart.co.kr" + url;
    window.open("https://story.kakao.com/share?url=" + encodeURIComponent(shareUrl), 'about:blank', 'width=450px,height=495px');
    return false;
}


function sharePinterest(url, imagePath, title, snsShareGbn, prdtCode) {
    if(url == null || url == '' || url == 'undefined') {
        return false;
    }

    setSnsShare(prdtCode, '04', snsShareGbn);

    if(!imagePath) {
        imagePath = '//image.abcmart.co.kr/nexti/images/abcmart_new/logo.png';
    }

    var shareUrl = encodeURIComponent('http://www.abcmart.co.kr' + url);
    var media = encodeURIComponent('http://image.abcmart.co.kr/nexti' + imagePath);
    var description = encodeURIComponent(title);
    var url = 'http://www.pinterest.com/pin/create/button/?url=' + shareUrl + '&media=' + media + '&description=' + description;
    var popupWindow = window.open(url, 'about:blank', 'width=800,height=500');
    if(popupWindow) {
        popupWindow.focus();
    }
}


function setSnsShare(bigo, snsGbn, snsShareGbn) {

    $.ajax({
        type: "post"
        , url: "/abc/system/ajaxSnsShare"
        , data: {
            "bigo": bigo,
            "snsGbn": snsGbn,
            "snsShareGbn": snsShareGbn
        }
        , dataType: "json"
        , success: function(data) {
            //skip
        }
        , error: function(xhr, status, error) {
            //skip
        }
    });
}


function saveWishProduct(productCode,reloadYn) {
    if (isLogin == 'false') { 
        document.location.href = "https://www.abcmart.co.kr/abc/login/form?redirectUrl=" + getOrgUrl();
    } else {
        // SNS회원 불가
        var userType = "";
        if(userType == 'SNS'){
            alert("찜하기는 온라인, 멤버십 회원만 가능합니다.");
            return;
        }
        
        $.ajax({
            type: "post"
            ,url: "/abc/user/saveWishProduct"
            ,data: {'productCode' : productCode}
            ,dataType: "json"
            ,success : function(data) {
                if (data.save) {
                    alert('선택된 상품을 찜하였습니다.');
                    
                    if(reloadYn){
                        window.location.reload();
                    }
                } else {
                    alert(data.message);
                }
            }
            ,error: function(data) {
                alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
            }
        });
    }
}


function getOrgUrl() {
    var returnUrl = document.location.href;
    var index = returnUrl.indexOf('#');
    if (index != -1) {
        returnUrl = returnUrl.substr(0, index);
    }
    
    return returnUrl;
}


function layerPopupShow(obj, isScroll){
    // 백그라운드 불투명하게 
    var maskWidth = $(window).width();
    var maskHeight = $(window).height();
    $('.bg_mask').css({'width':maskWidth,'height':maskHeight, 'opacity':'0.6', 'z-index': '500'});
    $('.bg_mask').show();
    
    // 위치조정
    obj.css("margin-left", '-' + obj.width()/2 + 'px');
    obj.css("max-height", $(window).height() - 100 + 'px').css("margin-top", '-' + obj.height()/2 + 'px');
    
    if(isScroll){
        obj.css("overflow-y", "scroll")
    }
    
    // show
    obj.show();
}


function layerPopupHide(obj){
    $(obj).hide();
    $('.bg_mask').hide();
}


function openLayerProductDetail(prdtCode, ctgrId, event){
    $.ajax({
        type: "get"
        ,url: "/abc/product/detailPreview"
        ,data : {"prdtCode" : prdtCode, "ctgrId" : ctgrId}
        ,dataType: "html"
        ,success : function(data) {
            //레이어 html 삽입
            $('div#productPreviewArea').html(data);
            
            // script.js에있는부분을 이곳에 옮김
            layerPopupShow($('div#productPreviewArea'), true);
            
            //닫기버튼
            $('a.btnLayerProductClose').click(function(){
                layerPopupHide($('div#productPreviewArea'));
            });
            
            // 제품 상세  보기
            $(".detail_img_box > ul > li").mouseover(function(){
                $(this).addClass('current').siblings('li').removeClass('current');
                $(".img_area > img").attr("src" , $(this).find("img").attr("src"));
            });
            
            $(".detail_size > li.disable").hoverIntent(
                function () {   
                    $(this).find(".tooltip_type1").fadeIn("fast");
                }, 
                function () {
                    $(this).find(".tooltip_type1").fadeOut("fast");
                }
          );
        }
    });
}


function viewProductDetail(prdtCode, realCtgrId){
    window.open('/abc/product/detail?prdtCode='+prdtCode+'&ctgrId='+realCtgrId);
}


function openLayerProductOption(prdtCode){
    $.ajax({
        type: "post"
        ,url: "/abc/product/selectOptionPopup"
        ,data: {'prdtCode' : prdtCode}
        ,dataType: "html"
        ,success : function(data) {
            $("div#productOptionArea").html(data);
            
            // script.js에있는부분을 이곳에 옮김
            layerPopupShow($('div#productOptionArea'), false);
            
            // selectbox div 클릭이벤트
            $("#selectOptionArea > a").click(function(e){
                $(this).toggleClass('on');
                $(this).parent().find(".relation_list").toggleClass("on");
            });
            
            //옵션선택이벤트
            $(".optnValueBtn").click(function(e){
                var optnId = $(this).attr("optnId"); //선택한 옵션아이디
                var optnValue = $(this).attr("optnValue"); //선택한 옵션값
                
                $("#selectOptionArea > a").attr("optnId", optnId); //값 세팅
                
                // 다시 닫아주기
                $("#selectOptionArea > a").toggleClass('on');
                $("#selectOptionArea > a").parent().find(".relation_list").toggleClass("on");
                
                // 선택한값 표시해주기
                $("#selectOptionArea > a").html(optnValue + "<span class='ico_arrow1'></span>");
            });
            
            //닫기버튼
            $('.btnLayerProductClose').click(function(){
                layerPopupHide($('div#productOptionArea'));
            });
            
            // 장바구니 담기버튼
            $(".addCart").click(function() {
                var optionId = $("#selectOptionArea > a").attr("optnId");
                
                if (isEmpty(optionId)) {
                    alert("옵션는(은) 생략할 수 없습니다.");
                } else {
                    
                    addCart(prdtCode, optionId, true, false);
                }
            });
            
        }
    });
}


function openOptionListForProdctView(obj){
    var selectedUl = $(obj);
    var selectedUlArea = $(obj).parent().find(".relation_list");
    var prdtCode = $(obj).attr("prdtCode");
    
    $.ajax({
        type: "GET"
        , url: "/common/optionList"
        , dataType: "html"
        , data : {prdtCode : prdtCode}
        , cache: false
        , success : function(data) {
            $(".pvOptionSelect").not(selectedUl).removeClass("on");
            $(".relation_list").not(selectedUlArea).removeClass("on");
            
            $(selectedUlArea).html(data);
            $(selectedUl).toggleClass('on');
            $(selectedUlArea).toggleClass("on");
        }
        , error: function(data) {
            alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
        }
    });
}
    

function addCartForProductView(obj, type){
    
    if(type == "2"){
        var pvOptionSelect = $(obj).parent().parent().parent().parent().find(".pvOptionSelect");
    }else{
        var pvOptionSelect = $(obj).parent().parent().parent().find(".pvOptionSelect");
    }
    var optnId = pvOptionSelect.attr("optnId");
    var prdtCode = pvOptionSelect.attr("prdtCode");
    
    addCart(prdtCode, optnId, false, true);
}


function selectedOptionForProdctView(optnId, optnValue, obj){
    var pvOptionSelect = $(obj).parent().parent().parent().find(".pvOptionSelect");
    var selectedUlArea = $(obj).parent().parent().parent().find(".relation_list");
    
    // 데이터세팅
    $(pvOptionSelect).attr("optnId", optnId);
    
    // view용 데이터 세팅
    $(pvOptionSelect).html(optnValue + "<span class='ico_arrow1'></span>");
    
    // 레이어닫아주기
    $(pvOptionSelect).toggleClass('on');
    $(selectedUlArea).toggleClass("on");
}


function addCart(prdtCode, optionId, closeLayerPopup, noConfirm){
    var count = 1;
    $.ajax({
        type: "POST"
        ,url: "/abc/order/addCart"
        ,data: {prdtCode : prdtCode, optnId : optionId, prdtCount : count}
        ,dataType: "json"
        ,success : function(data) {
            if(data.success) {
                if(!noConfirm){
                    if (confirm("해당 상품이 장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?")) {
                        document.location.href = "/abc/order/cart";
                    }else{
                        // 레이어팝업 닫기
                        if(closeLayerPopup){
                            layerPopupHide($('div#productOptionArea'));
                        }
                    }
                }else {
                    alert("해당 상품이 장바구니에 담겼습니다.");
                    document.location.href = "/abc/order/cart";
                }
            } else {
                var msg = uniqueMsg(data.errorMessages).join("\n");    //중복 메시지 제거후 개행
                alert(msg);
                if(msg.indexOf("모바일 전용 특가 상품입니다.") != -1) {
                    document.location.href = "/abc/promotion/startEvent?eventId=000214";
                }
            }
        }
        ,error: function(data) {
            alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
        }
    });
}


function lengthCheck(text){
    var length = text.length;
    var cnt = 0;
    for (var i=0; i < length; i++){
        var temp = text.charAt(i);
        if(escape(temp).length > 4){
            cnt += 2;
        }else{
            cnt += 1;
        }
    }
    return cnt;
}


function quickOrder(prdtCode, optnId, prdtCount, ctgrId) {
    if(optnId == "" || optnId == undefined) {
        alert("옵션을 선택해주세요.");
        return;
    }
    
    if(!confirm("해당상품만 바로구매 하시겠습니까?")) {
        return;
    }
    
    if(prdtCode == undefined) {
        prdtCode = "";
    }
    
    if(optnId == undefined) {
        optnId = "";
    }
    
    if(prdtCount == "" || prdtCount == undefined) {
        prdtCount = 1;
    }
    
    if(ctgrId == undefined) {
        ctgrId = "";
    }
    
    $.ajax({
        type: "POST"
        ,url: "/abc/order/quickOrder"
        ,data: {prdtCode : prdtCode, optnId : optnId, prdtCount : prdtCount, ctgrId : ctgrId}
        ,dataType: "json"
        ,success : function(data) {
            if(data.success) {
                window.location.href = "https://www.abcmart.co.kr/abc/order/order";
            } else {
                var msg = data.errorMessages.join("\n");
                alert(msg);
                if(msg.indexOf("모바일 전용 특가 상품입니다.") != -1) {
                    document.location.href = "/abc/promotion/startEvent?eventId=000214";
                }
            }
        }
        ,error: function(data) {
            alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
        }
    });
}

 
function openImageUpload(paramId) {
    var url = "/abc/uploadImageForm";
    if (paramId == undefined || paramId == "") {
    } else {
        url += "?paramId=" + paramId;
    }
    var options = 'width=391,height=230';
    //var options = 'width=381,height=230'; 

    window.open(url, 'imageUpload', options);
//    window.open(url,'imageUpload','width=500 , height=310');
    return false;
}



function getAdSearchWord(){

    if($(".searchText").length <= 0) {
        return false;
    }

    $.ajax({
        type: "POST"
        ,url: "/common/getAdSearchWord"
        ,dataType: "json"
        ,success : function(data) {
            if(data.adSearchWord != null){
                $(".searchText").prop("placeholder", data.adSearchWord.srchWord);
                $(".adSearchUrl").val(data.adSearchWord.moveUrl);
            }
        }
        ,error: function(data) {}
    });
}


function validatePassword(value) {
    var pswdStr = value;
    var pswdStrLength = pswdStr.length;

    
    var isChkOk1 = false;
    var isChkOk2 = false;
    var isChkOk3 = false;
    var isChkOk4 = true;
    var isChkOk5 = true;
    var isChkOk6 = true; 

    var pt1 = /^.*(?=.{10,20})(?=.*[a-zA-Z])(?=.*[0-9]).*$/;
    var pt2 = /^.*(?=.{10,20})(?=.*[a-zA-Z])(?=.*\W).*$/;
    var pt3 = /^.*(?=.{10,20})(?=.*[0-9])(?=.*\W).*$/;
    var pt4 = /^.*(?=.{10,20})(?=.*\s).*$/; 

    

    if(pswdStr.length < 10) {
        return '비밀번호는 10글자 이상, 20글자 이하이어야 합니다.';
    }
    if(pswdStr.length > 20) {
        return '비밀번호는 10글자 이상, 20글자 이하이어야 합니다.';
    }

    
    if (pt1.test(pswdStr)) { isChkOk1 = true; }

    
    if (pt2.test(pswdStr)) { isChkOk2 = true; }

    
    if (pt3.test(pswdStr)) { isChkOk3 = true; }

    
    if (pt4.test(pswdStr)) {isChkOk6 = false; }

    
    var alpNumSpc = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "`", "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "=", "+", "[", "{", "]", "}", "\\", "|", "'", "\"", ";", ":", "/", "?", ".", ">", ",", "<"];
    for (var i = 0; i < alpNumSpc.length; i++) {
        var pt = new RegExp(((i > 35)? "\\" + alpNumSpc[i] : alpNumSpc[i]) + "{3,}", "g");
        if (pt.test(pswdStr)){
            isChkOk4 = false;
            break;
        }
    }

    
    if($("input[name='userId']").val() == pswdStr || $("input[name='id']").val() == pswdStr){
        isChkOk5 = false;
    }

    
    if (!isChkOk1 && !isChkOk2 && !isChkOk3) {
        return '비밀번호는 영문, 숫자, 특수문자 중 두 개 조합이어야 합니다.';
    }
    if (!isChkOk4) {
        return '동일 문자 3회 사용';
    }
    if (!isChkOk5) {
        return '아이디와 동일';
    }
    if (!isChkOk6) {
        return '공백 사용';
    }

    return null;
}

function openPostNumPopup(searchType, paramId, serviceYn) {
    var param = "";
    param += 'searchType=' + searchType;
    if (!isEmpty(paramId)) {
        param += '&paramId=' + paramId;
    }

    if (!isEmpty(serviceYn)) {
        param += '&serviceYn=' + serviceYn;
    }

    //window.open(serverHostNonSSL + '/abc/searchPostNum?' + param, 'postPopup', 'width=700 ,height=650 ,scrollbars=yes');
    // width=530 + 10, height=740 + 50
    window.open('/abc/searchPostNum?' + param, 'postPopup', 'width=540, height=790, scrollbars=yes');
    return false;
}


function openPopupChangeLocation(orderNum, giftcardYn) {
    if(isEmpty(giftcardYn)){
        window.open('/abc/mypage/popupChangeLocationForm?orderNum='+orderNum, 'popup_membership_clause', 'width=841 , height=680' );
        return false;
    }else{
        window.open('/abc/mypage/popupChangeLocationFormForGiftcard?orderNum='+orderNum, 'popup_membership_clause', 'width=841 , height=680' );
        return false;
    }
}



function popupStoreMap(storeId) {
    var url = '/abc/customer/popupStoreMap?storeId='+encodeURIComponent(storeId);
    var sizeX = (document.body.clientWidth - 730) / 2;
    var sizeY = (document.body.clientHeight - 770) / 2;
    if (sizeX < 0) {
        sizeX = 0;
    }
    if (sizeY < 0) {
        sizeY = 0;
    }
    var positionX = window.screenLeft + sizeX;
    var positionY = window.screenTop + sizeY;
    var option = "width=730, height=770, top=" + positionY
               + ", left=" + positionX
               + ", toolbar=no, menubar=no, directories=no, resizable=no, scrollbars=no, status=no"
    window.open(url, "", option);
}


function popupStoreSearchForm(onlineSearchYn, pickupYn) {
    var param = '';
    if(onlineSearchYn != null && onlineSearchYn != '' && onlineSearchYn != 'undefined') {
        param = '?onlineSearchYn=' + onlineSearchYn;
    } 
    
    if(!isEmpty(pickupYn)) {
        if(isEmpty(param)) {
            param = '?pickupYn=' + pickupYn;
        } else {
            param = param + '&pickupYn=' + pickupYn;
        }
    }
    
    var url = '/abc/customer/popupStoreSearchForm' + param;
    var sizeX = (document.body.clientWidth - 850) / 2;
    var sizeY = (document.body.clientHeight - 650) / 2;
    if (sizeX < 0) {
        sizeX = 0;
    }
    if (sizeY < 0) {
        sizeY = 0;
    }
    var positionX = window.screenLeft + sizeX;
    var positionY = window.screenTop + sizeY;
    var option = "width=850, height=650, top=" + positionY
               + ", left=" + positionX
               + ", toolbar=no, menubar=no, directories=no, resizable=no, scrollbars=no, status=no"
    window.open(url, "", option);
}


function popupShowLGReceipt(lgupMid, lgupKey, pymntMeansCode, orderNum, lgupDealNum, lgupChprDealNum) {
    if(pymntMeansCode == '01') {
        showReceiptByTID(lgupMid, lgupDealNum, lgupChprDealNum);
    } else if(pymntMeansCode == '02') {
        showCashReceipts(lgupMid, orderNum, '001', 'BANK', lgupKey);
    } else if(pymntMeansCode == '03') {
    } else if(pymntMeansCode == '04') {
        showCashReceipts(lgupMid, orderNum, '001', 'CAS', lgupKey);
    }
}


function popupShowKCPReceipt(pymntMeansCode, orderNum, tradeMoney, authno, lgupDealNum) {
    if(pymntMeansCode == '01') {
        openKcpCardReceipt(lgupDealNum, orderNum, tradeMoney, 'card_bill');
    } else if(pymntMeansCode == '02') {
        openKcpCardReceipt(lgupDealNum, orderNum, tradeMoney, 'acnt_bill');
    } else if(pymntMeansCode == '03') {
        openKcpCardReceipt(lgupDealNum, orderNum, tradeMoney, 'mcash_bill');
    } else if(pymntMeansCode == '04') {
        openKcpCardReceipt(lgupDealNum, orderNum, tradeMoney, 'vcnt_bill');
    }
}


function openKcpCardReceipt(tno, order_no, trade_money, cmd) {
    var url = 'https://admin8.kcp.co.kr/assist/bill.BillActionNew.do?cmd=' + cmd + '&tno=' + tno + '&order_no=' + order_no + '&trade_mony=' + trade_money;
    var options = 'width:470,height:815';
    window.open(url, 'about:blank', options);
}


function openKcpCashReceipt(order_no, authno, trade_money) {
    var url = 'https://admin8.kcp.co.kr/assist/bill.BillActionNew.do?cmd=cash_bill&cash_no=' + authno + '&order_no=' + order_no + '&trade_mony=' + trade_money;
    var options = 'width:420,height:670';
    window.open(url, 'about:blank', options);
}


function checkPostNum(postNum){
   var result;
   $.ajax({
       type:"post"
       , url: "/common/checkPostNum"
       , data:{postNum: postNum}
       , dataType: "json"
       , async: false
       , success: function(data){
           result = data.checkedPostNum;
       }, error: function(data){}
   });
   return result;
}


function popupWriteProductReview(prdtCode, orderNum) {
    
    var url = '/abc/mypage/writeReview?prdtCode=' + prdtCode + '&orderNum=' + orderNum;
    var options = 'width=718,height=1110,scrollbars=yes';
    window.open(url, 'about:blank', options);
}


function popupWriteNoMemberShipProductReview(prdtCode, orderNum) {
    alert('상품후기에 대한 포인트는 \n멤버십회원만 지급됩니다.\n\n멤버십회원으로 전환 가입하시면,\n포인트를 받으실 수 있습니다.');
    
    var url = '/abc/mypage/writeReview?prdtCode=' + prdtCode + '&orderNum=' + orderNum;
    var options = 'width=718,height=1110,scrollbars=yes';
    window.open(url, 'about:blank', options);
}



function popupWriteProductReviewOffline(productCd, orderNum, sizeCd, storeCd, saleDate, dealNo, posNo, safeKeySeq) {
    var url = '/abc/mypage/writeReviewOffline';
    url += '?productCd=' + productCd;
    url += '&orderNum=' + orderNum;
    url += '&sizeCd=' + sizeCd;
    url += '&storeCd=' + storeCd;
    url += '&saleDate=' + saleDate;
    url += '&dealNo=' + dealNo;
    url += '&posNo=' + posNo;
    url += '&safeKeySeq=' + safeKeySeq;
    var options = 'width=718,height=1110,scrollbars=yes';
    window.open(url, 'about:blank', options);
}


function popupSearchPostCode(paramId) {
    var protocol = 'http://';
    if(window.location.href.indexOf('https') != -1) {
        protocol = 'https://';
    }

    var host = 'http://www.abcmart.co.kr';
    if(host && host.indexOf('http://') != -1) {
        host = host.substring('http://'.length);
    }

    var url = protocol + host + '/abc/common/searchPostCode';
    if(paramId) {
        url += '?paramId=' + paramId;
    }
    var options = 'width=500,height=550,resizable=0';
    window.open(url, 'about:blank', options);
}



function openPopupFixedPurchase(orderNum) {
    $.ajax({
        type: "POST"
        ,url: "/abc/mypage/checkOrderForDecidedPurchase"
        ,data: {orderNum : orderNum}
        ,dataType: "json"
        ,success : function(data) {
            if(data.checked) {
                window.open('/abc/mypage/popupDecidedPurchase?orderNum='+orderNum, 'pop_change_pass','width=890 , height=1110, scrollbars=yes');
            } else {
                alert(data.errorMessages.join("\n"));
            }
        }
        ,error: function(data) {
            alert('시스템 오류가 발생 했습니다. 관리자에게 문의하세요.');
        }
    });
}



function openPopupChangeMessage(orderNum) {
    window.open('/abc/mypage/popupChangeMessageForm?orderNum='+orderNum, 'popup_membership_clause', 'width=821 , height=310' );
    return false;
}






function openOptionChangeLayerPopup(orderNum, orderPrdtSeq, dlvyId){
    if(!orderNum || !orderPrdtSeq || !dlvyId){
        return;
    }
    
    $.ajax({
        type: "post"
        ,url: "/abc/mypage/popupChangeOrderProductOption"
        ,data: {orderNum : orderNum , orderPrdtSeq : orderPrdtSeq, dlvyId : dlvyId}
        ,dataType: "html"
        ,success : function(html) {
            $("#optionChangeArea").html(html);
            layerPopupShow($("#optionChangeArea"), false);
        }
    });
}


function orderCancelForMypage(orderNum, pymntMeansCode, orderStatCode){
    if(!orderNum){
        return;
    }
    
    if(pymntMeansCode == "04" && orderStatCode == "02") {
        window.open("/abc/mypage/popupOrderCancelAccountInfo?orderNum=" + orderNum, "poupOrderCancelAccountInfo", "width=530 , height=340,scrollbars=no");
    } else {
        if(confirm("주문번호 : " + orderNum + "\n주문을 취소하시겠습니까?")) {
            var url = "/abc/mypage/cancelOrderAll";
            $.ajax({
                type: "post"
                ,url: url
                ,async : false
                ,dataType: "json"
                ,data: {orderNum : orderNum}
                ,success: function(data) {
                    if(data.success) {
                        alert("취소하셨습니다.");
                        window.location.reload();
                    }else {
                        alert(data.errorMessages[0]);
                    }
                }
                ,error: function(xhr, status, error) {
                    alert("시스템 오류가 발생 했습니다. 관리자에게 문의하세요.");
                }
            });
        }
    }
}


function changePayment(orderNum) {
    window.open("/abc/mypage/popupChangePayment?orderNum=" + orderNum, "popupChangePayment", "width=910 , height=700");
}


function openChangePaymentHistoryPopup(orderNum) {
    window.open("/abc/mypage/popupListChangePaymentByOrderNum?orderNum=" + orderNum, "popupListChangePayment", "width=570 , height=430");
}


function openPromotion(plndpId, eventId) {
    if(plndpId != ""){
        location.href = "/abc/planDisp/detail?plndpId=" + plndpId;
    }else{
        location.href = "/abc/promotion/startEvent?eventId=" + eventId;
    }
}

function goValidEscrow(mertid){
    var strMertid = mertid; 
    window.open("https://admin.kcp.co.kr/Modules/escrow/kcp_pop.jsp?site_cd="+strMertid,"check","width=500, height=450, scrollbars=no");
}


function goSearch(searchTerm){
    location.href = "/abc/search/search?searchTerm=" + encodeURIComponent(searchTerm);
}


function sendAppDownloadUrl(deviceType){
    if(isLogin == 'false') {
        //alert("로그인 후 이용 가능 합니다.");
        moveLoginForm();
        return false;
    }else{
        $.ajax({
            type: "post"
            , url: "/abc/mypage/sendSmsMobileAppNotice"
            , data: {
                "phoneNumber": "event", "deviceType": deviceType
            }
            , dataType: "json"
            , success: function(data) {
                alert("전송하였습니다.");
            }
            , error: function(xhr, status, error) {
                alert("시스템 오류가 발생 했습니다. 관리자에게 문의하세요.");
            }
        });
    }
}


function joinMemberShip() {

    if (isLogin == 'false') { 
        alert("로그인하셔야 합니다.");
        document.location.href = "https://www.abcmart.co.kr/abc/login/form?redirectUrl=" + getOrgUrl();
        return false;
    }

    var memberShipYn = "";
    if (memberShipYn == 'true'){
        alert("이미 통합 멤버십 회원입니다.");
    } else {
        document.location.href = "http://www.abcmart.co.kr/abc/user/memberShipAgreement";
    }

    return false;
}


function isScollTopPrdtList(){
    var url = location.href;
    return (url.toLowerCase().indexOf('#product_list') > -1 || getParameterByName('up_prdtlist').toLowerCase() == 'y');
}


function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}


function corporateOpen() {
	var url = "http://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=2018176174";
	window.open(url, "communicationViewPopup", "width=750, height=700;");
}


function productBrandCheck(brandId,startDtm,endDtm) {
	
	var number = /[^0-9]/;
	
	if(brandId != ""){
		if(brandId == ""){
			alert("브랜드 아이디를 넣어주세요.");
			return false;
		} else if(brandId.length != 6){
			alert("브랜드 아이디가 6자리인지 확인해 주세요.");
			return false;
		} else if(brandId.search(number) != -1){
			alert("브랜드 아이디가 숫자인지 확인해 주세요.");
			return false;
		}
	}
	
	if(startDtm == ""){
		alert("이벤트 시작일자를 넣어주세요.");
		return false;
	} else if(startDtm.length != 8){
		alert("이벤트 시작일자가 8자리인지 확인해 주세요.");
		return false;
	} else if(startDtm.search(number) != -1){
		alert("이벤트 시작일자가 숫자인지 확인해 주세요.");
		return false;
	}
	
	if(endDtm == ""){
		alert("이벤트 종료일자를 넣어주세요.");
		return false;
	} else if(endDtm.length != 8){
		alert("이벤트 종료일자가 8자리인지 확인해 주세요.");
		return false;
	} else if(endDtm.search(number) != -1){
		alert("이벤트 종료일자가 숫자인지 확인해 주세요.");
		return false;
	}

    if (isLogin == 'false') { 
        alert("로그인 후 참여 가능합니다");
        document.location.href = "https://www.abcmart.co.kr/abc/login/form?redirectUrl=" + getOrgUrl();
        return false;
    }

	var eventId =  $("#eventId").val();

    $.ajax({
        type: "post"
        ,url: "/abc/event/brandCheck"
        ,data: {
            'eventId' : eventId, 'brandId' : brandId, 'startDtm' : startDtm, 'endDtm' : endDtm
        }
        ,dataType: "json"
        ,success : function(data) {
			if(data.success) {
	           	var successMessages = data.successMessages;
	           	alert(successMessages[0]);
	        }else{
	        	var errorMessages = data.errorMessages;
	     		alert(errorMessages[0]);
	        }
        }
    });
}