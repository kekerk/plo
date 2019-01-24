




jQuery(function($) {
//    $('input.inputNumberText').numeric();
    $('input.inputNumberText').keydown(function(event){
        inputNumberTextKeyDown(event);
    });
});

function inputNumberTextKeyDown(event){
    if(isEmpty(event)) {
        event = window.event;
    }
    
    if (event.keyCode != 13) {
        if (event.keyCode != 8) {
            if (event.keyCode == 9 || (!event.shiftKey && (event.keyCode >= 48 && event.keyCode <= 57)) || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 17 || event.keyCode == 67 || event.keyCode == 86) {
            }else{
                event.preventDefault();
            }
        }
    }
}


function accountNumTextKeyDown(event){
    if (event.keyCode != 13) {
        if (event.keyCode != 8) {
            if (event.keyCode == 9 || (!event.shiftKey && (event.keyCode >= 48 && event.keyCode <= 57)) || (event.keyCode >= 96 && event.keyCode <= 105 || event.keyCode == 189 )) {
            } else{
                event.preventDefault();
            }
        }
    }
}

function isEmpty(value) {
    var trimValue = $.trim(value);
    return (trimValue == null || trimValue == undefined || trimValue == "");
}

function openWindow(url, width, height, target) {
    if (isEmpty(target)) {
        target = '_BLANK';
    }
    
    window.open(url, target, 'width=' + width + ',height=' + height + ',scrollbars=yes');    
}


function discountPrice(sellPrice, dscntRate){
    
    var rate = parseFloat(dscntRate);
    var discountRate = (rate * 100.0) / 100.0;
    var minusPrice = Number((sellPrice * (discountRate / 100)));
    minusPrice = cutoff(minusPrice);
    
    return minusPrice;
}

function cutoff(minusPrice){
    return parseInt(Math.round((parseFloat(minusPrice) / 100.0))) * 100;
}

function expectSavePoint(sellPrice, dscntRate){
    
    var savePoint = (sellPrice * dscntRate) / 1000.0;
    savePoint = Math.floor(parseFloat(savePoint)) * 10;
    return parseInt(savePoint);
}



function discountRate(sellPrice, dscntSellPrice){

    var newDiscountRate = ((parseInt(sellPrice) - parseInt(dscntSellPrice)) / (parseInt(sellPrice) * 1.0)) * 100.0;
    /* 할인율 노출정책변경(2016-08-29 할인율 내림, 할인금액 올림) : ceil > floor */
    newDiscountRate = Math.floor(newDiscountRate);
    
    return newDiscountRate;
}

function price_format(val){
    val = $.trim(val+"");
    if(val == ''){ return val; }
    if(isNaN(val)){ return val; }

    var rv = "", idx = 0;
    for (var i = val.length-1 ; i >= 0 ; i--){
        rv = ((idx != 0 && idx%3 == 0) ? val.substring(i, i+1) + "," : val.substring(i, i+1)) + rv;
        idx++;
    }

    return rv;
}


function removeComma(val) {
    val = $.trim(val+"");
    val = val.replace(/,/gi, '');
    
    if(val == ''){ return val; }
    if(isNaN(val)){ return val; }
    
    return val;
}

function onlyNum() {
    if((event.keyCode < 48 || event.keyCode > 57 || event.shiftKey)
            && event.keyCode != 8 && event.keyCode != 9
            && ((event.keyCode < 96) || (event.keyCode > 105))
            && event.keyCode != 46 && event.keyCode != 13
            && event.keyCode != 37 && event.keyCode != 39
            && event.keyCode != 35 && event.keyCode != 36){

        event.returnValue = false;
        event.cancel = true;
        
        if(event.preventDefault){
            event.preventDefault();
        }
    }
}


function numberFilter(value){
    return value.replace(/[^0-9]/gi, "");
}

function onlyNumForKeyup(obj) {
    var isValid = false;
    var pattern = /\D/g;
    var cut = obj.val().substr(0, obj.val().length - 1);
    
    if (pattern.test(obj.val())) {
        isValid = false;
        alert("숫자만 사용할 수 있습니다.");
        obj.val(cut);
    } else {
        isValid = true;
    }
    
    return isValid;
}


function dataFormat(str){
    if(str.length == 8){
        str = str.substr(0,4) + "-" + str.substr(4,2) + "-" + str.substr(6,2);
    }

    return str;
}

function validateResno(obj) {
    return onlyNumForKeyup(obj);
}




