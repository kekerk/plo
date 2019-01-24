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
<div id="target3" class="pop_wrap" style="width: 700px; margin-left: -350px; margin-top: -378.5px; display: block;" tabindex="0">

<script>
$(function() {
    $('form#form-target3').on('submit', function() {
        var $cnslClassId = $('input[name=cnslClassId]:checked');
        var $cnslTitle = $('input[name=cnslTitle]');
        var $cnslCont = $('textarea[name=cnslCont]');

        if(isEmpty($cnslClassId.val())) {
            alert('문의유형을 선택해 주세요.');
            $($('input[name=cnslClassId]')[0]).focus();
            return false;
        }

        if(isEmpty($cnslTitle.val())) {
            alert('제목을 입력해 주세요.');
            $cnslTitle.val();
            return false;
        }

        if(isEmpty($cnslCont.val())) {
            alert('내용을 입력해 주세요.');
            $cnslCont.focus();
            return false;
        } else if($cnslCont.val().length > 5000) {
            alert('내용은 5000자 이내로 작성해 주세요.');
            $cnslCont.focus();
            return false;
        }

        if(confirm('등록하시겠습니까?')) {
            $.ajax({
                type: 'get',
                url: 'https://localhost:8080/board/main.shop',
                data: $('form#form-target3').serialize(),
                dataType: 'jsonp',
                jsonpCallback: 'jsonpCallback',
                success: function(data, textStatus, jqXHR) {
                    if(data && data.save) {
                        alert('저장되었습니다.');
                        $('div#target3').find('button.pop_x').click();
                        var reloadUrl = location.href;
                        if(reloadUrl.indexOf('#') != -1) {
                            reloadUrl = reloadUrl.substring(0, reloadUrl.indexOf('#')) + '#info_box3';
                        }
                        location.href = reloadUrl;
                        location.reload(true);
                    } else {
                        alert(data.errorMessages);
                        $('div#target3').find('button.pop_x').click();
                    }
                }
            });
        }
        return false;
    });
    
    
    $("button.btnEdit").click(function() {
        var $cnslClassId = $('input[name=cnslClassId]:checked');
        var $cnslTitle = $('input[name=cnslTitle]');
        var $cnslCont = $('textarea[name=cnslCont]');

        if(isEmpty($cnslClassId.val())) {
            alert('문의유형을 선택해 주세요.');
            $($('input[name=cnslClassId]')[0]).focus();
            return false;
        }

        if(isEmpty($cnslTitle.val())) {
            alert('제목을 입력해 주세요.');
            $cnslTitle.val();
            return false;
        }

        if(isEmpty($cnslCont.val())) {
            alert('내용을 입력해 주세요.');
            $cnslCont.focus();
            return false;
        } else if($cnslCont.val().length > 5000) {
            alert('내용은 5000자 이내로 작성해 주세요.');
            $cnslCont.focus();
            return false;
        }

        if (confirm('수정하시겠습니까?')) {
            $.ajax({
                type: "post"
                , url: "https://www.abcmart.co.kr/abc/customer/writeConsultation"
                , data: {
                    "cnslSeq" : '',
                    "cnslClassId" : $cnslClassId.val(),
                    "cnslTitle" : $cnslTitle.val(),
                    "cnslCont" : $cnslCont.val(),
                    "prdtCode" : '0034906',
                    "snsId" : ''
                }
                , dataType: "json"
                , success: function(data) {
                    if (data.save) {
                        alert('저장하였습니다.');
                    } else {
                        alert(data.errorMessages[0]);
                    }
                    location.reload(true);
                }
                , error: function(xhr, status, error) {
                    alert("시스템 오류가 발생 했습니다. 관리자에게 문의하세요.");
                }
            });
        }
    });
});
</script>


<header class="pop_header">
    <h2>상품 Q&amp;A 작성</h2>
    <button type="button" class="pop_x ico_close2">Close</button>
</header>

<div class="pop_container qnaBox">
    <div class="pop_content detail_info_area">
        <header class="product_tit qna_tit clearfix">
            <div class="fl-l mr30 proImg">
                <img src="../picture/" alt="OLD SKOOL" onerror="imageError(this)">
            </div>
            <div class="fl-l mt5">
                <span class="fs18 fc_type5 mb10">${item.brand }</span>
                <h2 class="tit_type1 fs22">${item.name}</h2>
                <p class="mt40">
                    <span>${item.price }<span>원</span></span>
                    
                </p>
            </div>
        </header>

<form id="form-target3" action="../board/qna.shop" method="post">
            <input type="hidden" name="prdtCode" value="0034906">
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
        </form>
        <ul class="list_type2 mt10">
            
            <li class="mb5">상품문의가 아닌 일반 문의는 <a href="http://www.abcmart.co.kr/abc/customer/writeConsultation" class="btn_sType3">1:1문의</a> 를 이용해주세요.
            </li><li>나의 문의 내역은 <a href="http://www.abcmart.co.kr/abc/mypage/counselingHistory" class="btn_sType3">마이페이지</a> 에서 확인 가능합니다.</li>
        </ul>
    </div>
    <div class="btn_group">
        
            <button type="button" class="btn_mType1" onclick="$('form#form-target3').submit();">등록</button>
        
        
        <button type="button" class="btn_mType3">닫기</button>
    </div>
</div></div>
</body>
</html>