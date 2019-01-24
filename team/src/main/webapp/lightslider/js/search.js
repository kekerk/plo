





function searchInit(){

    if($(".searchCondArea").length <= 0){
        return false;
    }

    // 상품View type 조회
    $("div#searchProductList .check_type_gallery ul.view_type li").each(function(i){
        if($(this).is(".current")){
            $(this).find("a").click();
        }
    });
  
    // Start 선택영역 toggle 이벤트 ======================================
    //1. 브랜드
    $(".condBrand").on("click", function(){
        $(this).toggleClass('current');
        
        var brandNm = $(this).find("img.imgOn").attr("alt");
        var brandId = $(this).find("input[name='tempId']").val();
        
        if($(this).is(".current")){
            $(this).find("img.imgOff").hide();
            $(this).find("img.imgOn").show();
            
            appendSearchRemoveArea("condBrand", brandId, brandNm);
        }else{
            $(this).find("img.imgOff").show();
            $(this).find("img.imgOn").hide();
            
            $(".searchRemoveArea li.condBrand" + brandId).remove();
        }
    });
    
    //2.1 대카테고리
    $(".condLCategory").on("click", function(){
        var checked = $(this).prop("checked");
        $(this).parent().parent().parent().find(".condMCategory").prop("checked", checked);
        
        // 선택영역 삭제 이벤트 =====
        var lCategoryNm = $(this).parent().find("label").text();
        var lCategoryId = $(this).val();
        if($(this).is(":checked")){
            appendSearchRemoveArea("condLCategory", lCategoryId,  lCategoryNm);
            $(this).parent().parent().parent().find(".condMCategory").each(function(){
                var mCategoryNm = $(this).parent().find("label").text();
                var mCategoryId = $(this).val();        
                appendSearchRemoveArea("condMCategory", mCategoryId,  mCategoryNm);
            });
        }else{
            $(".searchRemoveArea li.condLCategory" + lCategoryId).remove();
            $(this).parent().parent().parent().find(".condMCategory").each(function(){
                var mCategoryId = $(this).val();        
                $(".searchRemoveArea li.condMCategory" + mCategoryId).remove();
            });
        }
        // ======================
    });
    
    //2.2 중카테고리
    $(".condMCategory").on("click", function(){
        // 선택영역 삭제 이벤트 =====
        var mCategoryNm = $(this).parent().find("label").text();
        var mCategoryId = $(this).val();
        if($(this).is(":checked")){
            appendSearchRemoveArea("condMCategory", mCategoryId, mCategoryNm);

            //대카테고리가 체크가안되있을시 체크[검색 조회시 대카테고리가 함께 존재해야함]
            $(this).parent().parent().parent().parent().find(".condLCategory").prop("checked", true);
        }else{
            $(".searchRemoveArea li.condMCategory" + mCategoryId).remove();
            
            if($(this).parent().parent().parent().find("input:checked").length == 0){
                $(this).parent().parent().parent().parent().find(".condLCategory").prop("checked", false);
            }
        }
        //===================
    });
    
    
    //3.테마
    $(".condThema").on("click", function(){
        $(this).toggleClass('select');
        
        var thema = $(this).text();
        if($(this).is(".select")){
            appendSearchRemoveArea("condThema", thema, thema);
        }else{
            $(".searchRemoveArea li.condThema" + thema).remove();
        }
    });
    
    //4.size
    $(".condSize").on("click", function(){
        $(this).toggleClass('select');

        var size = $(this).find("a").text();
        if($(this).is(".select")){
            appendSearchRemoveArea("condSize", size, size);
        }else{
            $(".searchRemoveArea li.condSize" + size).remove();
        }
    });
    
    //5.색상 script.js의 클릭이벤트 off이후 재 설정
    $(".smart_color_zone").off("click");
    $(".condColor").on("click", function(){
        $(this).toggleClass('select');
        
        var color = $(this).find("a").text();
        if($(this).is(".select")){
            appendSearchRemoveArea("condColor", color, color);
        }else{
            $(".searchRemoveArea li.condColor" + color).remove();
        }
    });
        
    //가격 수정후 
    $("input[name='sPrice'], input[name='ePrice']").on("focusout", function(){
        
        // 선택영역 삭제 이벤트 =====
        $(".searchRemoveArea li.condPrice").remove();
        var value = $("input[name='sPrice']").val() + '원 ~ '+ $("input[name='ePrice']").val() +"원";
        var html = "<li class='condPrice'><span>" + value + "</span><a href='javascript://' class='ico_delete'>삭제</a></li>"; 
        $(".searchRemoveArea").append(html);
        searchRemoveAreaEvent();
        //===================
        
        $(this).val(removeComma($(this).val()));
    });
    
    //선택 해제
    searchRemoveAreaEvent();
    
    //전체 해제
    $(".searchRemoveAll").on("click", function(){
        searchRemoveAll();
    });

    // End 선택영역 toggle 이벤트 ======================================
     
    //cond영역의  선택된 내용 체크해서  선택한 조건 영역에 append *************************************************
    $(".searchRemoveArea").hide();
    $(".condBrand.current").each(function(i){
        var brandNm = $(this).find("img.imgOn").attr("alt");
        var brandId = $(this).find("input[name='tempId']").val();
        appendSearchRemoveArea("condBrand", brandId, brandNm);
        
    });
    
    $(".condLCategory:checked").each(function(){
        var lCategoryNm = $(this).parent().find("label").text();
        var lCategoryId = $(this).val();
        appendSearchRemoveArea("condLCategory", lCategoryId,  lCategoryNm);
    });
    
    $(".condMCategory:checked").each(function(){
        var mCategoryNm = $(this).parent().find("label").text();
        var mCategoryId = $(this).val();
        if($(this).is(":checked")){
            appendSearchRemoveArea("condMCategory", mCategoryId, mCategoryNm);

            //대카테고리가 체크가안되있을시 체크[검색 조회시 대카테고리가 함께 존재해야함]
            $(this).parent().parent().parent().parent().find(".condLCategory").prop("checked", true);
        }
    });
    
    
    $(".condThema.select").each(function(){
        var thema = $(this).text();
        appendSearchRemoveArea("condThema", thema, thema);
    });
    
    //4.size
    $(".condSize.select").each(function(){
        var size = $(this).find("a").text();
        appendSearchRemoveArea("condSize", size, size);
    });
    
    //5.색상 script.js의 클릭이벤트 off이후 재 설정
    $(".condColor.select").each(function(){
        var color = $(this).find("a").text();
        appendSearchRemoveArea("condColor", color, color);
    });
    
    //가격
    if(isEmpty($("input[name='sPrice']").val()) == false || isEmpty($("input[name='ePrice']").val()) == false){
	    var value = $("input[name='sPrice']").val() + '원 ~ '+ $("input[name='ePrice']").val() +"원";
	    var html = "<li class='condPrice'><span>" + value + "</span><a href='javascript://' class='ico_delete'>삭제</a></li>"; 
	    $(".searchRemoveArea").append(html);
	    searchRemoveAreaEvent();
    }
    //===================
    
    $(".searchRemoveArea").show();
  //cond영역의  선택된 내용 체크해서  선택한 조건 영역에 append *************************************************
};