function validatePassword($_obj) {
    
    var pswdStr            = $_obj.val();
    var pswdStrLength    = $_obj.val().length;
    
    
    var msg = "영문, 숫자의 조합 10자 이상";
    var fontColor = "#a38b7d";
    var isValid = false;

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

    
    if (pswdStrLength >= 10 && pswdStrLength <= 20) {
        
        
        if (pt1.test(pswdStr)) { isChkOk1 = true; }

        
        if (pt2.test(pswdStr)) { isChkOk2 = true; }

        
        if (pt3.test(pswdStr)) { isChkOk3 = true; }
    
        
        if (pt4.test(pswdStr)) {isChkOk6 = false; }
    
        
        var alpNumSpc = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "`", "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "=", "+", "[", "{", "]", "}", "\\", "|", "'", "\"", ";", ":", "/", "?", ".", ">", ",", "<"];
        for (var i = 0; i < alpNumSpc.length; i++) {
            var pt = new RegExp(((i > 35)? "\\" + alpNumSpc[i] : alpNumSpc[i]) + "{3,}", "g");
            if (pt.test($_obj.val())){
                isChkOk4 = false;
                break;
            }
        }

        
        if($("input[name='userId']").val() == $_obj.val() || $("input[name='id']").val() == $_obj.val()){
            isChkOk5 = false;
        }
        
        
        if (isChkOk1 || isChkOk2 || isChkOk3) {
            fontColor = "#fe5156"; 
            if (!isChkOk4) {
                msg = "동일 문자 3회 사용";
            } else if (!isChkOk5) {
                msg = "아이디와 동일";
            } else if (!isChkOk6) {
                msg = "공백 사용";
            } else {
                msg = "사용 가능"
                fontColor = "#00bff3";
                isValid = true;
            }
        } else {
            fontColor = "#fe5156";
        }
    }else if(pswdStrLength > 20){
        fontColor = "#fe5156";
        isValid = false;
    }

    
    $_obj.next().text(msg).css("color", fontColor);
    return isValid;
}


function validateNumPassword(obj) {
    var isValid = false;
    
    if (!isEmpty(obj.val()) && (obj.val().length < 4)) {
        isValid = false;
        obj.next().text("4자리 숫자").css("color", "gray");
    } else if (obj.val().length == 4) {
        var num = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
        var pattern = /\D/g;
        
        if (pattern.test(obj.val())) {
            isValid = false;
            obj.next().text("숫자만 사용할 수 있습니다.").css("color", "#fe5156");
        } else {
            isValid = true;
            obj.next().text("사용가능.").css("color", "#00bff3");
        }
        
        for (var i = 0; i < num.length; i++) {
            var pattern3 = new RegExp(num[i] + "{4,}", "g");
            if (pattern3.test(obj.val())){
                isValid = false;
                obj.next().text("같은 숫자를 네번 사용할 수 없습니다.").css("color", "#fe5156");
                break;
            }
        }
    }
    
    return isValid;
}

function imageError(obj) {
    obj.src = "http://image.abcmart.co.kr/nexti/images/noimage.gif";
}

function validateId(obj) {
    var pattern = /\W/g;
    var cut = obj.val().substr(0, obj.val().length - 1);
    
    if (!isEmpty(obj.val()) && pattern.test(obj.val())){
        alert("영문, 숫자만 입력할 수 있습니다.");
        obj.val(cut);
    }
}

function validateName(obj) {
    var pattern = /[^ㄱ-힣]/g;
    var cut = obj.val().substr(0, obj.val().length - 1);
    
    if (!isEmpty(obj.val()) && pattern.test(obj.val())){
        alert("한글만 입력할 수 있습니다.");
        obj.val(cut);
    }
}

/*****
* 영문과 숫자만 입력
* onkeydown="javaScript:validateNonKr();"
******/
function validateNonKr() {
    if(event.keyCode == 13 || event.keyCode == 35 || event.keyCode == 36 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 116 || event.keyCode == 8 || event.keyCode == 16 || (65 <= event.keyCode && event.keyCode <= 90) || (event.keyCode >= 96 && event.keyCode <= 105) || (!event.shiftKey && (47 < event.keyCode && event.keyCode < 58)) || event.keyCode == 9){
    }else{
        event.returnValue = false;
    }
}

/*****
* 영문과 숫자만 입력
* onkeydown="javaScript:validateNonKrForUserId();"
******/
function validateNonKrForUserId() {
    if(event.keyCode == 13 || event.keyCode == 35 || event.keyCode == 36 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 116 || event.keyCode == 8 || event.keyCode == 16 || (65 <= event.keyCode && event.keyCode <= 90) || (event.keyCode >= 96 && event.keyCode <= 105) || (!event.shiftKey && (47 < event.keyCode && event.keyCode < 58)) || event.keyCode == 9 || event.keyCode == 189){
    }else{
        event.returnValue = false;
    }
}

/*****
* 영문과 숫자 골뱅이@ 쩜. 만입력
* onkeydown="javaScript:validateNonKrForEmail();"
******/
function validateNonKrForEmail() {
    if(event.keyCode == 13 || event.keyCode == 35 || event.keyCode == 36 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 50 || event.keyCode == 110 || event.keyCode == 116 || event.keyCode == 190 || event.keyCode == 8 || event.keyCode == 16 || (65 <= event.keyCode && event.keyCode <= 90) || (event.keyCode >= 96 && event.keyCode <= 105) || (!event.shiftKey && (47 < event.keyCode && event.keyCode < 58) || (event.shiftKey && event.keyCode === 189) || event.keyCode == 189)){
    }else{
        event.returnValue = false;
    }
}

