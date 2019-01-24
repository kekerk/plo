<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<head>
<meta charset="EUC-KR">
<title>��ǰ����</title>
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
            alert('���������� ������ �ּ���.');
            $($('input[name=cnslClassId]')[0]).focus();
            return false;
        }

        if(isEmpty($cnslTitle.val())) {
            alert('������ �Է��� �ּ���.');
            $cnslTitle.val();
            return false;
        }

        if(isEmpty($cnslCont.val())) {
            alert('������ �Է��� �ּ���.');
            $cnslCont.focus();
            return false;
        } else if($cnslCont.val().length > 5000) {
            alert('������ 5000�� �̳��� �ۼ��� �ּ���.');
            $cnslCont.focus();
            return false;
        }

        if(confirm('����Ͻðڽ��ϱ�?')) {
            $.ajax({
                type: 'get',
                url: 'https://localhost:8080/board/main.shop',
                data: $('form#form-target3').serialize(),
                dataType: 'jsonp',
                jsonpCallback: 'jsonpCallback',
                success: function(data, textStatus, jqXHR) {
                    if(data && data.save) {
                        alert('����Ǿ����ϴ�.');
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
            alert('���������� ������ �ּ���.');
            $($('input[name=cnslClassId]')[0]).focus();
            return false;
        }

        if(isEmpty($cnslTitle.val())) {
            alert('������ �Է��� �ּ���.');
            $cnslTitle.val();
            return false;
        }

        if(isEmpty($cnslCont.val())) {
            alert('������ �Է��� �ּ���.');
            $cnslCont.focus();
            return false;
        } else if($cnslCont.val().length > 5000) {
            alert('������ 5000�� �̳��� �ۼ��� �ּ���.');
            $cnslCont.focus();
            return false;
        }

        if (confirm('�����Ͻðڽ��ϱ�?')) {
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
                        alert('�����Ͽ����ϴ�.');
                    } else {
                        alert(data.errorMessages[0]);
                    }
                    location.reload(true);
                }
                , error: function(xhr, status, error) {
                    alert("�ý��� ������ �߻� �߽��ϴ�. �����ڿ��� �����ϼ���.");
                }
            });
        }
    });
});
</script>


<header class="pop_header">
    <h2>��ǰ Q&amp;A �ۼ�</h2>
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
                    <span>${item.price }<span>��</span></span>
                    
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
        </form>
        <ul class="list_type2 mt10">
            
            <li class="mb5">��ǰ���ǰ� �ƴ� �Ϲ� ���Ǵ� <a href="http://www.abcmart.co.kr/abc/customer/writeConsultation" class="btn_sType3">1:1����</a> �� �̿����ּ���.
            </li><li>���� ���� ������ <a href="http://www.abcmart.co.kr/abc/mypage/counselingHistory" class="btn_sType3">����������</a> ���� Ȯ�� �����մϴ�.</li>
        </ul>
    </div>
    <div class="btn_group">
        
            <button type="button" class="btn_mType1" onclick="$('form#form-target3').submit();">���</button>
        
        
        <button type="button" class="btn_mType3">�ݱ�</button>
    </div>
</div></div>
</body>
</html>