//선택한 조건 표시 영역 삭제 이벤트
//카테고리 및 가격의 영역삭제이벤트는 선택영역클릭 이벤트 쪽에 존재
function searchRemoveAreaEvent(){
    $(".searchRemoveArea li").off("click");
    $(".searchRemoveArea li").on("click", function(){
        var checkId = $(this).attr("checkId");
        $(".checkEntity." + checkId).click();
        
        if($(this).is(".condPrice")){
            $("input[name='sPrice']").val($("input[name='initMinPrice']").val());
            $("input[name='ePrice']").val($("input[name='initMaxPrice']").val());
            $(this).remove();
        }
    });
}

//선택한 조건 표시 영역에 현재 클릭한 데이터 append 처리
function appendSearchRemoveArea(key, id, value){
     var html = "<li class='"+ key + id + "' checkId='"+ key + id + "'><span>" + value + "</span> <a href='javascript://' class='ico_delete'>삭제</a></li>"; 
     $(".searchRemoveArea").append(html);
     searchRemoveAreaEvent();
}

//선택영역에 체크된 내용을 form tag의 input 태그에 값을 세팅
function setParams(){
    $(".condSizeArea").show();
    
    $("form[name='totalSearch'] > input[name='kind']").val('shoes');
    if($("ul.searchRemoveArea li").length == 0){
        $("form[name='totalSearch'] > input[name='kind']").val(''); 
    }
    

    var token ="^";
    //브랜드명
    var brandNm="";
    $("article.smart_brand_article .condBrand.current").find("img.imgOn").each(function(i){
        if(i == 0){
            brandNm = $(this).attr("alt");
        }else{
            brandNm += token + $(this).attr("alt");
        }
    });
    //카테고리명[대,중]
    var largeCategory ="";
    $(".condLCategory:checked").each(function(i){
        if(i == 0){
            largeCategory = $(this).parent().find("label").text();
        }else{
            largeCategory += token + $(this).parent().find("label").text();
        }
    });
    
    var middleCategory ="";
    $(".condMCategory:checked").each(function(i){
        if(i == 0){
            middleCategory = $(this).parent().find("label").text();
        }else{
            middleCategory += token + $(this).parent().find("label").text();
        }
    });
    
    //테마
    var thema="";
    $(".condThema.select").each(function(i){
        if(i == 0){
            thema = $(this).text();
        }else{
            thema += token + $(this).text();
        }
    })
    //사이즈
    var size="";
     $(".condSize.select").each(function(i){
        if(i == 0){
            size = $(this).find("a").text();
        }else{
            size += token + $(this).find("a").text();
        }
    })
    //색싱
    var color="";
    $(".condColor.select").each(function(i){
        if(i == 0){
            color = $(this).find("a").text();
        }else{
            color += token + $(this).find("a").text();
        }
    })
    //가격
    var minPrice = "";
	var maxPirce = "";
    if(isEmpty($("input[name='sPrice']").val()) == false){
        minPrice = removeComma($("input[name='sPrice']").val());
    }
    if(isEmpty($("input[name='ePrice']").val()) == false){
        maxPirce = removeComma($("input[name='ePrice']").val());
    }

    //viewTYpe
    var viewType = "01";
    var obj = $(".check_type_gallery .view_type.tabs-nav li.current").find("a");
    if($(obj).is(".ico_view_list")){
        viewType = "02";
    }
    $("form[name='totalSearch'] > input[name='viewType']").val(viewType);
    
    
    $("form[name='totalSearch'] > input[name='brandName']").val(brandNm);
    $("form[name='totalSearch'] > input[name='largeCategory']").val(largeCategory);
    $("form[name='totalSearch'] > input[name='middleCategory']").val(middleCategory); 
    $("form[name='totalSearch'] > input[name='thema']").val(thema);
    
    if(isEmpty(minPrice) == false || isEmpty(maxPirce) == false){
	    $("form[name='totalSearch'] > input[name='minPrice']").val(minPrice);
	    $("form[name='totalSearch'] > input[name='maxPrice']").val(maxPirce);
    }else{
        $("form[name='totalSearch'] > input[name='minPrice']").val('');
        $("form[name='totalSearch'] > input[name='maxPrice']").val('');
    }

    $("form[name='totalSearch'] > input[name='size']").val(size);
    if(isEmpty(size)){
        $("form[name='totalSearch'] > input[name='minSize']").val("100");
        $("form[name='totalSearch'] > input[name='maxSize']").val("320");
    }else{
        $("form[name='totalSearch'] > input[name='minSize']").val("");
        $("form[name='totalSearch'] > input[name='maxSize']").val("");
    }
    
    $("form[name='totalSearch'] > input[name='detailColor']").val(color);
    
    if($("form[name='totalSearch'] > input[name='imgColor']").prop("setImgColorYn") != true){
        $("form[name='totalSearch'] > input[name='imgColor']").val("");
    }
}

