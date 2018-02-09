<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="js/jqueryWeui1.1.2/css/weui.min.css">
<link rel="stylesheet" href="js/jqueryWeui1.1.2/css/jquery-weui.min.css">
<script src="js/jqueryWeui1.1.2/lib/jquery-2.1.4.js"></script>
<script src="js/jqueryWeui1.1.2/js/jquery-weui.min.js"></script>
<title>微信配置</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<style type="text/css">
.required {
	color: red;
}
</style>
</head>
<body>
	<form id="myForm">
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label required">appId</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" name="appId">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label required">appSecret</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" name="appSecret">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label required">token</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" name="token">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label required">aesKey</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" name="aesKey">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">mchId</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" name="mchId">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">apiKey</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" name="apiKey">
			</div>
		</div>
		<a href="javascript:ajaxSub();" class="weui-btn weui-btn_primary">更新配置</a>
	</form>
</body>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : '/wxApi/getConfig',
			type : "post",
			dataType : "json",
			async : false,
			success : function(config) {
				$.each(config, function(key, val) {
					$("[name=" + key + "]").val(val);
				})
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
				alert("获取配置失败!");
			}
		})
	})

	function ajaxSub() {
		$.ajax({
			url : '/wxApi/setConfig',
			type : "post",
			data : $('#myForm').serialize(),// 你的formid
			dataType : "text",
			async : false,
			success : function(data) {
				alert(data);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
				alert("更新配置失败!");
			}
		})
	}
</script>
</html>