/*****
* 111@222.333.444
* @ 로 split한후 111 에 영문과숫자 - _ 를 제외한 특수문자를 체크한다.
* @ 로 split한후 도메인에 영문과 숫자 - _ 를 제외한 특수문제를 체크하고  222.333 형태인지 체크한다.
******/
function validateEmail(temp) {
    var tempArray = temp.split("@",2);
    var flag = true;
        //if(tempArray[0] == null || (/[^\w-]/g).test(tempArray[0]) || tempArray[1] == null || (/[^\w\.]/g).test(tempArray[1]) || !(/[^\s\.]\.[^\s\.]/g).test(tempArray[1])){
        if(tempArray[0] == null || tempArray[0].length < 1 || (/[^\w-\.]/g).test(tempArray[0]) || tempArray[1] == null || (/[^\w\.]/g).test(tempArray[1]) || !(/[^\s\.]\.[^\s\.]/g).test(tempArray[1])){
            flag = false;
        }
        return flag;
}

/*****
* 숫자와 ,   입력 (전화번호)
* onkeydown="javaScript:validateSmsPhoneNumber();"
******/
function validateSmsPhoneNumber() {
    
    if(event.keyCode == 8 || 35 <= event.keyCode && event.keyCode <= 40 || event.keyCode == 46 || event.keyCode == 188 || (48 <= event.keyCode && event.keyCode <= 57) || (96 <= event.keyCode && event.keyCode <= 105) || (!event.shiftKey && (47 < event.keyCode && event.keyCode < 58))){
    }else{
        event.returnValue = false;
    }
}


// maxlength 체크
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }
}

//ie 버전 체크
function msieversion(){
      var ua = window.navigator.userAgent
      var msie = ua.indexOf ( "MSIE " )

      if ( msie > 0 )      // If Internet Explorer, return version number
         return parseInt (ua.substring (msie+5, ua.indexOf (".", msie )))
      else                 // If another browser, return 0
         return 0

}

//중복메시지 제거
function uniqueMsg(list) {
    if(isEmpty(list)) return;
    
    var result = [];
    $.each(list, function(i, e) {
        if ($.inArray(e, result) == -1) result.push(e); //중복된 메시지가 아니라면 넣는다.
    });
    return result;
}

//접속환경 반환: P(PC), 그외는 mobile 입니다.
function getUserDeviceType() {
    var userAgent = navigator.userAgent.toLowerCase();
    
    var device = "pc";
    var mobileKeyWords = ["android", "iphone", "ipad"];
    
    for(var i =0; i < mobileKeyWords.length; ++i){
        if(userAgent.indexOf(mobileKeyWords[i]) != -1) {
            device =  mobileKeyWords[i];
            break;
        }
    }
    return device;
}


function openPromotionBeforeCopyUrl(plndpId, eventId, copypUrlYn) {
    //접속 환경에 따라 url 분기
    var device = getUserDeviceType() == 'pc' ? "abc" : "mobile"
    
    //URL을 클립보드에 복사
    var IE=(document.all) ? true : false;
    
    if (IE) {
        window.clipboardData.setData("Text", location.href);
        alert('[URL 주소가 복사 되었습니다.\n\Ctrl + V 또는 붙여 넣기를 선택하여 이용하시기 바랍니다.]');
    } else {
        if(device == 'abc') { //pc
            temp = prompt("[Ctrl+C를 눌러 URL주소를 복사하여 주시기 바랍니다.]", location.href);
        } else {
            temp = prompt("[URL주소를 복사하여 주시기 바랍니다.]", location.href);
        }
    }
    
    //기획전 or 이벤트 페이지 이동
    if(plndpId != ""){
        location.href = "/" + device + "/planDisp/detail?plndpId=" + plndpId;
    }else{
        location.href = "/" + device + "/promotion/startEvent?eventId=" + eventId;
    }
}


function openPromotionCopyUrl(plndpId, eventId) {
    //접속 환경에 따라 url 분기
    var device = getUserDeviceType() == 'pc' ? "abc" : "mobile"
    
    //URL을 클립보드에 복사
    var IE=(document.all) ? true : false;
    
    if (IE) {
        window.clipboardData.setData("Text", location.href);
        alert('[URL 주소가 복사 되었습니다.\n\Ctrl + V 또는 붙여 넣기를 선택하여 이용하시기 바랍니다.]');
    } else {
        if(device == 'abc') { //pc
            temp = prompt("[Ctrl+C를 눌러 URL주소를 복사하여 주시기 바랍니다.]", location.href);
        } else {
            temp = prompt("[URL주소를 복사하여 주시기 바랍니다.]", location.href);
        }
    }

}

function userHashEmail(){
    var userEmail = "";
    
    userEmail = "";
    

    return userEmail;
}