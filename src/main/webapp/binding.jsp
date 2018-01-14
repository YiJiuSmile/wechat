<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="js/jqueryWeui1.1.2/css/weui.min.css">
<link rel="stylesheet" href="js/jqueryWeui1.1.2/css/jquery-weui.min.css">
<script src="js/jqueryWeui1.1.2/lib/jquery-2.1.4.js"></script>
<!-- <script src="https://cdn.bootcss.com/jquery/1.8.3/jquery.min.js"></script> -->
<script src="js/jqueryWeui1.1.2/js/jquery-weui.min.js"></script>
<title>用户绑定</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
</head>
<body>
	<input id="contextPath" type="hidden" value="${contextPath}" />
	<input type="hidden" name="url" id="url"
		value="<%=request.getParameter("url")%>" />
	<form id="myForm">
		<input type="hidden" name="openid" id="openid"
			value="<%=request.getParameter("openid")%>" /> <input type="hidden"
			name="bindingType" id="bindingType"
			value="<%=request.getParameter("bindingType")%>" />
		<div class="weui-cells">
			<div class="weui-cell">
				<div class="weui-cell__bd">
					<input id="school" class="weui-input" style="text-align: center"
						value="<%=request.getParameter("schoolName")%>">
				</div>
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">帐号</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" id="userNmub" name="userNmub"
					placeholder="请填写学号或工号"
					data-value="<%=request.getParameter("userNumb")%>">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">密码</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" id="userPwd" name="userPwd"
					placeholder="请填写密码">
			</div>
		</div>
		<a id="binding" href="javascript:binding();"
			class="weui-btn weui-btn_primary">绑定</a>
	</form>
</body>
<script type="text/javascript">
	$(function() {
		var bindingType = $("#bindingType").val();
		if (bindingType == "2") {
			$(document).attr("title", "用户解绑");
			$("#userNmub").attr("readonly", "readonly").val(
					$("#userNmub").attr("data-value"));
			$("#binding").text("解绑");
		}
	})
	function binding() {
		var userNmub = $("#userNmub").val();
		if (userNmub == "") {
			$.toptip('请输入帐号', 'warning');
			return false;
		}
		var userPwd = $("#userPwd").val();
		if (userPwd == "") {
			$.toptip('请输入密码', 'warning');
			return false;
		}
		$.ajax({
			cache : false,
			type : "POST",
			url : "/wxApi/binding",
			data : $('#myForm').serialize(),
			dataType : "json",
			async : false,
			success : function(wxUser) {
				if (wxUser.binding) {
					$.toptip(wxUser.bindingResult, 'success');
				} else {
					$.toptip(wxUser.bindingResult, 'error');
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				$.toptip(XMLHttpRequest.status, 'error');
			}

		});
		return false;
	}
</script>
</html>