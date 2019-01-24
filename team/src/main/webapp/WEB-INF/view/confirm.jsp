<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<script>
	var ok = confirm("${exception.message}");
	if(ok==true) { 
		location.href='../cart/cartView.shop'; 
	} else { 
		location.href='${exception.url}';
	}
</script>