function setSort(sort){
    if(isEmpty(sort)){
        sort = "ENTRY_DT";
    }
    $("form[name='productSearch'] > input[name='imgColor']").prop("setImgColorYn", true);
    $("form[name='productSearch'] > input[name='sort']").val(sort);
    $("form[name='productSearch'] > input[name='page']").val(1);
    $("form[name='productSearch']").submit();
    
}
function setListSize(listSize){
    if(isEmpty(listSize)){
        listSize = "40";
    }
    $("form[name='productSearch'] > input[name='imgColor']").prop("setImgColorYn", true);
    $("form[name='productSearch'] > input[name='listSize']").val(listSize);
    $("form[name='productSearch'] > input[name='page']").val(1);
    $("form[name='productSearch']").submit();
}
function setImgColor(colorCd){
    $("form[name='productSearch'] > input[name='imgColor']").prop("setImgColorYn", true);
    $("form[name='productSearch'] > input[name='imgColor']").val(colorCd);
    $("form[name='productSearch'] > input[name='page']").val(1);
    $("form[name='productSearch']").submit();
}

function getProductList(page){
    $("form[name='productSearch'] > input[name='imgColor']").prop("setImgColorYn", true);
    $("form[name='productSearch'] > input[name='page']").val(page);
    $("form[name='productSearch']").submit();
}

function bestRolling(){
    if($(".rolling_slider").length <= 0){
        return false;
    }
    
    var rollingbxslider=$(".rolling_slider").bxSlider({
        slideWidth: 150,
        maxSlides: 5,
        moveSlides: 1,
        slideMargin: 60,
        pager:false
    });
}

function searchValidation(){
    if($("ul.searchRemoveArea li").length == 0){
        return false;
    }
    return true;
}