<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="js/jqueryWeui1.1.2/css/weui.min.css">
<link rel="stylesheet" href="js/jqueryWeui1.1.2/css/jquery-weui.min.css">
<script src="js/jqueryWeui1.1.2/lib/jquery-2.1.4.js"></script>
<script src="js/jqueryWeui1.1.2/js/jquery-weui.min.js"></script>
<title>模版配置</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<style type="text/css">
.required {
	color: red;
}

.weui-popup__modal {
	background-color: #FFF;
}

input:read-only {
	background-color: #c0c0c0;
}
</style>
</head>
<body>
	<a href="javascript:showAddTemplate();"
		class="weui-btn weui-btn_primary open-popup"
		data-target="#addTemplate">增加模版配置</a>
	<div id="addTemplate" class="weui-popup__container">
		<div class="weui-popup__overlay"></div>
		<div class="weui-popup__modal">
			<form id="myForm">
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">交换名称</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" name="exchangeName"
							placeholder="请输入交换名称">
					</div>
				</div>
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">模版ID</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" readonly="readonly" name="templateId"
							placeholder="请选择模版">
					</div>
					<div class="weui-cell__ft">
						<button class="weui-vcode-btn open-popup" data-target="#wechatTemplateList" onclick="javascript:">选择模版</button>
					</div>
				</div>
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">模版名称</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" readonly="readonly" name="templateName"
							placeholder="请选择模版">
					</div>
				</div>
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">模版主体内容</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" name="templateContent">
					</div>
				</div>
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">模版备注字段</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" name="templateRemark">
					</div>
				</div>
				<a href="javascript:ajaxSub();" class="weui-btn weui-btn_primary">增加模版配置</a>
				<button type="reset" style="display: none;"></button>
			</form>
			<br /> <a href="javascript:;"
				class="weui-btn weui-btn_primary close-popup">关闭</a>
		</div>
	</div>
	<div id="wechatTemplateList" class="weui-popup__container"></div>
</body>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : '/wxApi/wechatTemplateList',
			type : "post",
			dataType : "json",
			success : function(wechatTemplateList) {
				for (var int = 0; int < wechatTemplateList.length; int++) {
					var temp = wechatTemplateList[i];
					var str = '<div class="weui-form-preview">';
					str += '<div class="weui-form-preview__hd">';

				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
				alert("获取配置失败!");
			}
		})
		$
				.ajax({
					url : '/wxApi/templateList',
					type : "post",
					dataType : "json",
					success : function(baseResult) {
						if (baseResult.success) {
							var dataObj = JSON.parse(baseResult.data);
							var wechatTemplateList = dataObj.template_list;
							var str = '<div class="weui-cells weui-cells_radio">';
							for (var i = 0; i < wechatTemplateList.length; i++) {
								var temp = wechatTemplateList[i];
								str += '<label class="weui-cell weui-check__label" for="'+temp.template_id+'">';
								str += '<div class="weui-cell__bd"><p>'
										+ temp.title + '</p></div>';
								str += '<div class="weui-cell__ft">';
								str += '<input type="radio" class="weui-check" name="radio1" id="'+temp.template_id+'">';
								str += '<span class="weui-icon-checked"></span></div></label>';
							}
							str += '</div>';
							$("#wechatTemplateList").append(str);
						} else {
							alert(baseResult.messages);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert(XMLHttpRequest.status);
						alert("获取配置失败!");
					}
				})
	})

	function showAddTemplate() {
		$("button[type='reset']").trigger("click");//触发reset按钮 
	}

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